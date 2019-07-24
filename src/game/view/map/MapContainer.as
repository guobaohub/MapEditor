package game.view.map
{
	import flash.display.Sprite;

	public class MapContainer extends Sprite
	{
		
		public function MapContainer()
		{
			super();			
		}
		
		public function loadMapList(arr:Array):void
		{
			while(this.numChildren>0){
				this.removeChildAt(0);
			}
			var i:uint = 0;
			for(i = 0; i < arr.length; i ++)
			{
				var mapGridRes:MapGridRes = new MapGridRes();
				var data:Object = arr[i] as Object;
				for (var key:String in data)
				{
					mapGridRes[key] = data[key];
				}
				var mapGrid:MapGrid = new MapGrid(mapGridRes);
				mapGrid.mouseChildren = false;
				addChild(mapGrid);
			}
		}
		
		public function loadMapGrid(mapGridRes:MapGridRes):MapGrid
		{
			var mapGrid:MapGrid = new MapGrid(mapGridRes);
			mapGrid.mouseChildren = false;
			addChild(mapGrid);
			return mapGrid;
		}
	}
}