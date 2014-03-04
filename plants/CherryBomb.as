package plants 
{
	import data.GameData;
	import data.PlantType;
	import data.ZombType;
	import flash.events.Event;
	import zombs.zomb;
	/**
	 * ...
	 * @author IJUST
	 * 草莓炸弹
	 */
	public class CherryBomb extends plant
	{
		public function CherryBomb() 
		{
			super();
		}
		
		override protected function addedToStage(e:Event):void 
		{
			this.plantType = PlantType._CherryBomb;
			super.addedToStage(e);
		}
		override protected function checkZombie():void
		{
			if (this.cherry.currentFrame==this.cherry.totalFrames) 
			{
				for (var i:int = 0; i < zombArray.length; i++)
				{
					var item:zomb = zombArray[i] as zomb;
					if (Math.sqrt((item.x-this.x)* (item.x-this.x)+(item.y-this.y)* (item.y-this.y))<(GameData.tilewidth*2.5))  
					{
						item.gethurt(8000, ZombType.Bomb_To_Death);
					}
				}
				this.clearable = true;
			}
		}
	}

}