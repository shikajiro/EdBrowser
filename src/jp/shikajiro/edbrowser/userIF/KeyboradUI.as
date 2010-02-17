package jp.shikajiro.edbrowser.userIF
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import jp.shikajiro.edbrowser.FocusApp;
	
	import org.papervision3d.cameras.Camera3D;
	
	public class KeyboradUI
	{
		private var camera:Camera3D;
		
		public function KeyboradUI(camera:Camera3D){
			this.camera = camera;
		}
		
		private var topSpeed:Number = 0;
		private var sideSpeed:Number = 0;
		private var speed:Number = 0;
		private var side:Number = 0;

		private var keyRight:Boolean = false;
		private var keyLeft:Boolean = false;
		private var keyForward:Boolean = false;
		private var keyReverse:Boolean = false;
		

		/**
		 * キーボードによる操作
		 */
		public function updateCamera():void
		{
			camera.moveRight(side);
			camera.moveForward(speed);
		}
		
		public function keyDownHandler(event:KeyboardEvent):void
		{
			switch( event.keyCode )
			{
				// 前進
				case "W".charCodeAt():
				case Keyboard.UP:
					keyForward = true;
					keyReverse = false;
					break;
				// 後退
				case "S".charCodeAt():
				case Keyboard.DOWN:
					keyReverse = true;
					keyForward = false;
					break;
				// 左平行移動
				case "A".charCodeAt():
				case Keyboard.LEFT:
					keyLeft = true;
					keyRight = false;
					break;
				// 右平行移動
				case "D".charCodeAt():
				case Keyboard.RIGHT:
					keyRight = true;
					keyLeft = false;
					break;
			}
		}
		public function keyUpHandler( event :KeyboardEvent ):void
		{
			switch( event.keyCode )
			{
				case "W".charCodeAt():
				case Keyboard.UP:
					keyForward = false;
					break;

				case "S".charCodeAt():
				case Keyboard.DOWN:
					keyReverse = false;
					break;

				case "A".charCodeAt():
				case Keyboard.LEFT:
					keyLeft = false;
					break;

				case "D".charCodeAt():
				case Keyboard.RIGHT:
					keyRight = false;
					break;
			}
		}
		
		public function moveCamera():void
		{
			// 前進・後退
			if( keyForward )
			{
				topSpeed = 20;
			}
			else if( keyReverse )
			{
				topSpeed = -20;
			}
			else
			{
				topSpeed = 0;
			}
			
			speed -= ( speed - topSpeed ) / 10;

			if( keyRight )
			{
				sideSpeed = 50;
			}
			else if( keyLeft )
			{
				sideSpeed = -50;
			}
			else
			{
				sideSpeed = 0;
			}
			
			side -= ( side - sideSpeed ) / 10;
		}
		
	}
}