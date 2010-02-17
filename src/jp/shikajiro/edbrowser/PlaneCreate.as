package jp.shikajiro.edbrowser
{
	import caurina.transitions.Tweener;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import jp.shikajiro.edbrowser.models.CameraModel;
	import jp.shikajiro.edbrowser.models.PlaneDataModel;
	
	import mx.containers.Canvas;
	import mx.containers.TitleWindow;
	import mx.controls.HTML;
	import mx.controls.Text;
	import mx.core.Application;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	
	import org.papervision3d.events.InteractiveScene3DEvent;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.objects.primitives.Plane;
	
	public class PlaneCreate
	{
		
		private var thumbUrl:String;
		private var url:String;
		private var type:String;
		private var title:String;
		private var planeDataModel:PlaneDataModel;
		private var iconType:IconType;
		private var cameraModel:CameraModel;
		
		/**
		 * URL形式の画像をbitmapにする
		 */
        public function PlaneCreate(planeDataModel:PlaneDataModel,thumbUrl:String,url:String,type:String,title:String,camerarot:CameraModel) {
        	this.planeDataModel = planeDataModel;
        	this.thumbUrl = thumbUrl;
        	this.url = url;
        	this.type = type;
        	this.title = title;
        	this.iconType = IconType.getInstance();
        	this.cameraModel = camerarot;
        	
			imageRequest();
        }
        private function imageRequest():void{
            var loader:Loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
            var request:URLRequest = new URLRequest(thumbUrl);
            loader.load(request);
        }
        private function completeHandler(event:Event):void {
            var loader:Loader = Loader(event.target.loader);
            var bitmap:Bitmap = Bitmap(loader.content);
            
        	var bitmapData:BitmapData = BitmapData(iconType.imageIcon[this.type])
        	if(bitmapData != null){
        		bitmap.bitmapData.draw(bitmapData);
        	}
            var plane:Plane = createPlane(bitmap.bitmapData);
			planeDataModel.arrayObj.push(plane);
			planeDataModel.rootNode.addChild(plane);
        }

        /**
         * 平面3dに画像を設定して生成する。
         */
		private function createPlane(bitmapData:BitmapData):Plane{
        	
			// 平面
			var material:BitmapMaterial = new BitmapMaterial(bitmapData);
			material.interactive = true;
			material.doubleSided = true;
			var plane:Plane = new Plane(material,material.bitmap.width/4,material.bitmap.height/4);

			// 位置
			plane.x = cameraModel.createX + Common.xRandomInt(800);
			plane.y = cameraModel.createY + Common.xRandomInt(800);
			plane.z = cameraModel.createZ + Common.xRandomInt(800);
			
			Tweener.addTween(plane,{scale:4,time:3});

			plane.addEventListener(InteractiveScene3DEvent.OBJECT_OVER,planeOverHandler);
			plane.addEventListener(InteractiveScene3DEvent.OBJECT_OUT,planeOutHandler);
			plane.addEventListener(InteractiveScene3DEvent.OBJECT_CLICK,objectClickHandler); 
			plane.addEventListener(InteractiveScene3DEvent.OBJECT_DOUBLE_CLICK,objectDoubleClickHandler); 
			
			return plane;
		}
		
		/**
		 * ダブルクリックしてブラウザを開く
		 */
		private function objectDoubleClickHandler(event:InteractiveScene3DEvent):void{
			//window
			var window:TitleWindow = new TitleWindow();
			window.showCloseButton = true;
			window.layout = "absolute";
			window.width = 800;
			window.height = 600;
			window.addEventListener(CloseEvent.CLOSE,closeHandler);
			
			//htmlブラウザ
			var html:HTML = new HTML();
			html.name = "html";
			html.location=url;
			html.width = window.width-20;
			html.height = window.height-40;
			window.addChild(html);
			trace("PopUpURL:" + url);
			
			PopUpManager.addPopUp(window, Application.application.parent);
			PopUpManager.centerPopUp(window);
		}
		
		private function closeHandler(event:CloseEvent):void{
			var window:TitleWindow = TitleWindow(event.target)
			window.removeAllChildren();
			window = null;
			PopUpManager.removePopUp(TitleWindow(event.currentTarget));
		}
		
		/**
		 * クリックしてオブジェクトへ移動
		 */
		private function objectClickHandler(event:InteractiveScene3DEvent):void{
			
			// カメラの向きの初期化
			cameraModel.cameraRotX = 0;
			cameraModel.cameraRotY = 0;
			
			// 対象オブジェクト
			var plane:Plane = Plane(event.target);
    		
		    Tweener.addTween(cameraModel.camera3d,{
		    						x:Math.floor(Math.random()*600)-300,
		                            y:Math.floor(Math.random()*600)-300,
		                            z:Math.floor(Math.random()*600)-300,
		                            rotationX:plane.rotationX,
		                            rotationY:plane.rotationY,
		                            rotationZ:plane.rotationZ,
		                            time:3
		                            });
		                           
		    Tweener.addTween(cameraModel.camera3d,{
								 x:plane.x,
		                         y:plane.y,
		                         z:plane.z-200,
		                         time:3
		                         });
		}
		
		 /*
		  * マウスオーバーによる関連用語の表示・非表示 
		  */
		 private function planeOverHandler(event:InteractiveScene3DEvent):void{
		 	var creditCanvas:Canvas = Canvas(Application.application.creditCanvas);
			var creditText:Text = Text(creditCanvas.getChildByName("creditText"));
			
			creditText.text = title;
			
			creditCanvas.visible = true;
			creditText.visible = true;
		 }
		 private function planeOutHandler(event:InteractiveScene3DEvent):void{
		 	var creditCanvas:Canvas = Canvas(Application.application.creditCanvas);
			var creditText:Text = Text(creditCanvas.getChildByName("creditText"));
			
			creditCanvas.visible = false;
			creditText.visible = false;
		 }
	}
}