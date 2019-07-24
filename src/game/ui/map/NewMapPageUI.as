/**Created by the Morn,do not modify.*/
package game.ui.map {
	import morn.core.components.*;
	public class NewMapPageUI extends View {
		public var btnOK:Button = null;
		public var btnCancel:Button = null;
		public var txtlabel:TextInput = null;
		protected static var uiView:XML =
			<View width="300" height="150">
			  <Image skin="png.comp.bg" x="0" y="0" sizeGrid="4,30,4,4" width="300" height="150"/>
			  <Button label="确定" skin="png.comp.button" x="26" y="106" var="btnOK"/>
			  <Button label="取消" skin="png.comp.button" x="199" y="106" var="btnCancel"/>
			  <TextInput skin="png.comp.textinput" x="53" y="62" width="196" height="22" var="txtlabel"/>
			</View>;
		public function NewMapPageUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}