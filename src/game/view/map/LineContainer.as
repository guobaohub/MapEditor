package game.view.map
{
	import flash.display.Shape;

	public class LineContainer extends Shape
	{
		
		public function LineContainer()
		{
			super();
//			720/15 = 50
//			685/15 = 45
			//Config.height / 50
			//Config.width / 37
			
			//shu
			var i:uint = 0;
			for(i =0; i < 46; i ++)				
			{
				graphics.lineStyle(1,0x00ff00);
				graphics.moveTo(0, i * 15);
				graphics.lineTo(720, i * 15);
			}
			//heng
			for(i =0; i < 49; i ++)				
			{
				graphics.lineStyle(1,0x00ff00);
				graphics.moveTo(i * 15, 0);
				graphics.lineTo(i * 15, 685);
			}
		}
	}
}