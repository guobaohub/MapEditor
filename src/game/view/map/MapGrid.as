package game.view.map
{
	import flash.display.Sprite;
	
	import morn.core.components.Image;
	
	public class MapGrid extends Sprite
	{	
		public var mapGridRes:MapGridRes;
		
		public function MapGrid(_mapGridRes:MapGridRes)
		{
			super();
			
			var image:Image = new Image();
			image.skin = "png.grid.base.1";
			image.scale = 0.6;
			this.addChild(image);
			
			mapGridRes = _mapGridRes;
			
			setMapGridRes(mapGridRes);
		}
		
		public function setMapGridRes(_mapGridRes:MapGridRes):void
		{		
			if(_mapGridRes.x && _mapGridRes.x >= 0) this.x = _mapGridRes.x;
			if(_mapGridRes.y && _mapGridRes.y >= 0) this.y = _mapGridRes.y;			
		}
		
		private function init():void			
		{
			
		}
	}
}