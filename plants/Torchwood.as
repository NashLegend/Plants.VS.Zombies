package plants 
{
	import data.PlantType;
	import flash.events.Event;
	import plants.plant;
	/**
	 * ...
	 * @author IJUST
	 */
	public class Torchwood extends plant 
	{
		public function Torchwood() 
		{
			super();
		}
		override protected function addedToStage(e:Event):void 
		{
			this.plantType = PlantType._Torchwood;
			super.addedToStage(e);
		}
	}

}