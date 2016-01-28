package
{
	import flash.display.Sprite;
	
	import jp.takumus.utils.status.Status;
	
	import net.hires.utils.Stats;

	[SWF(frameRate="60")]
	public class AS3StatusSample extends Sprite
	{
		public function AS3StatusSample()
		{
			addChild(new Status());
		}
	}
}