package  
{
	import data.GameData;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author IJUST
	 */
	public class sunBoard extends MovieClip
	{
		//public var txt:TextField;
		public function sunBoard()
		{
			//txt = new TextField();
			//txt.textColor = 0xFFFF00;
			//txt.width = 80;
			//txt.height = 80;
			txt.text = GameData.sunshine.toString();
			this.addChild(txt);
		}
		
		public function addSunshine(shinny:int):void 
		{
			GameData.sunshine += shinny;
			update();
		}
		
		public function minusSunshine(shinny:int):void 
		{
			GameData.sunshine -= shinny;
			update();
		}
		
		private function update():void 
		{
			txt.text = GameData.sunshine.toString();
		}
	}

}