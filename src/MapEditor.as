package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import game.common.GameInstance;
	import game.common.PipeConstants;
	import game.core.manager.FacadeManager;
	import game.core.manager.PipeManager;
	import game.moudle.mappage.MapPage_ApplicationFacade;
	
	import morn.core.handlers.Handler;
	
	public class MapEditor extends Sprite
	{
		public function MapEditor()
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		 
		private function init():void {
			App.init(this);		
			App.loader.loadAssets(["assets/comp.swf", "assets/grid.swf"], new Handler(loadComplete), new Handler(loadProgress));
		}
		
		private function loadProgress(value:Number):void {
			
		}
		
		private function loadComplete():void {	
			GameInstance.instance.main = this;
			GameInstance.instance.initLayer();
			
			FacadeManager.startupFacade(MapPage_ApplicationFacade.NAME);
			PipeManager.sendMsg(PipeConstants.SHOW_MAPEDITOR_PANEL);
		}
	}
}