package game.core.loader
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	import game.core.loader.vo.LoadData;
	import game.core.loader.vo.RslLoadingInfo;
	
	/**
	 * RSL加载器
	 * 
	 */	
	public class RslLoader extends EventDispatcher
	{
		/**加载器*/
		private var _loader:Loader;
		private var _urlLoader:URLLoader;
		/**
		 * @private
		 * LoaderContext
		 */
		private var _context : LoaderContext;
		
		
		
		
		/**
		 * 是否锁定中(处于锁定中的加载器不能被重新启用)
		 */
		public var isLocked :Boolean;
		/**
		 * 是否正在加载中
		 */
		public var isLoading :Boolean;


		
		/**rsl加载数据*/
		public var rslLoadData:LoadData;
		/**rsl加载数据集*/
		public var rslLoadingInfo:RslLoadingInfo;

		
		/**
		 * RslLoader
		 */		
		public function RslLoader()
		{
			super();
			
			
			_context = new LoaderContext();
			//设置安全域
//			if(Security.sandboxType==Security.REMOTE)
//			{
//				_context.securityDomain = SecurityDomain.currentDomain;
//			}
			try{
				_context['allowLoadBytesCodeExecution'] = true;
			}catch(e:Error){}
			//设置应用程序域
			_context.applicationDomain = ApplicationDomain.currentDomain;
			
			
			
			_urlLoader = new URLLoader()
			_urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			
			
			_loader = new Loader();
			
		}
		
		/**
		 * 加载SWF
		 * @param $rslLoadData
		 * @retrun
		 */		
		public function load($rslLoadData:LoadData):void
		{
			isLoading = true;
			
			rslLoadData = $rslLoadData;

			var ur:URLRequest = new URLRequest(rslLoadData.url);
			ur.method = URLRequestMethod.POST;//暂时先用post11111111111111111111111111
			initUrlLoadEvent();
			_urlLoader.load(ur);
			return;
		}
		/**
		 * 停止加载
		 */	
		public function stop() : void
		{
			removeUrlLoadEvent();
			try{
				_urlLoader.close();
			}catch(e:Error){};
			try{
				_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
				_loader.close();
			}catch(e:Error){};
			

			isLoading = false;
		}
		
		/**
		 * @private
		 * 监听加载事件
		 */		
		private function initUrlLoadEvent() : void
		{
			_urlLoader.addEventListener(ProgressEvent.PROGRESS, onUrlProgress);
			_urlLoader.addEventListener(Event.COMPLETE, onUrlComplete);//注意这个
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onUrlError);
			_urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onUrlError);
		}
		/**
		 * @private
		 * 移除加载事件
		 */	
		private function removeUrlLoadEvent() : void
		{
			_urlLoader.removeEventListener(ProgressEvent.PROGRESS, onUrlProgress);
			_urlLoader.removeEventListener(Event.COMPLETE, onUrlComplete);//注意这个
			_urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, onUrlError);
			_urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onUrlError);
		}
		/** 
		 * @private
		 * 加载完成事件 
		 */
		private function onUrlComplete(e : Event) : void
		{
			//解密
			var bytes:ByteArray = e.currentTarget.data;
			if(rslLoadData.decode!=null)
			{
				bytes = rslLoadData.decode(bytes);
			}
			bytes.position = 0;
			//将解密后的二进制数据加载到制定域
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			_loader.loadBytes(bytes,_context);
		}
		/** 
		 * @private
		 * 加载进度事件 
		 */
		private function onUrlProgress(e : ProgressEvent) : void
		{
			dispatchEvent(e);
		}
		/** 
		 * @private
		 * 加载失败事件 
		 */
		private function onUrlError(e : Event) : void
		{
			stop();
			dispatchEvent(e);
		}
		/** 
		 * @private
		 * 加载完成事件 
		 */
		private function onComplete(e : Event) : void
		{
			stop();
			dispatchEvent(e);		//用rslLoader对象派发消息,   消息的接收 写在了 RslLoaderManager 中
		}
	}
}