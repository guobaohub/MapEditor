package game.view.map
{
	import flash.display.Sprite;
	
	import game.view.map.model.OtherConst;
	
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
			base.skin = OtherConst.base + 1;
			base.scale = 0.6;
			this.addChild(base);
			
			surface = new Image();
			surface.scale = 0.6;
			this.addChild(surface);
			
			decorate = new Image();
			decorate.scale = 0.6;
			this.addChild(decorate);
			
			player = new Image();
			player.scale = 0.6;
			this.addChild(player);
			
			monster = new Image();
			monster.scale = 0.6;
			this.addChild(monster);
			
			mapGridRes = _mapGridRes;
			
			setMapGridRes(mapGridRes);
		}
		
		public function setMapGridRes(_mapGridRes:MapGridRes):void
		{		
			if(_mapGridRes.x && _mapGridRes.x >= 0) this.x = _mapGridRes.x;
			if(_mapGridRes.y && _mapGridRes.y >= 0) this.y = _mapGridRes.y;		
			
			base.skin = _mapGridRes.base ? OtherConst.base + _mapGridRes.base : "";	
			
			surface.skin = _mapGridRes.surface ? OtherConst.surface + 1 : "";
			surface.y = 60 - 100;
			
			decorate.skin = _mapGridRes.decorate ? OtherConst.decorate + _mapGridRes.decorate : "";
			decorate.y = 60 - 100;
			
			player.skin = _mapGridRes.player ? OtherConst.player + 1 : "";
			player.x = 10; player.y = 30 * 0.6 - player.height;
			
			monster.skin = _mapGridRes.monster ? OtherConst.monster + 1 : "";
			monster.x = (100 - monster.width) >> 1;
			monster.y = 50 - monster.height;
		}
		
		private function init():void			
		{
			
		}
	}
}