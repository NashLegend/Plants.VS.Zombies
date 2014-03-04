package plants 
{
	import bullet.SnowPeaBullet;
	import data.PlantType;
	import flash.events.Event;
	import plants.plant;
	import zombs.zomb;
	/**
	 * ...
	 * @author IJUST
	 */
	public class SnowPea extends plant
	{
		
		public function SnowPea() 
		{
			//this.plantType = PlantType._Peashooter;
			super();
			
		}
		
		override protected function addedToStage(e:Event):void
		{
			this.plantType = PlantType._SnowPea;
			super.addedToStage(e);
		}
		
		override protected function checkZombie():void 
		{
			for (var i:int = 0; i < zombArray.length; i++) 
			{
				var item:zomb = zombArray[i] as zomb;
				if (item.positionY==this.positionY&&item.x>this.x) 
				{
					fire();
				}
			}
		}
		
		protected function fire():void 
		{
			if (int(inc % fireinterval)==0) 
			{
				var peaBullet:SnowPeaBullet = new SnowPeaBullet();
				peaBullet.bulletlayer = this.bulletLayer;
				peaBullet.zombArray = this.zombArray;
				peaBullet.plantArr = this.plantArray;
				//子弹要放到不同在一个显示对象里
				peaBullet.x = this.x+30;
				peaBullet.y = this.y-22;
				peaBullet.positionY = this.positionY;
				bulletLayer.addChild(peaBullet);
			}
		}
	}
}