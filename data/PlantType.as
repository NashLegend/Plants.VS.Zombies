package data 
{
	import plants.*;
	/**
	 * ...
	 * @author IJUST
	 */
	public class PlantType 
	{
		
		
		//各种需要的地面状况
		public static const Lawn_NoPlant_Field:int = 0;
		public static const Lawn_HasPlant_Field:int = 1;
		public static const Lawn_NoPlant_Water:int = 2;
		public static const Lawn_HasPlant_Water:int=3
		public static const Lawn_HasLily:int = 4;
		public static const Lawn_HasSprite:int = 5;
		public static const Lawn_Bowl:int = 6;
		/*************************************************/
		//普通地面、荷叶、花盆
		static public const arr1:Array = [PlantType.Lawn_NoPlant_Field, PlantType.Lawn_HasLily,PlantType.Lawn_Bowl];
		//普通地面、荷叶（这个仅仅是那个盆子）
		static public const arr2:Array = [PlantType.Lawn_NoPlant_Field, PlantType.Lawn_HasLily];
		//水面
		static public const arr3:Array = [PlantType.Lawn_NoPlant_Water];
		//有植物的
		static public const arr4:Array = [PlantType.Lawn_HasPlant_Field];
		/*************************************************/
		
		
		//植物的各种状态如吃等等 我了个去 只有吞噬者 坚果 甚至坚果都不需要
		static public const ATTACK:String = "ATTACK";
		static public const CHAWING:String = "CHAWING";
		static public const WAITING:String = "WAITING";
		
		
		
		
		
		/*************************************************/
		//豌豆
		static public const _Peashooter:Object = { LawnState:PlantType.arr1, hp:200, fireinterval:48, cooldown:7500, sunshine:100, cardpath:"images/Card/Plants/Peashooter.png", cardpathG:"images/Card/Plants/PeashooterG.png", tips:"豌豆射手",intropath:"images/PlantIntro/Peashooter.gif",intro:"You've Got PeaShooter" };
		//向日葵
		static public const _SunFlower:Object = {LawnState:PlantType.arr1, hp:200, fireinterval:120, cooldown:7500, sunshine:50, cardpath:"images/Card/Plants/SunFlower.png", cardpathG:"images/Card/Plants/SunFlowerG.png", tips:"太阳花",intropath:"images/PlantIntro/SunFlower.gif",intro:"You've Got SunFlower" };
		//草莓
		static public const _CherryBomb:Object = {LawnState:PlantType.arr1, hp:200, fireinterval:48, cooldown:30000, sunshine:50, cardpath:"images/Card/Plants/CherryBomb.png", cardpathG:"images/Card/Plants/CherryBombG.png", tips:"樱桃炸弹",intropath:"images/PlantIntro/CherryBomb.gif",intro:"You've Got CherryBomb" };
		//坚果墙
		static public const _WallNut:Object = {LawnState:PlantType.arr1,hp:200, fireinterval:48, cooldown:7500, sunshine:50, cardpath:"images/Card/Plants/WallNut.png", cardpathG:"images/Card/Plants/WallNutG.png", tips:"坚果墙",intropath:"images/PlantIntro/WallNut.gif",intro:"You've Got WallNut" };
		//双线
		static public const _Repeater:Object = {LawnState:PlantType.arr1, hp:200, fireinterval:48, cooldown:7500, sunshine:100, cardpath:"images/Card/Plants/Repeater.png", cardpathG:"images/Card/Plants/RepeaterG.png", tips:"双线射手",intropath:"images/PlantIntro/Repeater.gif",intro:"You've Got Repeater" };
		//雪豌豆
		static public const _SnowPea:Object= {LawnState:PlantType.arr1, hp:200, fireinterval:48, cooldown:7500, sunshine:100, cardpath:"images/Card/Plants/SnowPea.png", cardpathG:"images/Card/Plants/SnowPeaG.png", tips:"冰射手",intropath:"images/PlantIntro/SnowPea.gif" ,intro:"You've Got Snowpea"};
		//小喷菇
		static public const _PuffShroom:Object={LawnState:PlantType.arr1, hp:200, fireinterval:48, cooldown:7500, sunshine:0, cardpath:"images/Card/Plants/PuffShroom.png", cardpathG:"images/Card/Plants/PuffShroomG.png", tips:"小喷菇",intropath:"images/PlantIntro/PuffShroom.gif" ,intro:"You've Got PuffShroom" };
		//大喷菇
		static public const _FumeShroom:Object={LawnState:PlantType.arr1, hp:200, fireinterval:48, cooldown:7500, sunshine:100, cardpath:"images/Card/Plants/FumeShroom.png", cardpathG:"images/Card/Plants/FumeShroomG.png", tips:"大喷菇",intropath:"images/PlantIntro/FumeShroom.gif" ,intro:"You've Got FumeShroom" };
		//吞噬者
		static public const _Chomper:Object={LawnState:PlantType.arr1, hp:200, fireinterval:240, cooldown:7500, sunshine:100, cardpath:"images/Card/Plants/Chomper.png", cardpathG:"images/Card/Plants/ChomperG.png", tips:"吞噬者",intropath:"images/PlantIntro/Chomper.gif" ,intro:"You've Got Chomper" };
		//地刺
		static public const _Spikeweed:Object={LawnState:PlantType.arr1, hp:200, fireinterval:48, cooldown:7500, sunshine:100, cardpath:"images/Card/Plants/Spikeweed.png", cardpathG:"images/Card/Plants/SpikeweedG.png", tips:"地刺",intropath:"images/PlantIntro/spikeweed.gif" ,intro:"You've Got spikeweed" };
		//火树桩
		static public const _Torchwood:Object={LawnState:PlantType.arr1, hp:200, fireinterval:48, cooldown:7500, sunshine:100, cardpath:"images/Card/Plants/Torchwood.png", cardpathG:"images/Card/Plants/TorchwoodG.png", tips:"火树桩" ,intropath:"images/PlantIntro/torchwood.gif" ,intro:"You've Got TorchWood"};
		//荷叶
		static public const _LilyPad:Object = {LawnState:PlantType.arr3, hp:200, fireinterval:48, cooldown:7500, sunshine:100, cardpath:"images/Card/Plants/LilyPad.png", cardpathG:"images/Card/Plants/LilyPadG.png", tips:"荷叶",intropath:"images/PlantIntro/lilypad.gif" ,intro:"You've Got LilyPad" };
		//花盆
		static public const _FlowerPot:Object={LawnState:PlantType.arr2, hp:200, fireinterval:48, cooldown:7500, sunshine:100, cardpath:"images/Card/Plants/FlowerPot.png", cardpathG:"images/Card/Plants/FlowerPotG.png", tips:"花盆" ,intropath:"images/PlantIntro/flowerpot.gif" ,intro:"You've Got FlowerPot"};
		/*************************************************/
		
		
		public function PlantType() 
		{
			 
		}
		//生命值
		//发射间隔
		
	}

}