package plants 
{
	import data.PlantType;
	import flash.events.Event;
	import plants.plant;
	import zombs.zomb;
	/**
	 * ...
	 * @author IJUST
	 */
	public class Spikeweed extends plant 
	{
		private var damage:int = 20;
		public var item:zomb;
		public function Spikeweed() 
		{
			super();
		}
		override protected function addedToStage(e:Event):void 
		{
			this.plantType = PlantType._Peashooter;
			super.addedToStage(e);
		}
		override protected function checkZombie():void 
		{
			for (var i:int = 0; i < zombArray.length; i++) 
			{
				item = zombArray[i] as zomb;
				if (item.positionY==this.positionY&&Math.abs(item.x-this.x)<40)
				{
					fire();
				}
			}
		}
		protected function fire():void 
		{
			if (int(inc % fireinterval)==0) 
			{
				item.gethurt(this.damage);
			}
		}
		
	}

}