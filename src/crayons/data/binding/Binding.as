package crayons.data.binding
{
    import crayons.signals.ChangeSignal;
    import crayons.signals.ChangeSlot;

    
    
    public class Binding implements ChangeSlot
    {

        private var _signal:ChangeSignal = null;
        private var _host:*;
        private var _property:*;

        
        
        public function Binding(signal:ChangeSignal, host:*, property:*)
        {
            _signal = signal;
            _host = host;
            _property = property;
        }

        
        
        public function get signal():ChangeSignal
        {
            return _signal;
        }

        
        
        public function onChange(oldValue:*, newValue:*):void
        {
            _host[_property] = newValue;
        }
    }
}