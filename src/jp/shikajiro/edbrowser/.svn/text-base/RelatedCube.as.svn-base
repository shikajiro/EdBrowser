package jp.shikajiro.edbrowser
{
	import caurina.transitions.Tweener;
	
	import jp.shikajiro.edbrowser.models.CameraModel;
	import jp.shikajiro.edbrowser.models.PlaneDataModel;
	
	import mx.containers.Canvas;
	import mx.controls.Text;
	import mx.core.Application;
	
	import org.papervision3d.events.InteractiveScene3DEvent;
	import org.papervision3d.materials.ColorMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.primitives.Cube;
	
	public class RelatedCube
	{
		private var planeDataModel:PlaneDataModel;
		private var cameraModel:CameraModel;
		
		public function RelatedCube(planeDataModel:PlaneDataModel,camerarot:CameraModel){
			this.planeDataModel = planeDataModel;
			this.cameraModel = camerarot;
		}

		/**
		 * 関連用語によるCube作成
		 */
		public function createCube(word:String):Cube{
			
			// Cubeオブジェクト
			var colorMaterial:ColorMaterial = new ColorMaterial(Math.floor(Math.random() * 0xFFFFFF),0.6);
			colorMaterial.interactive = true;
			colorMaterial.name = word;
			var materials:MaterialsList = new MaterialsList(
                    {
                        front:  colorMaterial,
                        back:   colorMaterial,
                        right:  colorMaterial,
                        left:   colorMaterial,
                        top:    colorMaterial,
                        bottom: colorMaterial
                    });
			var cube:Cube = new Cube(materials,10,10,10);
			
			// アニメーション
			Tweener.addTween(cube,{scale:5,time:3});
			
			// イベント
			cube.addEventListener(InteractiveScene3DEvent.OBJECT_OVER,cubeOverHandler);
			cube.addEventListener(InteractiveScene3DEvent.OBJECT_OUT,cubeOutHandler);
			cube.addEventListener(InteractiveScene3DEvent.OBJECT_CLICK,cubeClickHandler); 
			
			// xyz軸の設定
		 	cube.x = cameraModel.createX + Common.xRandomInt(1600);
			cube.y = cameraModel.createY + Common.xRandomInt(1200);
			cube.z = cameraModel.createZ + 800;
			
			return cube;
		 }
		 
		 /*
		  * マウスオーバーによる関連用語の表示・非表示 
		  */
		 private function cubeOverHandler(event:InteractiveScene3DEvent):void{
		 	var creditCanvas:Canvas = Canvas(Application.application.creditCanvas);
			var creditText:Text = Text(creditCanvas.getChildByName("creditText"));
			
			creditText.text = event.displayObject3D.materials.materialsByName.front.name.toString();
			
			creditCanvas.visible = true;
			creditText.visible = true;
		 }
		 private function cubeOutHandler(event:InteractiveScene3DEvent):void{
		 	var creditCanvas:Canvas = Canvas(Application.application.creditCanvas);
			var creditText:Text = Text(creditCanvas.getChildByName("creditText"));
			
			creditCanvas.visible = false;
			creditText.visible = false;
		 }
		 
		/*
		 * クリックしてオブジェクトへの移動と検索
		 */
		private function cubeClickHandler(event:InteractiveScene3DEvent):void{

			// カメラの向きの初期化
			cameraModel.cameraRotX = 0;
			cameraModel.cameraRotY = 0;
			
			// 対象オブジェクト
			var cube:Cube = Cube(event.target);
    		
    		// アニメーション
		    Tweener.addTween(cameraModel.camera3d,{
		    						x:Math.floor(Math.random()*600)-300,
		                            y:Math.floor(Math.random()*600)-300,
		                            z:Math.floor(Math.random()*600)-300,
		                            rotationX:cube.rotationX,
		                            rotationY:cube.rotationY,
		                            rotationZ:cube.rotationZ,
		                            time:3
		                            });
		    Tweener.addTween(cameraModel.camera3d,{
								 x:cube.x,
		                         y:cube.y,
		                         z:cube.z-200,
		                         time:3
		                         });
		    
		    // xyz軸の設定
			cameraModel.createX = cube.x;
			cameraModel.createY = cube.y;
			cameraModel.createZ = cube.z+800;
			
			// 検索処理に移行
			Application.application.searchAll(event.displayObject3D.materials.materialsByName.front.name.toString());
		}
	}
}