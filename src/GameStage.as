package {
	import flash.events.MouseEvent;
	
	import game.core.base.BaseEvent;
	import game.ui.GameStageUI;
	import game.view.ButtonTest;
	import game.view.CheckBoxTest;
	import game.view.ClipTest;
	import game.view.ComboBoxTest;
	import game.view.ContainerTest;
	import game.view.DataSourceTest;
	import game.view.FrameClipTest;
	import game.view.LabelTest;
	import game.view.LanguageTest;
	import game.view.LayOutBoxTest;
	import game.view.ListTest;
	import game.view.PanelTest;
	import game.view.ProgressTest;
	import game.view.RadioGroupTest;
	import game.view.SliderTest;
	import game.view.TabTest;
	import game.view.TextAreaTest;
	import game.view.TextInputTest;
	import game.view.ToolTipTest;
	import game.view.ViewStackTest;
	
	import morn.core.components.Button;
	
	/**游戏舞台*/
	public class GameStage extends GameStageUI {
		
		public static const BUTTON_CLICK:String = "BUTTON_CLICK";
		
		public function GameStage() {
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(e:MouseEvent):void {
			
			var btn:Button = e.target as Button;
			if (btn) {
				this.dispatchEvent(new BaseEvent(GameStage.BUTTON_CLICK));
				switch (btn.label) {
					case "按钮": 
						new ButtonTest().show(true);
						break;
					case "多选框": 
						new CheckBoxTest().show(true);
						break;
					case "位图切片": 
						new ClipTest().show(true);
						break;
					case "矢量动画": 
						new FrameClipTest().show(true);
						break;
					case "下拉框": 
						new ComboBoxTest().show(true);
						break;
					case "相对定位": 
						new ContainerTest().show(true);
						break;
					case "文本": 
						new LabelTest().show(true);
						break;
					case "布局容器": 
						new LayOutBoxTest().show(true);
						break;
					case "列表": 
						new ListTest().show(true);
						break;
					case "面板": 
						new PanelTest().show(true);
						break;
					case "进度条": 
						new ProgressTest().show(true);
						break;
					case "滑动条": 
						new SliderTest().show(true);
						break;
					case "单选框": 
						new RadioGroupTest().show(true);
						break;
					case "标签": 
						new TabTest().show(true);
						break;
					case "输入框": 
						new TextInputTest().show(true);
						break;
					case "文本域": 
						new TextAreaTest().show(true);
						break;
					case "多视图": 
						new ViewStackTest().show(true);
						break;
					case "赋值": 
						new DataSourceTest().show(true);
						break;
					case "鼠标提示": 
						new ToolTipTest().show(true);
						break;
					case "多语言": 
						new LanguageTest().show(true);
						break;
				}
			}
		}
	}
}