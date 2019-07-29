package game.moudle.mappage.view	
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.ui.KeyboardType;
	import flash.utils.ByteArray;
	
	import game.common.GameInstance;
	import game.common.PipeConstants;
	import game.common.utils.DataCreater;
	import game.core.base.BaseEvent;
	import game.core.manager.FileManager;
	import game.core.manager.UIEventsRegisterManager;
	import game.moudle.mappage.model.MapPage_MsgSenderProxy;
	import game.view.map.MapGrid;
	import game.view.map.MapGridRes;
	import game.view.map.MapPage;
	import game.view.map.NewMapPage;
	import game.view.map.model.MapGridModel;
	import game.view.map.model.MapPageModel;
	import game.view.map.model.MapPageSharedObject;
	
	import morn.core.components.List;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class MapPage_Mediator extends Mediator
	{
		public static const NAME:String = 'MapPage_Mediator';
		
		public function MapPage_Mediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(NAME);
		}
		
		private var _mapPageModel:MapPageModel;
		public function get mapPageModel():MapPageModel
		{
			if(_mapPageModel == null)
			{
				_mapPageModel = new MapPageModel();
			}
			return _mapPageModel;
		}
		
		private var _senderProxy:MapPage_MsgSenderProxy;
		private function get senderProxy():MapPage_MsgSenderProxy
		{
			if(_senderProxy == null) {
				_senderProxy = facade.retrieveProxy(MapPage_MsgSenderProxy.NAME) as MapPage_MsgSenderProxy;
			}
			return _senderProxy;
		}
		
		protected function get panel():MapPage
		{
			if(viewComponent==null)
			{
				setViewComponent(GameInstance.instance.uiInstace.mapPage);	
			}
			return viewComponent as MapPage;
		}
		
		override public function listNotificationInterests():Array
		{
			return [ 
				PipeConstants.SHOW_MAPEDITOR_PANEL				
			];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case PipeConstants.SHOW_MAPEDITOR_PANEL:
//					GameInstance.instance.main.addChild(GameInstance.instance.uiInstace.gameStage);
					GameInstance.instance.main.addChild(panel);
					loadRes();
					panel.mapList.array = [];
					
					if(MapPageSharedObject.instance && MapPageSharedObject.instance.data.nativePath)
					{
						mapPageModel.nativePath = MapPageSharedObject.instance.data.nativePath;
						var list:Array = FileManager.getAllFiles(new File(mapPageModel.nativePath), [".json"]);
						var vec:Array = DataCreater.getgetFilesVector(list);
						if(vec.length > 0)
						{
							mapPageModel.mapList = vec;
							mapPageModel.mapListSelectedItem = vec[0];
						}
						mapPageModel.sceneModel = true;
					}					
					break;
			}
		}
		
		override public function onRegister():void {
			//注册事件
			initEvents();
		}
		
		/**
		 * 注册事件
		 */
		private function initEvents():void
		{		
			UIEventsRegisterManager.addUIRegisterEvent(MapPage,function():void{
				panel.addEventListener(Event.ADDED_TO_STAGE, handler);
				panel.addEventListener(Event.REMOVED_FROM_STAGE, handler);				
				panel.addEventListener(GameStage.BUTTON_CLICK, handler);
				
				panel.mapList.addEventListener(Event.CHANGE, onChangeHandler);
				panel.gridList.addEventListener(Event.CHANGE, onChangeHandler1);
				panel.btnTab.addEventListener(Event.CHANGE, onTabHandler);
				GameInstance.instance.main.stage.addEventListener(MouseEvent.MOUSE_DOWN, onHandler);
				GameInstance.instance.main.stage.addEventListener(MouseEvent.MOUSE_UP, onHandler);
				GameInstance.instance.main.stage.addEventListener(MouseEvent.MOUSE_MOVE, onHandler);	
				GameInstance.instance.main.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyHandler);
				panel.btnOpen.addEventListener(MouseEvent.CLICK, onOpenHandler);
				panel.btnNew.addEventListener(MouseEvent.CLICK, onNewHandler);
				panel.btnSave.addEventListener(MouseEvent.CLICK, onSaveHandler);
				panel.btn8X8.addEventListener(MouseEvent.CLICK, onSortHandler);
				panel.btn6X6.addEventListener(MouseEvent.CLICK, onSortHandler);	
				panel.btnScene.addEventListener(MouseEvent.CLICK, onSortHandler);	
				panel.btnProperty.addEventListener(MouseEvent.CLICK, onSortHandler);	
			});
			UIEventsRegisterManager.addUIRemovedEvent(MapPage,function():void{
				panel.removeEventListener(Event.ADDED_TO_STAGE, handler);
				panel.removeEventListener(Event.REMOVED_FROM_STAGE, handler);				
				panel.removeEventListener(GameStage.BUTTON_CLICK, handler);
				
				panel.mapList.removeEventListener(Event.CHANGE, onChangeHandler);
				panel.gridList.removeEventListener(Event.CHANGE, onChangeHandler1);
				panel.btnTab.removeEventListener(Event.CHANGE, onTabHandler);
				GameInstance.instance.main.stage.removeEventListener(MouseEvent.MOUSE_DOWN, onHandler);
				GameInstance.instance.main.stage.removeEventListener(MouseEvent.MOUSE_UP, onHandler);
				GameInstance.instance.main.stage.removeEventListener(MouseEvent.MOUSE_OUT, onHandler);
				GameInstance.instance.main.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onHandler);		
				GameInstance.instance.main.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyHandler);
				panel.btnOpen.removeEventListener(MouseEvent.CLICK, onOpenHandler);
				panel.btnNew.removeEventListener(MouseEvent.CLICK, onNewHandler);
				panel.btnSave.removeEventListener(MouseEvent.CLICK, onSaveHandler);
				panel.btn8X8.removeEventListener(MouseEvent.CLICK, onSortHandler);
				panel.btn6X6.removeEventListener(MouseEvent.CLICK, onSortHandler);	
				panel.btnScene.removeEventListener(MouseEvent.CLICK, onSortHandler);	
				panel.btnProperty.removeEventListener(MouseEvent.CLICK, onSortHandler);
			});
		}
		
		private function handler(e:Event):void
		{	
			
		}
		
		private function onKeyHandler(e:KeyboardEvent):void
		{	
			if(e.controlKey && e.keyCode == Keyboard.S)
			{
				onSaveHandler();
			}
		}
		
		private function onTabHandler(e:Event):void
		{
			switch(panel.btnTab.selectedIndex)
			{
				case 0:
					mapPageModel.gridList = mapPageModel.baseList;
					break;
				case 1:
					mapPageModel.gridList = mapPageModel.surfaceList;
					break;
//				case 2:
//					mapPageModel.gridList = mapPageModel.decorateList;
//					break;
				case 2:
					mapPageModel.gridList = mapPageModel.playerList;
					break;
				case 3:
					mapPageModel.gridList = mapPageModel.monsterList;
					break;
			}
			mapPageModel.sceneModel = true;
		}
		
		private function onChangeHandler1(e:Event):void
		{
			mapPageModel.sceneModel = true;
		}
		
		private var curData:Object;
		private function onChangeHandler(e:Event):void
		{
			var data:Object = (e.target as List).selectedItem;	
			curData = data;
			mapPageModel.name = data.label as String;
			var byte:ByteArray = data.byte as ByteArray;
			var st:String = data.data;
			var config:Object = st ? JSON.parse(st) : new Object();
			var arr:Array = config.map ? config.map as Array : [];
			
			mapPageModel.mapData = arr;	
			mapPageModel.sceneModel = true;
		}
		
		private var target:MapGrid;
		private function onHandler(e:MouseEvent):void
		{
			switch(e.type)
			{
				case MouseEvent.MOUSE_DOWN:
					if(target)
					{
						var mapGridRes:MapGridRes = target.mapGridRes;		
						
						if(mapPageModel.sceneModel)
						{
							if(panel.btnTab.selectedIndex == 0 && panel.gridList.selectedIndex == 0) return;
							switch(panel.btnTab.selectedIndex)
							{
								case 0:
									mapGridRes.base = panel.gridList.selectedIndex;
									break;
								case 1:
									mapGridRes.surface = panel.gridList.selectedIndex;
									break;
//								case 2:
//									mapGridRes.decorate = panel.gridList.selectedIndex;
//									break;
								case 2:
									mapGridRes.player = panel.gridList.selectedIndex;
									break;
								case 3:
									mapGridRes.monster = panel.gridList.selectedIndex;
									break;
							}
							var mapGridModel:MapGridModel = new MapGridModel();
							mapGridModel.mapGrid = target;
							mapGridModel.mapGridRes = mapGridRes;
							
							mapPageModel.mapGridModel = mapGridModel;
						}	
						else
						{
							if(e.target as MapGrid)
							{
								setTargetFilter(e.stageX, e.stageY);
							}
						}
					}
					else
					{
						if(e.target as MapGrid)
						{
							setTargetFilter(e.stageX, e.stageY);
						}
					}
					break;
				case MouseEvent.MOUSE_UP:
					break;
				case MouseEvent.MOUSE_OUT:
					break;
				case MouseEvent.MOUSE_MOVE:
					if(mapPageModel.sceneModel)
					{
						if(e.target as MapGrid)
						{
							setTargetFilter(e.stageX, e.stageY);
						}
						else
						{
							if(target)
							{
								target.filters = [];
								target = null;
							}
						}
					}
					else
					{
						
					}					
					break;	
			}
		}
		
		private function setTargetFilter(stageX:Number, stageY:Number):void
		{
			for(var i:int = 0; i < panel.mapContainer.numChildren; i ++)
			{
				var t:MapGrid =  panel.mapContainer.getChildAt(i) as MapGrid;
				arrPoly = [[t.x + 0, t.y + 15], [t.x + 30, t.y + 0], [t.x + 30, t.y + 30], [t.x + 60, t.y + 15]];
				if(pointInPoly(stageX  - panel.container.x - panel.mapContainer.x, stageY - panel.container.y - panel.mapContainer.y, arrPoly))
				{
					if(target)
					{
						target.filters = [];
					}
					target = t;
					target.filters = [new GlowFilter(0xffffff, 1, 3, 3, 15, BitmapFilterQuality.LOW)];
				}
			}
		}
		
		private function loadRes():void
		{
			var dataList:Array;
			var i:uint = 0;
			var vect:Vector.<Object>;		
			
			dataList = new Array();
			for(i = 0; i < 6; i ++)
			{
				dataList.push({image : "png.grid.base." + i});//{image : "png.grid.base." + (i + 1), index : (i + 1)}
			}
			mapPageModel.baseList = dataList;
			
			dataList = new Array();
			for(i = 0; i < 2; i ++)
			{
				dataList.push({image : "png.grid.surface." + i});
			}
			mapPageModel.surfaceList = dataList;
			
			dataList = new Array();
			for(i = 0; i < 0; i ++)
			{
				dataList.push({image : "png.grid.decorate." + i});
			}
			mapPageModel.decorateList = dataList;
			
			dataList = new Array();
			for(i = 0; i < 2; i ++)
			{
				dataList.push({image : "png.grid.player." + i});
			}
			mapPageModel.playerList = dataList;
			
			dataList = new Array();
			for(i = 0; i < 2; i ++)
			{
				dataList.push({image : "png.grid.monster." + i});
			}
			mapPageModel.monsterList = dataList;
			
			panel.btnTab.selectedIndex = 0;
			mapPageModel.gridList = mapPageModel.baseList;
		}
		
		/**
		 * 新建地图文件
		 */		
		private function onNewHandler(e:MouseEvent):void
		{
			if(mapPageModel.nativePath)
			{
				NewMapPage.alert("", "确定", "取消", function():void{
					var name:String = GameInstance.instance.uiInstace.newMapPage.txtlabel.text + ".json";	
					mapPageModel.name = name;
					if(mapPageModel.nativePath && mapPageModel.name)
					{
						var data:String = "";
						FileManager.saveJSON(data, mapPageModel.nativePath  + "\\" + mapPageModel.name, function():void{
							var list:Array = FileManager.getAllFiles(new File(mapPageModel.nativePath), [".json"]);
							var vec:Array = DataCreater.getgetFilesVector(list);
							if(vec.length > 0)
							{
								mapPageModel.mapList = vec;
								
								for(var i:int = 0; i < vec.length; i ++)
								{
									if(mapPageModel.name == vec[i].label)
									{
										mapPageModel.mapListSelectedItem = vec[i];
									}
								}
							}
							else
							{
								
							}
						});						
					}
					else 
					{
						//提示
					}		
				});
			}
		}
		
		/**
		 * 打开目录，如果为空创模板文件
		 */		
		private function onOpenHandler(e:MouseEvent = null):void
		{
			DataCreater.openFile(function(list:Array, patch:String):void
			{
				mapPageModel.nativePath = patch;
				if(list.length > 0)
				{
					var vec:Array = DataCreater.getgetFilesVector(list);
					if(vec.length > 0)
					{						
						mapPageModel.mapList = vec;
						mapPageModel.mapListSelectedItem = vec[0];;
					}					
				}
				else
				{
					
				}				
			});			
		}
		
		/**
		 * 获取当前地图数据
		 */		
		private function getMapData():String
		{
			var data:String = '{"bg":' + mapPageModel.mapBG + ',"map":[';
			var i:uint = 0;
			var r:MapGridRes;
			for(i = 0; i < panel.mapContainer.numChildren; i ++)
			{
				r = (panel.mapContainer.getChildAt(i) as MapGrid).mapGridRes;
				if(i > 0) data += ",";
				data += '{' +
					'"x":' + r.x + "," + 
					'"y":' + r.y +  "," + 
					'"base":' + r.base + "," + 
					'"surface":' + r.surface +  "," + 
					'"decorate":' + r.decorate +  "," + 
					'"player":' + r.player +  "," + 
					'"monster":' + r.monster
					+ '}';
			}			
			data += "]}";
			return data;
		}
		
		private function onSaveHandler(e:MouseEvent = null):void
		{			
			if(mapPageModel.nativePath && mapPageModel.name)
			{
				var data:String = getMapData();
				curData.data = data;
				mapPageModel.mapListSelectedItem = curData;
				FileManager.saveJSON(data, mapPageModel.nativePath  + "\\" + mapPageModel.name);
			}
			else 
			{
				//提示
			}			
		}
		
		/**
		 * 层级排序
		 */		
		private function sortMapContainer():void
		{
			var children:Array = [];   
			var n:uint =0;
			for(n = 0; n < panel.mapContainer.numChildren; n ++){
				children.push(panel.mapContainer.getChildAt(n) as MapGrid);
			}
			
			children.sortOn(["y", "x"],[Array.NUMERIC, Array.NUMERIC]);
			
			for(n = 0; n < children.length; n++){
				panel.mapContainer.setChildIndex(children[n], n);
			}
		}
		
		private function onSortHandler(e:MouseEvent):void
		{
			if(!mapPageModel.nativePath || !mapPageModel.name) return;
			switch(e.target)
			{
				case panel.btn6X6:
					sortMapContainerAxB(6, 6);
					break;				
				case panel.btn8X8:
					sortMapContainerAxB(8, 8);
					break;
				case panel.btnScene:
					mapPageModel.sceneModel = true;
					break;
				case panel.btnProperty:
					mapPageModel.sceneModel = false;
					if(target)
					{
						target.filters = [];
						target = null;
					}					
					break;
			}			
		}
		
		private function sortMapContainerAxB(A:int, B :int):void
		{
			var children:Array = [];   
			var n:uint =0;
			var leng:int = A * B > panel.mapContainer.numChildren ? A * B : panel.mapContainer.numChildren;
			for(n = 0; n < leng; n ++){
				if(n < A * B)
				{											
					if(n < panel.mapContainer.numChildren)
						//有就直接用	
						children.push(panel.mapContainer.getChildAt(n) as MapGrid);
					else 
						//没有就得造
						children.push(panel.mapContainer.loadMapGrid(new MapGridRes()));
				}	
				else
				{
					//超了就得删
					if(panel.mapContainer.getChildAt(panel.mapContainer.numChildren - 1) as MapGrid)
						panel.mapContainer.removeChildAt(panel.mapContainer.numChildren - 1)
				}
			}
			for(var i:int = 0; i < A; i ++)
			{
				for(var j:int = 0; j < B; j ++)
				{
					var grid:MapGrid = children[i * A + j] as MapGrid;
					
					grid.x = i * 30 + j * 30;
					grid.y = (B - 1 - j) * 15 + i* 15;
					grid.mapGridRes.x = grid.x;
					grid.mapGridRes.y = grid.y;
				}
			}			
			sortMapContainer();
			//720 685
			panel.mapContainer.x = (720 - panel.mapContainer.width) >> 1;
			panel.mapContainer.y = (685 - panel.mapContainer.height) >> 1;
		}			
		
		private var arrPoly:Array = [[0, 15], [30, 0], [30, 30], [60, 15]];
		private function pointInPoly(x:int, y:int, arrPoly:Array):Boolean
		{  
			var A:Point = new Point(arrPoly[1][0], arrPoly[1][1]);
			var B:Point = new Point(arrPoly[0][0], arrPoly[0][1]);			  
			var C:Point = new Point(arrPoly[2][0], arrPoly[2][1]); 						
			var D:Point = new Point(arrPoly[3][0], arrPoly[3][1]); 
			
			var a:int  = (B.x - A.x)*(y - A.y) - (B.y - A.y)*(x - A.x);  
			var b:int  = (C.x - B.x)*(y - B.y) - (C.y - B.y)*(x - B.x);  
			var c:int  = (D.x - C.x)*(y - C.y) - (D.y - C.y)*(x - C.x);  
			var d:int  = (A.x - D.x)*(y - D.y) - (A.y - D.y)*(x - D.x);  
			if((a > 0 && b > 0 && c > 0 && d > 0) || (a < 0 && b < 0 && c < 0 && d < 0)) {  
				return true;  
			} 
			return false;   
		}
		
	}
}