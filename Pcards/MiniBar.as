package Pcards 
{
	import data.GameData;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author IJUST
	 */
	public class MiniBar extends MovieClip
	{
		//用一个静态类来记载选中的植物 那就是GameData.Plant_Has_Select
		//用一个静态类来记录MiniBar的容量 那就是GameData.MiniBar_Content_Lenght
		//若超出则停止addPlantCard
		public var miniboard:MiniBoard;
		public var MiniBarPlant:Array;
		public function MiniBar() 
		{
			MiniBarPlant = new Array();
			initBar();
		}
		public function initBar():void 
		{
			//确定宽度
		}
		
		public function addPlantCard(pType:Object):void
		{
			//Check Length
			GameData.Plant_Has_Select.push(pType);
			var BarMiniPlant:MiniCard = new MiniCard(pType);
			BarMiniPlant.belongs = MiniCard.InBar;
			BarMiniPlant.miniboard = this.miniboard;
			BarMiniPlant.minibar = this;
			BarMiniPlant.x = (GameData.Plant_Has_Select.length - 1) * GameData.BarTileWidth+GameData.BarLeftGap;
			BarMiniPlant.y = GameData.BarTopGap;
			addChild(BarMiniPlant);
			this.MiniBarPlant.push(BarMiniPlant);
			resortMiniBar();
		}
		
		public function deletePlantCard(pType:MiniCard):void 
		{
			//在删除的同时还要使MiniBoard的delete的不再显示灰阶  已在MiniCard类中实现
			for (var i:int = 0; i < this.MiniBarPlant.length; i++) 
			{
				var item:MiniCard = this.MiniBarPlant[i] as MiniCard;
				if (item==pType) 
				{
					this.removeChild(item);
					this.MiniBarPlant.splice(i, 1);
					GameData.Plant_Has_Select.splice(i, 1);
					break;
				}
				
			}
			resortMiniBar();
		}
		
		public function resortMiniBar():void 
		{
			for (var i:int = 0; i < this.MiniBarPlant.length; i++) 
			{
				var item:MiniCard = MiniBarPlant[i] as MiniCard;
				item.x = GameData.BarTileWidth * i+GameData.BarLeftGap;
				item.y = GameData.BarTopGap;
			}
		}
		
	}

}