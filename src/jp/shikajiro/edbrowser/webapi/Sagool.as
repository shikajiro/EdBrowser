package jp.shikajiro.edbrowser.webapi{
	import flash.events.Event;
	import flash.utils.escapeMultiByte;
	
	import jp.shikajiro.edbrowser.FocusApp;
	import jp.shikajiro.edbrowser.IconType;
	import jp.shikajiro.edbrowser.PlaneCreate;
	import jp.shikajiro.edbrowser.models.CameraModel;
	
	public class Sagool	extends WebApiImpl{
		
		public static const SAGOOL_API:String = "http://sagool.jp/openapi?";
		public static const SAGOOL_QUERY:String = "query=";
		public static const SAGOOL_CLIENT:String = "&clientUrl=http://sagool.jp/";
		public static const SAGOOL_COUNT:String = "&hitsPerPage=";
		
		public function Sagool(focusApp:FocusApp,camerarot:CameraModel){
			super(focusApp,camerarot);
		}
		
		override public function requestApi(searchText:String=null):void{
			var query:String = SAGOOL_API + SAGOOL_QUERY + escapeMultiByte(searchText) + SAGOOL_CLIENT + SAGOOL_COUNT + "20";
			requestLoad(query);
		}
		override protected function completeHandler(event:Event):void{
			var xmlObj:XML = new XML(event.target.data);
			for each(var xml:XML in xmlObj.children().child("item")){
				var origUrl:String = xml.child("link").toString();
				var title:String = xml.child("title").toString();
				trace("Sagool" + origUrl);
				var url:String = SimpleAPI.requestApi(origUrl);
				new PlaneCreate(focusApp,url,origUrl,IconType.BROWSER,title,camerarot);
			}
		}
	}
}