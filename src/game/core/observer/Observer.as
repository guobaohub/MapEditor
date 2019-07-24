package game.core.observer
{
	/**
	 * 观察者
	 * @author zcp
	 */
	public class Observer
	{
		/**通知函数*/
		public var notifyMethod:Function;
		/**通知的所有者标识，一般为一个字符串*/
		public var notifyContext:*;
		
		/**
		 * 观Observer者
		 * @parm $notifyMethod
		 * @parm $type 类型可以为空
		 */
		public function Observer( $notifyMethod:Function, $notifyContext:* )
		{
			notifyMethod = $notifyMethod;
			notifyContext = $notifyContext;
		}
		/**
		 * 通知Observer
		 * 
		 */
		public function notifyObserver( $notification:Notification ):void
		{
			notifyMethod.apply(notifyContext,[$notification]);
		}
		/**
		 * 比较类型
		 * @parm $notifyContext
		 */
		public function compareNotifyContext( $notifyContext:* ):Boolean
		{
			return $notifyContext === notifyContext;
		}	
	}
}