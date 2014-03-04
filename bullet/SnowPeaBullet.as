package bullet 
{
	import data.BulletType;
	import data.GameData;
	import flash.events.Event;
	import plants.plant;
	import plants.Torchwood;
	import utils.hitTest;
	import zombs.zomb;
	/**
	 * ...
	 * @author IJUST
	 */
	public class SnowPeaBullet extends Bullet 
	{
		private var coldable:Boolean;
		public function SnowPeaBullet()
		{
			super();
		}
		override protected function addedTooStage(e:Event):void 
		{
			this.coldable = true;
			this.mouseEnabled = false;
			this.bulletType = BulletType._SnowPeabullet;
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
						this.coldable = false;
						this.damage = 40;
						return;
					}
				}
			}
		}
		override protected function hitTestZombie():void 
		{
			for (var i:int = 0; i < zombArray.length; i++) 
			{
				var item:zomb = zombArray[i];
				if (this.positionY==item.positionY) 
				{
					if (hitTest.hitTestPoint(this,item))
					{
						item.gethurt(this.damage);
						if (this.coldable) 
						{
							item.getCold();
						}
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