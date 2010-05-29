package crayons.signals
{

    
    
    public class ChangeFunctionSlot implements ChangeSlot
    {

        public var func:Function;

        
        
        public function ChangeFunctionSlot(func:Function)
        {
            this.func = func;
        }

        
        public function onChange(oldValue:*, newValue:*):void
        {
            if(func != null)
            {
                func(oldValue, newValue);
            }
        }
    }
}