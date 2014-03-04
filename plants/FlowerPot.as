package plants 
{
	import data.PlantType;
	import flash.events.Event;
	import plants.plant;
	/**
	 * ...
	 * @author IJUST
	 */
	public class FlowerPot extends plant 
	{
		
		public function FlowerPot() 
		{
			super();
		}
		override protected function addedToStage(e:Event):void 
		{
			this.plantType = PlantType._Peashooter;
			super.addedToStage(e);
		}
	}

}