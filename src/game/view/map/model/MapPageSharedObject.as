package game.view.map.model
{
	import flash.net.SharedObject;
	
	public class MapPageSharedObject
	{
		public function MapPageSharedObject()
		{
			
		}
		
		private static var _mapPageShared:SharedObject;
		public static function get instance():SharedObject
		{
			if(_mapPageShared == null)
			{
				_mapPageShared = SharedObject.getLocal("MapEditor");
			}
			return _mapPageShared;
		}
		
		public var nativePath:String = "";
	}
}