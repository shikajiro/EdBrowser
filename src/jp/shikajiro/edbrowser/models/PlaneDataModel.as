package jp.shikajiro.edbrowser.models
{
	import org.papervision3d.objects.DisplayObject3D;
	
	public class PlaneDataModel
	{
		
		private var _rootNode:DisplayObject3D;
		private var _arrayObj:Array = new Array();
		
		public function PlaneDataModel()
		{
		}
		public function get rootNode():DisplayObject3D{
			return this._rootNode;
		}
		public function set rootNode(pram:DisplayObject3D):void{
			this._rootNode = pram;
		}
		public function get arrayObj():Array{
			return this._arrayObj;
		}
		public function set arrayObj(pram:Array):void{
			this._arrayObj = pram;
		}
	}
}