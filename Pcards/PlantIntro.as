package Pcards 
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import data.PlantType;
	import flash.net.URLRequest;
	/**
	 * ...
	 * 图鉴
	 * @author IJUST
	 */
	public class PlantIntro extends MovieClip
	{
		var urlrec:URLRequest;
		var loader:Loader;
		public function PlantIntro(plant:Object) 
		{
			urlrec = new URLRequest();
			urlrec.url = plant.intropath;
			loader = new Loader();
			loader.load(urlrec);
			loader.x = 60;
			loader.y = 20;
			addChild(loader);
			txt.text = plant.intro;
		}
		
	}

}