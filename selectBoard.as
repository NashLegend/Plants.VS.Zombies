package  
{
	import data.GameData;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLRequest;
	import Pcards.MiniBar;
	import Pcards.MiniBoard;
	import Pcards.ZombShow;
	/**
	 * ...
	 * @author IJUST
	 */
	public class selectBoard extends MovieClip
	{
		public var Minibar:MiniBar;
		public var Miniboard:MiniBoard;
		public var zombboard:ZombShow;
		private var bmpData:BitmapData;
		private var bmp:Bitmap;
		private var loader:Loader;
		private var urlreq:URLRequest;
		private var inc:int = 0;
		private var incEnd:int = 0;
		private var moveint:int = 20;
		public function selectBoard() 
		{
			urlreq = new URLRequest();
			//根据关卡设置地图
			var urls:String="";
			//根据关卡级别判断col
			var bigMission:int = GameData.currentMission/ 3;
			switch (bigMission) 
			{
				case 0:
					urls ="images/interface/background1.jpg";
				break;
				case 1:
					urls ="images/interface/background2.jpg";
				break;
				case 2:
					urls ="images/interface/background3.jpg";
				break;
				default:
					
				break;
			}
			urlreq.url = urls;
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadcomplete);
			loader.load(urlreq);
		}
		private function froms(e:Event):void 
		{
			this.removeChild(Minibar);
			this.removeChild(Miniboard);
			this.removeChild(zombboard);
		}
		private function loadcomplete(e:Event):void 
		{
            bmp = Bitmap(loader.content);
			addChild(bmp);
			this.addEventListener(Event.ENTER_FRAME, ScrollBmp);
		}
		//滚动像素
		private function ScrollBmp(e:Event):void 
		{
			inc++;
			if (inc<36)
			{
				return;
			}
			bmp.x -= moveint;
			if (bmp.x<=-600) 
			{
				bmp.x <= -600;
				moveint = 0;
				incEnd++;
				if (incEnd<24) 
				{
					return;
				}
				this.removeEventListener(Event.ENTER_FRAME, ScrollBmp);
				addCardBoard();
			}
		}
		//将Card与Board加到selectboard上面
		private function addCardBoard():void 
		{
			Minibar = new MiniBar();
			Miniboard = new MiniBoard();
			zombboard = new ZombShow();
			Minibar.miniboard = this.Miniboard;
			Miniboard.minibar = this.Minibar;
			Minibar.x = 0;
			Minibar.y = 0;
			Miniboard.x = 0;
			Miniboard.y = Minibar.height;
			zombboard.x = 480;
			zombboard.y = 150;
			this.addChild(zombboard);
			this.addChild(Miniboard);
			this.addChild(Minibar);
			zombboard.stops();
			addEventListener(Event.REMOVED_FROM_STAGE, froms);
		}
		
		
	}

}