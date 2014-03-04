package Mission 
{
	import zombs.*;
	/**
	 * ...
	 * @author IJUST
	 */
	public class Zombs extends Object
	{
		public var zombType:Object;
		public var interval:int;
		public var posX:int;
		public var posY:int;
		
		public function Zombs(ut:Object,interval:int,x:Number,y:Number) 
		{
			this.zombType = ut;
			this.posX = x;
			this.posY = y;
			this.interval = interval;
		}
		
		static public function MakeZombies(ut:Object,interval:int,x:Number,y:Number):Zombs
		{
			return new Zombs(ut, interval, x, y);
		}
	}

}