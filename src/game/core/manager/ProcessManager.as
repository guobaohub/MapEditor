package game.core.manager
{
	import game.common.PipeConstants;
	import game.common.GameState;
	import game.core.handler.HandlerThread;
	import game.core.manager.PipeManager;
	

	/**
	 * 流程控制器（尤其针对流程等待的处理）
	 * @author zcp
	 */	
	public class ProcessManager
	{
		/**
		 * 客户端准备就绪
		 * 
		 */	
		public static function clientReady() : void
		{				
			//第一次进入场景,执行一些操作
			if(GameState.fristEnterScene)
			{
				GameState.fristEnterScene = false;
				trace("ProcessManager:正在启动程序模块 和 初始化界面");
									
				//启动各个模块
				var delay:Number = 5;
				var ht:HandlerThread = new HandlerThread();
				var facadeArr:Array = [
					//启动"UI模块"
				];
				var facadeName:String;
				var i:int;
				var len:int = facadeArr.length;
				for(i=0; i<len; i++)
				{
					facadeName = facadeArr[i];
					ht.push(startupFacade, [i,facadeName], delay);
				}
				function startupFacade($i:int, $facadeName:String):void
				{
					FacadeManager.startupFacade($facadeName);
				}

				//发送管道消息
				var msgArr:Array = [
					//展示主界面
					//发送客户端准备完毕
					PipeConstants.CLIENT_READY
				];
				var msg:String;
				var len2:int = msgArr.length;
				for(i=0; i<len2; i++)
				{
					msg = msgArr[i];
					ht.push(sendMsg, [i,msg], delay);
				}
				function sendMsg($i:int, $msg:String):void
				{
					PipeManager.sendMsg($msg);
				}
				trace("ProcessManager:启动模块和初始化界面完毕");
			}
			else
			{
				trace("ProcessManager:正在请求进入场景");
				//发送客户端准备完毕
				PipeManager.sendMsg(PipeConstants.CLIENT_READY);
			}
		}
	}
}