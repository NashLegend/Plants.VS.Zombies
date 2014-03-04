package Pcards 
{
	import data.GameData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import MyEvent.PvzEvent;
	/**
	 * ...
	 * @author IJUST
	 */
	public class MiniBoard extends MovieClip
	{
		public var BoardCard:Array=[];
		public var minibar:MiniBar;
		public function MiniBoard() 
		{
			this.btnRockAndRoll.enabled = true;
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);	
		}
		public function addedToStage(e:Event):void 
		{
			this.builtMiniBoard();
			this.btnRockAndRoll.addEventListener(MouseEvent.CLICK, rockAndRoll);	
		}
		public function rockAndRoll(e:MouseEvent):void
		{
			if (GameData.Plant_Has_Select.length>0)
			{
				PvzEvent.Pvz_MainEvent.dispatchEvent(new Event(PvzEvent.LETS_ROCK_AND_ROLL));
			}
		}
		public function builtMiniBoard():void
		{
			for (var i:int = 0; i < GameData.PlantUnsealed.length; i++)
			{
				var item:Object = GameData.PlantUnsealed[i] as Object;
				var Cards:MiniCard = new MiniCard(item);
				Cards.belongs = MiniCard.InBoard;
				Cards.minibar = this.minibar;
				Cards.miniboard = this;
				BoardCard.push(Cards);
				//设定Card在MiniBoard的位置 其中一行放8个植物 
				Cards.x = (i % 8) * GameData.BarTileWidth+14;
				Cards.y = int(i / 8) * GameData.BarTileHeight+32;
				addChild(Cards);
			}
		}
		//事实上这是设置为不显示灰
		public function setCardColor(cardToGrey:Object):void 
		{
			for (var i:int = 0; i < BoardCard.length; i++) 
			{
				var item:MiniCard = BoardCard[i] as MiniCard;
				if (item.cardType==cardToGrey) 
				{
					item.sp.visible = true;
					item.spG.visible = false;
					item.cardState = MiniCard.CardCanSelect;
				}
			}
		}
	}
}