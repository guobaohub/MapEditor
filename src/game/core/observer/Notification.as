package game.core.observer
{
	/**
	 * 通知信息
	 * @author zcp
	 */
	public class Notification
	{
		/**通知标识*/
		public var name : *;
		/**通知数据体*/
		public var body : *;
		/**
		 * Notification 
		 * @param $name
		 * @param $body
		 */
		public function Notification( $name:*, $body:*=null)
		{
			name = $name;
			body = $body;
		}
	}
}