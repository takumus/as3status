package jp.takumus.utils.status
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	public class Status extends Bitmap
	{
		private const WIDTH:int = 100;
		private const HEIGHT:int = 100;
		private const _textGen:TextGenerator = new TextGenerator();
		private var _prevTime:int;
		public function Status()
		{
			super();
			bitmapData = new BitmapData(WIDTH, HEIGHT, true, 0xffff0000);
			_textGen.renderText(bitmapData, 0, 0, "hello");
			
			this.addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(event:Event):void
		{
			var nowTime:int = getTimer();
			var diffTime:int = nowTime - _prevTime;
			var fps:Number = 1.0/(diffTime*0.001);
			_prevTime = nowTime;
			_textGen.renderText(bitmapData, 0, 0, fps+"");
		}
	}
}