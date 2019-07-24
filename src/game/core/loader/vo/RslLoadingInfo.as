package game.core.loader.vo
{
	

	/**
	 * RslLoadingInfo
	 * @author zcp
	 */	
	public class RslLoadingInfo
	{
		/**loadData数组*/
		public var loadList:Array;
		/**全体完成回调*/
		public var callBack:Function;
		/**全体优先级*/
		public var priority:int;
		
		public function RslLoadingInfo($loadList:Array, $callBack:Function, $priority:int)
		{
			loadList = $loadList;
			callBack = $callBack;
			priority = $priority;
		}
	}
}