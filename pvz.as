package  
{
	import data.GameData;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.events.Event;
	import Layers.layer;
	import MyEvent.PvzEvent;
	import flash.display.StageScaleMode;
	
	/**
	 * ...
	 * @author IJUST
	 */
	public class pvz extends MovieClip
	{
		private var SelectBoard:selectBoard;
		private var surface:Surface;
		private var lawn:Lawn;
		private var plantbar:PlantBar;
		private var sunboard:sunBoard;
		private var sunLayer:layer;
		private var BMPlayer:layer;
		public function pvz() 
		{
			addEventListener(Event.ADDED_TO_STAGE, tostage);
			//冒险模式点击开始
			surface = new Surface();
			addChild(surface);
			PvzEvent.Pvz_MainEvent.addEventListener(PvzEvent.BEGIN_ADVENTURE, beginAdventure);
			PvzEvent.Pvz_MainEvent.addEventListener(PvzEvent.LETS_ROCK_AND_ROLL, letsRockAndRoll);
			PvzEvent.LawnEvent.addEventListener(PvzEvent.MISSION_FAILED, missionFailed);
			PvzEvent.LawnEvent.addEventListener(PvzEvent.MISSION_RESTART, missionRestart);
			PvzEvent.LawnEvent.addEventListener(PvzEvent.NEXT_MISSION, missionNext);
			PvzEvent.LawnEvent.addEventListener(PvzEvent.GAME_OVER, GameOver);
		}
		private function tostage(e:Event):void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
		}
		private function beginAdventure(e:Event):void 
		{
			//先播放
			//添加各种元素
			this.removeChild(surface);
			//scrollMap();
			SelectBoard = new selectBoard();
			addChild(SelectBoard);
		}
		private function scrollMap():void 
		{
			//滚动图片
		}
		private function letsRockAndRoll(e:Event):void
		{
			GameData.sunshine = GameData.sunInit;
			this.removeChild(SelectBoard);
			plantbar = new PlantBar();
			lawn = new Lawn();
			sunboard = new sunBoard();
			sunLayer = new layer();
			sunLayer.mouseChildren = false;
			sunLayer.mouseEnabled = false;
			BMPlayer = new layer();
			lawn.x = 40;
			lawn.y = 80;
			sunboard.x = 0;
			sunboard.y = lawn.y * ( -1)+40;
			plantbar.x = sunboard.width + 5;
			plantbar.y = lawn.y * ( -1);
			lawn.plantbar = this.plantbar;
			lawn.sunshineBoard = this.sunboard;
			lawn.sunshineLayer = this.sunLayer;
			plantbar.sunshineBoard = this.sunboard;
			plantbar.spritePlantBMP = this.BMPlayer;
			this.addChild(lawn);
			lawn.addChildAt(sunboard, 1);
			lawn.addChildAt(plantbar, 2);
			this.addChild(sunLayer);
			this.addChild(BMPlayer);
			
		}
		private function startMission():void 
		{
			//开始头卡
		}
		//PvzEvent的监听的事件
		private function missionFailed(e:Event):void 
		{
			//重新开始
			//先清除各种杂物
			removeChild(lawn);
			//添加选择版
			SelectBoard = new selectBoard();
			addChild(SelectBoard);
		}
		
		private function missionNext(e:Event):void 
		{
			//先清除各种杂物
			removeChild(lawn);
			GameData.currentMission++;
			//添加选择版
			SelectBoard = new selectBoard();
			addChild(SelectBoard);
		}
		
		private function missionRestart(e:Event):void 
		{
			//重新开始关卡
		}
		
		private function GameOver(e:Event):void 
		{
			//完成播放一段动画
			////trace("Game Over");
		}
	}

}