package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import MyEvent.PvzEvent;
	/**
	 * ...
	 * @author IJUST
	 */
	public class Surface extends MovieClip
	{
		
		public function Surface() 
		{
			this.btnAdventure.addEventListener(MouseEvent.CLICK, beginAdventure);
		}
		private function beginAdventure(e:MouseEvent):void 
		{
			PvzEvent.Pvz_MainEvent.dispatchEvent(new Event(PvzEvent.BEGIN_ADVENTURE));
		}
	}

}