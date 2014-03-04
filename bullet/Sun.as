package bullet 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import utils.hitTest;
	import utils.MoveUtils;
	import com.greensock.*;
	/**
	 * ...
	 * @author IJUST
	 */
	public class Sun extends MovieClip
	{
		public var SunBoard:sunBoard;
		private var speed:Number = 5;
		public function Sun() 
		{
			this.mouseEnabled = false;
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		private function addedToStage(e:Event):void
		{
			moveToBoard();
		}
		private function moveToBoard():void
		{
			var tt:int= Math.sqrt((this.x-SunBoard.x)*(this.x-SunBoard.x)+(this.y-SunBoard.y)*(this.y-SunBoard.y))>450?5:3
			TweenLite.to(this, tt, { x:40, y:40, onComplete:die } );
			if (this.x<0||this.y<0) 
			{
				if (this.parent) 
				{
					this.parent.removeChild(this);
				}
			}
		}
		private function die():void 
		{
			SunBoard.addSunshine(50);
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			if (this.parent) 
			{
				this.parent.removeChild(this);
			}
		}
	}

}