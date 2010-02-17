package jp.shikajiro.edbrowser.userIF
{
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import jp.shikajiro.edbrowser.FocusApp;
	import jp.shikajiro.edbrowser.models.CameraModel;
	
	import mx.core.Application;
	
	import org.wiiflash.Nunchuk;
	import org.wiiflash.Wiimote;
	
	public class WiimoteUI
	{
		private var camerarot:CameraModel;
		
		public function WiimoteUI(camerarot:CameraModel){
			this.camerarot = camerarot;
		}
		
		private var speed:Number = 0;
		
		private var speedCameraUp:Number = 0;
		private var speedCameraSide:Number = 0;

		/**
		 * キーボードによる操作
		 */
		public function updateCamera(event :Event):void
		{
			var wiimote:Wiimote = Wiimote(event.target.wiimote);
			var nunchuk:Nunchuk = Nunchuk(wiimote.nunchuk);
			// Move
			var AUTO_MOVE:int = 0.5;//勝手に少しずつ前に進む
			camerarot.camera3d.moveRight( nunchuk.stickX * 20);
			camerarot.camera3d.moveForward( nunchuk.stickY * 20 + AUTO_MOVE);
			camerarot.camera3d.moveUp( speed );
			

		}
				
		public function moveCamera(event :Event):void
		{
			var wiimote:Wiimote = Wiimote(event.target.wiimote);
			var nunchuk:Nunchuk = Nunchuk(wiimote.nunchuk);
			
			//
			var topSpeed:Number = 0;
			if( nunchuk.c ){
				topSpeed = 20;
				
			}else if( nunchuk.z ){
				topSpeed = -20;
				
			}else{
				topSpeed = 0;
			}
			speed -= ( speed - topSpeed ) / 10;
			
			//
			var topCameraUp:Number = 0;
			if( wiimote.up ){
				topCameraUp = -1;
				
			}else if(wiimote.down){
				topCameraUp = 1;
				
			}else{
				topCameraUp = 0;
			}
			
			//
			var topCameraSide:Number = 0;
			if(wiimote.left){
				topCameraSide = -1;
				
			}else if(wiimote.right){
				topCameraSide = 1;
				
			}else{
				topCameraSide = 0;
			}
			
			speedCameraUp -= ( speedCameraUp - topCameraUp ) / 10;
			speedCameraSide -= ( speedCameraSide - topCameraSide ) / 10;
			camerarot.camera3d.rotationX += speedCameraUp;
			camerarot.camera3d.rotationY += speedCameraSide;
			

		}
		public static function loop(evt:Event):void{
			var wiimote:Wiimote = Wiimote(evt.target.wiimote);
			
			var virtualx:Number = (1 - wiimote.ir.x1) * 1000;
			var virtualy:Number = (1 - (wiimote.ir.y1 + 1)) * 1000;
			
			if(virtualx > 0){
				Application.application.virtualMouse.x = virtualx;
				Application.application.virtualMouse.y = virtualy;
			}
		}
		public static function OnMouse_MOVE(evt:MouseEvent):void{
			Application.application.imgCursor.x = Application.application.virtualMouse.x;
			Application.application.imgCursor.y = Application.application.virtualMouse.y;
		}
	}
}