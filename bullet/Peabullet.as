package bullet 
{
	import data.BulletType;
	import data.GameData;
	import flash.events.Event;
	import plants.plant;
	import plants.Torchwood;
	/**
	 * ...
	 * @author IJUST
	 */
	
	public class Peabullet extends Bullet
	{
		public function Peabullet() 
		{
			super();
		}
		override protected function addedTooStage(e:Event):void 
		{
			this.mouseEnabled = false;
			this.bulletType = BulletType._Peabullet;
			super.addedTooStage(e);
		}
		override protected function move():void 
		{
			checkTorch();
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
		private function checkTorch():void 
		{
			for (var i:int = 0; i < this.plantArr.length; i++) 
			{
				var item:plant = this.plantArr[i] as plant;
				if (this.hitTestObject(item)) 
				{
					if (item is Torchwood) 
					{
						this.gotoAndStop(2);
						this.damage = 40;
						return;
					}
				}
			}
		}
	}

}