package plants 
{
	import bullet.*;
	import data.GameData;
	import data.PlantType;
	import flash.events.Event;
	import plants.plant;
	import zombs.zomb;
	/**
	 * ...
	 * @author IJUST
	 */
	public class PuffShroom extends plant 
	{
		
		public function PuffShroom() 
		{
			super();
		}
		override protected function addedToStage(e:Event):void 
		{
			this.plantType = PlantType._PuffShroom;
			super.addedToStage(e);
		}
		override protected function checkZombie():void 
		{
			for (var i:int = 0; i < zombArray.length; i++) 
			{
				var item:zomb = zombArray[i] as zomb;
				if (item.positionY == this.positionY && item.x > this.x && (item.x - this.x) < GameData.tilewidth * 3 ) 
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
				Shroom.scaleX = Shroom.scaleY = 0.6;
				Shroom.bulletlayer = this.bulletLayer;
				Shroom.zombArray = this.zombArray;
				Shroom.plantArr = this.plantArray;
				//子弹要放到不同在一个显示对象里
				Shroom.x = this.x+10;
				Shroom.y = this.y;
				Shroom.positionY = this.positionY;
				this.bulletLayer.addChild(Shroom);
			}
		}
		
	}

}