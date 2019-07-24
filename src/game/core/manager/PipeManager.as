package game.core.manager
{
	import game.core.observer.Notification;
	import game.core.observer.Observer;
	import game.core.observer.ObserverThread;
	

	/**
	 * 管道管理器(模块与壳 以及 模块间 通讯的第三方管理器)
	 * 回调函数类似这样：function handlePipeMessage( $message:PipeMessage ):void;
	 * @author zcp
	 */	
	public class PipeManager
	{
		/**
		 * 消息观察线程
		 */		
		private static var _msgObserverThread:ObserverThread = new ObserverThread();
		
		/**
		 * 注册消息 
		 * @param $msgCode
		 * @param $callBack 接收数据回调
		 * @param $owner 所有者标识
		 * 
		 */	
		public static function registerMsg ($msgCode:String, $callBack:Function, $owner:*) : void
		{
			var observer:Observer = new Observer($callBack, $owner);
			_msgObserverThread.registerObserver($msgCode,observer);
		}
		/**
		 * 批量注册消息 
		 * @param $msgCodeArr
		 * @param $callBack 接收数据回调
		 * @param $owner 所有者标识
		 * 
		 */	
		public static function registerMsgs ($msgCodeArr:Array, $callBack:Function, $owner:*) : void
		{
			var key:*;
			for each(key in $msgCodeArr)
			{
				registerMsg(key, $callBack, $owner);
			}
		}
		/**
		 * 移除消息 
		 * @param $msgCode
		 * @param $owner
		 * 
		 */	
		public static function removeMsg ($msgCode:String, $owner:*) : void
		{
			_msgObserverThread.removeObserver($msgCode,$owner);
		}
		/**
		 * 批量删除消息 
		 * @param $msgCodeArr
		 * @param $owner 所有者标识
		 * 
		 */	
		public static function removeMsgs ($msgCodeArr:Array,  $owner:*) : void
		{
			var key:*;
			for each(key in $msgCodeArr)
			{
				removeMsg(key, $owner);
			}
		}
		/**
		 * 发送消息
		 * @param $msgCode
		 * @param $data
		 */
		public static function sendMsg ($msgCode:String, $data:Object=null) : void
		{
			var notification:Notification = new Notification($msgCode, $data);
			_msgObserverThread.notifyObservers(notification);
		}
	}
}