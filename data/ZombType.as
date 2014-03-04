package data 
{
	import zombs.*;
	/**
	 * ...
	 * @author IJUST
	 */
	public class ZombType 
	{
		//僵尸的各种状态如行走死亡倒地等等
		public static const WALK:String = "WALK";
		public static const ATTACK:String = "ATTACK";
		public static const BOMB_DIE:String = "BOMB_DIE";
		public static const NORMAL_DIE:String = "NORMAL_DIE";
		public static const NORMAL_DIE_FAST:String = "NORMAL_DIE_FAST";
		public static const FALL:String = "FALL";
		public static const JUMP:String = "JUMP";
		public static const WALK_SLOW:String = "WALK_SLOW";
		public static const WALK_SHIELD:String = "WALK_SHIELD";
		public static const ATTACK_SHIELD:String = "ATTACK_SHIELD";
		public static const LOSE_NEWSPAPER:String = "LOSE_NEWSPAPER";
		
		//僵尸的死亡类型  比如被豌豆打死、炸死、压死等等
		public static const Shoot_To_Death:String = "shoottodeath";
		public static const Bomb_To_Death:String = "bombtodeath";
		public static const Wheeled_To_Death:String = "wheeledtodeath";
		
		//各种各样的僵尸们以及其属性
		static public const _Zombie:Object = {  hp:200, speed:0.3, damage:20.1, hitinterval:10 };
		static public const _ConeheadZombie:Object = {  hp:400, speed:0.3, damage:20.2, hitinterval:10 };
		static public const _PoleVaultingZombie:Object = {  hp:200, speed:0.6, damage:20.3, hitinterval:10 };
		static public const _BucketheadZombie:Object = { hp:200, shieldhp:400, speed:0.3, damage:20.4, hitinterval:10 };
		static public const _NewspaperZombie:Object = { hp:200, shieldhp:150, speed:0.3, damage:20.5, hitinterval:10 };
		static public const _ScreenDoorZombie:Object = { hp:200, shieldhp:150, speed:0.3, damage:20.6, hitinterval:10 };
		
		
	}

}