package game.core.timer.vo
{
	import flash.utils.Timer;
	/**
	 * 计时器模型对象
	 * @author zcp
	 * 
	 */	
	public class TimerData
	{
		private var _timer:Timer;
		private var _destroy:Function;

		/**
		 * TimerData
		 * @param $timer
		 * @param $destroy 销毁该Timer的函数
		 * 
		 */	
		public function TimerData($timer:Timer, $destroy:Function)
		{
			_timer = $timer;
			_destroy = $destroy;
		}
		public function get timer():Timer
		{
			return _timer;
		}
		public function get destroy():Function
		{
			return _destroy;
		}
	}
}