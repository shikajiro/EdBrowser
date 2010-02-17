package jp.shikajiro.edbrowser.webapi{
	import flash.events.Event;
	import flash.utils.escapeMultiByte;
	
	import jp.shikajiro.edbrowser.FocusApp;
	import jp.shikajiro.edbrowser.IconType;
	import jp.shikajiro.edbrowser.PlaneCreate;
	import jp.shikajiro.edbrowser.models.CameraModel;
	
	
	public class YahooVideoSearch extends WebApiImpl{

		public static const REQUEST_URL:String = "http://search.yahooapis.jp/VideoSearchService/V1/videoSearch";
		public static const ID:String = "?appid="
		public static const APP_ID:String = "Hec_zAuxg66jh.kp9zWeNlpoh2BA1AN0tl9lqA0H0BPvW8ECB5.Ub7MeCtIvxH6l";
		public static const QUERY:String = "&query=";
		public static const FORMAT:String = "&format=";
		
		public function YahooVideoSearch(focusApp:FocusApp,camerarot:CameraModel){
			super(focusApp,camerarot);
		}
		
		override public function requestApi(searchText:String=null):void{
			var query:String = REQUEST_URL + ID + APP_ID + QUERY + escapeMultiByte(searchText) + FORMAT + "flash";
			requestLoad(query);
		}
		
		override protected function completeHandler(event:Event):void{
			var xmlObj:XML = new XML(event.target.data);
			var ns:Namespace = new Namespace("urn:yahoo:jp:srchmv");
			for each(var xml:XML in xmlObj.ns::Result){
				
				var origUrl:String = xml.ns::Url;
				var url:String = xml.ns::Thumbnail.ns::Url;
				var title:String = xml.ns::Title;
				trace("YahooVideoSearch origi:" + origUrl);
				trace("YahooVideoSearch url:" + url);
				new PlaneCreate(focusApp,url,origUrl,IconType.MOVIE,title,camerarot);
			}
		}
	}
}