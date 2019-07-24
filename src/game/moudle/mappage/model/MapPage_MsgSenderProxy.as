package game.moudle.mappage.model
{
	import flash.utils.ByteArray;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	public class MapPage_MsgSenderProxy extends Proxy
	{
		public static const NAME:String = 'ZhaoCaiFu_MsgSenderProxy';
		
		public function MapPage_MsgSenderProxy(proxyName:String=null, data:Object=null)
		{
			super(NAME, data);
		}
		
		/**
		 * 请求道具洗绑信息
		 * 
		 */		
		public function send_74291($data:*=null):void
		{
//			ZLog.add("74291：发出 请求招财符信息");
			var buf:ByteArray = new ByteArray();
//			NetWorkManager.sendMsg(74291,buf);			
		}
		
		
	}
}