package bullet 
{
	import data.GameData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import Layers.layer;
	import utils.hitTest;
	import zombs.zomb;
	/**
	 * ...
	 * @author IJUST
	 */
	public class Bullet extends MovieClip
	{
		public var plantArr:Array;
		public var bulletlayer:layer;
		public var speed:int=0;
		public var damage:int=0;
		public var bulletType:Object;
		public var zombArray:Array;
		public var positionX:int;
		public var positionY:int;
		public var clearable:Boolean;
		public function Bullet() 
		{
			clearable = false;
			this.mouseEnabled = false;
			addEventListener(Event.ADDED_TO_STAGE, addedTooStage);
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		protected function addedTooStage(e:Event):void 
		{
			this.speed = bulletType.speed;
			this.damage = bulletType.damage;
		}
		
		protected function enterFrame(e:Event):void 
		{
			move();
			hitTestZombie();
			if (this.x<0||this.y<0||this.x>GameData.stagewidth||this.y>GameData.stageheight) 
			{
				if (this.parent) 
				{
					this.parent.removeChild(this);
				}
			}
		}
		
		
		protected function move():void 
		{
			this.x += this.speed;
			if (this.x>GameData.stagewidth||this.y<(-10)) 
			{
				this.removeEventListener(Event.ENTER_FRAME, enterFrame);
				if (this.parent) 
				{
					this.parent.removeChild(this);
				}
			}
		}
		
		protected function hitTestZombie():void 
		{
			for (var i:int = 0; i < zombArray.length; i++) 
			{
				var item:zomb = zombArray[i];
				if (this.positionY==item.positionY) 
				{
					if (hitTest.hitTestPoint(this,item))
					{
						item.gethurt(this.damage);
						this.removeEventListener(Event.ENTER_FRAME, enterFrame);
						if (this.parent) 
						{
							this.parent.removeChild(this);
						}
						
						break;
					}
				}
			}
		}
	}

}