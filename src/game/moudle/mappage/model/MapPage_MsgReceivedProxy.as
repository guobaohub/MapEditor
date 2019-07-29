package game.moudle.mappage.model
{
	import flash.utils.ByteArray;
	
	import game.core.observer.Notification;
	import game.moudle.mappage.view.MapPage_Mediator;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	public class MapPage_MsgReceivedProxy extends Proxy
	{
		public static const NAME:String = "MapPage_MsgReceivedProxy";
		
		
		public function MapPage_MsgReceivedProxy(proxyName:String=null, data:Object=null)
		{
			super(NAME, data);
		}
		
		private var _zhaocaifu_Mediator:MapPage_Mediator
		private function get zhaocaifu_Mediator():MapPage_Mediator {
			if(!_zhaocaifu_Mediator) {
				_zhaocaifu_Mediator = facade.retrieveMediator(MapPage_Mediator.NAME) as MapPage_Mediator;
			}
			return _zhaocaifu_Mediator;
		}
		
		override public function onRegister():void
		{
//			NetWorkManager.registerMsgs([
//				74292
//			],receivedMsgHandle, NAME);
		}
		override public function onRemove():void
		{
//			NetWorkManager.removeMsgs([
//				74292
//			], NAME);	
		}
		
		/**
		 * 处理管道信息
		 * @param $notification
		 */
		private function receivedMsgHandle( $notification:Notification):void
		{
			var name:* = $notification.name;
			var data:ByteArray = $notification.body as ByteArray;
			if(this.hasOwnProperty("received_"+name))
			{
				this["received_"+name](data);
			}
			else
			{
//				ZLog.add("协议号"+name+"不存在");
			}
			return;
		}
		
		/**
		 * 返回面板信息
		 * 当前香数（int）
		 */		
		
		public function received_74292($data:ByteArray):void
		{
			var buf:ByteArray = $data;
			
		}
		
		
		
		
		
		
	}
}