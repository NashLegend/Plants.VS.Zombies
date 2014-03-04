package plants 
{
	import flash.display.MovieClip;
	import data.GameData;
	import flash.display.Sprite;
	import flash.events.Event;
	import zombs.zomb;
	import data.PlantType;
	import Layers.layer;
	/**
	 * ...
	 * @author IJUST
	 */
	public class plant extends MovieClip
	{
		public var plantArray:Array;
		protected var hp:int;
		public var zombArray:Array;
		protected var inc:int;
		public var positionX:int;
		public var positionY:int;
		public var clearable:Boolean;
		protected var numZombies:int;
		protected var fireinterval:int;
		protected var plantType:Object;
		public var bulletLayer:layer;
		public var PlantLayer:layer;
		
		public function plant() 
		{
			this.mouseEnabled = false;
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, decades);
		}
		
		protected function addedToStage(e:Event):void 
		{
			this.hp = plantType.hp;
			this.fireinterval = plantType.fireinterval;
			this.clearable = false;
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		
		protected function enterFrame(e:Event):void 
		{
			inc++;
			checkZombie();
		}
		
		protected function checkZombie():void 
		{
			
		}
		public function gethurt(damage:int):void 
		{
			this.hp -= damage;
			if (this.hp<=0) 
			{
				die();
			}
		}
		protected function die():void 
		{
			this.stop();
			this.clearable = true;
		}
		protected function  decades(e:Event):void 
		{
			this.removeEventListener(Event.ENTER_FRAME, enterFrame);
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
	}

}