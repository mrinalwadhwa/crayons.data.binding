package crayons.data.binding
{
	import asunit.framework.Assert;
	
	import crayons.data.binding.Binder;
	import crayons.data.binding.mocks.MockSource;
	import crayons.data.binding.mocks.MockTarget;



	public final class BinderTest
	{
		private var _binder:Binder = null;
        
		private var _source:MockSource = null;
		
		private var _target:MockTarget = null;
    private static const _targetProperty1Name:String = "targetProperty1";
		private static const _targetProperty2Name:String = "targetProperty2";
            


		[Before]
		public function before():void
		{
			_binder = new Binder();
			
			_source = new MockSource();
			_target = new MockTarget();
		}



		[After]
		public function after():void
		{
			_binder = null;
		
			_target = null;
			_source = null;
		}



		[Test]
		public function test_simple_bind():void
		{
			_binder.bind(_source.sourceProperty1Changed, _target, _targetProperty1Name);

			_source.sourceProperty1 = MockSource.VALUE1;
			Assert.assertEquals(_source.sourceProperty1, _target.targetProperty1);

			_source.sourceProperty1  = null;
			Assert.assertNull(_target.targetProperty1);

			_source.sourceProperty1 = MockSource.VALUE2;
			Assert.assertEquals(_source.sourceProperty1, _target.targetProperty1);
		}

		
		[Test]
		public function multi_property_bind_on_one_target():void
		{
			_binder.bind(_source.sourceProperty1Changed, _target, _targetProperty1Name);
			_binder.bind(_source.sourceProperty1Changed, _target, _targetProperty2Name);
			
			_source.sourceProperty1 = MockSource.VALUE1;
			Assert.assertEquals(_source.sourceProperty1, _target.targetProperty1);
			Assert.assertEquals(_source.sourceProperty1, _target.targetProperty2);
		}		
		


		[Test]
		public function allow_overwrites():void
		{
			_binder = new Binder(true);
			_binder.bind(_source.sourceProperty1Changed, _target, _targetProperty1Name);
			_binder.bind(_source.sourceProperty2Changed, _target, _targetProperty1Name);
			
			Assert.assertTrue(_binder.hasBinding(_target, _targetProperty1Name));		    
		}



		[Test]
		public function supress_overrites():void
		{
			_binder = new Binder(false);
			_binder.bind(_source.sourceProperty1Changed, _target, _targetProperty1Name);
			Assert.assertThrows(Error, function():void{
				_binder.bind(_source.sourceProperty2Changed, _target, _targetProperty1Name);
			});
		}



		[Test]
		public function valid_has_binding():void
		{
            _binder.bind(_source.sourceProperty1Changed, _target, _targetProperty1Name);
            Assert.assertTrue(_binder.hasBinding(_target, _targetProperty1Name));
		}



		[Test]
		public function invalid_has_binding():void
		{
			_binder.bind(_source.sourceProperty1Changed, _target, _targetProperty1Name);
			Assert.assertFalse(_binder.hasBinding(_target, _targetProperty2Name));
		}


		
		[Test]
		public function unbind_has_binding_returns_false():void
		{
			_binder.bind(_source.sourceProperty1Changed, _target, _targetProperty1Name);
			_binder.unbind(_target, _targetProperty1Name);
			
			Assert.assertFalse(_binder.hasBinding(_target, _targetProperty1Name));
		}	



		[Test]
		public function unbind_slot_is_removed_from_signal():void
		{
			_binder.bind(_source.sourceProperty1Changed, _target, _targetProperty1Name);
			_binder.unbind(_target, _targetProperty1Name);
			
			Assert.assertEquals(0, _source.sourceProperty1Changed.numSlots);
		}			
		
		[Test]
		public function unbind_all_has_binding_returns_false():void
		{
			_binder.bind(_source.sourceProperty1Changed, _target, _targetProperty1Name);
			_binder.bind(_source.sourceProperty1Changed, _target, _targetProperty2Name);
			_binder.unbindAll();
			
			Assert.assertFalse(_binder.hasBinding(_target, _targetProperty1Name));
			Assert.assertFalse(_binder.hasBinding(_target, _targetProperty2Name));
		}
		
		
		
		[Test]
		public function unbind_all_allSlots_are_removed():void
		{
			_binder.bind(_source.sourceProperty1Changed, _target, _targetProperty1Name);
			_binder.bind(_source.sourceProperty1Changed, _target, _targetProperty2Name);
			_binder.unbindAll();
			
			Assert.assertEquals(0, _source.sourceProperty1Changed.numSlots);
		}		

	}
}