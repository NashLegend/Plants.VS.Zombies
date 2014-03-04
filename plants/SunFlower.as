package plants 
{
	import bullet.Sun;
	import data.PlantType;
	import flash.events.Event;
	import Layers.layer;
	/**
	 * ...
	 * @author IJUST
	 */
	public class SunFlower extends plant
	{
		public var sunboard:sunBoard;
		public var sunLayer:layer;
		public function SunFlower() 
		{
			super();
		}
		override protected function addedToStage(e:Event):void 
		{
			this.plantType = PlantType._SunFlower;
			super.addedToStage(e);
		}
		override protected function enterFrame(e:Event):void 
		{
			inc++;
			if (int(inc%this.fireinterval)==0) 
			{
				productSunshine();
			}
		}
		
		public function productSunshine():void 
		{
			var gameSun:Sun = new Sun();
			gameSun.SunBoard = this.sunboard;
			gameSun.x = this.x+40;
			gameSun.y = this.y+80;
			this.sunLayer.addChild(gameSun);
		}

		
	}

}