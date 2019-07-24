package game.core.manager
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.system.ApplicationDomain;
	import flash.utils.*;
	
	import game.core.loader.RslLoader;
	import game.core.loader.vo.LoadData;
	import game.core.loader.vo.RslLoadingInfo;
	
	/**
	 * RSL加载管理器
	 * 只能用来加载导出类（加载SWF,或加密的SWF）
	 * 全局回调类似：
	 * function callBack();void{}
	 * @author zcp
	 * 
	 */	
	public class RslLoaderManager
	{
		/**
		 * 等待加载的数据
		 * data: RslLoadingInfo
		 * */
		private static var waitLoadList:Array = [];
		/**
		 * 所有加载器的集合
		 * data: RslLoader
		 * */
		private static var loaderList:Array = [];
		
		/**并行加载最大条数*/
		public static var MAX_THREAD:int = 10;
		
		
		
		
		
		public function RslLoaderManager()
		{
	        throw new Error("Can not New!");
		}
		//常用
		//==============================================================================
		/**
		 * 获取类
		 * @param $className	类名称
		 * @return			获取的类定义，如果不存在返回null
		 * 
		 */		
		public static function getClass($className : String) : Class
		{
			if($className==null||$className=="")return null;
			if (ApplicationDomain.currentDomain.hasDefinition($className))
			{
				return ApplicationDomain.currentDomain.getDefinition($className) as Class;
			}
			else
			{
				trace("RslLoaderManager.getClass: 类“"+$className+"”不存在");
			}
			return null;
		}
		
		/**
		 * 专门获取BitmapData类
		 * @param $className	类名称
		 * @return			获取的类定义，如果不存在返回null
		 * 
		 */	
		public static function getBDClass($className:String):Class
		{
			if($className==null||$className=="")
				return null;
			if (ApplicationDomain.currentDomain.hasDefinition($className))
			{
				return ApplicationDomain.currentDomain.getDefinition($className) as Class;
			}
			return null;
		}
		
		/**
		 * 获取指定类名的实例
		 * 
		 * @param $className	类名称，必须包含完整的命名空间
		 * @param str			参数集合
		 * @return				类的一个实例，如果不存在返回null
		 */				//TODOTODO	项目中 使用此函数来返回 bitmapData的地方 都要改成  StaticValue.getBitmapByClassName()
		public static function getInstance($className:String, ... str:*) : *
		{
			var Instance:Class = getClass($className);
			var instance:* = getInstanceByClass(Instance,str);
			return instance;
		}
		/**
		 * 获取指定类的实例
		 * 
		 * @param $class	类名称，必须包含完整的命名空间
		 * @param $params			参数的数组
		 * @return				类的一个实例，如果不存在返回null
		 * 说明：现在最多支持15个参数的类
		 */	
		public static function getInstanceByClass($class:Class, $params:Array) : *
		{
			if($class==null)return null;
			var instance:*;
			var len:int = $params ? $params.length : 0 ;
			switch(len)
			{
				case 0:
					instance = new $class();
					break;
				case 1:
					instance = new $class($params[0]);
					break;
				case 2:
					instance = new $class($params[0], $params[1]);
					break;
				case 3:
					instance = new $class($params[0], $params[1], $params[2]);
					break;
				case 4:
					instance = new $class($params[0], $params[1], $params[2], $params[3]);
					break;
				case 5:
					instance = new $class($params[0], $params[1], $params[2], $params[3], $params[4]);
					break;
				case 6:
					instance = new $class($params[0], $params[1], $params[2], $params[3], $params[4], $params[5]);
					break;
				case 7:
					instance = new $class($params[0], $params[1], $params[2], $params[3], $params[4], $params[5], $params[6]);
					break;
				case 8:
					instance = new $class($params[0], $params[1], $params[2], $params[3], $params[4], $params[5], $params[6], $params[7]);
					break;
				case 9:
					instance = new $class($params[0], $params[1], $params[2], $params[3], $params[4], $params[5], $params[6], $params[7], $params[8]);
					break;
				case 10:
					instance = new $class($params[0], $params[1], $params[2], $params[3], $params[4], $params[5], $params[6], $params[7], $params[8], $params[9]);
					break;
				case 11:
					instance = new $class($params[0], $params[1], $params[2], $params[3], $params[4], $params[5], $params[6], $params[7], $params[8], $params[9], $params[10]);
					break;
				case 12:
					instance = new $class($params[0], $params[1], $params[2], $params[3], $params[4], $params[5], $params[6], $params[7], $params[8], $params[9], $params[10], $params[11]);
					break;
				case 13:
					instance = new $class($params[0], $params[1], $params[2], $params[3], $params[4], $params[5], $params[6], $params[7], $params[8], $params[9], $params[10], $params[11], $params[12]);
					break;
				case 14:
					instance = new $class($params[0], $params[1], $params[2], $params[3], $params[4], $params[5], $params[6], $params[7], $params[8], $params[9], $params[10], $params[11], $params[12], $params[13]);
					break;
				case 15:
					instance = new $class($params[0], $params[1], $params[2], $params[3], $params[4], $params[5], $params[6], $params[7], $params[8], $params[9], $params[10], $params[11], $params[12], $params[13], $params[14]);
					break;
			}
			return instance;
		}
		//==============================================================================
		
		
		
		//公有
		//==============================================================================
		/**
		 * 加载RSL
		 * @param $loadList	数据类型：LoadData数组
		 * @param $callBack	全部加载完毕之后的回调函数
		 * @param $priority 优先级
		 * 
		 */		
		public static function load($loadList:Array,$callBack:Function=null, $priority:int=0):void
		{
			if(!$loadList || $loadList.length==0)
			{
				if($callBack!=null)$callBack();
				return;
			}
			
			//数组内部按优先级排序(降序)
			$loadList.sortOn("priority", Array.DESCENDING | Array.NUMERIC);
			

			
			//创建数据
			var nli:RslLoadingInfo = new RslLoadingInfo($loadList, $callBack, $priority);

			//取得一个空闲的加载器
			var rslLoader:RslLoader = getFreeLoader(nli.priority);
			//如果加载器不为空
			if(rslLoader!=null)
			{
				//记录下
				rslLoader.rslLoadingInfo = nli;
				//开始执行加载
				loadNext(rslLoader);
			}
			else
			{
				//添加进数组
				waitLoadList.push(nli);
				//全局排序
				waitLoadList.sortOn("priority", Array.DESCENDING | Array.NUMERIC);
			}
			return;
		}
		/**
		 * 懒惰加载RSL
		 * @param $callBack	全部加载完毕之后的回调函数
		 * @param $decode	解密函数
		 * @param ...str	加载文件的URL集合
		 * 
		 */		
		public static function lazyLoad($callBack:Function=null,$decode:Function=null, ... str:*):void
		{
			if(!str || str.length==0)
			{
				if($callBack!=null)$callBack();
				return;
			}
			
			//生成简单的LoadData数组
			var loadList:Array = str.map(function(item:*, index:int, arr:Array):LoadData{return new LoadData(String(item),null,null,null,"","",0,$decode);});
			
			load(loadList,$callBack);
			return;
		}
		/**
		 * 取消加载与 某地址 相关的项
		 * @param $url	加载地址
		 * 
		 */		
		public static function cancelLoadByUrl($url:String):void
		{
			//先检测等待加载的
			var len:int = waitLoadList.length;
			for(var i:int=len-1; i>=0; i--)
			{
				var nli:RslLoadingInfo = waitLoadList[i];
				var len2:int = nli.loadList.length;
				for(var i2:int=len2-1; i2>=0; i2--)
				{
					var ld2:LoadData = nli.loadList[i2];
					if(ld2.url==$url)
					{
						nli.loadList.splice(i2, 1);
					}
				}
				
				if(nli.loadList.length==0)
				{
					waitLoadList.splice(i, 1);
				}
			}
			
			//在检查正在加载的
			for each(var rslLoader:RslLoader in loaderList)
			{
				var nli2:RslLoadingInfo = rslLoader.rslLoadingInfo;
				if(nli2!=null && nli2.loadList.length>0)
				{
					//检测正在加载的数组内部
					var count:int = nli2.loadList.length;
					for(var j:int=count-1; j>=0; j--)
					{
						var nowLd:LoadData = nli2.loadList[j];
						if(nowLd.url==$url)
						{
							nli2.loadList.splice(j, 1);
						}
					}
					
					//检测正在加载的那一个
					if(rslLoader.isLoading)
					{
						if(rslLoader.rslLoadData.url==$url)
						{
							//停止掉
							rslLoader.stop();
							//加载下一个
							loadNext(rslLoader);
						}
					}
				}
			}

			return;
		}
		/**
		 * 取消加载与 某单独回调 相关的项
		 * @param $urlCallBack	某加载地址的单独回调
		 * 
		 */		
		public static function cancelLoadByUrlCallBack($urlCallBack:Function):void
		{
			//先检测等待加载的
			var len:int = waitLoadList.length;
			for(var i:int=len-1; i>=0; i--)
			{
				var nli:RslLoadingInfo = waitLoadList[i];
				var len2:int = nli.loadList.length;
				for(var i2:int=len2-1; i2>=0; i2--)
				{
					var ld2:LoadData = nli.loadList[i2];
					if(ld2.onComplete==$urlCallBack)
					{
						nli.loadList.splice(i2, 1);
					}
				}
				
				if(nli.loadList.length==0)
				{
					waitLoadList.splice(i, 1);
				}
			}
			
			//在检查正在加载的
			for each(var rslLoader:RslLoader in loaderList)
			{
				var nli2:RslLoadingInfo = rslLoader.rslLoadingInfo;
				if(nli2!=null && nli2.loadList.length>0)
				{
					//检测正在加载的数组内部
					var count:int = nli2.loadList.length;
					for(var j:int=count-1; j>=0; j--)
					{
						var nowLd:LoadData = nli2.loadList[j];
						if(nowLd.onComplete==$urlCallBack)
						{
							nli2.loadList.splice(j, 1);
						}
					}
					
					//检测正在加载的那一个
					if(rslLoader.isLoading)
					{
						if(rslLoader.rslLoadData.onComplete==$urlCallBack)
						{
							//停止掉
							rslLoader.stop();
							//加载下一个
							loadNext(rslLoader);
						}
					}
				}
			}
			
			return;
		}
		/**
		 * 取消加载与 某地址和某回调  的相关的项
		 * @param $url	加载地址
		 * @param $url	单独回调
		 */		
		public static function cancelLoadByUrlAndUrlCallBack($url:String, $urlCallBack:Function):void
		{
			//先检测等待加载的
			var len:int = waitLoadList.length;
			for(var i:int=len-1; i>=0; i--)
			{
				var nli:RslLoadingInfo = waitLoadList[i];
				var len2:int = nli.loadList.length;
				for(var i2:int=len2-1; i2>=0; i2--)
				{
					var ld2:LoadData = nli.loadList[i2];
					if(ld2.url==$url && ld2.onComplete==$urlCallBack)
					{
						nli.loadList.splice(i2, 1);
					}
				}
				
				if(nli.loadList.length==0)
				{
					waitLoadList.splice(i, 1);
				}
			}
			
			//在检查正在加载的
			for each(var rslLoader:RslLoader in loaderList)
			{
				var nli2:RslLoadingInfo = rslLoader.rslLoadingInfo;
				if(nli2!=null && nli2.loadList.length>0)
				{
					//检测正在加载的数组内部
					var count:int = nli2.loadList.length;
					for(var j:int=count-1; j>=0; j--)
					{
						var nowLd:LoadData = nli2.loadList[j];
						if(nowLd.url==$url && nowLd.onComplete==$urlCallBack)
						{
							nli2.loadList.splice(j, 1);
						}
					}
					
					if(rslLoader.isLoading)
					{
						//检测正在加载的那一个
						if(rslLoader.rslLoadData.url==$url && rslLoader.rslLoadData.onComplete==$urlCallBack)
						{
							//停止掉
							rslLoader.stop();
							//加载下一个
							loadNext(rslLoader);
						}
					}
				}
			}
			
			return;
		}
		/**
		 * 取消加载与 某“组回调” 相关的项
		 * @param $groupCallBack	组回调
		 * 
		 */		
		public static function cancelLoadByGroupCallBack($groupCallBack:Function):void
		{
			//先检测等待加载的
			var len:int = waitLoadList.length;
			for(var i:int=len-1; i>=0; i--)
			{
				var nli:RslLoadingInfo = waitLoadList[i];
				if(nli.callBack==$groupCallBack)
				{
					waitLoadList.splice(i, 1);
				}
			}
			
			//在检查正在加载的
			for each(var rslLoader:RslLoader in loaderList)
			{
				var nli2:RslLoadingInfo = rslLoader.rslLoadingInfo;
				if(nli2!=null && nli2.callBack==$groupCallBack)
				{
					//清空该组
					nli2.loadList.length = 0;
					
					//检测正在加载的那一个
					if(rslLoader.isLoading)
					{
						//停止掉
						rslLoader.stop();
						//加载下一个
						loadNext(rslLoader);
					}
				}
			}
			
			return;
		}
		//==============================================================================
		
		//私有
		//==============================================================================
		/**
		 * 获取空闲的加载器
		 * @param $priority 低于此优先级的
		 * 
		 */		
		private static function getFreeLoader($priority:int=0):RslLoader
		{
			var rslLoader:RslLoader;
			
			//先寻找空闲的
			for each(rslLoader in loaderList)
			{
				if(!rslLoader.isLocked && !rslLoader.isLoading)//如果未处于锁定状态， 且未处于运行状态
				{
					if(rslLoader.rslLoadingInfo==null || rslLoader.rslLoadingInfo.loadList.length==0)
					{
						return rslLoader;
					}
				}
			}
			
			
			//再看是否线程满了
			if(loaderList.length<MAX_THREAD)
			{
				rslLoader = new RslLoader();
				//添加进数组
				loaderList.push(rslLoader);
				return rslLoader;
			}
			
			
			//最后查找替换较低线程的
			var lowLoader:RslLoader
			for each(rslLoader in loaderList)
			{
				if(lowLoader==null || lowLoader.rslLoadingInfo.priority>rslLoader.rslLoadingInfo.priority)
				{
					lowLoader = rslLoader;
				}
			}
			if(lowLoader.rslLoadingInfo.priority<$priority)
			{
				//暂停掉该加载器
				lowLoader.stop();
				
				//还原加载数组到等待加载数组
				waitLoadList.push(lowLoader.rslLoadingInfo);
				//全局排序
				waitLoadList.sortOn("priority", Array.DESCENDING | Array.NUMERIC);
				
				return lowLoader;
			}
			return null;
		}
		/**
		 * 加载下一个
		 * @param $rslLoader
		 *  
		 */			
		private static function loadNext($rslLoader:RslLoader):void
		{
			if($rslLoader.isLoading)return;
			
			//判断是否到达尾部
			if($rslLoader.rslLoadingInfo.loadList.length==0)
			{
				//锁定
				$rslLoader.isLocked = true;
				//执行全局回调函数
				if($rslLoader.rslLoadingInfo.callBack!=null)$rslLoader.rslLoadingInfo.callBack();
				//解锁
				$rslLoader.isLocked = false;
				
				//检索下一组加载
				if(waitLoadList.length>0)
				{
					var nextNli:RslLoadingInfo = waitLoadList.shift();
					//记录
					$rslLoader.rslLoadingInfo = nextNli;
					//开始下一组加载
					loadNext($rslLoader);
				}
				return;
			}

			//获取最上一个等待加载的元素
			var self:LoadData = $rslLoader.rslLoadingInfo.loadList[0] as LoadData;
			//加载
			initLoadEvent($rslLoader);
			$rslLoader.load(self);
			return;
		}
		
		private static function initLoadEvent($rslLoader:RslLoader) : void
		{
			$rslLoader.addEventListener(Event.COMPLETE, rslLoaderHandler);
			$rslLoader.addEventListener(ProgressEvent.PROGRESS, rslLoaderHandler);
			$rslLoader.addEventListener(IOErrorEvent.IO_ERROR, rslLoaderHandler);
			$rslLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, rslLoaderHandler);
			return;
		}
		private static function removeLoadEvent($rslLoader:RslLoader) : void
		{
			$rslLoader.removeEventListener(Event.COMPLETE, rslLoaderHandler);
			$rslLoader.removeEventListener(ProgressEvent.PROGRESS, rslLoaderHandler);
			$rslLoader.removeEventListener(IOErrorEvent.IO_ERROR, rslLoaderHandler);
			$rslLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, rslLoaderHandler);
			return;
		}
		private static function rslLoaderHandler(e:Event) : void
		{
			var rslLoader:RslLoader = e.target as RslLoader;
			var loadData:LoadData = rslLoader.rslLoadingInfo.loadList[0];
			
			switch(e.type)
			{
				case Event.COMPLETE:
					//移除监听
					removeLoadEvent(rslLoader);
					rslLoader.rslLoadingInfo.loadList.shift();
					//单个回调
					if(loadData.onComplete!=null)
					{
						//锁定
						rslLoader.isLocked = true;
						loadData.onComplete(loadData, e);
						//解锁
						rslLoader.isLocked = false;
					}
					//移除刚刚加载的元素
					loadNext(rslLoader);
					break;
				case ProgressEvent.PROGRESS:
					//单个回调
					if(loadData.onUpdate!=null)
					{
						//锁定
						rslLoader.isLocked = true;
						loadData.onUpdate(loadData, e);
						//解锁
						rslLoader.isLocked = false;
					}
					break;
				case IOErrorEvent.IO_ERROR:
				case SecurityErrorEvent.SECURITY_ERROR:
					trace("RslLoaderManager: 加载"+loadData.url+"失败");
					//移除监听
					removeLoadEvent(rslLoader);
					rslLoader.rslLoadingInfo.loadList.shift();
					//单个回调
					if(loadData.onError!=null)
					{
						//锁定
						rslLoader.isLocked = true;
						loadData.onError(loadData,e);
						//解锁
						rslLoader.isLocked = false;
					}
					loadNext(rslLoader);
					break;				
			}
			return;
		}
		//==============================================================================
	}
}