/* 主要機能 */
//TODO BBSのレスを流す。

/* アニメーション */
//TODO 自動に動く機能 低 
//TODO 浮遊感 低

/* */
//TODO チェックボックスによるWEBAPI選択

/*　可能？だいぶ先　*/
//TODO 座標に意味合いを持たせる。　Yahooは更新日時を持っている
//TODO 色に意味合いを持たせる。
//TODO 現在地のレーダー
//TODO　他の使用者との通信

/* Bug */

package jp.shikajiro.edbrowser
{
	import air.update.events.UpdateEvent;
	
	import caurina.transitions.Tweener;
	
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import jp.shikajiro.edbrowser.models.CameraModel;
	import jp.shikajiro.edbrowser.models.PlaneDataModel;
	import jp.shikajiro.edbrowser.update.UpdateManager;
	import jp.shikajiro.edbrowser.userIF.*;
	import jp.shikajiro.edbrowser.webapi.*;
	
	import mx.core.UIComponent;
	import mx.core.WindowedApplication;
	import mx.events.FlexEvent;
	
	import org.papervision3d.cameras.Camera3D;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.render.BasicRenderEngine;
	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.view.Viewport3D;
	import org.wiiflash.Wiimote;
	import org.wiiflash.events.ButtonEvent;

	public class FocusApp extends WindowedApplication
	{
//		private var sagool:Sagool;
//		private var photozou:Photozou;
		private var reflexa:Reflexa;
		private var yahooImage:YahooImageSearch;
		private var technorati:Technorati;
//		private var amebaVision:AmebaVision;
//		private var yahooVideoSearch:YahooVideoSearch;
		private var yahooWordSearch:YahooWordSearch;
		private var youtube:Youtube;
		
		private var scene:Scene3D;
		private var render:BasicRenderEngine;
		private var viewport:Viewport3D;
		
		private var keyboradUI:KeyboradUI;
		private var mouseUI:MouseUI;
		private var wiimoteUI:WiimoteUI;
		public var wiimote:Wiimote;

		private var updateManager:UpdateManager;

//		public var virtualMouse:VirtualMouse;
		
		//Model
		private var cameraModel:CameraModel;
		private var planeDataModel:PlaneDataModel;
		
		[Embed(source="img/cursor.png")]
		[Bindable]
		private var _cursor:Class;
			
		/**
		 * 初期化
		 */
		public function FocusApp()
		{
			trace("constractor()");
			//Version更新確認
			initUpdate();
			
			//Model生成
			cameraModel = new CameraModel();
			planeDataModel = new PlaneDataModel();
			
			//初期化処理
			addEventListener(FlexEvent.INITIALIZE,function(){
				wiimoteControll();
			});
			
			addEventListener(FlexEvent.APPLICATION_COMPLETE, initializeHandler);
		}
		
		/**
		 * UpdateManager
		 */
		private function initUpdate():void{
			updateManager = new UpdateManager();
			updateManager.addEventListener(UpdateEvent.INITIALIZED,function updateHandler(event:UpdateEvent):void{
				updateManager.removeEventListener(event.type,arguments.callee);
				updateManager.checkNow();
			});
			updateManager.initialize();
		}
		
		/*コントロールパネル*/
		/**
		 * 削除
		 */
		public function remove():void{
			planeDataModel.arrayObj.forEach(function(element:*, index:int, arr:Array):void{
				Tweener.addTween(element,{scale:0,time:3});
			});
			planeDataModel.arrayObj.forEach(function(element:*, index:int, arr:Array):void{
				element = null;
			});
			Tweener.addTween(scene,{
							delay:1,
							onComplete:scene.removeChild,
							onCompleteParams:[planeDataModel.rootNode]
							});
			planeDataModel.rootNode = scene.addChild( new DisplayObject3D( "rootNode" ) );
		}
		
		/**
		 * ホームポジジョン
		 */
		public function homePosition():void{
			cameraModel.createX = 0;
			cameraModel.createY = 0;
			cameraModel.createZ = 0;
		    Tweener.addTween(cameraModel.camera3d,{
						x:0,
                        y:0,
                        z:-1000,
                        rotationX:0,
                        rotationY:0,
                        rotationZ:0,
                        time:3
                        });
		}
		
		/**
		 * serach
		 */
	 	public function searchAll(text:String):void{
	 		trace("text:" + text);
	 		reflexa.requestApi(text);
			yahooImage.requestApi(text);
//			sagool.requestApi(text);
//			photozou.requestApi(text);
//			amebaVision.requestApi(text);
//			yahooVideoSearch.requestApi(text);
			yahooWordSearch.requestApi(text);
			youtube.requestApi(text);
		}
		/**
		 * wiimote切り替え
		 */
		 
		public function wiimoteControll():void{
			
//			if(!wiimote.connected){
//				Application.application.stage.addChild(Application.application.removeChild(Application.application.imgCursor));
			
//				Application.application.virtualMouse = new VirtualMouse(this.stage, Application.application.imgCursor.x, Application.application.imgCursor.y);
//				Application.application.virtualMouse.addEventListener(MouseEvent.MOUSE_MOVE, WiimoteUI.OnMouse_MOVE);
				wiimote = new Wiimote();
				wiimote.addEventListener( Event.CONNECT, function(event:Event):void{
					trace("wiimote conected");
				} );
				wiimote.addEventListener( ButtonEvent.UP_PRESS, function(event){
					trace("uppress");
				});
				wiimote.connect();
//				Application.application..addEventListener(Event.ENTER_FRAME, WiimoteUI.loop);
//			}else{
//				wiimote.close();
//			}
		}
		
		/*コントロールパネル*/

		/**
		 * 初期化
		 */
		private function initializeHandler(event:FlexEvent):void
		{
			trace("initializeHandler()");
			//最大化 TODO
			maximize();
			
			//component3D
			var component3D:UIComponent = event.target.component3D;
			component3D.stage.align = StageAlign.TOP_LEFT;
			component3D.stage.scaleMode = StageScaleMode.NO_SCALE;
			component3D.stage.frameRate = 60;
			component3D.stage.quality = StageQuality.BEST;
			
			//viewport
			viewport = new Viewport3D(0,0,true,true);
            viewport.containerSprite.buttonMode = true;
            component3D.addChild(viewport);  
            
            //render
			render = new BasicRenderEngine();
			
			//camera
			cameraModel.camera3d = new Camera3D();
			
			//scene
			scene = new Scene3D();
			planeDataModel.rootNode = scene.addChild( new DisplayObject3D( "rootNode" ) );
			
			//UserInterface
			keyboradUI = new KeyboradUI(cameraModel.camera3d);
			mouseUI = new MouseUI(stage,cameraModel);
			wiimoteUI = new WiimoteUI(cameraModel);
//			wiimote = new Wiimote();
			
			//WebApi
			technorati = new Technorati(planeDataModel,cameraModel);
//			sagool = new Sagool(this,cameraModel);
//			photozou = new Photozou(this,cameraModel);
			reflexa = new Reflexa(planeDataModel,cameraModel);
//			amebaVision = new AmebaVision(this,cameraModel);
			yahooImage = new YahooImageSearch(planeDataModel,cameraModel);
//			yahooVideoSearch = new YahooVideoSearch(this,cameraModel);
			yahooWordSearch = new YahooWordSearch(planeDataModel,cameraModel);
			youtube = new Youtube(planeDataModel,cameraModel);
			
			//Event
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			component3D.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyboradUI.keyDownHandler );
			component3D.stage.addEventListener(KeyboardEvent.KEY_UP, keyboradUI.keyUpHandler );
			component3D.stage.addEventListener(MouseEvent.MOUSE_WHEEL,mouseUI.mhoile);
			component3D.stage.addEventListener(MouseEvent.MOUSE_DOWN,mouseUI.mdown);
			component3D.stage.addEventListener(MouseEvent.MOUSE_MOVE,mouseUI.mmove);
			component3D.stage.addEventListener(MouseEvent.MOUSE_UP,mouseUI.mup); 
			
			// 最初の10個はランキングを表示
			technorati.requestApi();
		}
		
		/**
		 * 1コマ分データを読み込んだあとの動作
		 */
		private function onEnterFrame(event:Event):void
		{
			// カメラの動き
			keyboradUI.moveCamera();
			keyboradUI.updateCamera();
			
			//wiimote
			if(wiimote.connected){
				trace("up:"+wiimote.up.toString());
				wiimoteUI.updateCamera(event);
				wiimoteUI.moveCamera(event);
			}

			// カメラのレンダリング
			render.renderScene(scene,cameraModel.camera3d,viewport);
		}

	}
}