package zombs 
{
	import data.ZombType;
	import flash.events.Event;
	import plants.*;
	import utils.*;
	import zombs.zomb;
	/**
	 * ...
	 * @author IJUST
	 */
	public class ConeheadZombie extends zomb 
	{
		public function ConeheadZombie()
		{
			super();
		}
		override protected function addedToStage(e:Event):void 
		{
			this.zombieType = ZombType._ConeheadZombie;
			super.addedToStage(e);
		}
		
		override protected function checkMoveState():void 
		{
			switch (moveState)
			{
				case ZombType.NORMAL_DIE:
					if (this.zombiedie.currentFrame==this.zombiedie.totalFrames) 
					{
						this.gotoAndPlay("fall");
						this.walkable = false;
						this.moveState =ZombType.FALL;
					}
				break;
				case ZombType.FALL:
					if (this.zombiefall.currentFrame==this.zombiefall.totalFrames) 
					{
						this.clearable = true;
					}
				break;
				case ZombType.BOMB_DIE:
					if (this.zombiebomb.currentFrame==this.zombiebomb.totalFrames) 
					{
						this.clearable = true;
					}
				break;
				default:
					
				break;
			}
		}
		
		override protected function move():void 
		{
			if (this.walkable) 
			{
				gotoAndPlay("walk");
				this.x -= speed;
			}
			
		}
		
		override protected function CheckHitPlants():void
		{
				for (var i:int = 0; i < PlantArray.length; i++) 
				{
					var item:plant = PlantArray[i] as plant;
					if (item is Spikeweed) 
					{
						return;
					}
					if (item.positionY==this.positionY) 
					{
						if (hitTest.hitTestPoint(this,item))
						{
							this.walkable = false;
							gotoAndPlay("attack");
							this.moveState = ZombType.ATTACK;
							if (inc%hitinterval==0)
							{
								item.gethurt(this.damage);
							}
							return;
						}
						if (i==(PlantArray.length-1))
						{
							if (this.moveState==ZombType.WALK||this.moveState==ZombType.ATTACK) 
							{
								this.moveState = ZombType.WALK;
								gotoAndPlay("walk");
								this.walkable = true;
							}
							return;
						}
					}
					//this.moveState = ZombType.WALK;
					//this.walkable = true;
				}
				this.moveState = ZombType.WALK;
				this.walkable = true;
		
		}
		
		override protected function  die(hurtType:String):void 
		{
			switch (hurtType)
			{
				case ZombType.Shoot_To_Death:
					gotoAndPlay("die");
					this.walkable = false;
					this.moveState = ZombType.NORMAL_DIE;
				break;
				case ZombType.Bomb_To_Death:
					gotoAndPlay("bomb");
					this.walkable = false;
					this.moveState = ZombType.BOMB_DIE;
				break;
				case ZombType.Wheeled_To_Death:
					this.clearable = true;
				break;
				default:
					
				break;
			}
		}
	}

}