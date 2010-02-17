package jp.shikajiro.edbrowser.webapi{
	import flash.events.Event;
	import flash.utils.escapeMultiByte;
	
	import jp.shikajiro.edbrowser.IconType;
	import jp.shikajiro.edbrowser.PlaneCreate;
	import jp.shikajiro.edbrowser.models.CameraModel;
	import jp.shikajiro.edbrowser.models.PlaneDataModel;
	
	
	public class YahooImageSearch extends WebApiImpl{

		public static const REQUEST_URL:String = "http://search.yahooapis.jp/ImageSearchService/V1/imageSearch";
		public static const ID:String = "?appid="
		public static const APP_ID:String = "Hec_zAuxg66jh.kp9zWeNlpoh2BA1AN0tl9lqA0H0BPvW8ECB5.Ub7MeCtIvxH6l";
		public static const QUERY:String = "&query=";
		
		public function YahooImageSearch(planeDataModel:PlaneDataModel,camerarot:CameraModel){
			super(planeDataModel,camerarot);
		}
		
		override public function requestApi(searchText:String=null):void{
			var query:String = REQUEST_URL + ID + APP_ID + QUERY + escapeMultiByte(searchText);
			requestLoad(query);
		}
		
		override protected function completeHandler(event:Event):void{
			var xmlObj:XML = new XML(event.target.data);
			var ns:Namespace = new Namespace("urn:yahoo:jp:srchmi");
			for each(var xml:XML in xmlObj.ns::Result){
				trace("YahooImageSearch");
				var origUrl:String = xml.ns::Url;
				var url:String = xml.ns::Thumbnail.ns::Url;
				var title:String = xml.ns::Title;
				new PlaneCreate(planeDataModel,url,origUrl,IconType.PHOTO,title,camerarot);
			}
		}
	}
}