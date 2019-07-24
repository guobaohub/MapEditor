package game.common
{
	import flash.display.Sprite;

	public class GameInstance
	{
		public var main:Sprite;	
		public var uiInstace:UIInstance;
		public var uiContainer:Sprite;
		
		private static var _instance:GameInstance;
		public static function get instance():GameInstance{
			if(_instance == null){
				_instance = new GameInstance();
			}
			return _instance;
		}
		
		public function initLayer():void
		{
			uiInstace = new UIInstance();
			
			uiContainer = new Sprite();
			main.addChild(uiContainer);
		}
	}
}