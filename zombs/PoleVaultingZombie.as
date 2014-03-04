package zombs 
{
	import data.ZombType;
	import flash.events.Event;
	import plants.*;
	import utils.hitTest;
	/**
	 * ...
	 * @author IJUST
	 */
	
	public class PoleVaultingZombie extends zomb
	{
		public var firstHit:Boolean;//是否已经遇到第一个植物 若为真则未遇到
		public var speedSlow:Number;//减速后的速度
		public var firstPlant:Boolean;//若为真则已经路过第一个植物
		public function PoleVaultingZombie() 
		{
			super();
		}
		override protected function addedToStage(e:Event):void 
		{
			this.firstPlant = false;
			this.zombieType = ZombType._PoleVaultingZombie;
			this.firstHit = true;//尚未跳过
			super.addedToStage(e);
			this.speedSlow = speed / 2;
		}
		override protected function move():void 
		{
			if (this.walkable) 
			{
				if (this.firstHit) 
				{
					gotoAndPlay("walk");
					this.x -= speed;
				}
				else 
				{
					gotoAndPlay("slowwalk");
					this.x -= speedSlow;
				}
			}
		}
		
		//检查运动状态  
		override protected function checkMoveState():void 
		{
			switch (moveState)
			{
				case ZombType.NORMAL_DIE:
					if (this.zombiedie.currentFrame==this.zombiedie.totalFrames) 
					{
						this.gotoAndPlay("fall");
						this.walkable = false;
						this.moveState = ZombType.FALL;
					}
				break;
				case ZombType.NORMAL_DIE_FAST:
					if (this.zombiediefast.currentFrame==this.zombiediefast.totalFrames) 
					{
						this.gotoAndPlay("fall");
						this.walkable = false;
						this.moveState = ZombType.FALL;
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
				case ZombType.JUMP:
					if (this.zombiejump.currentFrame==this.zombiejump.totalFrames)
					{
						this.x -= 140;
						this.firstPlant = true;
						this.gotoAndPlay("slowwalk");
						this.walkable = true;
						this.moveState = ZombType.WALK_SLOW;
					}
				break;
				default:
					
				break;
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
				if (this.positionY==item.positionY) 
				{
					if (hitTest.hitTestPoint(this,item))
					{
						//若之前未跳过则跳过此植物
						//记录FirstPlant
						//怎样判断第一个植物来
						if (firstHit)
						{
							jump();
							this.walkable = false;
							this.firstHit = false;
							//设为false后  下一帧执行check时就会false并且attack
							return;
						}
						if (this.firstPlant) 
						{
							this.walkable = false;
							//播放啃食动画
							gotoAndPlay("attack");
							this.moveState = ZombType.ATTACK;
							//每隔一个interval的时间对植物进行一次伤害
							if (inc%hitinterval==0) 
							{
								item.gethurt(this.damage);
							}
							return;
						}
					}
					if (i==(PlantArray.length-1))
					{
						if (this.moveState==ZombType.WALK||this.moveState==ZombType.ATTACK||this.moveState==ZombType.WALK_SLOW) 
						{
							this.walkable = true;
							if (this.moveState==ZombType.ATTACK) 
							{
								this.moveState = ZombType.WALK_SLOW;
							}
						}
						return;
					}
				}
				
				if (this.moveState==ZombType.WALK&&this.moveState==ZombType.WALK_SLOW) 
				{
					this.walkable = true;
					if (this.moveState==ZombType.ATTACK) 
					{
						this.moveState = ZombType.WALK_SLOW;
					}
				}
			}
			if (this.moveState==ZombType.WALK&&this.moveState==ZombType.WALK_SLOW) 
			{
				this.walkable = true;
				if (this.moveState==ZombType.ATTACK) 
				{
					this.moveState = ZombType.WALK_SLOW;
				}
			}
		}
		protected function jump():void 
		{
			//直接移动过去  未加跳跃
			gotoAndPlay("jump")
			this.moveState = ZombType.JUMP;
		}
		
		
		override protected function  die(hurtType:String):void 
		{
			//this.removeEventListener(Event.ENTER_FRAME, enterFrame);
			//gotoAndStop("die")
			switch (hurtType)
			{
				case ZombType.Shoot_To_Death:
					if (this.firstHit) 
					{
						gotoAndPlay("diefast");
						this.walkable = false;
						this.moveState = ZombType.NORMAL_DIE_FAST;
					}
					else 
					{
						gotoAndPlay("die");
						this.walkable = false;
						this.moveState = ZombType.NORMAL_DIE;
					}
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