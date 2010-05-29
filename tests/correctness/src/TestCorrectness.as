package
{
	import asunit.core.TextCore;

  import flash.display.MovieClip;

  import crayons.TestSuite;

	[SWF(width='1000', height='800', backgroundColor='#333333', frameRate='31')]
	public class TestCorrectness extends MovieClip
	{
    private var core:TextCore;

		public function TestCorrectness()
		{
      core = new TextCore();
			core.start(TestSuite, null, this);
		}
	}
}

