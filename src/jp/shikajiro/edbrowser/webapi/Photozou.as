package jp.shikajiro.edbrowser.webapi{
	import flash.events.Event;
	import flash.utils.escapeMultiByte;
	
	import jp.shikajiro.edbrowser.FocusApp;
	import jp.shikajiro.edbrowser.IconType;
	import jp.shikajiro.edbrowser.PlaneCreate;
	import jp.shikajiro.edbrowser.models.CameraModel;
	
	public class Photozou extends WebApiImpl{

		public static const PHOTOZOU_SEARCH:String = "http://api.photozou.jp/rest/search_public/?";
		public static const PHOTOZOU_KEYWORD:String = "keyword="
		public static const TYPE_PHOTO:String = "photo";
		public static const TYPE_MOVIE:String = "movie";
		
		public function Photozou(focusApp:FocusApp,camerarot:CameraModel){
			super(focusApp,camerarot);
		}
		
		override public function requestApi(searchText:String=null):void{
			var query:String = PHOTOZOU_SEARCH + PHOTOZOU_KEYWORD + escapeMultiByte(searchText);
			requestLoad(query);
		}
		
		override protected function completeHandler(event:Event):void{
			var xmlObj:XML = new XML(event.target.data);
			for each(var xml:XML in xmlObj.child("info").child("photo")){
				//original_image_url == null の場合movieである。
				var type:String;
				var origUrl:String;
				if(xml.child("original_image_url") == ""){//movieの場合はHTMLページ
					type = IconType.MOVIE;
					origUrl = xml.child("url").toString();
				}else{//photoの場合は直接リンク
					type = IconType.PHOTO;
					origUrl = xml.child("image_url").toString();
				}
				var url:String = xml.child("thumbnail_image_url").toString();
				var title:String = xml.child("photo_title").toString();
				trace("Photozou:url" + url + " origi:" + origUrl + " type:"+ type);
				new PlaneCreate(focusApp,url,origUrl,type,title,camerarot);
			}
		}

	}
}