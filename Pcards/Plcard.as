package Pcards 
{
	/**
	 * ...
	 * @author IJUST
	 */
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import data.PlantType;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.text.TextFormat;
	import data.GameData;
	import flash.text.TextField;
	import flash.utils.Timer;
	import data.MouseState;
	import tools.tips;
	public class Plcard extends MovieClip
	{
		private var GreyColdingDown:Sprite = new Sprite();
		private var GreyNoSunshine:Sprite = new Sprite();
		
		//放选中植物且尚未放下时的层
		public var spritePlantBMP:Sprite;
		private var imgLoader:Loader;
		//public var urlreq:URLRequest = new URLRequest();
		//图片路径
		private var picPath:String;
		private var cardType:Object;
		//卡片显示图片
		private var bmp:Bitmap;
		//鼠标划过提示
		private var tip:String;
		//正常与灰色显示的元件
		public var sp:Sprite;
		//需要的阳光
		private var sunshineNeed:int;
		//是否已经冷却
		private var _hasColddown:Boolean;
		//冷却时间
		private var colddownTime:int;
		//冷却计时器
		private var colddownTimer:Timer;
		//计时器计时间隔
		private var interv:int=100;
		//计时器运行次数
		private var times:int;
		//记录状态
		public var cardState:int;
		//是否可选
		public var selectable:Boolean;
		
		public function Plcard(card:Object) 
		{
			//确定卡片代表类型
			this.cardType = card;
			//预设一些值
			this.cardState = MouseState.CARD_NORMAL;
			sp = new Sprite();
			//spG = new Sprite();
			sunshineNeed = cardType.sunshine;
			tip = cardType.tips;
			hasColddown = true;
			colddownTime = cardType.cooldown;
			times = colddownTime / interv;
			colddownTimer = new Timer(interv,times);
			//为计时器添加侦听事件
			colddownTimer.addEventListener(TimerEvent.TIMER,timergoing);
			colddownTimer.addEventListener(TimerEvent.TIMER_COMPLETE, timerComplete);
			
			addChild(sp);
			
			GreyColdingDown.graphics.beginFill(0x2D2D2D, 0.4);
			GreyColdingDown.graphics.drawRect(0, 0, 50, 70);
			GreyColdingDown.graphics.endFill();
			addChild(GreyColdingDown);
			GreyColdingDown.visible = false;
			
			GreyNoSunshine.graphics.beginFill(0x2D2D2D, 0.4);
			GreyNoSunshine.graphics.drawRect(0, 0, 50, 70);
			GreyNoSunshine.graphics.endFill();
			addChild(GreyNoSunshine);
			GreyColdingDown.visible = false;
			
			//初始化图片Loader
			imgLoader = new Loader();
			//载入所需要的图片，灰色和彩色;
			loadImage();
			//把图片加到容器中
			sp.addChild(imgLoader);
			//判断开始是否可用  一开始都是hasColdDown为true的
			if (GameData.sunshine>=this.sunshineNeed&&this.hasColddown)
			{
				this.selectable = true;
			}
			else 
			{
				this.selectable = false;
			}
			this.addEventListener(MouseEvent.CLICK,clickHandler);
			this.addEventListener(MouseEvent.ROLL_OVER, overHandler);
			this.addEventListener(MouseEvent.ROLL_OUT, outHandler);
			this.addEventListener(Event.ENTER_FRAME, drawbg);
		}
		//卡片背景0xA26846
		private function drawbg(e:Event):void
		{
			//如果阳光充足并且已经冷却
			//trace(GreyColdingDown.visible, GreyNoSunshine.visible,GreyColdingDown.scaleY);
			if (GameData.sunshine>=this.sunshineNeed) 
			{
				GreyNoSunshine.visible = false;
			}
			else 
			{
				GreyNoSunshine.visible = true;
			}
			
			if (GameData.sunshine>=this.sunshineNeed&&this.hasColddown)
			{
				//如果已经选择而未放下。则仍显示灰！！！
				if (this.cardState==MouseState.CARD_SELECT) 
				{
					this.selectable = false;
				}
				else 
				{
					this.selectable = true;
				}
			}
			else 
			{
				this.selectable = false;
			}
		}
		//载入图片
		private function loadImage():void 
		{
			var picPath:String = this.cardType.cardpath;
			var urlRec:URLRequest = new URLRequest(picPath);
			imgLoader.load(urlRec);
		}
		private function clickHandler(e:MouseEvent):void 
		{
			//最开始应该初始化一下MouseState的状态
			if (MouseState.MouseStates==MouseState.MOUSE_HASDROPED_PLANT) 
			{
				selectPlant();
			}
		}
		
		private function overHandler(e:MouseEvent):void
		{
			
			
			
		}
		
		private function outHandler(e:MouseEvent):void 
		{
			
			
		}
		 
		private function timergoing(e:TimerEvent):void
		{
			GreyColdingDown.scaleY = 1 - e.target.currentCount / this.times;
		}
		
		private function timerComplete(e:TimerEvent):void 
		{
			this.hasColddown = true;
			GreyColdingDown.visible = false;
			//this.removeChild(coldTxt);
			
		}
		
		
		//选中植物
		private function selectPlant():void 
		{
			//判断是否可选
			//如果可选
			//由于Bubble 点击后传到PlantBar会再次取消选择
			//所以应该做一个标记  第二次点击的时候才会取消
			//就用静态量MouseState.Card_Or_Bar_ClickState来做标记
			//在PlantBar中做判断
			//那就先取消Bubble
			if (this.selectable)
			{
				//建立一个位图并随鼠标移动
				//选中层添加一个植物的BitmapData
				var bmpData:BitmapData = new BitmapData(sp.width,sp.height);
				bmpData.draw(this.imgLoader);
				var PlantBMP:Bitmap = new Bitmap(); 
				PlantBMP.bitmapData = bmpData;
				var plantbmp:Sprite = new Sprite();
				plantbmp.addChild(PlantBMP);
				spritePlantBMP.addChild(plantbmp);
				plantbmp.startDrag(true);
				//记录选中状态,此时是选中但未种植植物
				this.cardState = MouseState.CARD_SELECT;
				//记录鼠标点击类型
				MouseState.MouseStates = MouseState.MOUSE_HASSELECT_PLANT;
				//记录选择的植物的类型
				MouseState.Plant_Selected = this.cardType;
				//sp.visible = false;
				//spG.visible = true;
				this.selectable = false;
			}
		}
		
		//利用get set 设置开始计时等等
		
		public function get hasColddown():Boolean
		{ 
			return _hasColddown; 
		}
		
		public function set hasColddown(value:Boolean):void 
		{
			_hasColddown = value;
			if (value==false) 
			{
				colddownTimer.reset();
				colddownTimer.start();
				GreyColdingDown.visible = true;
				//addChild(coldTxt);
			}
		}	
	}

}
