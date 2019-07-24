package game.core.handler.vo
{
	import flash.events.EventDispatcher;
	/**
	 * 执行函数模型对象
	 * @author zcp
	 * 
	 */	
	public class HandlerData
	{
		private var _handler:Function;
		private var _parameters:Array;
		private var _delay:Number;
		private var _doNext:Boolean;
		/**
		 * HandlerData
		 * @param $handler 函数
		 * @param $parameters 参数数组
		 * @param $delay 延时（单位：毫秒）
		 * @param $doNext 执行完毕是否自动执行下一个
		 */
		public function HandlerData($handler:Function, $parameters:Array=null,$delay:Number=0,$doNext:Boolean=true)
		{
			_handler = $handler;
			_parameters = $parameters;
			_delay = $delay;
			_doNext = $doNext;
		}
		public function get handler():Function
		{
			return _handler;
		}
		public function get parameters():Array
		{
			return _parameters;
		}
		public function get delay():Number
		{
			return _delay;
		}
		public function get doNext():Boolean
		{
			return _doNext;
		}	
	}
}