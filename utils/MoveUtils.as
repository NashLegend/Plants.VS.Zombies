package utils 
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import com.greensock.*;
	
	/**
	 * ...
	 * @author IJUST
	 */
	public class MoveUtils 
	{
		
		public function MoveUtils() 
		{
			
		}
		public static function moveTo(shape1:DisplayObject,shape2:DisplayObject,speed:Number):void 
		{
			TweenLite.to(shape1, 3, { x:shape2.x, y:shape2.y } );
			var point1:Point = shape1.parent.localToGlobal(new Point(shape1.x, shape1.y));
			var point2:Point = shape2.parent.localToGlobal(new Point(shape2.x, shape2.y));
			//var disX:Number = point2.x - point1.x;
			//var disY:Number = point2.y - point1.y;
			//var dis:Number = Math.sqrt(disX * disX + disY * disY);
			//var speedX:Number = speed*disX / dis;
			//var speedY:Number = speed * disY / dis;
			//shape1.x += speedX;
			//shape1.y += speedY;
		}
	}
}