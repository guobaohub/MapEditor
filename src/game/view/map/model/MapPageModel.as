package game.view.map.model
{
	import game.common.GameInstance;
	import game.view.map.MapPage;

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
		
		public var baseList:Array;
		public var surfaceList:Array;
		public var decorateList:Array;
		public var playerList:Array;
		public var monsterList:Array;
		
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
			
			MapPageSharedObject.instance.data.nativePath = _nativePath;
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
			panel.gridList.selectedIndex = 0;
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
		
		private var _mapGridModel:MapGridModel;

		public function get mapGridModel():MapGridModel
		{
			return _mapGridModel;
		}

		public function set mapGridModel(value:MapGridModel):void
		{
			_mapGridModel = value;			
			_mapGridModel.mapGrid.setMapGridRes(_mapGridModel.mapGridRes);
		}
		
		private var _sceneModel:Boolean;

		public function get sceneModel():Boolean
		{
			return _sceneModel;
		}

		public function set sceneModel(value:Boolean):void
		{
			_sceneModel = value;
			
			panel.btnScene.disabled = value;
			panel.btnProperty.disabled = !panel.btnScene.disabled;
			
			panel.sceneContainer.visible = value;
			panel.proContainer.visible = !panel.sceneContainer.visible;
		}

		
		private var _mapBG:int;

		public function get mapBG():int
		{
			return _mapBG;
		}

		public function set mapBG(value:int):void
		{
			_mapBG = value;
		}

	}		
}

