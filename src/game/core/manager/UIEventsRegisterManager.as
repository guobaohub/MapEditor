package game.core.manager
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import game.core.handler.helper.HandlerHelper;

	/**
	 * UI事件注册管理器
	 * 此方式有两个缺点：
	 * 1.必须一个UI类对应的实例必须只有一个，否则容易出错 
	 * 2.如果在addUIRegisterEvent之前调用了registerUI，可能会造成事件注册不上
	 * @author zcp
	 */	
	public class UIEventsRegisterManager
	{
		/**
		 * 注册UI
		 * @param $msgCode
		 * @param $callBack 接收数据回调
		 * 
		 */	
		public static function registerUI ($dobj:DisplayObject, $Class:Class) : void
		{
			$dobj.addEventListener(Event.ADDED_TO_STAGE, function(e:Event):void{
				registerUIEvent($Class);
			},false,int.MAX_VALUE);	//注册 使用最大上限, 保证优先级最高, 最先注册---nick
			$dobj.addEventListener(Event.REMOVED_FROM_STAGE, function(e:Event):void{
				removedUIEvent($Class);
			},false,-int.MAX_VALUE);	//移除,使用最小下限,保证优先级最低, 最后移除---nick
		}	
		
		//事件存储
		//=====================================================================================================================
		/**
		 * UI添加事件存储器
		 */		
		private static var _uiRegisterDict:Dictionary = new Dictionary();
		/**
		 * UI移除事件存储器
		 */		
		private static var _uiRemovedDict:Dictionary = new Dictionary();
		/**
		 * 添加UI添加事件到管理器(只起到存储作用)
		 * @param $msgCode
		 * @param $callBack 接收数据回调
		 * 
		 */	
		public static function addUIRegisterEvent ($msgCode:Class, $callBack:Function) : void
		{
			if( _uiRegisterDict[ $msgCode ] != null ) {
				_uiRegisterDict[ $msgCode ].push( $callBack );
			} else {
				_uiRegisterDict[ $msgCode ] = [ $callBack ];	
			}
		}
		/**
		 * 添加UI移除事件到管理器(只起到存储作用)
		 * @param $msgCode
		 * @param $callBack 接收数据回调
		 * 
		 */	
		public static function addUIRemovedEvent ($msgCode:Class, $callBack:Function) : void
		{
			if( _uiRemovedDict[ $msgCode ] != null ) {
				_uiRemovedDict[ $msgCode ].push( $callBack );
			} else {
				_uiRemovedDict[ $msgCode ] = [ $callBack ];	
			}
		}
		/**
		 * 注册UI事件
		 * @param $msgCode
		 * 
		 */	
		private static function registerUIEvent ($msgCode:Class) : void
		{
			var callBackArr:Array = _uiRegisterDict[ $msgCode ] as Array;
			if(callBackArr!=null)
			{
				var callBack:Function;
				for each(callBack in callBackArr)
				{
					HandlerHelper.execute(callBack);
				}
			}
		}
		/**
		 * 注册UI事件
		 * @param $msgCode
		 * 
		 */	
		private static function removedUIEvent ($msgCode:Class) : void
		{
			var callBackArr:Array = _uiRemovedDict[ $msgCode ] as Array;
			if(callBackArr!=null)
			{
				var callBack:Function;
				for each(callBack in callBackArr)
				{
					HandlerHelper.execute(callBack);
				}
			}
		}
	}
}