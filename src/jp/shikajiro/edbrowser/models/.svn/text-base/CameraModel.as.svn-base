package jp.shikajiro.edbrowser.models
{
	import org.papervision3d.cameras.Camera3D;
	
	[Bindable]
	public class CameraModel
	{
		private var _camera3d:Camera3D;
		private var _cameraRotX :Number = 0;
		private var _cameraRotY :Number = 0;
		
		private var _createX:int = 0;
		private var _createY:int = 0;
		private var _createZ:int = 0;
		
		public function set cameraRotX(_rot:Number):void{
			if(-89<_rot&&_rot<89){
				_cameraRotX = _rot;
			}else if(-89>=_rot){
				_cameraRotX = -89;
			}else{
				_cameraRotX = 89;
			}
		}
		public function get cameraRotX():Number{
			return this._cameraRotX;
		}
		public function set cameraRotY(_rot:Number):void{
			_cameraRotY = _rot;
		}
		public function get cameraRotY():Number{
			return this._cameraRotY;
		}
		public function set camera3d(param:Camera3D):void{
			_camera3d = param;
		}
		public function get camera3d():Camera3D{
			return _camera3d;
		}
		public function get createX():int{
			return this._createX;
		}
		public function get createY():int{
			return this._createY;
		}
		public function get createZ():int{
			return this._createZ;
		}
		public function set createX(pram:int):void{
			this._createX = pram;
		}
		public function set createY(pram:int):void{
			this._createY = pram;
		}
		public function set createZ(pram:int):void{
			this._createZ = pram;
		}
	}
}