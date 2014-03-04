package  
{
	import data.GameData;
	import data.MouseState;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import Pcards.Plcard;
	/**
	 * ...
	 * @author IJUST
	 */
	
	 //要不要仅仅把他当作一个容器而不做任何其他的处理
	 //在Bar里面定义鼠标点击事件可以在已经选中的情况下点击任一植物  然后undo
	 //而在card里面定义。只能点击原来的来undo
	public class PlantBar extends MovieClip
	{
		public var sunshineBoard:sunBoard;
		//放选中植物且尚未放下时的层
		public var spritePlantBMP:Sprite;
		private var Pcard:Plcard;
		private var PcardArr:Array;
		private var cardChildren:Array;
		public function PlantBar() 
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, removed);
		}
		private function addedToStage(e:Event):void 
		{
			cardChildren = [];
			PcardArr = GameData.Plant_Has_Select;
			////trace(PcardArr.length);
			BuildBar();
			//在此导致无法点击
			addEventListener(MouseEvent.CLICK, clickBar);
			this.stage.stageFocusRect = true;
			//trace(this.height);
		}
		private function removed(e:Event):void 
		{
			removeEventListener(MouseEvent.CLICK, clickBar);
		}
		private function BuildBar():void 
		{
			var cardlength:int = PcardArr.length;
			for (var i:int = 0; i < cardlength; i++) 
			{
				var item:Object = PcardArr[i] as Object;
				Pcard = new Plcard(item);
				Pcard.x = 60 * i;
				Pcard.y = 0;
				Pcard.spritePlantBMP = this.spritePlantBMP;
				addChild(Pcard);
				cardChildren.push(Pcard);
			}
		}
		
		//撤销对植物的选择
		private function clickBar(e:MouseEvent):void
		{
			if (!spritePlantBMP.numChildren) 
			{
				return;
			}
			
			if (MouseState.Card_Or_Bar_ClickState==MouseState.CARD_OR_BAR_FIRSTCLICK)
			{
				//第一次点击后变为第二次以做下一次的撤销响应
				MouseState.Card_Or_Bar_ClickState = MouseState.CARD_OR_BAR_SECONDCLICK;
			}
			else if (MouseState.Card_Or_Bar_ClickState==MouseState.CARD_OR_BAR_SECONDCLICK)
			{
				if (MouseState.MouseStates==MouseState.MOUSE_HASSELECT_PLANT) 
				{
					//撤销选择函数
					//需要有东西来记录选择的种类
					for (var i:int = 0; i < cardChildren.length; i++) 
					{
						var item:Plcard = cardChildren[i] as Plcard;
						if (item.cardState==MouseState.CARD_SELECT) 
						{
							//撤销选择的植物
							MouseState.MouseStates = MouseState.MOUSE_HASDROPED_PLANT;
							item.cardState = MouseState.CARD_NORMAL;
							item.selectable = true;
							//清除BMP层中的bitmapdata
							while (spritePlantBMP.numChildren)
							{
								spritePlantBMP.removeChildAt(0);
								MouseState.Plant_Selected = null;
							}
							//第二次点击后变成第一次点击以做下一次响应
							MouseState.Card_Or_Bar_ClickState = MouseState.CARD_OR_BAR_FIRSTCLICK;
							break;
						}
					}
				}
			}
		}
		
		
		public function hasPlant():void
		{
			for (var i:int = 0; i < this.cardChildren.length; i++) 
				{
					var item:Plcard = this.cardChildren[i] as Plcard;
					if (item.cardState==MouseState.CARD_SELECT) 
					{
						//选择的植物状态回到
						MouseState.MouseStates = MouseState.MOUSE_HASDROPED_PLANT;
						sunshineBoard.minusSunshine(MouseState.Plant_Selected.sunshine);
						item.cardState = MouseState.CARD_NORMAL;
						item.hasColddown = false;
						item.selectable = false;
						//清除BMP层中的bitmapdata
						while (spritePlantBMP.numChildren)
						{
							spritePlantBMP.removeChildAt(0);
							MouseState.Plant_Selected = null;
						}
						break;
					}
					
				}
		}
	}

}