package game.view.map
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import game.common.GameInstance;
	import game.ui.map.NewMapPageUI;
	
	public class NewMapPage extends NewMapPageUI
	{
		public function NewMapPage()
		{
			super();
			
			btnOK.addEventListener(MouseEvent.CLICK, onClickOK);
			btnCancel.addEventListener(MouseEvent.CLICK, onClickCancel);
		}
		
		private function onClickOK(e:MouseEvent):void
		{
			dispatchEvent(new Event(Event.CLOSE));
			if(this && this.parent)
			{
				this.parent.removeChild(this);
			}
		}
		
		private function onClickCancel(e:MouseEvent):void
		{
			if(this && this.parent)
			{
				this.parent.removeChild(this);
			}
		}		
		
		public static function alert(_label:String, OKLabel:String, cancelLabel:String, calBack:Function, _patent:DisplayObjectContainer = null):void
		{			
			function onClose(e:Event):void
			{
				if(GameInstance.instance.uiInstace.newMapPage.txtlabel.text)
				{
						calBack();
				}
				else
				{
					GameInstance.instance.uiInstace.newMapPage.txtlabel.text = "请输入map name"
				}
			}
			GameInstance.instance.uiInstace.newMapPage.txtlabel.text = _label;
			GameInstance.instance.uiInstace.newMapPage.btnOK.label = OKLabel;
			GameInstance.instance.uiInstace.newMapPage.btnCancel.label = cancelLabel;
			if(!GameInstance.instance.uiInstace.newMapPage.hasEventListener(Event.CLOSE))
				GameInstance.instance.uiInstace.newMapPage.addEventListener(Event.CLOSE, onClose);
			
			if(_patent)
			{
				_patent.addChild(GameInstance.instance.uiInstace.newMapPage);
			}
			else
			{
				GameInstance.instance.main.addChild(GameInstance.instance.uiInstace.newMapPage);
			}
			GameInstance.instance.uiInstace.newMapPage.x = (GameInstance.instance.uiInstace.newMapPage.parent.width - GameInstance.instance.uiInstace.newMapPage.width) >> 1;
			GameInstance.instance.uiInstace.newMapPage.y = (GameInstance.instance.uiInstace.newMapPage.parent.height - GameInstance.instance.uiInstace.newMapPage.height) >> 1;
		}
	}
}