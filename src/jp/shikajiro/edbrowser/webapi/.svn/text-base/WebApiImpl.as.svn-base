package jp.shikajiro.edbrowser.webapi
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.describeType;
	
	import jp.shikajiro.edbrowser.models.CameraModel;
	import jp.shikajiro.edbrowser.models.PlaneDataModel;
	
	public class WebApiImpl implements IWebApi
	{
		protected var planeDataModel:PlaneDataModel;
		protected var camerarot:CameraModel;
		
		public function WebApiImpl(planeDataModel:PlaneDataModel,camerarot:CameraModel){
			this.planeDataModel = planeDataModel;
			this.camerarot = camerarot;
		}
		
		public function requestApi(searchText:String=null):void{}
		
		protected function completeHandler(event:Event):void{}
		
		protected function ioErrorHandler(event:IOErrorEvent):void{
			trace("error > " + describeType(this).@name + "ioErrorHandler");
		}
		
		/**
		 * URLRequestを行う
		 */
		protected function requestLoad(query:String):void{
			var request:URLRequest = new URLRequest(query);
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE,completeHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
			loader.load(request);
		}

	}
}