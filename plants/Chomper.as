package plants 
{
	import data.GameData;
	import data.PlantType;
	import flash.events.Event;
	import plants.plant;
	import zombs.zomb;
	/**
	 * ...
	 * @author IJUST
	 */
	public class Chomper extends plant 
	{
		public var plstate:String;
		public var chawCountDown:int;
		public var zombeat:zomb;
		public function Chomper() 
		{
			super();
		}

		override protected function addedToStage(e:Event):void 
		{
			this.plantType = PlantType._Chomper;
			this.hp = plantType.hp;
			this.fireinterval = plantType.fireinterval;
			this.clearable = false;
			this.plstate = PlantType.WAITING;
			addEventListener(Event.ENTER_FRAME, enterFrame);
			//
		}
		override protected function enterFrame(e:Event):void 
		{
			inc++;
			checkstate();
		}
		//发现僵尸并且在可攻击时发起攻击
		override protected function checkZombie():void 
		{
			for (var i:int = 0; i < zombArray.length; i++) 
			{
				this.zombeat = zombArray[i] as zomb;
				//这样攻击的不一定是最近的了
				//要从中筛选出距离最近的来
				if (zombeat.positionY==this.positionY&&zombeat.x>this.x&&(zombeat.x-this.x)<GameData.tilewidth*2) 
				{
					eat();
					return;
				}
			}
		}
		
		protected function checkstate():void 
		{
			switch (this.plstate) 
			{
				case PlantType.WAITING:
					checkZombie();
				break;
				case PlantType.CHAWING:
					chawCountDown++;
					if (chawCountDown==this.fireinterval) 
					{
						gotoAndPlay("waiting");
						this.plstate = PlantType.WAITING;
					}
				break;
				case PlantType.ATTACK:
					//攻击
					if (this.attack.currentFrame==this.attack.totalFrames) 
					{
						zombeat.clearable = true;
						gotoAndPlay("chaw");
						this.plstate = PlantType.CHAWING;
						this.chawCountDown = 0;
					}
				break;
				default:
					
				break;
			}
		}
		
		protected function eat():void 
		{
			//仍然是用状态机制来写
			gotoAndPlay("attack");
			this.plstate = PlantType.ATTACK;
			
		}
	}

}