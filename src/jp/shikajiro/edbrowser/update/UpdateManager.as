package jp.shikajiro.edbrowser.update
{
	import air.update.ApplicationUpdaterUI;
	
	import flash.events.ErrorEvent;

	public class UpdateManager extends ApplicationUpdaterUI
	{
		public function UpdateManager()
		{
			super();
			
			updateURL = 'http://shikajiro.googlepages.com/update.xml';
			
			isCheckForUpdateVisible = false;
			isDownloadUpdateVisible = true;
			isDownloadProgressVisible = true;
			isInstallUpdateVisible = true;
			
			addEventListener(ErrorEvent.ERROR,trace);
		}
		
	}
}