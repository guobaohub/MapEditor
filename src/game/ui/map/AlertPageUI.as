/**Created by the Morn,do not modify.*/
package game.ui.map {
	import morn.core.components.*;
	public class AlertPageUI extends View {
		public var txtLabel:Label = null;
		public var btnOK:Button = null;
		public var btnCancel:Button = null;
		protected static var uiView:XML =
			<View width="300" height="150">
			  <Image skin="png.comp.bg" x="0" y="0" sizeGrid="4,30,4,4" width="300" height="150"/>
			  <Label text="提示信息" x="25" y="51" width="250" height="36" mouseChildren="false" mouseEnabled="false" align="center" multiline="true" wordWrap="true" var="txtLabel"/>
			  <Button label="确定" skin="png.comp.button" x="26" y="106" var="btnOK"/>
			  <Button label="取消" skin="png.comp.button" x="199" y="106" var="btnCancel"/>
			</View>;
		public function AlertPageUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}