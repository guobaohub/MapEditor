/**Created by the Morn,do not modify.*/
package game.ui.map {
	import morn.core.components.*;
	public class MapPageUI extends View {
		public var gridList:List = null;
		public var mapList:List = null;
		public var container:Box = null;
		public var btnFuzhu:Button = null;
		public var btnSave:Button = null;
		public var btnOpen:Button = null;
		public var btnNew:Button = null;
		public var btn8X8:Button = null;
		public var btn6X6:Button = null;
		public var txtNativePath:Label = null;
		public var txtName:Label = null;
		public var btnTab:Tab = null;
		public var btnScene:Button = null;
		public var btnProperty:Button = null;
		public var proContainer:Box = null;
		public var monster:TextInput = null;
		public var sceneContainer:Box = null;
		public var bg:TextInput = null;
		protected static var uiView:XML =
			<View width="1200" height="780">
			  <Image skin="png.comp.blank" x="0" y="66" width="276" height="346"/>
			  <Image skin="png.comp.blank" x="0" y="440" width="276" height="311"/>
			  <Image skin="png.comp.blank" x="280" y="66" width="720" height="685"/>
			  <List x="0" y="66" spaceX="0" spaceY="0" width="276" height="346" vScrollBarSkin="png.comp.vscroll" var="gridList">
			    <Box name="render">
			      <Clip skin="png.comp.clip_selectBox" x="0" y="0" clipY="2" width="86" name="selectBox" height="86"/>
			      <Image skin="png.comp.blank" x="2" y="2" width="82" height="82" name="image"/>
			    </Box>
			  </List>
			  <List x="0" y="440" spaceX="0" spaceY="0" width="276" height="311" vScrollBarSkin="png.comp.vscroll" var="mapList">
			    <Box name="render">
			      <Clip skin="png.comp.clip_selectBox" x="0" y="0" clipY="2" width="275" name="selectBox" height="25"/>
			      <Label text="map_test" x="5" y="0" width="259" height="25" name="label" bold="true" size="18"/>
			    </Box>
			  </List>
			  <Box x="280" y="66" width="720" height="685" var="container"/>
			  <Button label="辅助" skin="png.comp.button" x="186" y="6" width="55" height="55" var="btnFuzhu" labelBold="true"/>
			  <Button label="保存" skin="png.comp.button" x="126" y="6" width="55" height="55" var="btnSave" labelBold="true"/>
			  <Button label="目录" skin="png.comp.button" x="6" y="6" width="55" height="55" var="btnOpen" toolTip="打开map存储目录" labelBold="true"/>
			  <Button label="新建" skin="png.comp.button" x="66" y="6" width="55" height="55" var="btnNew" toolTip="新建地图文件" labelBold="true"/>
			  <Button label="8X8" skin="png.comp.button" x="246" y="6" width="55" height="55" var="btn8X8" toolTip="打开map存储目录" labelBold="true"/>
			  <Button label="6X6" skin="png.comp.button" x="306" y="6" width="55" height="55" var="btn6X6" toolTip="打开map存储目录" labelBold="true"/>
			  <Label text="操作目录：" x="6" y="756" bold="true"/>
			  <Label x="75" y="756" bold="true" width="377" height="18" var="txtNativePath"/>
			  <Label text="操作文件：" x="458" y="756" bold="true"/>
			  <Label x="527" y="756" bold="true" width="141" height="18" var="txtName"/>
			  <Tab labels="地基,地表,角色,怪物" skin="png.comp.tab" x="0" y="412" labelBold="true" var="btnTab"/>
			  <Image skin="png.comp.blank" x="1005" y="66" width="195" height="685"/>
			  <Button label="场景" skin="png.comp.button" x="1005" y="6" width="55" height="55" toolTip="打开map存储目录" labelBold="true" var="btnScene"/>
			  <Button label="属性" skin="png.comp.button" x="1065" y="6" width="55" height="55" var="btnProperty" toolTip="打开map存储目录" labelBold="true"/>
			  <Box x="1005" y="66" width="195" var="proContainer" height="685">
			    <Label text="怪物" x="0" y="1" color="0xffffff"/>
			    <TextInput text="0" skin="png.comp.textinput" x="65" y="0" backgroundColor="0x666666" color="0xffffff" background="true" var="monster"/>
			  </Box>
			  <Box x="1005" y="66" width="195" var="sceneContainer" height="685">
			    <Label text="背景" x="0" y="1" color="0xffffff"/>
			    <TextInput text="0" skin="png.comp.textinput" x="65" y="0" backgroundColor="0x666666" color="0xffffff" background="true" var="bg"/>
			  </Box>
			</View>;
		public function MapPageUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}