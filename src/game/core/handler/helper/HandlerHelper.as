package game.core.handler.helper
{
	import flash.events.Event;
	/**
	 * 函数辅助器
	 * @author zcp
	 * 
	 */	
	public class HandlerHelper
	{
		public function HandlerHelper()
		{
			throw new Event("静态类");
		}
		/**
		 * 立即执行某函数
		 * 
		 */			
		public static function execute($handler:Function, $parameters:Array=null):*
		{
			if($handler==null)return null;
			return $handler.apply(null,$parameters);
		}
	}
}