package Pcards 
{
	import bullet.Sun;
	import data.*;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import Layers.layer;
	import Mission.*;
	import MyEvent.PvzEvent;
	import Pcards.PlantIntro;
	import plants.*;
	import vehicle.*;
	import zombs.*;
	/**
	 * ...
	 * @author IJUST
	 */
	public class ZombShow extends MovieClip 
	{
		private var zomArr:Array = [];
		private var zombieArr:Array = [];
		public function ZombShow() 
		{
			picup();
			addEventListener(Event.REMOVED_FROM_STAGE, rem);
		}
		public function stops():void 
		{
			for (var j:int = 0; j < zombieArr.length; j++) 
			{
				zombieArr[j].speed = 0;
			}
		}
		private function rem(e:Event):void 
		{
			for (var j:int = 0; j < zombieArr.length; j++) 
			{
				if (zombieArr[j].parent) 
				{
					(zombieArr[j].parent as Sprite).removeChild(zombieArr[j]);
				}
			}
			zombieArr = [];
		}
		private function picup():void 
		{
			var ss:int = Missions.aMission[GameData.currentMission].zomblists.length;
			var arr:Array = Missions.aMission[GameData.currentMission].zomblists;
			for (var i:int = 0; i < ss; i++) 
			{	
				if (zomArr.length==0) 
				{
					zomArr.push(arr[i]);
				}
				for (var j:int = 0; j <zomArr.length ; j++) 
				{
					if (zomArr[j].zombType.damage==arr[i].zombType.damage)
					{
						break;
					}
					if (j==zomArr.length-1)
					{
						zomArr.push(arr[i]);
					}
				}
			}
			pruductZomb();
		}
		private function pruductZomb():void 
		{
			for (var i:int = 0; i < zomArr.length; i++) 
			{
				var zom:Zombs = zomArr[i] as Zombs;
				var rx:int = 200 * Math.random();
				var ry:int = 400 * Math.random();
				switch (zom.zombType) 
				{
					case ZombType._Zombie:
						var gameZombie:Zombie = new Zombie();
						gameZombie.x = rx
						gameZombie.y = ry;
						this.zombieArr.push(gameZombie);
						this.addChild(gameZombie);
					break;
					case ZombType._ConeheadZombie:
						var gameConeheadZombie:ConeheadZombie = new ConeheadZombie();
						gameConeheadZombie.x = rx;
						gameConeheadZombie.y = ry;
						this.zombieArr.push(gameConeheadZombie);
						this.addChild(gameConeheadZombie);
					break;
					case ZombType._PoleVaultingZombie:
						var gamePoleVaultingZombie:PoleVaultingZombie = new PoleVaultingZombie();
						gamePoleVaultingZombie.x = rx;
						gamePoleVaultingZombie.y = ry;
						this.zombieArr.push(gamePoleVaultingZombie);
						this.addChild(gamePoleVaultingZombie);
					break;
					case ZombType._BucketheadZombie:
						var basket:BucketheadZombie = new BucketheadZombie();
						basket.x = rx;
						basket.y = ry;
						this.zombieArr.push(basket);
						this.addChild(basket);
					break;
					case ZombType._NewspaperZombie:
						var news:NewspaperZombie = new NewspaperZombie();
						news.x = rx;
						news.y = ry;
						this.zombieArr.push(news);
						this.addChild(news);
					break;
					case ZombType._ScreenDoorZombie:
						var screen:ScreenDoorZombie = new ScreenDoorZombie();
						screen.x = rx;
						screen.y = ry;
						this.zombieArr.push(screen);
						this.addChild(screen);
					break;
					default:
						
					break;
				}
			}
			for (var j:int = 0; j < zombieArr.length; j++) 
			{
				zombieArr.sortOn("y");
			}
			for (var k:int = 0; k < zombieArr.length; k++) 
			{
				this.setChildIndex(zombieArr[k], k);
			}
		}
		
	}

}