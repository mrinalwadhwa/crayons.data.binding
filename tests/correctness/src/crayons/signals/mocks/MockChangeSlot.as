package crayons.signals.mocks
{
	import crayons.signals.ChangeSlot;



	public class MockChangeSlot implements ChangeSlot
	{
		public var called:Boolean = false;
		public var oldValue:*;
		public var newValue:*;



		public function onChange(oldValue:*, newValue:*):void
		{
			called = true;
			this.oldValue = oldValue;
			this.newValue = newValue;
		}
	}
}