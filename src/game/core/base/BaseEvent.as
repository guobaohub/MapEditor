package game.core.base
{
	import flash.events.Event;
	/**
	 * 事件基类
	 * @author zcp
	 * 
	 */	
	public class BaseEvent extends Event
	{
        public static const INIT_COMPLETE:String	= "BaseEvent.initComplete";
        public static const UPDATE:String			= "BaseEvent.update";
        public static const COMPLETE:String		= "BaseEvent.complete";        
		/**类型*/
		public var action:String;
		/**数据*/
		public var data:Object;
	  
		public function BaseEvent($type:String, $action:String="",$data:Object=null, $bubbles:Boolean=false, $cancelable:Boolean=false)
		{
			super($type, $bubbles, $cancelable);
			action = $action;
			data = $data;
		}
		/**创建一个副本*/
        override public function clone():Event
        {
        	return new BaseEvent(type,action,data, bubbles, cancelable);
        }
        
        override public function toString():String
        {
        	return "[BaseEvent]";
        }
	}
}