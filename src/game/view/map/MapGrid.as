package game.view.map
{
	import flash.display.Sprite;
	
	import morn.core.components.Image;
	
	public class MapGrid extends Sprite
	{	
		public var mapGridRes:MapGridRes;
		
		private var base:Image;
		private var surface:Image;
		private var decorate:Image;
		private var player:Image;
		private var monster:Image;
		public function MapGrid(_mapGridRes:MapGridRes)
		{
			super();
			
			base = new Image();
			base.skin = "png.grid.base.1";
			base.scale = 0.6;
			this.addChild(base);
			
			surface = new Image();
			surface.scale = 0.6;
			this.addChild(surface);
			
			decorate = new Image();
			decorate.scale = 0.6;
			this.addChild(decorate);
			
			player = new Image();
//			player.scale = 0.6;
			this.addChild(player);
			
			monster = new Image();
//			monster.scale = 0.6;
			this.addChild(monster);
			
			mapGridRes = _mapGridRes;
			
			setMapGridRes(mapGridRes);
		}
		
		public function setMapGridRes(_mapGridRes:MapGridRes):void
		{		
			if(_mapGridRes.x && _mapGridRes.x >= 0) this.x = _mapGridRes.x;
			if(_mapGridRes.y && _mapGridRes.y >= 0) this.y = _mapGridRes.y;		
			
			base.skin = _mapGridRes.base ? "png.grid.base." + _mapGridRes.base : "";	
			
			surface.skin = _mapGridRes.surface ? "png.grid.surface." + _mapGridRes.surface : "";
			surface.y = 60 - 100;
			
			decorate.skin = _mapGridRes.decorate ? "png.grid.decorate." + _mapGridRes.decorate : "";
			decorate.y = 60 - 100;
			
			player.skin = _mapGridRes.player ? "png.grid.player." + _mapGridRes.player : "";
			player.x = 10; player.y = 90 - 100;
			
			monster.skin = _mapGridRes.monster ? "png.grid.monster." + _mapGridRes.monster : "";
			monster.y = 30 - 100;
		}
		
		private function init():void			
		{
			
		}
	}
}