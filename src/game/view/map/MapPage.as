package game.view.map
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	import game.common.GameInstance;
	import game.common.res.MapRes;
	import game.common.utils.DataCreater;
	import game.core.manager.FileManager;
	import game.ui.map.MapPageUI;
	
	import morn.core.components.Box;
	import morn.core.components.List;

	public class MapPage extends MapPageUI
	{
		private var lineContainer:LineContainer;
		public var mapContainer:MapContainer;
		public function MapPage()
		{
			super();			
			
			
			
			mapContainer = new MapContainer();
			container.addChild(mapContainer);
			
			lineContainer = new LineContainer();
			container.addChild(lineContainer);
		}			
		
	}
}