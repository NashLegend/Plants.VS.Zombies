package vehicle 
{
	import data.GameData;
	import data.PlantType;
	import flash.display.MovieClip;
	import flash.events.Event;
	import zombs.zomb;
	
	/**
	 * ...
	 * @author IJUST
	 */
	public class LawnCleaner extends MovieClip 
	{
		public var zombArray:Array;
		private var speed:int = 20;
		private var state:String;
		public var positionY:int;
		public function LawnCleaner() 
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		private function addedToStage(e:Event):void 
		{
			state = PlantType.WAITING;
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		private function enterFrame(e:Event):void 
		{
			checkState();
		}
		private function checkState():void 
		{
			switch (state) 
			{
				case PlantType.WAITING:
					checkZombie();
				break;
				default:
					PlantType.ATTACK;
					move();
				break;
			}
		}
		private function checkZombie():void 
		{
			for (var i:int = 0; i < zombArray.length; i++) 
			{
				var item:zomb = zombArray[i] as zomb;
				if (Math.abs(item.x - this.x) < 20&&item.positionY==this.positionY ) 
				{
					this.state = PlantType.ATTACK;
					return;
				}
			}
		}
		private function move():void 
		{
			this.x += speed;
			if (this.x>GameData.stagewidth+60) 
			{
				if (this.parent) 
				{
					this.removeEventListener(Event.ENTER_FRAME, enterFrame);
					this.removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
					this.parent.removeChild(this);
				}
			}
			for (var i:int = 0; i < zombArray.length; i++) 
			{
				var item:zomb = zombArray[i] as zomb;
				if (Math.abs(item.x - this.x) < 20&&item.positionY==this.positionY ) 
				{
					item.clearable = true;
					return;
				}
			}
		}
	}

}