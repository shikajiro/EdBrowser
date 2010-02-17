package jp.shikajiro.edbrowser.webapi{
	import flash.events.Event;
	
	import jp.shikajiro.edbrowser.RelatedCube;
	import jp.shikajiro.edbrowser.models.CameraModel;
	import jp.shikajiro.edbrowser.models.PlaneDataModel;
	
	import org.papervision3d.objects.primitives.Cube;
	
	public class Technorati extends WebApiImpl{

		public static const REQUEST_URL:String = "http://feeds.technorati.jp/trjcf/keyword_ranking/";
		
		private var relatedCube:RelatedCube;
		
		public function Technorati(planeDataModel:PlaneDataModel,camerarot:CameraModel){
			super(planeDataModel,camerarot);
			relatedCube = new RelatedCube(planeDataModel,camerarot); 
		}
		
		override public function requestApi(searchText:String = null):void{
			var query:String = REQUEST_URL;
			requestLoad(query);
		}
		
		override protected function completeHandler(event:Event):void{
			var xmlObj:XML = new XML(event.target.data);
			for each(var xml:XML in xmlObj.children().child("item")){
				var title:String = xml.child("title").toString();
				trace("Technorati" + title);
				var cube:Cube = relatedCube.createCube(title);
							
				// focusAppへ追加
				planeDataModel.arrayObj.push(cube);
				planeDataModel.rootNode.addChild(cube);
			}
		}
	}
}