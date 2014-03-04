package  
{
	import bullet.Sun;
	import data.*;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import Layers.layer;
	import Mission.Missions;
	import MyEvent.PvzEvent;
	import Pcards.PlantIntro;
	import plants.*;
	import vehicle.*;
	import zombs.*;
	
	/**
	 * ...
	 * @author IJUST
	 * Game 主场景
	 * 由外部传入的是  通过鼠标对植物的PlantBar的植物选择 在这里只要New 一个植物即可  而不必关心鼠标交互
	 * 各种如得分、金币等均不在些Lawn类中，应有另外一个InfoBoard类
	 * 但是分数在些计算，并传出
	 * ZombieLayer与PlantLayer必须分层否则会出现重叠现象 可以直接从Layer类里分成五种
	 * 如此那数组也要分成五组
	 * 关卡开始时设定Lawn类的sunshineBoard
	 */
	public class Lawn extends MovieClip
	{
		private var scales:Number;
		private var mapInfo:Array;
		private var tileHeight:Number;
		private var tileWidth:Number;
		//阳光信息显示板
		public var sunshineBoard:sunBoard;
		//
		public var plantbar:PlantBar;
		//当前的关数
		private var missions:int;
		//记录植物数组，一维数组
		private var plantArr:Array = [];
		//记录Zombie数组
		private var zombieArr:Array = [];
		//当前Zombie指针
		private var currentZombie:int;
		//当前计时器
		private var crtTime:int;
		//绝对位置
		private var absTime:int;
		//植物层
		private var plantLayer:layer;
		//僵尸层
		private var zombieLayer:layer;
		//子弹层
		private var bulletLayer:layer;
		//阳光层
		public var sunshineLayer:layer;
		//拖动层
		public var PcardLayer:layer;
		//天气
		private var Issunny:Boolean;
		//鼠标位置
		private var clickX:int;
		private var clickY:int;
		//转动时间线
		private var timer:Timer;
		//Timer中计数器
		private var inc:int = 0;
		//计数器时间
		private var timerLong:int = 36;
		//Timer中是否可以结束
		private var canEnd:Boolean = false;
		//下一次要添加的Plant图鉴
		private var plantNext:PlantIntro;
		//失败时显示
		private var txtfail:txtFail = new txtFail();
		
		private var txtover:txtOver = new txtOver();
		
		public function Lawn() 
		{
			crtTime = 0;
			absTime = crtTime;
			//设置当前关卡
			setMission();
			//初始化僵尸队列参数
			crtTime = 0;
			currentZombie = 0;
			//初始化地图
			initMap();
			//添加草坪车
			setCar();
			//创建植物层
			creatPlantLayer();
			//创建僵尸层
			creatZombieLayer();
			//创建子弹层
			creatBulletLayer();
			//创建阳光层
			creatSunshineLayer();
			//设置天气
			setweather();
			//创建拖动层;在Stage中创建
			//creatPcardsLayer();
			PvzEvent.LawnEvent.addEventListener(PvzEvent.ZOMBIE_INSIDE, MissionFailed);
			//通过鼠标事件来种植植物以及除掉植物
			this.addEventListener(MouseEvent.CLICK, plantPlant);
			//通过帧循环事件来进行其他一般操作如产生Zombie 除掉clearable的物体
			this.addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		private function setCar():void 
		{
			var col:int;
			//根据关卡级别判断col
			var bigMission:int = this.missions / GameData.BigMissionLength;;
			switch (bigMission) 
			{
				case 0:
					col = 5;
				break;
				case 1:
					col = 5;
				break;
				case 2:
					col = 6;
				break;
				default:
					
				break;
			}
			for (var i:int = 0; i < col; i++) 
			{
				var item:LawnCleaner = new LawnCleaner();
				item.x = -10;
				item.y=this.tileHeight*(i+0.5)
				item.positionY = i;
				item.zombArray = this.zombieArr;
				addChild(item);
			}
		}
		private function setweather():void 
		{
			Issunny = Missions.aMission[missions].IsSunny;
		}
		private function setMission():void 
		{
			//获取关卡级别
			this.missions = GameData.currentMission;
			
		}
		private function setTile():void 
		{
			//根据关卡级别设置长宽
			
		}
		
		private function plantPlant(e:MouseEvent):void 
		{
			/*
			 * 首先通过查看点击位置是是否已经可以种植
			 * 这就需要一个二维数组记录各个位置种植的植物
			 * 如果可以种植则种植下  同时设置二维数组此处的植物
			 */
			if (this.mouseX<=0||this.mouseY<=0) 
			{
				return;
			}
			clickX = int(this.mouseX / this.tileWidth);
			clickY = int(this.mouseY / this.tileHeight);
			if (this.mapInfo[clickX][clickY]!=100) 
			{
				if (creatPlants(MouseState.Plant_Selected, clickX, clickY))
				{
					//已经种植上后要把MouseState.Card_Or_Bar_ClickState重新归置
					MouseState.Card_Or_Bar_ClickState = MouseState.CARD_OR_BAR_FIRSTCLICK;
					this.plantbar.hasPlant();
				}
				else 
				{
					return;
				}
			}
			
		}
		private function enterFrame(e:Event):void 
		{
			crtTime++;
			//产生僵尸
			makeZombie();
			//除去clearable的元素
			clearPlants();
			clearZombie();
			//产生阳光
			productSun();
		}
		private function productSun():void 
		{
			//产生阳光的间隔是100
			if (Issunny&&(crtTime%100==0))
			{
				var suns:Sun = new Sun();
				suns.SunBoard = this.sunshineBoard;
				suns.x = 100 + 300 * Math.random();
				suns.y = 200 + 300 * Math.random();
				this.sunshineLayer.addChild(suns);
			}
		}
		private function initMap():void 
		{
			//初始化地图
			//根据关卡设置地图
			this.scales = Missions.aMission[missions].scale;
			this.tileHeight = GameData.tileheight * this.scales;
			this.tileWidth = GameData.tilewidth;
			this.mapInfo = []
			for (var i:int = 0; i < Missions.aMission[missions].mapInfo.length; i++) 
			{
				var item:Array = new Array();
				item = Missions.aMission[missions].mapInfo[i].concat();
				this.mapInfo.push(item);
			}
			////trace(this.mapInfo);
			var bigMission:int = missions / GameData.BigMissionLength;
			switch (bigMission) 
			{
				case 0:
					this.gotoAndStop(0);
				break;
				case 1:
					this.gotoAndStop(10);
				break;
				case 2:
					this.gotoAndStop(20);
				break;
				default:
					
				break;
			}
			
		}
		
		private function creatPlantLayer():void 
		{
			//设置植物层
			this.plantLayer = new layer();
			addChild(plantLayer);
		}
		private function creatZombieLayer():void 
		{
			//设置僵尸层
			this.zombieLayer = new layer();
			addChild(zombieLayer);
		}
		private function creatBulletLayer():void 
		{
			//设置子弹层
			this.bulletLayer = new layer();
			addChild(bulletLayer);
		}
		private function creatSunshineLayer():void 
		{
			//设置阳光层
			this.sunshineLayer = new layer();
			addChild(sunshineLayer);
		}
		
		//拖动层应该在stage上面，而不应该在Lawn类里 
		//Lawn类里的层应该只有只在内部运行的元素
		//所以要注释掉
		private function creatPcardsLayer():void 
		{
			//设置选中植物拖动层
			this.PcardLayer = new layer();
			addChild(PcardLayer);
		}
		private function makeZombie():void 
		{
			var relTime = crtTime-absTime;
			if (currentZombie>Missions.aMission[missions].zomblists.length-1)
			{
				return;
			}
			if (relTime==Missions.aMission[missions].zomblists[currentZombie].interval) 
			{
				absTime = crtTime;
				creatZombies(Missions.aMission[missions].zomblists[currentZombie]);
				currentZombie++;
			}
		}
		//去除各种元素
		private function clearBullet():void 
		{
			while (this.bulletLayer.numChildren) 
			{
				this.bulletLayer.removeChildAt(0);
			}
		}
		//除去植物
		private function clearPlants():void 
		{
				for (var j:int = plantArr.length-1; j >=0; j--) 
				{
					var item:plant = plantArr[j] as plant;
					if (item.clearable) 
					{
						this.mapInfo[item.positionX][item.positionY] = 0;
						plantLayer.removeChild(item);
						plantArr.splice(j, 1);
					}
					
				}
		}
		//除去僵尸
		private function clearZombie():void 
		{
			for (var i:int = 0; i < zombieArr.length; i++) 
			{
				var item:zomb = zombieArr[i] as zomb;
				if (item.clearable) 
				{
					zombieArr.splice(i, 1);
					item.ZombLayer.removeChild(item);
					item = null;
				}
			}
			if (!zombieArr.length&&currentZombie==Missions.aMission[missions].zomblists.length) 
			{
				//结束一关
				currentZombie++;
				////trace("Game Over!!!!!!!!!!!!!!!!!!!!");
				//如果这是最后一关
				if (Missions.aMission.length==(GameData.currentMission+1))
				{
					GameOver();
				}
				else 
				{
					NextMission();
				}
				
			}
		}
		//阳光如何交互来?
		//莫非要用Lawn类调用Sunshine类？
		//Lawn的构造函数上加一个stage，这样把Sunshine加到stage上
		//然后再move to Sunshine bar
		private function creatZombies(zom:Object):void 
		{
			switch (zom.zombType) 
			{
				case ZombType._Zombie:
					var gameZombie:Zombie = new Zombie();
					gameZombie.ZombLayer = this.zombieLayer;
					gameZombie.scaleX =gameZombie.scaleY= this.scales;
					gameZombie.x = zom.posX;
					gameZombie.y = zom.posY;
					gameZombie.positionY = zom.posY / this.tileHeight;
					gameZombie.PlantArray = this.plantArr;
					this.zombieArr.push(gameZombie);
					this.zombieLayer.addChild(gameZombie);
				break;
				case ZombType._ConeheadZombie:
					var gameConeheadZombie:ConeheadZombie = new ConeheadZombie();
					gameConeheadZombie.ZombLayer = this.zombieLayer;
					gameConeheadZombie.scaleX = gameConeheadZombie.scaleY=this.scales;
					gameConeheadZombie.x = zom.posX;
					gameConeheadZombie.y = zom.posY;
					gameConeheadZombie.positionY = zom.posY / this.tileHeight;
					gameConeheadZombie.PlantArray = this.plantArr;
					this.zombieArr.push(gameConeheadZombie);
					this.zombieLayer.addChild(gameConeheadZombie);
				break;
				case ZombType._PoleVaultingZombie:
					var gamePoleVaultingZombie:PoleVaultingZombie = new PoleVaultingZombie();
					gamePoleVaultingZombie.ZombLayer = this.zombieLayer;
					gamePoleVaultingZombie.scaleX = gamePoleVaultingZombie.scaleY=this.scales;
					gamePoleVaultingZombie.x = zom.posX;
					gamePoleVaultingZombie.y = zom.posY;
					gamePoleVaultingZombie.positionY = zom.posY / this.tileHeight;
					gamePoleVaultingZombie.PlantArray = this.plantArr;
					this.zombieArr.push(gamePoleVaultingZombie);
					this.zombieLayer.addChild(gamePoleVaultingZombie);
				break;
				case ZombType._BucketheadZombie:
					var basket:BucketheadZombie = new BucketheadZombie();
					basket.ZombLayer = this.zombieLayer;
					basket.scaleX =basket.scaleY= this.scales;
					basket.x = zom.posX;
					basket.y = zom.posY;
					basket.positionY = zom.posY / this.tileHeight;
					basket.PlantArray = this.plantArr;
					this.zombieArr.push(basket);
					this.zombieLayer.addChild(basket);
				break;
				case ZombType._NewspaperZombie:
					var news:NewspaperZombie = new NewspaperZombie();
					news.ZombLayer = this.zombieLayer;
					news.scaleX = news.scaleY=this.scales;
					news.x = zom.posX;
					news.y = zom.posY;
					news.positionY = zom.posY / this.tileHeight;
					news.PlantArray = this.plantArr;
					this.zombieArr.push(news);
					this.zombieLayer.addChild(news);
				break;
				case ZombType._ScreenDoorZombie:
					var screen:ScreenDoorZombie = new ScreenDoorZombie();
					screen.ZombLayer = this.zombieLayer;
					screen.scaleX = screen.scaleY=this.scales;
					screen.x = zom.posX;
					screen.y = zom.posY;
					screen.positionY = zom.posY / this.tileHeight;
					screen.PlantArray = this.plantArr;
					this.zombieArr.push(screen);
					this.zombieLayer.addChild(screen);
				break;
				default:
					
				break;
			}
		}
		
		private function creatPlants(pl:Object,posX:int,posY:int):Boolean
		{
			switch (pl) 
			{
				case PlantType._Peashooter:
					//普通地面以及水面的荷叶
					if (checkCanNotPlant(pl)) 
					{
						return false;
					}
					var peashooter:Peashooter = new Peashooter();
					peashooter.PlantLayer = this.plantLayer;
					peashooter.scaleX = peashooter.scaleY=this.scales;
					peashooter.x = posX * this.tileWidth + this.tileWidth / 2;
					peashooter.y = posY * this.tileHeight + this.tileHeight / 2;
					peashooter.positionX = posX;
					peashooter.positionY = posY;
					peashooter.zombArray = this.zombieArr;
					peashooter.plantArray = this.plantArr;
					peashooter.bulletLayer = this.bulletLayer;
					this.plantArr.push(peashooter);
					this.plantLayer.addChild(peashooter);
					////trace(Missions.Map1);
					this.mapInfo[posX][posY] = GameData.Lawn_HasPlant_Field;
					////trace(Missions.Map1);
					return true;
				break;
				case PlantType._SunFlower:
					if (checkCanNotPlant(pl)) 
						{
							return false;
						}
					var sunflower:SunFlower = new SunFlower();
					sunflower.sunboard = this.sunshineBoard;
					sunflower.PlantLayer = this.plantLayer;
					sunflower.scaleX = sunflower.scaleY=this.scales;
					sunflower.x=posX * this.tileWidth + this.tileWidth / 2;
					sunflower.y=posY * this.tileHeight + this.tileHeight / 2;
					sunflower.positionX = posX;
					sunflower.positionY = posY;
					sunflower.zombArray = this.zombieArr;
					sunflower.plantArray = this.plantArr;
					sunflower.sunLayer = this.sunshineLayer;
					this.plantLayer.addChild(sunflower);
					this.plantArr.push(sunflower);
					this.mapInfo[posX][posY] = GameData.Lawn_HasPlant_Field;
					return true;
				break;
				case PlantType._CherryBomb:
					if (checkCanNotPlant(pl)) 
					{
						return false;
					}
					var cherrybomb:CherryBomb = new CherryBomb();
					cherrybomb.PlantLayer = this.plantLayer;
					cherrybomb.scaleX = cherrybomb.scaleY=this.scales;
					cherrybomb.x = posX * this.tileWidth + this.tileWidth / 2;
					cherrybomb.y = posY * this.tileHeight + this.tileHeight / 2;
					cherrybomb.positionX = posX;
					cherrybomb.positionY = posY;
					cherrybomb.zombArray = this.zombieArr;
					cherrybomb.plantArray = this.plantArr;
					this.plantLayer.addChild(cherrybomb);
					this.plantArr.push(cherrybomb);
					this.mapInfo[posX][posY] = GameData.Lawn_HasPlant_Field;
					return true;
				break;
				case PlantType._WallNut:
					if (checkCanNotPlant(pl)) 
					{
						return false;
					}
					var wallnut:WallNut = new WallNut();
					wallnut.PlantLayer = this.plantLayer;
					wallnut.scaleX = wallnut.scaleY=this.scales;
					wallnut.x = posX * this.tileWidth + this.tileWidth / 2;
					wallnut.y = posY * this.tileHeight + this.tileHeight / 2;
					wallnut.positionX = posX;
					wallnut.positionY = posY;
					wallnut.zombArray = this.zombieArr;
					wallnut.plantArray = this.plantArr;
					this.plantLayer.addChild(wallnut);
					this.plantArr.push(wallnut);
					this.mapInfo[posX][posY] = GameData.Lawn_HasPlant_Field;
					return true;
				break;
				case PlantType._Chomper:
					if (checkCanNotPlant(pl))
					{
						return false;
					}
					var chomper:Chomper = new Chomper();
					chomper.PlantLayer = this.plantLayer;
					chomper.scaleX =chomper.scaleY= this.scales;
					chomper.x = posX * this.tileWidth + this.tileWidth / 2;
					chomper.y = posY * this.tileHeight + this.tileHeight / 2;
					chomper.positionX = posX;
					chomper.positionY = posY;
					chomper.zombArray = this.zombieArr;
					chomper.plantArray = this.plantArr;
					this.plantLayer.addChild(chomper);
					this.plantArr.push(chomper);
					this.mapInfo[posX][posY] = GameData.Lawn_HasPlant_Field;
					return true;
				break;
				case PlantType._FumeShroom:
					if (checkCanNotPlant(pl))
					{
						return false;
					}
					if (Issunny) 
					{
						return false;
					}
					var fumrshroom:FumeShroom = new FumeShroom();
					fumrshroom.PlantLayer = this.plantLayer;
					fumrshroom.scaleX = fumrshroom.scaleY=this.scales;
					fumrshroom.x = posX * this.tileWidth + this.tileWidth / 2;
					fumrshroom.y = posY * this.tileHeight + this.tileHeight / 2;
					fumrshroom.positionX = posX;
					fumrshroom.positionY = posY;
					fumrshroom.bulletLayer = this.bulletLayer;
					fumrshroom.zombArray = this.zombieArr;
					fumrshroom.plantArray = this.plantArr;
					this.plantLayer.addChild(fumrshroom);
					this.plantArr.push(fumrshroom);
					this.mapInfo[posX][posY] = GameData.Lawn_HasPlant_Field; 
					return true;
				break;
				case PlantType._Repeater:
					if (checkCanNotPlant(pl))
					{
						return false;
					}
					var repeater:Repeater = new Repeater();
					repeater.PlantLayer = this.plantLayer;
					repeater.scaleX = repeater.scaleY=this.scales;
					repeater.x = posX * this.tileWidth + this.tileWidth / 2;
					repeater.y = posY * this.tileHeight + this.tileHeight / 2;
					repeater.positionX = posX;
					repeater.positionY = posY;
					repeater.zombArray = this.zombieArr;
					repeater.plantArray = this.plantArr;
					repeater.bulletLayer = this.bulletLayer;
					this.plantArr.push(repeater);
					this.plantLayer.addChild(repeater);
					this.mapInfo[posX][posY] = GameData.Lawn_HasPlant_Field;
					return true;
				break;
				case PlantType._Torchwood:
					if (checkCanNotPlant(pl))
					{
						return false;
					}
					var torch:Torchwood = new Torchwood();
					torch.PlantLayer = this.plantLayer;
					torch.scaleX = torch.scaleY=this.scales;
					torch.x = posX * this.tileWidth + this.tileWidth / 2;
					torch.y = posY * this.tileHeight + this.tileHeight / 2;
					torch.positionX = posX;
					torch.positionY = posY;
					torch.zombArray = this.zombieArr;
					torch.plantArray = this.plantArr;
					this.plantArr.push(torch);
					this.plantLayer.addChild(torch);
					this.mapInfo[posX][posY] = GameData.Lawn_HasPlant_Field;
					return true;
				break;
				case PlantType._Spikeweed:
					if (checkCanNotPlant(pl))
					{
						return false;
					}
					var spike:Spikeweed = new Spikeweed();
					spike.PlantLayer = this.plantLayer;
					spike.scaleX =spike.scaleY= this.scales;
					spike.x = posX * this.tileWidth + this.tileWidth / 2;
					spike.y = posY * this.tileHeight + this.tileHeight / 2;
					spike.positionX = posX;
					spike.positionY = posY;
					spike.zombArray = this.zombieArr;
					spike.plantArray = this.plantArr;
					this.plantArr.push(spike);
					this.plantLayer.addChild(spike);
					this.mapInfo[posX][posY] = GameData.Lawn_HasPlant_Field;
					return true;
				break;
				case PlantType._SnowPea:
					if (checkCanNotPlant(pl)) 
					{
						return false;
					}
					var snow:SnowPea = new SnowPea();
					snow.PlantLayer = this.plantLayer;
					snow.scaleX =snow.scaleY= this.scales;
					snow.x = posX * this.tileWidth + this.tileWidth / 2;
					snow.y = posY * this.tileHeight + this.tileHeight / 2;
					snow.positionX = posX;
					snow.positionY = posY;
					snow.zombArray = this.zombieArr;
					snow.plantArray = this.plantArr;
					snow.bulletLayer = this.bulletLayer;
					this.plantArr.push(snow);
					this.plantLayer.addChild(snow);
					this.mapInfo[posX][posY] = GameData.Lawn_HasPlant_Field;
					return true;
				break;
				case PlantType._FlowerPot:
					if (checkCanNotPlant(pl)) 
					{
						return false;
					}
					var pot:FlowerPot = new FlowerPot();
					pot.PlantLayer = this.plantLayer;
					pot.scaleX =pot.scaleY=pot.scaleY= this.scales;
					pot.x = posX * this.tileWidth + this.tileWidth / 2;
					pot.y = posY * this.tileHeight + this.tileHeight / 2;
					pot.positionX = posX;
					pot.positionY = posY;
					pot.zombArray = this.zombieArr;
					pot.plantArray = this.plantArr;
					this.plantLayer.addChild(pot);
					this.plantArr.push(pot);
					this.mapInfo[posX][posY] = GameData.Lawn_HasPlant_Field;
					return true;
				break;
				case PlantType._LilyPad:
					if (checkCanNotPlant(pl)) 
					{
						return false;
					}
					var lili:LilyPad = new LilyPad();
					lili.PlantLayer = this.plantLayer;
					lili.scaleX = lili.scaleY=this.scales;
					lili.x = posX * this.tileWidth + this.tileWidth / 2 - 12;
					lili.y = posY * this.tileHeight + this.tileHeight / 2;
					lili.positionX = posX;
					lili.positionY = posY;
					lili.zombArray = this.zombieArr;
					lili.plantArray = this.plantArr;
					this.plantLayer.addChild(lili);
					this.plantArr.push(lili);
					this.mapInfo[posX][posY] = GameData.Lawn_HasLily;
					return true;
				break;
				case PlantType._PuffShroom:
					if (checkCanNotPlant(pl)) 
					{
						return false;
					}
					if (Issunny) 
					{
						return false;
					}
					var puff:PuffShroom = new PuffShroom();
					puff.PlantLayer = this.plantLayer;
					puff.scaleX = puff.scaleY=this.scales;
					puff.x = posX * this.tileWidth + this.tileWidth / 2;
					puff.y = posY * this.tileHeight + this.tileHeight / 2;
					puff.positionX = posX;
					puff.positionY = posY;
					puff.bulletLayer = this.bulletLayer;
					puff.zombArray = this.zombieArr;
					puff.plantArray = this.plantArr;
					this.plantLayer.addChild(puff);
					this.plantArr.push(puff);
					this.mapInfo[posX][posY] = GameData.Lawn_HasPlant_Field; 
					return true;
				break;
				default:
					return false;
				break;
			}
			return false;
		}
		
		private function checkCanNotPlant(pla:Object):Boolean 
		{
			var arr:Array = pla.LawnState;
			for (var i:int = 0; i < arr.length; i++) 
			{
				var item:int = arr[i];
				if (item==this.mapInfo[clickX][clickY]) 
				{
					return false;
				}
			}
			return true;
		}
		
		private function addPlant():void 
		{
			//过关后增加植物奖励
			//向GameData.PlantUnsealed里push GameData.ALL_PLANT_TYPE里的第GameData.currentMission个
			var planttype:Object = GameData.ALL_PLANT_TYPE[GameData.currentMission+1] as Object;
			for (var i:int = 0; i < GameData.PlantUnsealed.length; i++) 
			{
				var item:Object = GameData.PlantUnsealed[i] as Object;
				if (item==planttype) 
				{
					return;
				}	
			}
			GameData.PlantUnsealed.push(planttype);
			//添加动画  可是我不会呃
		}
		private function NextMission():void 
		{
			//添加植物奖励
			addPlant();
			clearAllElements();
			var plantIntro:Object=GameData.PlantUnsealed[GameData.PlantUnsealed.length-1]
			plantNext = new PlantIntro(plantIntro);
			plantNext.x = (GameData.stagewidth - plantNext.width) / 2;
			this.addChild(plantNext);
			timer= new Timer(100);
			timer.addEventListener(TimerEvent.TIMER, rotate);
			timer.start();
		}
		//完成后的动画
		//我擦不能转
		private function rotate(e:TimerEvent):void
		{
			inc++;
			if (inc>this.timerLong)
			{
				//时间停止
				timer.removeEventListener(TimerEvent.TIMER, rotate);
				//去除图鉴
				this.removeChild(plantNext);
				//下一开始
				PvzEvent.LawnEvent.dispatchEvent(new Event(PvzEvent.NEXT_MISSION));
			}
		}
		
		private function MissionFailed(e:Event):void 
		{
			clearAllElements();
			addChild(txtfail);
			txtfail.x = 400;
			txtfail.y = 300;
			timer= new Timer(100,40);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, fail);
			timer.start();
		}
		private function fail(e:TimerEvent):void 
		{
			removeChild(txtfail);
			PvzEvent.LawnEvent.dispatchEvent(new Event(PvzEvent.MISSION_FAILED));
		}
		private function clearAllElements():void 
		{
			//清空已选植物
			GameData.Plant_Has_Select = [];
			this.plantArr = [];
			this.zombieArr = [];
			MouseState.Card_Or_Bar_ClickState = MouseState.CARD_OR_BAR_FIRSTCLICK;
			this.removeEventListener(Event.ENTER_FRAME, enterFrame);
			this.removeEventListener(MouseEvent.CLICK, plantPlant);
			this.removeChild(bulletLayer);
			this.removeChild(plantLayer);
			this.removeChild(zombieLayer);
		}
		
		private function MissionRestart():void 
		{
			clearAllElements();
			PvzEvent.LawnEvent.dispatchEvent(new Event(PvzEvent.MISSION_RESTART));
		}
		private function GameOver():void 
		{
			clearAllElements();
			addChild(txtover);
			txtover.x = 400;
			txtover.y = 300;
			timer= new Timer(100,40);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, over);
			timer.start();
		}
		private function over(e:TimerEvent):void 
		{
			removeChild(txtover);
			PvzEvent.LawnEvent.dispatchEvent(new Event(PvzEvent.GAME_OVER));
		}
	}

}