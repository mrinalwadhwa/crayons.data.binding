package crayons.signals
{

    
    
    /**
     *   A ChangeSignal signal holds a list of ChangeSlots and calls the onChange method on 
     *   them all when the signal is "dispatched". 
     *   
     *   This signal passes two parameters to its slots, oldValue and newValue
     */
    public class ChangeSignal
    {

        private var _propertyName:String;
        private var _slots:Array = [];
        private var _slotsNeedCopying:Boolean;
        private var _numDispatchesInProgress:uint;

        
        
        public function ChangeSignal(proptertyName:String = "")
        {
            _propertyName = proptertyName;
        }

        
        
        /**
         *
         * Name of the property whose change in value this signal represents
         *
         */
        public function get propertyName():String
        {
            return _propertyName;
        }

        
        
        public function set propertyName(name:String):void
        {
            if(_propertyName != name)
            {
                _propertyName = name;
            }
        }

        
        
        /**
         *   Add a slot to be called during dispatch
         *
         *   @param slot ChangeSlot to add or a Functin to add via a ChangeFunctionSlot
         *   This method has no effect if the slot is null or the signal already has the slot.
         */
        public function add(slot:*):void
        {
            var s:ChangeSlot;
		    
            if(slot is Function)
            {
                s = new ChangeFunctionSlot(slot as Function);
            }
            else
            {
                s = slot;
            }
		    
            // Only add valid slots we don't already have
            if(!s || _slots.indexOf(s) >= 0)
            {
                return;
            }

            // Copy the list during dispatch
            if(_slotsNeedCopying)
            {
                _slots = _slots.slice();
                _slotsNeedCopying = false;
            }

            _slots[_slots.length] = s;		        
        }

        
        
        /**
         *   Remove a Function listener
         *
         *   @param func
         */
        public function remove(slot:*):void
        {
            // Can't remove a slot we don't have
            var index:int = indexOf(slot);
            if(index < 0)
            {
                return;
            }

            // Copy the list during dispatch
            if(_slotsNeedCopying)
            {
                _slots = _slots.slice();
                _slotsNeedCopying = false;
            }

            _slots.splice(index, 1);
        }

        
        
        /**
         *   Remove all slots so that they are not called during dispatch
         */
        public function removeAll():void
        {
            if(_slotsNeedCopying)
            {
                _slots = [];
                _slotsNeedCopying = false;
            }
            else
            {
                _slots.length = 0;
            }
        }

        
        
        /**
         *   Check if the signal has a slot
         *
         *   @param slot Slot to check
         *   @return If the signal has the given slot
         */
        public function has(slot:*):Boolean
        {
            return indexOf(slot) >= 0;
        }

        
        
        /**
         *   Get the number of slots the signal has
         *
         *   @return The number of slots the signal has
         */
        public function get numSlots():uint
        {
            return _slots.length;
        }

        
        
        /**
         *   Get the index of a slot in the list of slots this signal has
         *    
         *   @return The index of the given slot in the list of slots this signal has or -1 if this signal 
         *   does not have the given slot
         */
        public function indexOf(slot:*):int
        {
            if(slot is Function)
            {
                var l:int = _slots.length;
                for(var i:int = 0;i < l;++i)
                {
                    if(_slots[i]["func"] === slot)
    					return i;
                }
            }
		    else if (slot is ChangeSlot)
            {
                return _slots.indexOf(slot);
            }

            return -1;
        }

        
        
        /**
         *   Call all of the slots the signal has. Calls to add() or remove() by any slot in response to these
         *   calls will not change which slots are called or the order in which they are called during
         *   this particular dispatch.
         *
         *   @param oldValue First argument to pass to the slots
         *   @param newValue Second argument to pass to the slots
         */
        public function dispatch(oldValue:*, newValue:*):void
        {
            var slots:Array = _slots;
            _slotsNeedCopying = true;
            _numDispatchesInProgress++;

            for(var i:uint = 0, len:uint = slots.length;i < len;++i)
            {
                ChangeSlot(slots[i]).onChange(oldValue, newValue);
            }

            _numDispatchesInProgress--;

            if(_numDispatchesInProgress == 0)
            {
                _slotsNeedCopying = false;
            }
        }
    }
}
