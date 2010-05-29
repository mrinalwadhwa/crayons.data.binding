package crayons.signals
{
	import asunit.asserts.*;

	import crayons.signals.mocks.MockChangeSlot;



	public class ChangeSignalTest
	{
		public var signal:ChangeSignal;
		public var mockSlot1:MockChangeSlot;
		public var mockSlot2:MockChangeSlot;



		[Before]
		public function before():void
		{
			this.signal = new ChangeSignal();
			this.mockSlot1 = new MockChangeSlot();
			this.mockSlot2 = new MockChangeSlot();
		}



		[After]
		public function after():void
		{
			this.signal.removeAll();
			this.signal = null;
			this.mockSlot1 = null;
			this.mockSlot2 = null;
		}



		[Test]
		public function numSlots_is_0_after_instantiation():void
		{
			assertEquals(0, this.signal.numSlots);
		}



		[Test]
		public function does_not_have_slot_after_instantiation():void
		{
			assertFalse(this.signal.has(this.mockSlot1));
		}



		[Test]
		public function does_not_have_null_slot():void
		{
			assertFalse(this.signal.has(null));
		}



		[Test]
		public function indexOf_is_negative_for_null():void
		{
			assertEquals(-1, this.signal.indexOf(null));
		}



		[Test]
		public function indexOf_is_negative_for_unadded_slot():void
		{
			assertEquals(-1, this.signal.indexOf(this.mockSlot1));
		}



		[Test]
		public function indexOf_is_0_for_first_added_slot():void
		{
			this.signal.add(this.mockSlot1);
			assertEquals(0, this.signal.indexOf(this.mockSlot1));
		}



		[Test]
		public function indexOf_is_0_for_first_and_1_for_second():void
		{
			this.signal.add(this.mockSlot1);
			this.signal.add(this.mockSlot2);
			assertEquals(0, this.signal.indexOf(this.mockSlot1));
			assertEquals(1, this.signal.indexOf(this.mockSlot2));
		}



		[Test]
		public function indexOf_is_0_for_first_after_remove_second():void
		{
			this.signal.add(this.mockSlot1);
			this.signal.add(this.mockSlot2);
			this.signal.remove(this.mockSlot2);
			assertEquals(0, this.signal.indexOf(this.mockSlot1));
		}



		[Test]
		public function indexOf_is_negative_for_second_after_remove_second():void
		{
			this.signal.add(this.mockSlot1);
			this.signal.add(this.mockSlot2);
			this.signal.remove(this.mockSlot2);
			assertEquals(-1, this.signal.indexOf(this.mockSlot2));
		}



		[Test]
		public function indexOf_is_0_for_second_after_remove_first():void
		{
			this.signal.add(this.mockSlot1);
			this.signal.add(this.mockSlot2);
			this.signal.remove(this.mockSlot1);
			assertEquals(0, this.signal.indexOf(this.mockSlot2));
		}



		[Test]
		public function indexOf_is_negative_for_first_after_remove_first():void
		{
			this.signal.add(this.mockSlot1);
			this.signal.add(this.mockSlot2);
			this.signal.remove(this.mockSlot1);
			assertEquals(-1, this.signal.indexOf(this.mockSlot1));
		}



		[Test]
		public function numSlots_is_1_after_adding():void
		{
			this.signal.add(this.mockSlot1);
			assertEquals(1, this.signal.numSlots);
		}



		[Test]
		public function numSlots_is_1_after_adding_duplicate_slot():void
		{
			this.signal.add(this.mockSlot1);
			this.signal.add(this.mockSlot1);
			assertEquals(1, this.signal.numSlots);
		}



		[Test]
		public function numSlots_is_2_after_adding_two_slots():void
		{
			this.signal.add(this.mockSlot1);
			this.signal.add(this.mockSlot2);
			assertEquals(2, this.signal.numSlots);
		}



		[Test]
		public function numSlots_is_1_after_adding_two_then_removing_first():void
		{
			this.signal.add(this.mockSlot1);
			this.signal.add(this.mockSlot2);
			this.signal.remove(this.mockSlot1);
			assertEquals(1, this.signal.numSlots);
		}



		[Test]
		public function numSlots_is_1_after_adding_two_then_removing_second():void
		{
			this.signal.add(this.mockSlot1);
			this.signal.add(this.mockSlot2);
			this.signal.remove(this.mockSlot2);
			assertEquals(1, this.signal.numSlots);
		}



		[Test]
		public function numSlots_is_0_after_adding_two_then_removing_both():void
		{
			this.signal.add(this.mockSlot1);
			this.signal.add(this.mockSlot2);
			this.signal.remove(this.mockSlot1);
			this.signal.remove(this.mockSlot2);
			assertEquals(0, this.signal.numSlots);
		}



		[Test]
		public function removing_null_does_not_crash():void
		{
			this.signal.remove(null);
		}



		[Test]
		public function removing_unadded_slot_does_not_crash():void
		{
			this.signal.remove(this.mockSlot1);
		}



		[Test]
		public function removing_unadded_slot_does_not_change_numSlots_when_empty():void
		{
			var oldNumSlots:uint = this.signal.numSlots;
			this.signal.remove(this.mockSlot1);
			assertEquals(oldNumSlots, this.signal.numSlots);
		}



		[Test]
		public function removing_unadded_slot_does_not_change_numSlots_when_populated():void
		{
			this.signal.add(this.mockSlot1);
			var oldNumSlots:uint = this.signal.numSlots;
			this.signal.remove(this.mockSlot2);
			assertEquals(oldNumSlots, this.signal.numSlots);
		}



		[Test]
		public function removeAll_when_empty_does_not_crash():void
		{
			this.signal.removeAll();
		}



		[Test]
		public function removeAll_removes_two_slots():void
		{
			this.signal.add(this.mockSlot1);
			this.signal.add(this.mockSlot2);
			this.signal.removeAll();
			assertEquals(0, this.signal.numSlots);
			assertFalse(this.signal.has(this.mockSlot1));
			assertFalse(this.signal.has(this.mockSlot2));
		}



		[Test]
		public function numSlots_is_0_after_adding_null():void
		{
			this.signal.add(null);
			assertEquals(0, this.signal.numSlots);
		}



		[Test]
		public function dispatch_should_call_only_slot():void
		{
			this.signal.add(this.mockSlot1);
			this.signal.dispatch(null, null);
			assertTrue(this.mockSlot1.called);
		}




		[Test]
		public function dispatch_should_pass_correct_parameters():void
		{
			var myObject1:Object = {a: 100};
			var myObject2:Object = {b: 200};
			var called:Boolean;
			this.signal.add(mockSlot1);
			this.signal.dispatch(myObject1, myObject2);
			assertEquals(myObject1, this.mockSlot1.oldValue);
			assertEquals(myObject2, this.mockSlot1.newValue);
			assertTrue(this.mockSlot1.called);
		}



		[Test]
		public function dispatch_should_not_call_removed_slot():void
		{
			this.signal.add(this.mockSlot1);
			this.signal.remove(this.mockSlot1);
			this.signal.dispatch(null, null);
			assertFalse(this.mockSlot1.called);
		}



		[Test]
		public function add_two_slots_remove_first_calls_second_only():void
		{
			this.signal.add(this.mockSlot1);
			this.signal.add(this.mockSlot2);
			this.signal.remove(this.mockSlot1);
			this.signal.dispatch(null, null);
			assertFalse(this.mockSlot1.called);
			assertTrue(this.mockSlot2.called);
		}



		[Test]
		public function add_two_slots_remove_second_calls_first_only():void
		{
			this.signal.add(this.mockSlot1);
			this.signal.add(this.mockSlot2);
			this.signal.remove(this.mockSlot2);
			this.signal.dispatch(null, null);
			assertTrue(this.mockSlot1.called);
			assertFalse(this.mockSlot2.called);
		}



		[Test]
		public function add_listener():void
		{
			var c:Number;
			this.signal.add(function(a:*, b:*):void
				{
					c = a + b;
				});
			this.signal.dispatch(100, 200);
			assertEquals(c, 300);
		}



		[Test]
		public function has_listener():void
		{
			var fun:Function = function(a:*, b:*):void
				{
					a + b;
				}
			this.signal.add(fun);
			assertTrue(this.signal.has(fun));
		}



		[Test]
		public function remove_listener():void
		{
			var fun:Function = function(a:*, b:*):void
				{
					a + b;
				}
			this.signal.add(fun);
			assertTrue(this.signal.has(fun));

			this.signal.remove(fun);

			assertFalse(this.signal.has(fun));
		}



		[Test]
		public function typed_function_listener_args():void
		{
			var c:Number;
			this.signal.add(function(a:Number, b:Number):void
				{
					c = a + b;
				});
			this.signal.dispatch(100, 200);
			assertEquals(c, 300);
		}
	}

}