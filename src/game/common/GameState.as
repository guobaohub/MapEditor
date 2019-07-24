package game.common
{
	import flash.geom.Point;
	import flash.utils.Dictionary;
	/**
	 * 游戏状态
	 * 
	 */	
	public class GameState
	{

		/**
		 * 加载线程1加载完毕
		 * 登陆资源加载完毕
		 * */
		public static var loadThread1Complete:Boolean = false;

		
		/**
		 * 加载线程2加载完毕
		 * 登陆资源加载完毕
		 * */
		public static var loadThread2Complete:Boolean = false;
		
		/**已经选择了角色，选择了分线*/
		public static var hasSelectedChar:Boolean = false;
		/**服务器返回：进入分线服务器成功，可以进入场景了*/
		public static var enterLineSucess:Boolean = false;
		
		

		/**服务器返回：进入指定地图场景成功*/
		public static var enterSceneSucess:Boolean = false;

		/**是否是第一次进入场景*/
		public static var fristEnterScene:Boolean = true;

		/**是否处于原服务器和跨服服务器之间切换*/
		public static var switchServer:Boolean = false;
		
		
		/**
		 * 主任务面板标签状态
		 * 0：隐藏， 1：已接任务， 2：可接任务， 3：活动面板
		 */
		public static var taskPlaneTabStatus:int = 0;
		/**
		 * 任务追踪面板标签状态
		 * 0：隐藏， 1：已接任务， 2：可接任务
		 */
		public static var taskTrackerPlaneTabStatus:int = 1;
		
		/**
		 * 上次跳跃的时间
		 */
		public static var lastJumpTime:int = -1;
		
		/**
		 * 是不是第一次收到10108消息 是否是刚上线
		 */		
		public static var isFirst10108:Boolean = true;
		
		/**
		 * 是否启用心跳特效
		 */		
		public static var enableHeartEffect:Boolean = true;
		/**
		 * 是否启用双休特效
		 */		
		public static var enableShuangxiuEffect:Boolean = false;	
		/**
		 * 是否启用提示消息(脚下)
		 */		
		public static var enableTishiMsg:Boolean = true;	
		
		//限时大将兑换***************************************************************
		/**
		 * 限时兑换大奖ID（大于0则表示活动处于开启状态,范围0（含）到100（含））
		 */		
		public static var xinshiDuihuan:int = 0;
		//动态功能模块***************************************************************
		/**
		 * 神奇木耙的使用 是否开启
		 */		
		public static var gongneng101:Boolean=false
		/**
		 * 寻宝数兑换礼金 是否开启
		 */		
		public static var gongneng102:Boolean=false
		/**
		 * 免聚灵珠兑换神龙护身符 是否开启
		 */		
		public static var gongneng103:Boolean=false
		/**
		 * 紫装重置100% 是否开启
		 */		
		public static var gongneng104:Boolean=false
		/**
		 * 神奇炼骨丹的使用 是否开启
		 */		
		public static var gongneng105:Boolean=false
		/**
		 * 宝石限时兑换 是否开启
		 */		
		public static var gongneng106:Boolean=false
		/**
		 * 神奇资质丹的使用 是否开启
		 */		
		public static var gongneng107:Boolean=false
		/**
		 * 祝福值兑换神奇炼骨丹 是否开启
		 */		
		public static var gongneng108:Boolean=false
		/**
		 * 宝石兑换（5级相同属性的宝石 换 一个6级相同属性的宝石）
		 */		
		public static var gongneng109:Boolean=false
		/**
		 * 限时加工（含 六品宝石任意置换 和 六品宝石融100血）
		 */		
		public static var gongneng110:Boolean=false
		/**
		 * 激活 孔雀翎（暗器第七阶）强化属性
		 */		
		public static var gongneng111:Boolean=false
		/**
		 * 显示“使用菩提精萃”选项
		 */		
		public static var gongneng112:Boolean=false
		/**
		 * 显示“使用神奇菩提丹”选项
		 */		
		public static var gongneng113:Boolean=false
		/**
		 * 重置附加属性数值100%
		 */		
		public static var gongneng114:Boolean=false
		
			
		/**
		 * 是否在界面上固定显示  寻宝鼠友好度赠送活动  中的   松果友好丹BUFF
		 */		
		public static var gongneng150:Boolean=false;
		/**
		 * 是否在界面上固定显示  弓箭进阶合成祝福时间活动  中的  弓箭祝福丹BUFF
		 */		
		public static var gongneng151:Boolean=false;
		/**
		 * 是否在界面上固定显示  七阶弓箭免费领取箭术秘籍活动  中的  七阶弓箭免费领取箭术秘籍活动BUFF
		 */		
		public static var gongneng152:Boolean=false;
		/**
		 * 是否在界面上固定显示  龙鳞丹活动  中的 龙鳞丹BUFF
		 */		
		public static var gongneng153:Boolean=false;
		/**
		 * 是否在界面上固定显示  炼体金丹活动  中的 炼体金丹BUFF
		 */		
		public static var gongneng154:Boolean=false;
		/**
		 * 是否在界面上固定显示  弓箭保级丹活动  中的 弓箭保级丹BUFF
		 */		
		public static var gongneng155:Boolean=false;	
		/**
		 * 是否在界面上固定显示  丹田祝福丹活动  中的  丹田祝福丹BUFF
		 */		
		public static var gongneng156:Boolean=false;	
		/**
		 * 是否在界面上固定显示  超值梦幻菩提卡活动  中的  超值梦幻菩提卡BUFF和肉身提升祝福时间（锻体金丹）
		 */		
		public static var gongneng157:Boolean=false;	
		

		/**
		 * 显示“使用聚灵精华”选项（每个聚灵精华==一个聚灵珠，每次提升最多使用一个聚灵精华）
		 */		
		public static var gongneng158:Boolean=false;	
		/**
		 * 显示“使用神奇四灵锻造丹”选项（每个神奇四灵锻造丹==一次四灵阵提升，无论此次需要多少聚灵珠）
		 */		
		public static var gongneng159:Boolean=false;	
		/**
		 * 显示“使用神奇舍利子提升丹”选项（每个神奇舍利子提升丹==一次舍利子提升，无论此次需要多少聚灵珠）
		 */		
		public static var gongneng160:Boolean=false;	
		/**
		 * 显示“使用碧灵精华”选项（每个碧灵精华==一个碧灵珠，每次提升最多使用一个碧灵精华）
		 */		
		public static var gongneng161:Boolean=false;	
		/**
		 * 显示“使用神奇碧灵丹”选项（每个神奇碧灵丹==一次丹田提升，无论此次需要多少碧灵丹）
		 */		
		public static var gongneng162:Boolean=false;	
		
		/**
		 * 是否在界面上固定显示  龙筋免消耗材料锻造弓箭BUFF
		 */		
		public static var gongneng163:Boolean=false;	
		
		
		/**
		 * 显示“使用洞箫精华”选项（每个洞箫精华==一个洞箫升段石，每次提升最多使用一个洞箫精华）
		 */		
		public static var gongneng164:Boolean=false;	
		
		/**
		 * 显示“使用神奇洞箫升段石”选项（每个奇洞箫升段石==一次洞箫提升，无论此次需要多少洞箫升段石）
		 */		
		public static var gongneng165:Boolean=false;	
		
		//***************************(占位, 国内暂时不使用此ID)
		/**
		 * 控制韩服 领取合服奖励 选项是否显示
		 */		
		public static var gongneng166:Boolean=false;
		
		/**
		 * 控制左上角跨平台比武大会 按钮是否显示
		 */		
		public static var gongneng1000:Boolean=false;
		
		/**
		 * 控制成就面板中 比武大会 按钮是否显示
		 */		
		public static var gongneng1001:Boolean=false;	//测试时为true eddy
		/**
		 * 是否跳过帮会旗帜帮助
		 */		
		public static var tiaoguoBangzhu:Boolean = false;
		
		/**
		 * 活动面板的累计登录奖励
		 */
		public static var gongneng2001:Boolean = false;
		
		/**
		 * 控制刺杀任务按钮是否显示
		 */
		public static var gongneng2002:Boolean = false;
		/**
		 * 控制傲剑争霸按钮是否显示
		 */
		public static var gongneng2003:Boolean = false;
		/**
		 * 控制止战之殇按钮是否显示
		 */
		public static var gongneng2004:Boolean = false;
		/**
		 * 控制蛇贺新春按钮是否显示
		 */
		public static var gongneng2005:Boolean = false;
		
		/**
		 * 控制人物属性面板中运程是否显示
		 */
		public static var gongneng2200:Boolean = false;
		
		/**
		 * 控制人物属性面板中五行之刃是否显示
		 */
		public static var gongneng2201:Boolean = false;
		/**
		 * 控制魔兽碎片兑换功能是否开启
		 */
		public static var gongneng2202:Boolean = false;
	
		/**
		 * 
		 */		
		public static var isNPCTask:Boolean = false;
		/**
		 * 控制36手标签是否显示
		 */
		public static var gongneng2014:Boolean = false;	
		/**
		 * 
		 */		
		public static var isMonsterTask:Boolean = false;
		/**
		 * 收集物品任务
		 */
		public static var isGoodsTask:Boolean = false;
		
		/**
		 * 是否显示新手副本，是：直接选择第一个角色登录，不显示角色选择界面
		 */
		public static var showXinShouFuBen:Boolean = false;
		public static var isEndShouFuBen:Boolean = false;
		public static var inJumpTask:Boolean = true;
		
		//命运转盘的结果是否已经显示
		public static var mingyunzhuanpanJieGuoIsShow:Boolean=true;
		
		public static var mingyunzhuanpanTiShiIsShow:Boolean = true;
		
		/**
		 * 空格 释放 明玉功  移花接木技能
		 */		
		public static var SPACE_TO_MINGYUGONG_SKILL:Boolean = false;
		
		/**
		 * 陷阱
		 */
		public static var xianJingDict:Dictionary = new Dictionary();
		
		/**
		 * 主角激活状态字典
		 */
		public static var dictMainStatus:Dictionary = new Dictionary();
		/**
		 * 查看玩家激活状态字典
		 */
		public static var dictTargetStatus:Dictionary = new Dictionary();
	}
}