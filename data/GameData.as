package data 
{
	/**
	 * ...
	 * @author IJUST
	 */
	import data.PlantType;
	public class GameData 
	{
		public static var currentMission:int = 0;
		//MiniBar每块长宽
		public static const BarTileWidth:int = 60;
		public static const BarTileHeight:int = 70;
		public static const BarLeftGap:int = 80;
		public static const BarTopGap:int = 8;
		public static const BoardLeftGap:int = 22;
		public static const BoardTopGap:int = 80;
		public static const BigMissionLength:int = 4;
		//区块长度
		public static const tilewidth:int = 80;
		//区块宽度
		public static const tileheight:int = 100;
		//阳光总量
		public static var sunshine:int = 500;
		//阳光初始值
		public static var sunInit:int = 50;
		//舞台宽度
		public static const stagewidth:int = 700;
		//舞台高度
		public static const stageheight:int=600;
		//记录所有植物种类
		public static var ALL_PLANT_TYPE:Array = [PlantType._Peashooter,PlantType._SunFlower,PlantType._CherryBomb,PlantType._WallNut,PlantType._PuffShroom,PlantType._SnowPea,PlantType._FumeShroom,PlantType._Chomper,PlantType._Repeater,PlantType._Spikeweed,PlantType._Torchwood,PlantType._LilyPad,PlantType._FlowerPot];
		//记录选择的植物种类
		public static var Plant_Has_Select:Array = [];
		
		//地面上的植物类型
		
		
		//各种各样的地面状况
		public static const Lawn_NoPlant_Field:int = 0;
		public static const Lawn_HasPlant_Field:int = 1;
		public static const Lawn_NoPlant_Water:int = 2;
		public static const Lawn_HasPlant_Water:int=3
		public static const Lawn_HasLily:int = 4;
		public static const Lawn_HasSprite:int = 5;
		public static const Lawn_Bowl:int = 6;
		public static const Nothing_And_Barn:int = 100;
		//
		//
		//
		//
		//
		//
		//
		//
		//记录MiniBar的容器长度
		public static var MiniBar_Content_Lenght:int=4;	
		//记录可以选择即已经解封的植物
		public static var PlantUnsealed:Array=[PlantType._Peashooter];
		//记录地图上植物种植状况
		public static var MapInfo:Array =
		[
			[0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0]
		]
		//恢复MapInfo所用数组
		public static const MapReset:Array =
		[
			[0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0]
		]
		

		
		public function GameData() 
		{
			
		}
		
	}

}