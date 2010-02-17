package jp.shikajiro.edbrowser.userIF
{
	import caurina.transitions.Tweener;
	
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import jp.shikajiro.edbrowser.FocusApp;
	import jp.shikajiro.edbrowser.models.CameraModel;
	
	import org.papervision3d.cameras.Camera3D;
	import org.papervision3d.core.math.Matrix3D;
	
	public class MouseUI{
		
		private var focusApp:FocusApp;
		private var stage:Stage;
		private var camerarot:CameraModel;
		
		public function MouseUI(stage:Stage,camerarot:CameraModel){
			this.stage = stage;
			this.camerarot = camerarot;
		}
		
		private var mousePos  :Point = null;
		private var cameraPos :Point = null;


		public function mhoile(event:MouseEvent):void{
		    Tweener.addTween(camerarot.camera3d,{z:camerarot.camera3d.z + event.delta * 50,time:1});
			//TODO カメラの向きに移動したい
		}

		/**
		 * ドラッグによる視点変更
		 */
		public function mdown(evt:MouseEvent):void{
			mousePos = new Point(stage.mouseX,stage.mouseY);
		}
		public function mmove(evt:MouseEvent):void{
			if(mousePos){
				var vx :Number = (stage.mouseX - mousePos.x)/100;
				var vy :Number = (stage.mouseY - mousePos.y)/100;
				camerarot.cameraRotX = camerarot.cameraRotX - vy;
				camerarot.cameraRotY = camerarot.cameraRotY + vx;
				updateCameraPos();
				mousePos = new Point(stage.mouseX,stage.mouseY);
			}
		}
		private function updateCameraPos():void{
			var v:Matrix3D = new Matrix3D([0,0,-1000,1,0,0,0,0,0,0,0,0]);
			var vrx:Matrix3D = Matrix3D.rotationX(camerarot.cameraRotX/180*Math.PI);
			var vry:Matrix3D = Matrix3D.rotationY(camerarot.cameraRotY/180*Math.PI);
			var va0:Matrix3D = Matrix3D.multiply(v,vrx);
			var va1:Matrix3D = Matrix3D.multiply(va0,vry);
			camerarot.camera3d.rotationY = 0 - va1.n11;
			camerarot.camera3d.rotationX = va1.n12;
		}	
		public function mup(evt:MouseEvent):void{
			mousePos = null;
		}
	}
}