package game.view.map
{
	import game.common.GameInstance;

	public class MapPageModel
	{		
		private var _panel:MapPage;
		protected function get panel():MapPage
		{
			if(_panel==null)
			{
				_panel = GameInstance.instance.uiInstace.mapPage;	
			}
			return _panel;
		}
		
		private var _width:uint = 1000;
		public function get width():uint
		{
			return _width;
		}

		public function set width(value:uint):void
		{
			_width = value;
		}
		
		private var _height:uint = 750;
		public function get height():uint
		{
			return _height;
		}

		public function set height(value:uint):void
		{
			_height = value;
		}
		
		private var _nativePath:String = "";

		public function get nativePath():String
		{
			return _nativePath;
		}

		public function set nativePath(value:String):void
		{
			_nativePath = value;
			
			panel.txtNativePath.text = _nativePath;
		}

		private var _name:String = "";

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
			
			panel.txtName.text = _name;
		}
		
		private var _mapData:Array;

		public function get mapData():Array
		{
			return _mapData;
		}

		public function set mapData(value:Array):void
		{
			_mapData = value;
			
			panel.mapContainer.loadMapList(_mapData);
			//720 685
			panel.mapContainer.x = (720 - panel.mapContainer.width) >> 1;
			panel.mapContainer.y = (685 - panel.mapContainer.height) >> 1;
		}
		
		private var _gridList:Array;

		public function get gridList():Array
		{
			return _gridList;
		}

		public function set gridList(value:Array):void
		{
			_gridList = value;
			
			panel.gridList.array = _gridList;
		}

		private var _mapList:Array;

		public function get mapList():Array
		{
			return _mapList;
		}

		public function set mapList(value:Array):void
		{
			_mapList = value;
			
			panel.mapList.array = _mapList;
		}
		
		private var _mapListSelectedItem:Object;

		public function get mapListSelectedItem():Object
		{
			return _mapListSelectedItem;
		}

		public function set mapListSelectedItem(value:Object):void
		{
			_mapListSelectedItem = value;
			
			panel.mapList.selectedItem = _mapListSelectedItem;
		}

		
	}
}