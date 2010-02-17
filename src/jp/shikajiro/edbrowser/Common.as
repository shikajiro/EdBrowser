package jp.shikajiro.edbrowser
{
	public class Common
	{
		public function Common()
		{
		}
		/**
		 * 共通関数
		 */
		public static function xRandomInt(n:int):int {
			// nMinからnMaxまでのランダムな整数を返す
			return Math.floor(Math.random()*(n*2+1))-n;
		}
	}
}