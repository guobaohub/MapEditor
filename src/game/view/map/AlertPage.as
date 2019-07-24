package game.view.map
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import game.common.GameInstance;
	import game.ui.map.AlertPageUI;
	
	public class AlertPage extends AlertPageUI
	{
		public function AlertPage()
		{
			super();
			
			btnOK.addEventListener(MouseEvent.CLICK, onClickOK);
			btnOK.addEventListener(MouseEvent.CLICK, onClickCancel);
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
		
		public static function alert(_label:String, OKLabel:String, cancelLabel:String, calBack:Function, _patent:DisplayObjectContainer):void
		{			
			GameInstance.instance.uiInstace.alertPage.txtLabel.text = _label;
			GameInstance.instance.uiInstace.alertPage.btnOK.label = _label;
			GameInstance.instance.uiInstace.alertPage.btnCancel.label = _label;
			GameInstance.instance.uiInstace.alertPage.addEventListener(Event.CLOSE, function(e:Event):void
			{
				calBack();
			});
			if(_patent)
			{
				_patent.addChild(GameInstance.instance.uiInstace.alertPage);
			}
			else
			{
				GameInstance.instance.main.addChild(GameInstance.instance.uiInstace.alertPage);
			}
			GameInstance.instance.uiInstace.alertPage.x = (GameInstance.instance.uiInstace.alertPage.parent.x - GameInstance.instance.uiInstace.alertPage.x) >> 1;
			GameInstance.instance.uiInstace.alertPage.y = (GameInstance.instance.uiInstace.alertPage.parent.y - GameInstance.instance.uiInstace.alertPage.y) >> 1;
		}
	}
}