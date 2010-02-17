package jp.shikajiro.edbrowser.webapi{
	import flash.events.Event;
	import flash.utils.escapeMultiByte;
	
	import jp.shikajiro.edbrowser.FocusApp;
	import jp.shikajiro.edbrowser.IconType;
	import jp.shikajiro.edbrowser.PlaneCreate;
	import jp.shikajiro.edbrowser.models.CameraModel;
	
	public class AmebaVision extends WebApiImpl{

		public static const SEARCH_URL:String = "http://vision.ameba.jp/api/get/search/keyword/popular.do?";
		public static const KEYWORD:String = "keyword="
		
		public function AmebaVision(focusApp:FocusApp,camerarot:CameraModel){
			super(focusApp,camerarot);
		}
		
		override public function requestApi(searchText:String=null):void{
			var query:String = SEARCH_URL + KEYWORD + escapeMultiByte(searchText);
			requestLoad(query);
		}
		
		override protected function completeHandler(event:Event):void{
			var xmlObj:XML = new XML(event.target.data);
			for each(var xml:XML in xmlObj.child("item")){
				var origUrl:String = xml.child("link").toString();
				var url:String = xml.child("imageUrlMedium").toString();
				var title:String = xml.child("title").toString();
				trace("AmebaVision:"+origUrl);
				new PlaneCreate(focusApp,url,origUrl,IconType.MOVIE,title,camerarot);
			}
		}

	}
}