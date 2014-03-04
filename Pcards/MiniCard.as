package Pcards 
{
	import data.GameData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author IJUST
	 */
	public class MiniCard extends MovieClip
	{
		public static const InBar:String = "belongtobar";
		public static const InBoard:String = "belongtoboard";
		public static const CardCanSelect:String = "csrdcanselect";
		public static const CardCannotSelect:String = "cardcannotselect";
		private var imgLoader:Loader;
		private var imgLoaderG:Loader;
		public var belongs:String;
		public var cardType:Object;
		public var sp:Sprite;
		public var spG:Sprite;
		public var cardState:String;
		public var minibar:MiniBar;
		public var miniboard:MiniBoard;
		public function MiniCard(plantTp:Object) 
		{
			this.buttonMode = true;
			this.cardType = plantTp;
			this.cardState = MiniCard.CardCanSelect;
			sp = new Sprite();
			spG = new Sprite();
			addChild(sp);//正常模式
			addChild(spG);//显示灰阶
			imgLoader = new Loader();
			imgLoaderG = new Loader();
			InitCard();
			this.addEventListener(MouseEvent.CLICK, clickHandler);
			//this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removed);
		}
		//public function addedToStage(e:Event):void 
		//{
			//this.cardState = MiniCard.CardCanSelect;
			//sp = new Sprite();
			//spG = new Sprite();
			//addChild(sp);//正常模式
			//addChild(spG);//显示灰阶
			//imgLoader = new Loader();
			//imgLoaderG = new Loader();
			//InitCard();
			//this.addEventListener(MouseEvent.CLICK, clickHandler);
		//}
		private function removed(e:Event):void 
		{
			this.removeEventListener(MouseEvent.CLICK, clickHandler);
			this.removeEventListener(Event.REMOVED_FROM_STAGE,removed);
		}
		private function InitCard():void 
		{
			loadImage();
			loadImageG();
			sp.addChild(imgLoader);
			spG.addChild(imgLoaderG);
			sp.visible = true;
			spG.visible = false;
		}
		private function loadImage():void 
		{
			var picpath:String = this.cardType.cardpath;
			var urlRec:URLRequest = new URLRequest(picpath);
			imgLoader.load(urlRec);
		}
		private function loadImageG():void 
		{
			var picpath:String = this.cardType.cardpathG;
			var urlRec:URLRequest = new URLRequest(picpath);
			imgLoaderG.load(urlRec);
		}
		private function clickHandler(e:MouseEvent):void 
		{
			if (this.belongs==MiniCard.InBar) 
			{
				//若此卡片是在MiniBar中，点击后取消选择
				minibar.deletePlantCard(this);
				//将已经选择的植物再次取消灰阶
				miniboard.setCardColor(this.cardType);
				if (miniboard.btnRockAndRoll.enabled = true) 
				{
					miniboard.btnRockAndRoll.enabled = false;
				}
			}
			else if (this.belongs==MiniCard.InBoard) 
			{
				//如果可选并且未选满
				if (this.cardState==MiniCard.CardCanSelect&&GameData.Plant_Has_Select.length<GameData.MiniBar_Content_Lenght) 
				{
					//在可选的情况下选中后
					minibar.addPlantCard(this.cardType);
					this.cardState = MiniCard.CardCannotSelect;
					sp.visible = false;
					spG.visible = true;
					if (GameData.Plant_Has_Select.length==GameData.MiniBar_Content_Lenght) 
					{
						miniboard.btnRockAndRoll.enabled = true;
					}
				}
				else 
				{
					//在不可选的情况下
					return;
				}
			}
		}
		
	}

}