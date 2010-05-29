package crayons.data.binding.mocks
{
	import crayons.signals.ChangeSignal;



	public final class MockSource
	{
		public static const VALUE1:String = "value one";
		public static const VALUE2:String = "value two";

		private var _sourceProperty1:String;
		public var sourceProperty1Changed:ChangeSignal;

		private var _sourceProperty2:String;
		public var sourceProperty2Changed:ChangeSignal;

		public function MockSource()
		{
			sourceProperty1Changed = new ChangeSignal("sourceProperty1");
			sourceProperty2Changed = new ChangeSignal("sourceProperty2");
		}



		public function get sourceProperty1():String
		{
			return _sourceProperty1;
		}



		public function set sourceProperty1(value:String):void
		{
			var old:String = _sourceProperty1;
			_sourceProperty1 = value;
			sourceProperty1Changed.dispatch(old, _sourceProperty1);
		}


		
		
		public function get sourceProperty2():String
		{
			return _sourceProperty2;
		}
		
		
		
		public function set sourceProperty2(value:String):void
		{
			var old:String = _sourceProperty2;
			_sourceProperty2 = value;
			sourceProperty2Changed.dispatch(old, _sourceProperty2);
		}

	}
}