package plants 
{
	import data.PlantType;
	import flash.events.Event;
	/**
	 * ...
	 * @author IJUST
	 */
	public class WallNut extends plant
	{
		
		public function WallNut() 
		{
			
			super();
		}
		override protected function addedToStage(e:Event):void 
		{
			this.plantType = PlantType._WallNut;
			super.addedToStage(e);
		}
		//不同的植物getHurt很多 都要重写
		
	}

}