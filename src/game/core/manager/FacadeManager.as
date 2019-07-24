package game.core.manager
{
	import game.core.manager.PipeManager;
	
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;

	/**
	 * Facade管理器
	 * @author zcp
	 */	
	public class FacadeManager
	{
		/**
		 * 启动一个facade模块
		 * @parm $facadeName 目标facade的完整包路径
		 * @parm $data 参数
		 * 
		 */
		public static function startupFacade($facadeName:String, $data:*=null) :void 
		{
			trace("启动模块："+$facadeName);
			//调用一遍单例，保证目标facade一定存在
			var facade:IFacade = FacadeManager.getFacade($facadeName);
			if(facade==null)
			{
				throw new Error("模块"+$facadeName+"不存在");
			}
			//发送启动消息
			PipeManager.sendMsg($facadeName, $data);
		}
		/**
		 * 卸载一个facade模块
		 * @parm $facadeName 目标facade的完整包路径
		 * 
		 */
		public static function killFacade($facadeName:String) :void 
		{
			trace("移除模块："+$facadeName);
			//调用一遍单例，保证目标facade一定存在
			var facade:IFacade = FacadeManager.getFacade($facadeName);
			if(facade!=null)
			{
				(facade as Object).dispose();
			}
		}
		/**
		 * 通用取Facade方法
		 * 如果找不到，则通过$FacadeClass类创建，如果$FacadeClass==null, 则通过$key字符串反射创建，如果创建不成功，则则返回空
		 * 区别于Facade.get.getInstance方法，Facade.get.getInstance在没有找到的情况下，将创建一个最基本的Facade ,而不是我们期望的
		 * @parm $key
		 * @parm $FacadeClass
		 */
		public static function getFacade( $key:String ,$FacadeClass:Class=null) :IFacade 
		{
			return TempFacade.getFacade($key, $FacadeClass);
		}
		/**
		 * 是否存在指定的Facade
		 * 此方法只判断有无，不反射创建
		 * @parm $key
		 */
		public static function hasFacade( $key:String):Boolean 
		{
			return TempFacade.hasFacade($key);
		}
	}
}

import game.core.manager.RslLoaderManager;

import org.puremvc.as3.multicore.interfaces.IFacade;
import org.puremvc.as3.multicore.patterns.facade.Facade;

/**
 * for FacadeManager
 * @author zcp
 */	
class TempFacade extends Facade
{
	public function TempFacade($key:String)
	{
		super($key);
	}
	public static function getFacade( $key:String ,$FacadeClass:Class=null) :IFacade 
	{
		if ( instanceMap[ $key ] == null ) instanceMap[ $key ] = ($FacadeClass!=null) ? new $FacadeClass($key): RslLoaderManager.getInstance( $key, $key  );
		return instanceMap[ $key ];
	}
	public static function hasFacade( $key:String ) :Boolean 
	{
		return ( instanceMap[ $key ] != null );
	}
}
