package game.common.res
{
	public class MapRes
	{
		public function MapRes()
		{
			
		}
		
		public static var mapListRes:Array;
		public static var mapGridRes:Array;
		
		
		
		public static function setMapListRes(data:Array):void
		{
			if(data)	
				mapListRes = data;
		}
	}
}