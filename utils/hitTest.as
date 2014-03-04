package utils 
{
	import flash.display.DisplayObject;
	import flash.display.*;
	import flash.geom.*;
	/**
	 * ...
	 * @author IJUST
	 */
	public class hitTest 
	{
		
		public function hitTest() 
		{
			
		}
		
		
		//基本按矩形碰撞
		public static function hitTestRect():Boolean  
		{
			return false;
		}
		
		//按点碰撞//用于子弹测试
		public static function hitTestPoint(shape1:DisplayObject,shape2:DisplayObject):Boolean  
		{
			//对于已经限定了Y的来说
			var disX:Number = shape1.x - shape2.x;
			//shape1是Pea
			if (disX<40&&disX>(-10)) 
			{
				return true;
			}
			else 
			{
				return false;
			}
		}
		
		//像素级碰撞
		
		public static function hitTestPixels(shape1:DisplayObject,shape2:DisplayObject):Boolean 
		{
			
			var p1x:Number = shape1.getRect(shape1).x;
			var p1y:Number = shape1.getRect(shape1).y;
			var p2x:Number = shape2.getRect(shape2).x;
			var p2y:Number = shape2.getRect(shape2).y;

			var p1w:Number = shape1.width;
			var p1h:Number = shape1.height;
			var p2w:Number = shape2.width;
			var p2h:Number = shape2.height;
			p1w = p1w<1?1:p1w;
			p1h = p1h<1?1:p1h;
			p2w = p2w<1?1:p2w;
			p2h = p2h<1?1:p2h;
			
			var BmpData1:BitmapData = new BitmapData(p1w,p1h,true,0x00000000);
			var BmpData2:BitmapData = new BitmapData(p2w,p2h,true,0x00000000);
			BmpData1.draw(shape1,new Matrix(1,0,0,1,-p1x, -p1y));
			BmpData2.draw(shape2,new Matrix(1,0,0,1,-p2x, -p2y));
			
			var gp1:Point = shape1.localToGlobal(new Point(p1x,p1y));
			var gp2:Point = shape2.localToGlobal(new Point(p2x,p2y));
			var re:Boolean = BmpData1.hitTest(gp1,0x05,BmpData2,gp2,0x05);
			
			BmpData1.dispose();
			BmpData2.dispose();
			return re;
		}
	}

}