package jp.shikajiro.edbrowser.webapi{
	import flash.events.Event;
	import flash.utils.escapeMultiByte;
	
	import jp.shikajiro.edbrowser.RelatedCube;
	import jp.shikajiro.edbrowser.models.CameraModel;
	import jp.shikajiro.edbrowser.models.PlaneDataModel;
	
	
	public class Reflexa extends WebApiImpl{
		
		public static const WEB_URL:String = "http://labs.preferred.jp/reflexa/api.php";
		public static const WEB_QUERY:String = "?q=";
		public static const WEB_FORMAT:String = "&format=";
		
		private var relatedCube:RelatedCube;
		
		public function Reflexa(planeDataModel:PlaneDataModel,camerarot:CameraModel){
			super(planeDataModel,camerarot);
			relatedCube = new RelatedCube(planeDataModel,camerarot); 
		}
		
		override public function requestApi(searchText:String=null):void{
			var query:String = WEB_URL + WEB_QUERY + escapeMultiByte(searchText) + WEB_FORMAT + "xml";
			requestLoad(query);
		}
		
		override protected function completeHandler(event:Event):void{
			var xmlObj:XML = new XML(event.target.data);
			var i:int = 0;
			for each(var xml:XML in xmlObj.children().child("word")){
				i++;
				if(i == 1) continue;//1個目は検索語と同じ
				var title:String = xml.toString();
				trace("Reflexa" + title);
				relatedCube.createCube(title);
				if(i == 10+1) break;//10個くらいでいい。
			}
		}
	}
}