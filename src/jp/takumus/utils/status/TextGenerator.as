package jp.takumus.utils.status
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	
	internal class TextGenerator
	{
		private static var _charBMDs:Dictionary;
		private static var _textField:TextField;
		private static var _tmpPos:Point;
		public function TextGenerator(def:String = "")
		{
			_charBMDs = new Dictionary();
			_textField = new TextField();
			_textField.autoSize = "left";
			_textField.defaultTextFormat = new TextFormat("_sans", 10, 0xffffff);
			_tmpPos = new Point();
			
			for(var i:int = 0; i < def.length; i ++){
				getCharBMD(def.charAt(i));
			}
		}
		public function get height():int
		{
			_textField.text = "X";
			return _textField.height;
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
			text = null;
		}
		private function getCharBMD(char:String):Object
		{
			if(!_charBMDs[char]){
				_textField.text = char;
				var charBMD:BitmapData = new BitmapData(_textField.width, _textField.height, false, 0x000000);
				charBMD.draw(_textField);
				_charBMDs[char] = {};
				_charBMDs[char].bmd = charBMD;
				_charBMDs[char].rect = charBMD.rect;
			}
			return _charBMDs[char];
		}
	}
}