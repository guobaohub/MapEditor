package game.moudle.mappage
{
	import game.common.PipeConstants;
	import game.core.manager.PipeManager;
	import game.core.observer.Notification;
	import game.moudle.mappage.controller.MapPage_StartupCommand;
	
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	public class MapPage_ApplicationFacade extends Facade
	{
		public static const NAME:String = "game.moudle.mappage.MapPage_ApplicationFacade";
		
		public static const STARTUP:String = "STARTUP";
		
		public function MapPage_ApplicationFacade(key:String)
		{
			super(key);
			PipeManager.registerMsgs( [ 
				PipeConstants.STARTUP_ZHAOCAIFU,
				PipeConstants.SHOW_MAPEDITOR_PANEL
			],
				handlePipeMessage, 
				MapPage_ApplicationFacade 
			);
		}
		
		public static function getInstance() : MapPage_ApplicationFacade 
		{
			if ( instanceMap[ NAME ] == null ) 
				instanceMap[ NAME ] = new MapPage_ApplicationFacade( NAME );
			return instanceMap[ NAME ] as MapPage_ApplicationFacade;
		}
		
		
		override protected function initializeController():void 
		{
			super.initializeController();
			registerCommand( STARTUP, MapPage_StartupCommand );
		}
		/**
		 * 处理管道消息
		 * @param	$notification
		 */
		public function handlePipeMessage( $notification:Notification ):void 
		{
			var key:String = $notification.name;
			var data:Object = $notification.body;
			switch ( key ) 
			{
				//启动此facade
				case PipeConstants.STARTUP_ZHAOCAIFU:
					startup();
					break;
				case PipeConstants.SHOW_MAPEDITOR_PANEL:
					sendNotification(key, data);
					break;
			}
		}
		
		/**
		 * 启动
		 */
		public function startup():void 
		{
			sendNotification( STARTUP );
		}
	}
}