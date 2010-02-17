package jp.shikajiro.edbrowser
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	/**
	 * 固定のアイコンを保持するsingleton
	 */
	public class IconType
	{
		public static var iconType:IconType;
		
		public var imageIcon:Object = new Object();
		
		public static const PHOTO:String = "img/iPhoto_32.png";
		public static const MOVIE:String = "img/Movie-32.png";
		public static const BROWSER:String = "img/Window1_32.png";
		public static const YOUTUBE:String = "img/Youtube_32.png";
		
		[Embed(source='img/iPhoto_32.png')]
		private static const PhotoImage:Class;
		[Embed(source='img/Movie_32.png')]
		private static const MovieImage:Class;
		[Embed(source='img/Window1_32.png')]
		private static const WindowImage:Class;
		[Embed(source='img/Youtube_32.png')]
		private static const YoutubeImage:Class;
		
		function IconType(){
			trace("IconType()");
			var photoImage:Bitmap = new PhotoImage();
			var movieImage:Bitmap = new MovieImage();
			var windowImage:Bitmap = new WindowImage();
			var youtubeImage:Bitmap = new YoutubeImage();
			imageIcon[PHOTO] = photoImage.bitmapData;
			imageIcon[MOVIE] = movieImage.bitmapData;
			imageIcon[BROWSER] = windowImage.bitmapData;
			imageIcon[YOUTUBE] = youtubeImage.bitmapData;
		}
		public static function getInstance():IconType{
			if(iconType == null){
				iconType = new IconType();
			}
			return iconType;
		}
	}
}