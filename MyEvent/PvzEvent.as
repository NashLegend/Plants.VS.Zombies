package MyEvent 
{
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author IJUST
	 */
	public class PvzEvent 
	{
		public static const LawnEvent:EventDispatcher = new EventDispatcher();
		public static const Pvz_MainEvent:EventDispatcher = new EventDispatcher();
		public static const ZOMBIE_INSIDE:String = "zombieinside";
		public static const NEXT_MISSION:String = "nextmission";
		public static const MISSION_FAILED:String = "missionfailed";
		public static const MISSION_RESTART:String = "missionrestart";
		public static const GAME_OVER:String = "gameover";
		public static const BEGIN_ADVENTURE:String = "beginadventure";
		public static const LETS_ROCK_AND_ROLL:String = "letsrockandroll";
		//就这样
		public function PvzEvent() 
		{
			
		}
		
	}

}