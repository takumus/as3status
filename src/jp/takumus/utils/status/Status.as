package jp.takumus.utils.status
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	public class Status extends Bitmap
	{
		private const WIDTH:int = 60;
		private const HEIGHT:int = 80;
		private const _textGen:TextGenerator = new TextGenerator("1234567890FPS.");
		private var _fpsLabelRect:Rectangle;
		private var _fpsGraphRect:Rectangle;
		private var _fpsGraphLineRect:Rectangle;
		private var _fpsGraphLineWidth:int = 2;
		private var _prevTime:int;
		private var _timer:Timer;
		private var _frame:int = 0;
		private var _rate:Number = 1.0;
		public function Status()
		{
			super();
			bitmapData = new BitmapData(WIDTH, HEIGHT, false, 0x000000);
			_fpsLabelRect = new Rectangle(0, 0, WIDTH, _textGen.height);
			_fpsGraphRect = new Rectangle(0, _fpsLabelRect.height, WIDTH, HEIGHT - _fpsLabelRect.height);
			_fpsGraphLineRect = new Rectangle(0, 0, 0, 0);
			_timer = new Timer(1000*_rate);
			_timer.start();
			_timer.addEventListener(TimerEvent.TIMER, time);
			
			this.addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(event:Event):void
		{
			_frame ++;
		}
		private function time(event:TimerEvent):void
		{
			var fps:int = (_frame)/_rate;
			//FPS
			renderFPS(fps);
			//FPS Graph
			renderFPSGraph(fps);
			_frame = 0;
		}
		
		private function renderFPS(fps:int):void
		{
			bitmapData.fillRect(_fpsLabelRect, 0x000000);
			_textGen.renderText(bitmapData, 0, 0, "FPS:"+fps);
		}
		private function renderFPSGraph(fps:int):void
		{
			//bitmapData.fillRect(_fpsGraphRect, 0xff0000);
			bitmapData.copyPixels(bitmapData, _fpsGraphRect, new Point(_fpsGraphLineWidth, _fpsGraphRect.y));
			
			_fpsGraphLineRect.x = 0;
			_fpsGraphLineRect.y = _fpsGraphRect.y;
			_fpsGraphLineRect.width = _fpsGraphLineWidth;
			_fpsGraphLineRect.height = _fpsGraphRect.height;
			
			bitmapData.fillRect(_fpsGraphLineRect, 0x000000);
			
			var h:int = (fps/stage.frameRate)*_fpsGraphRect.height;
			var y:int = _fpsGraphRect.height - h + _fpsGraphRect.y;
			_fpsGraphLineRect.x = 0;
			_fpsGraphLineRect.y = y;
			_fpsGraphLineRect.width = _fpsGraphLineWidth;
			_fpsGraphLineRect.height = h;
			
			bitmapData.fillRect(_fpsGraphLineRect, 0xff9900);
		}
	}
}