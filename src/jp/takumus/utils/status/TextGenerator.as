package jp.takumus.utils.status
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	
	internal class TextGenerator
	{
		private var _charBMDs:Dictionary;
		private var _textField:TextField;
		private var _tmpPos:Point;
		public function TextGenerator()
		{
			_charBMDs = new Dictionary();
			_textField = new TextField();
			_textField.autoSize = "left";
			_tmpPos = new Point();
		}
		public function renderText(target:BitmapData, x:Number, y:Number, text:String):void
		{
			for(var i:int = 0; i < text.length; i ++){
				var c:Object = getCharBMD(text.charAt(i));
				_tmpPos.x = x;
				_tmpPos.y = y;
				x += c.rect.width;
				target.copyPixels(c.bmd, c.rect, _tmpPos);
			}
		}
		private function getCharBMD(char:String):Object
		{
			if(!_charBMDs[char]){
				_textField.text = char;
				var charBMD:BitmapData = new BitmapData(_textField.width, _textField.height, true, 0x00000000);
				charBMD.draw(_textField);
				_charBMDs[char] = {};
				_charBMDs[char].bmd = charBMD;
				_charBMDs[char].rect = charBMD.rect;
			}
			return _charBMDs[char];
		}
	}
}