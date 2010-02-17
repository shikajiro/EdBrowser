package jp.shikajiro.edbrowser.webapi{
	import flash.events.Event;
	import flash.utils.escapeMultiByte;
	
	import jp.shikajiro.edbrowser.IconType;
	import jp.shikajiro.edbrowser.PlaneCreate;
	import jp.shikajiro.edbrowser.models.CameraModel;
	import jp.shikajiro.edbrowser.models.PlaneDataModel;
	
	
	public class Youtube extends WebApiImpl{

		public static const REQUEST_URL:String = "http://gdata.youtube.com/feeds/api/videos";
		public static const QUERY:String = "?vq=";
		public static const ORDERBY:String = "&orderby="
		
		public function Youtube(planeDataModel:PlaneDataModel,camerarot:CameraModel){
			super(planeDataModel,camerarot);
		}
		
		override public function requestApi(searchText:String=null):void{
			var query:String = REQUEST_URL + QUERY + escapeMultiByte(searchText) + ORDERBY + "published";
			trace("query:"+query);
			requestLoad(query);
		}
		
		override protected function completeHandler(event:Event):void{
			var xmlObj:XML = new XML(event.target.data);
			var ns:Namespace = new Namespace("http://www.w3.org/2005/Atom");
			var nsMedia:Namespace = new Namespace("http://search.yahoo.com/mrss/");
			for each(var xml:XML in xmlObj.ns::entry){
				trace("Youtube");
				var xmlGroup:XML = xml.nsMedia::group[0];
				var origUrl:String = "";
				var content:String = xmlGroup.nsMedia::content;
				if(content != ""){
					origUrl = xmlGroup.nsMedia::content[0].@url;
				}else{
					origUrl = xmlGroup.nsMedia::player.@url;
				}
				var url:String = xmlGroup.nsMedia::thumbnail[2].@url;
				var title:String = xmlGroup.nsMedia::title;
				new PlaneCreate(planeDataModel,url,origUrl,IconType.YOUTUBE,title,camerarot)
			}
		}
	}
}