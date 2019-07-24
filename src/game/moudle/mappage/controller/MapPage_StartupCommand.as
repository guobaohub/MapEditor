package game.moudle.mappage.controller
{
	import game.moudle.mappage.model.MapPage_MsgReceivedProxy;
	import game.moudle.mappage.model.MapPage_MsgSenderProxy;
	import game.moudle.mappage.view.MapPage_Mediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class MapPage_StartupCommand extends SimpleCommand
	{
		public function MapPage_StartupCommand()
		{
			super();
		}
		override public function execute( $note:INotification ):void 
		{
			//register proxy
			facade.registerProxy( new MapPage_MsgReceivedProxy() );
			facade.registerProxy( new MapPage_MsgSenderProxy() );
			facade.registerMediator( new MapPage_Mediator() );
		}
	}
}