package Mission 
{
	import data.GameData;
	/**
	 * ...
	 * @author IJUST
	 */
	public class Missions 
	{
		static public var Map1:Array =[
					[0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0]
				  ];
		static public var Map2:Array =[
					[0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0]
				  ];
		static public var Map3:Array =[
					[0, 0, 2, 2, 0, 0],
					[0, 0, 2, 2, 0, 0],
					[0, 0, 2, 2, 0, 0],
					[0, 0, 2, 2, 0, 0],
					[0, 0, 2, 2, 0, 0],
					[0, 0, 2, 2, 0, 0],
					[0, 0, 2, 2, 0, 0],
					[0, 0, 2, 2, 0, 0],
					[0, 0, 2, 2, 0, 0]
				  ];  
		//大小关  
		static public const Mission1:Object = { zomblists:ZomieList.Zombs1, IsSunny:true, mapInfo:Missions.Map1, scale:1 };
		
		static public const Mission2:Object = { zomblists:ZomieList.Zombs2, IsSunny:true, mapInfo:Missions.Map1, scale:1 };
		
		static public const Mission3:Object = { zomblists:ZomieList.Zombs3, IsSunny:true, mapInfo:Missions.Map1, scale:1 };
		
		static public const Mission4:Object = { zomblists:ZomieList.Zombs4, IsSunny:false, mapInfo:Missions.Map1 , scale:1 }; 
		
		static public const Mission5:Object = { zomblists:ZomieList.Zombs5, IsSunny:false, mapInfo:Missions.Map2, scale:1 };
		
		static public const Mission6:Object = { zomblists:ZomieList.Zombs6, IsSunny:false, mapInfo:Missions.Map2, scale:1 };
		
		static public const Mission7:Object = { zomblists:ZomieList.Zombs7, IsSunny:false, mapInfo:Missions.Map2 , scale:1 };
		
		static public const Mission8:Object = { zomblists:ZomieList.Zombs8, IsSunny:false, mapInfo:Missions.Map2 , scale:1 };
		
		static public const Mission9:Object = { zomblists:ZomieList.Zombs9, IsSunny:false, mapInfo:Missions.Map3, scale:5 / 6 };
		
		static public const Mission10:Object = { zomblists:ZomieList.Zombs10, IsSunny:false, mapInfo:Missions.Map3, scale:5 / 6 };
		
		static public const Mission11:Object = { zomblists:ZomieList.Zombs11, IsSunny:false, mapInfo:Missions.Map3, scale:5 / 6 };
		
		static public const Mission12:Object = { zomblists:ZomieList.Zombs12, IsSunny:false, mapInfo:Missions.Map3, scale:5 / 6 };
		
		static public const aMission:Array = [Mission1, Mission2, Mission3,Mission4,Mission5,Mission6];
				  
		//static public function getMap(crtMission:int):Array
		//{
			//生成地图
			//var SoMission:int = int(crtMission / 10);
			//var SoMission:int = crtMission;
			//switch (SoMission) 
			//{
				//case 0:
				  //var map0:Array =
				  //[
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0]
				  //];
					//return map0;
				//break;
				//case 1:
					//var map1:Array =
				  //[
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0]
				  //];
					//return map1;
				//break;
				//case 2:
					//var map2:Array =
				  //[
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0]
				  //];
					//return map2;
				//break;
				//case 3:
					//var map3:Array =
				  //[
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0]
				  //];
					//return map3;
				//break;
				//case 4:
					//var map4:Array =
				  //[
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0]
				  //];
					//return map4;
				//break;
				//case 4:
					//var map5:Array =
				  //[
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0]
				  //];
					//return map5;
				//break;
				//case 4:
					//var map6:Array =
				  //[
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0]
				  //];
					//return map6;
				//break;
				//case 4:
					//var map7:Array =
				  //[
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0]
				  //];
					//return map7;
				//break;
				//case 4:
					//var map8:Array =
				  //[
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0]
				  //];
					//return map8;
				//break;
				//case 4:
					//var map9:Array =
				  //[
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0],
					//[0, 0, 0, 0, 0]
				  //];
					//return map9;
				//break;
				//default:
					//
				//break;
			//}
			//return [];
		//}
		//static public function getWeather(crtMission:int):Boolean 
		//{
			//设定天气
			//switch (crtMission) 
			//{
				//case 0:
					//return true;
				//break;
				//case 1:
					//return false;
				//break;
				//case 2:
					//return true;
				//break;
				//default:
					//
				//break;
			//}
			//return true;
		//}
		public function Missions() 
		{
			//
		}
		
	}

}