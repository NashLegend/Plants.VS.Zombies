package plants 
{
	import data.PlantType;
	import flash.events.Event;
	import plants.plant;
	/**
	 * ...
	 * @author IJUST
	 */
	public class LilyPad extends plant 
	{
		
		public function LilyPad() 
		{
			super();
		}
		override protected function addedToStage(e:Event):void 
		{
			this.plantType = PlantType._LilyPad;
			this.hp = plantType.hp;
			this.clearable = false;
		}
	}

}