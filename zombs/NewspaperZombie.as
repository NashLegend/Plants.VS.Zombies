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
	public class NewspaperZombie extends zomb 
	{
		private var shieldable:Boolean;
		private var shieldHP:int;
		public function NewspaperZombie() 
		{
			super();
		}
		override protected function addedToStage(e:Event):void 
		{
			this.zombieType = ZombType._NewspaperZombie;
			this.shieldHP = zombieType.shieldhp;
			this.shieldable = true;
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
				case ZombType.LOSE_NEWSPAPER:
					if (this.zombielosepaper.currentFrame==this.zombielosepaper.totalFrames) 
					{
						this.gotoAndPlay("walk");
						this.walkable = true;
						this.moveState = ZombType.WALK_SLOW;
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
				if (this.shieldable) 
				{
					gotoAndPlay("walkshield");
					this.x -= speed;
				}
				else 
				{
					gotoAndPlay("walk");
					this.x -= speed;
				}
				
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
						if (this.shieldable) 
						{
							gotoAndPlay("attackshield");
						}
						else 
						{
							gotoAndPlay("attack");
						}
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
							if (this.shieldable) 
							{
								gotoAndPlay("walkshield");
							}
							else 
							{
								gotoAndPlay("walk");
							}
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
		
		override public function gethurt(damage:int, hurtType:String = ZombType.Shoot_To_Death, killer:Object=null):void
		{
			if (this.HitTestable)
			{
				if (this.shieldable) 
				{
					this.shieldHP -= damage;
					if (this.shieldHP<=0) 
					{
						gotoAndPlay("losepaper");
						this.moveState = ZombType.LOSE_NEWSPAPER;
						this.walkable = false;
						this.shieldable = false;
						this.speed = this.speed * 1.5;
					}
				}
				else 
				{
					this.hp -= damage;
					if (this.hp<=0) 
					{
						this.HitTestable = false;
						this.die(hurtType);
					}
				}
				
			}
			
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