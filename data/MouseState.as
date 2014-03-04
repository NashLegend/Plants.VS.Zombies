package data 
{
	/**
	 * ...
	 * @author IJUST
	 */
	//记录鼠标点击事件的鼠标点击状态
	public class MouseState 
	{
		//初始鼠标状态为未选中植物
		public static var MouseStates:int = 1;
		
		//在游戏中选择植物在状态 ，分别为选中植物、未选中植物、选中铲子
		public static const MOUSE_HASSELECT_PLANT:int = 0;
		public static const MOUSE_HASDROPED_PLANT:int = 1;
		public static const MOUSE_HASSELECT_SHOVEL:int = 2;
		
		//卡片点击次数记录  若第一次则是选择   第二次则是取消
		public static const CARD_OR_BAR_FIRSTCLICK:int = 1;
		public static const CARD_OR_BAR_SECONDCLICK:int = 2;
		public static var Card_Or_Bar_ClickState:int = 1;
		//开始前选植物的量为：
		
		
		//记录选择的种类
		public static var Plant_Selected:Object=new Object();
		
		
		//植物卡片的状态
		public static const CARD_SELECT:int = 0;
		public static const CARD_NORMAL:int = 1;
		public static const CARD_PLANTED:int = 2;
		
		
		public function MouseState() 
		{
			
		}
		
	}

}