package game.core.handler
{
	import com.zcp.manager.TimerManager;
	
	import game.core.handler.helper.HandlerHelper;
	import game.core.handler.vo.HandlerData;
	
	
	/**
	 * 函数执行线程模型对象
	 * @author zcp
	 * 
	 */	
	public class HandlerThread
	{
		/**原始等待执行函数数组(HandlerData数组)*/
		private var _handlerDataArr:Array;
		/**进Timer的等待执行函数数组(HandlerData数组)(从_handlerDataArr中移除后，添加到time中等待执行但还未被执行时)*/
		private var _handlerDataReadyArr:Array;
		
		
		
		private var _isRunning:Boolean ;//是否正在运行
		
		private var _canRun:Boolean ;//强制开始或停止
		
		private var _isQueue:Boolean ;//是否是以队列queue形式（先进先出）执行（否则以栈stack的形式执行）
		
		private var _next:HandlerData;
		/**
		 * HandlerThread
		 * @param $handlerArr	数据类型：HandlerData数组
		 * @param $isQueue	是否是以队列queue形式（先进先出）执行（否则以栈stack的形式执行）
		 * 
		 */	
		public function HandlerThread($handlerArr:Array=null,$isQueue:Boolean=true)
		{
			_handlerDataArr = $handlerArr || [];
			_handlerDataReadyArr = [];
			_isQueue = $isQueue;
			_isRunning = false;
			_canRun = true;
			_next = null;
		}
		/**
		 * 线程是否正在运行
		 */
		public function get isRunning():Boolean
		{
			return _isRunning;
		}
		/**
		 * 获取等待执行的函数数量(只返回_handlerDataArr内的，不返回字典内的)
		 */			
		public function getHandlersNum():int
		{
			return _handlerDataArr.length;
		}		
		
		/**
		 * 添加函数到执行队列(执行完一个执行另一个，可设置每个函数的延时延时)（强烈建议保持传进的每个函数唯一,如果不唯一请嵌套一层函数使之唯一,否则在调用移除函数时可能会出现移除不掉的情况，该情况出现在：函数已在等待加载数组中移除，但依旧等待在timer中）
		 * 此方法不能获取函数返回值，但可返回一个HandlerData对象
		 * @param $handler 函数
		 * @param $parameters 参数数组
		 * @param $delay 延时（单位：毫秒）
		 * @param $doNext 执行完毕是否自动执行下一个
		 * @param $autoStart 是否自动开始]
		 * @param $priority 是否优先执行
		 */		
		public function push($handler:Function, $parameters:Array=null,$delay:Number=0,$doNext:Boolean=true,$autoStart:Boolean=true,$priority:Boolean=false):HandlerData
		{
			//添加进数组
			var handlerData:HandlerData = new HandlerData($handler,$parameters,$delay,$doNext);
			if($priority)
			{
				_handlerDataArr.unshift(handlerData);
			}
			else
			{
				_handlerDataArr.push(handlerData);
			}
			//如果处在休息状态，则执行下一个命令
			if(_canRun && $autoStart && !_isRunning)
			{
				executeNext();
			}
			return handlerData;
		}
		/**
		 * 取消所有未执行函数的执行(慎用：将移除与此参数给定的函数有关的所有HandlerData)
		 * 
		 */			
		public function removeAllHandlers():void
		{
			//清空_handlerDataArr
			_handlerDataArr.length=0;
			//清空_handlerDataReadyArr
			_handlerDataReadyArr.length=0;
			//改变标志位
			_isRunning = false;
			return;
		}
		/**
		 * 取消某个未执行函数的执行(慎用：将移除与此参数给定的函数有关的所有HandlerData)
		 * @param $handler
		 */			
		public function removeHandler($handler:Function):void
		{
			if($handler==null)return;			
			//从_handlerDataArr中移除
			var hData:HandlerData;
			var len:int = _handlerDataArr.length;
			while(len-->0)
			{
				hData = _handlerDataArr[len];
				if(hData.handler==$handler)
				{
					_handlerDataArr.splice(len,1);
					//break;//这里不用break??????111111111111
				}
			}
			//从_handlerDataReadyArr中移除
			len = _handlerDataReadyArr.length;
			while(len-->0)
			{
				hData = _handlerDataReadyArr[len];
				if(hData.handler==$handler)
				{
					_handlerDataReadyArr.splice(len,1);
					//break;//这里不用break??????111111111111
				}
			}
			//改变标志位
			if(_handlerDataArr.length==0 && _handlerDataReadyArr.length==0)
			{
				_isRunning = false;
			}
			return;
		}
		//		/**
		//		 * 取消某个未执行函数的执行(只移除数组内的，不移除字典内的)
		//		 * @param $handlerData
		//		 * 
		//		 */			
		//		public function removeHandlerData($handlerData:HandlerData):void
		//		{
		//			if($handlerData==null)return;		
		//			//从数组中移除
		//			var index:int = _handlerDataArr.indexOf($handlerData);
		//			if(index!=-1)
		//			{
		//				_handlerDataArr.splice(index,1);
		//			}
		//			//从字典中移除111111111111111111111111这里应该这样做吗？
		//			//removeWaitExecuteFromDictByFun($handlerData.handler);
		//			return;
		//		}
		/**
		 * 是否存在指定的等待执行的函数
		 * @param $handler
		 */			
		public function hasHandler($handler:Function):Boolean
		{
			var hData:HandlerData;
			//检测_handlerDataArr内
			for each(hData in _handlerDataArr)
			{
				if(hData.handler==$handler)
				{
					return true;
				}
			}
			//检测_handlerDataReadyArr内
			for each(hData in _handlerDataReadyArr)
			{
				if(hData.handler==$handler)
				{
					return true;
				}
			}
			return false;
		}
//		/**
//		 * 强制开始执行
//		 * 
//		 */			
//		public function strongStart():void
//		{
//			_canRun = true;
//			_isRunning = false;
//			executeNext();
//			return;
//		}
		/**
		 * 开始执行
		 * 
		 */			
		public function start():void
		{
			_canRun = true;
			if(!_isRunning)
			{
				executeNext();
			}
			return;
		}
		/**
		 * 停止执行
		 * 
		 */			
		public function stop():void
		{
			_canRun = false;
			return;
		}
		/**
		 * @private
		 * 设置运行状态为未运行
		 * 
		 */			
		private function setNotRunning():void
		{
			_isRunning = false;
			return;
		}
		//=======================================================================================================
		
		//对内方法
		//=======================================================================================================
		/**
		 * @private
		 * 执行下一条命令
		 * 
		 */			
		private function executeNext():void
		{
			//是否允许运行
			if(!_canRun)
			{
				_isRunning = false;
				return;
			}
			
			//判断是否到达尾部
			if(_handlerDataArr.length==0)
			{
				_isRunning = false;	
				return;
			}
			
			//改变状态标识
			_isRunning = true;
			
			//获取最下一个等待执行的事件
			_next = (_isQueue ? _handlerDataArr.shift() : _handlerDataArr.pop()) as HandlerData;
			
			//执行
			//如果下一个存在
			if(_next)
			{
				//如果是延时函数，则执行延时处理
				if(_next.delay>0)
				{
					//新的执行函数
					function newHandler():void
					{
						//从等待字典移除，同时验证存在性
						if(removeReadyHD(_next))
						{
							//执行函数
							HandlerHelper.execute(_next.handler,_next.parameters);
						}
						//如果需要执行下一个则执行下一个
						_next.doNext?executeNext():setNotRunning();
					}
					//添加进等待执行字典
					addReadyHD(_next);
					//创建延时TimerData
					TimerManager.createOneOffTimer(
						_next.delay,
						1,//注意这里只给一次
						newHandler,
						null,
						null,
						null,
						true
					);
					
//					//创建延时TimerData
//					TimerManager.addDelayCallBack(
//						_next.delay,
//						newHandler
//					);
				}
					//否则直接运行
				else
				{
					HandlerHelper.execute(_next.handler,_next.parameters);
					//如果需要执行下一个则执行下一个
					_next.doNext?executeNext():setNotRunning();
				}
			}
				//否则直接运行下一个
			else
			{
				executeNext();
			}
			return;
		}
		/**
		 * @private
		 * 向_handlerDataReadyArr中添加
		 *  @parm $hd
		 */	
		private function addReadyHD($hd:HandlerData):void
		{
			if(_handlerDataReadyArr.indexOf($hd)!=-1)return;
			_handlerDataReadyArr.push($hd);
		}
		/**
		 * @private
		 * 从_handlerDataReadyArr中移除
		 *  @parm $fun 执行函数
		 *  @return 移除成功返回true, 移除失败或不存在返回false
		 */	
		private function removeReadyHD($hd:HandlerData):Boolean
		{
			var index:int = _handlerDataReadyArr.indexOf($hd);
			if(index!=-1)
			{
				//从数组中移除
				_handlerDataReadyArr.splice(index,1);
				return true;
			}
			return false;
		}
		//=======================================================================================================				
	}
}