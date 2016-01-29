package jp.takumus.utils.status
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	public class Status extends Bitmap
	{
		private const WIDTH:int = 60;
		private const HEIGHT:int = 60;
		private const _textGen:TextGenerator = new TextGenerator("1234567890FPS.");
		private var _rect:Rectangle;
		private var _prevTime:int;
		private var _timer:Timer;
		private var _frame:int = 0;
		private var _rate:Number = 1.0;
		public function Status()
		{
			super();
			bitmapData = new BitmapData(WIDTH, HEIGHT, false, 0xff0000);
			_rect = bitmapData.rect;
			_timer = new Timer(1000*_rate);
			_timer.start();
			_timer.addEventListener(TimerEvent.TIMER, time);
			
			this.addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(event:Event):void
		{
			//var nowTime:int = getTimer();
			//var diffTime:int = nowTime - _prevTime;
			//_prevTime = nowTime;
			_frame ++;
		}
		private function time(event:TimerEvent):void
		{
			bitmapData.fillRect(_rect, 0xff0000);
			_textGen.renderText(bitmapData, 0, 0, (_frame)/_rate+"");
			_frame = 0;
		}
	}
}