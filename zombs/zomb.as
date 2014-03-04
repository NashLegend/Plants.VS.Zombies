package zombs 
{
	import data.*
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.utils.Timer;
	import Layers.layer;
	import MyEvent.PvzEvent;
	import plants.plant;
	import utils.hitTest;
	/**
	 * ...
	 * @author IJUST
	 */
	public class zomb extends MovieClip
	{
		public var PlantArray:Array=[];
		public var speed:Number;
		public var hp:Number;
		public var killer:plant;
		public var inc:int;
		public var positionX:int;
		public var positionY:int;
		public var clearable:Boolean;
		public var zombieType:Object;
		public var walkable:Boolean;
		public var numPlants:int;
		public var hitinterval:int;
		public var damage:Number;
		public var ZombLayer:layer;
		public var moveState:String;
		public var HitTestable:Boolean;
		public var coldTimer:Timer = new Timer(100,40);
		public function zomb() 
		{
			this.HitTestable = true;
			this.moveState = ZombType.WALK;
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, decades);
		}
		protected function addedToStage(e:Event):void 
		{
			this.coldTimer.addEventListener(TimerEvent.TIMER_COMPLETE, timercomplete);
			this.walkable = true;
			this.hp = zombieType.hp;
			this.speed = zombieType.speed;
			this.damage = zombieType.damage;
			this.hitinterval = zombieType.hitinterval;
			this.clearable = false;
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		protected function timercomplete(e:TimerEvent):void 
		{
			this.transform.colorTransform = new ColorTransform();
			this.speed = zombieType.speed;
		}
		protected function  enterFrame(e:Event):void 
		{
			inc++;
			
			checkMoveState();
			
			if (this.HitTestable) 
			{
				CheckHitPlants();
			}
			
			checkInvasion();
			
			if (walkable) 
			{
				move();
			}
		}
		
		//检查是否僵尸已经侵入
		protected function checkInvasion():void
		{
			if (this.x<(-30)) 
			{
				PvzEvent.LawnEvent.dispatchEvent(new Event(PvzEvent.ZOMBIE_INSIDE));
			}
		}
		//检查运动状态  下一级要重写了
		protected function checkMoveState():void 
		{
			
		}
		//子类中要继承并添加hittest
		protected function move():void 
		{
			
		}
		//被冰冻
		public function getCold():void 
		{
			coldTimer.reset();
			this.transform.colorTransform = new ColorTransform(0.5, 0.5, 1, 1, 0, 0, 0, 0);
			coldTimer.start();
			this.speed = this.speed / 2;
		}
		protected function CheckHitPlants():void
		{
			
		}
		//是否使用防护
		public function gethurt(damage:int,hurtType:String=ZombType.Shoot_To_Death,killer:Object=null):void 
		{
			//trace(damage);
			if (this.HitTestable)
			{
				this.hp -= damage;
				if (this.hp<=0) 
				{
					this.HitTestable = false;
					this.die(hurtType);
				}
			}
		}
		protected function  die(hurtType:String):void 
		{
			
		}
		//从舞台移除时
		protected function decades(e:Event):void 
		{
			this.removeEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
	}

}