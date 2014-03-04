package plants 
{
	import bullet.ShroomBullet;
	import data.GameData;
	import data.PlantType;
	import flash.events.Event;
	import plants.plant;
	import zombs.zomb;
	/**
	 * ...
	 * @author IJUST
	 */
	public class FumeShroom extends plant 
	{
		private var plstate:String;
		public function FumeShroom() 
		{
			super();
		}
		override protected function addedToStage(e:Event):void 
		{
			this.plstate = PlantType.WAITING;
			this.plantType = PlantType._FumeShroom;
			super.addedToStage(e);
		}
		
		override protected function enterFrame(e:Event):void 
		{
			inc++;
			checkstate();
		}
		
		protected function checkstate():void 
		{
			switch (this.plstate) 
			{
				case PlantType.WAITING:
					checkZombie();
				break;
				case PlantType.ATTACK:
					//攻击
					if (this.attack.currentFrame==this.attack.totalFrames) 
					{
						gotoAndPlay("waiting");
						this.plstate = PlantType.WAITING;
					}
				break;
				default:
					
				break;
			}
		}
		
		override protected function checkZombie():void 
		{
			for (var i:int = 0; i < zombArray.length; i++) 
			{
				var item:zomb = zombArray[i] as zomb;
				if (item.positionY==this.positionY && item.x>this.x && (item.x - this.x) < GameData.tilewidth * 3) 
				{
					fire();
				}
			}
		}
		protected function fire():void 
		{
			if (int(inc % fireinterval)==0) 
			{
				var Shroom:ShroomBullet = new ShroomBullet();
				Shroom.bulletlayer = this.bulletLayer;
				Shroom.zombArray = this.zombArray;
				Shroom.plantArr = this.plantArray;
				//子弹要放到不同在一个显示对象里
				Shroom.x = this.x+30;
				Shroom.y = this.y-22;
				Shroom.positionY = this.positionY;
				this.bulletLayer.addChild(Shroom);
				gotoAndPlay("attacking");
				this.plstate = PlantType.ATTACK;
			}
		}
	}

}