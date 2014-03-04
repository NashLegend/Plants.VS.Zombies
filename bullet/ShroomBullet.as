package bullet 
{
	import data.BulletType;
	import data.ZombType;
	import flash.events.Event;
	import utils.hitTest;
	import zombs.zomb;
	/**
	 * ...
	 * @author IJUST
	 */
	public class ShroomBullet extends Bullet 
	{
		
		public function ShroomBullet() 
		{
			super();
		}
		override protected function addedTooStage(e:Event):void 
		{
			this.mouseEnabled = false;
			this.bulletType = BulletType._Peabullet;
			super.addedTooStage(e);
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
						item.gethurt(this.damage, ZombType.Shoot_To_Death, this.bulletType);
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