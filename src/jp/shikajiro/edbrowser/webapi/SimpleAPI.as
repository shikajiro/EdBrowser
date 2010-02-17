package jp.shikajiro.edbrowser.webapi{
	
	public class SimpleAPI{
	
		public static const SIMPLE_API:String = "http://img.simpleapi.net/small/";
	
		public static function requestApi(url:String):String{
			return SIMPLE_API + url;
		}

	}
}