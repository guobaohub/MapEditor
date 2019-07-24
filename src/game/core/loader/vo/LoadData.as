package game.core.loader.vo
{
	import flash.display.LoaderInfo;
	import flash.events.EventDispatcher;

	/**
	 * 基本加载模型对象
	 * 所有回调的参数类型统一为(loadData:LoadData, e:Event)
	 * e类型分别为Event、ProgressEvent、IOErrorEvent或SecurityErrorEvent
	 * @author zcp
	 * 
	 */	
	public class LoadData
	{
		private var _url:String;//地址
		private var _name:String;//用于显示信息
		private var _key:String;//加载唯一标识
		private var _priority:int;//加载优先级

		
		private var _onComplete:Function;
		private var _onUpdate:Function;
		private var _onError:Function;
		
		private var _decode:Function;//解密函数
		
		
		private var _userData:Object;//自定义数据
		/**只读属性的自定义数据！！！*/
		public function get userData():Object
		{
			if(_userData==null)
			{
				_userData = {};
			}
			return _userData;
		}
		
		/**
		 * LoadData
		 * @param $url 
		 * @param $onComplete
	 	 * @param $onUpdate 
	 	 * @param $onError 
	 	 * @param $name
	 	 * @param $key
	 	 * @param $priority 加载优先级（值越高越先加载）
	 	 * @param $decode 解密函数
		 */
		public function LoadData($url:String,$onComplete:Function=null,$onUpdate:Function=null,$onError:Function=null,$name:String="",$key:String="",$priority:int=0,$decode:Function=null)
		{
			_url = $url;
			_name = $name;
			_key = $key;
			_priority = $priority;
			
			_onComplete = $onComplete;
			_onUpdate = $onUpdate;
			_onError = $onError;
			
			_decode = $decode;
		}
		public function get url():String
		{
			return _url;
		}
		public function get name():String
		{
			return _name;
		}
		public function get key():String
		{
			return _key;
		}
		public function get priority():int
		{
			return _priority;
		}
		public function get onComplete():Function
		{
			return _onComplete;
		}
		public function get onUpdate():Function
		{
			return _onUpdate;
		}
		public function get onError():Function
		{
			return _onError;
		}
		public function get decode():Function
		{
			return _decode;
		}
	}
}