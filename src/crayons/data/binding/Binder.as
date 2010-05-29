package crayons.data.binding
{
    import crayons.signals.ChangeSignal;

    import flash.utils.Dictionary;

    
    
    public class Binder
    {

        protected var bindings:Dictionary = null;
        protected var allowOverwrites:Boolean = false;
        protected var useWeakReferences:Boolean = false;

        
        
        public function Binder(allowOverwrites:Boolean = false, useWeakReferences:Boolean = false)
        {
            this.bindings = new Dictionary(useWeakReferences);
            this.useWeakReferences = useWeakReferences;
            this.allowOverwrites = allowOverwrites;
        }

        
        
        public function bind(signal:ChangeSignal, host:*, property:String):void
        {
            createBinding(signal, host, property);
        }

        
        
        public function hasBinding(host:*, property:String):Boolean
        {
            if(bindings[host] == null)
				return false;
			
            var binding:Binding = bindings[host][property];
            return binding != null && binding;
        }

        
        
        public function unbind(host:*, property:String):void
        {
            if(hasBinding(host, property))
            {
                var binding:Binding = bindings[host][property];

                binding.signal.remove(binding);
                binding = null;

                delete bindings[host][property];
            }
        }

        
        
        public function unbindAll():void
        {
            this.bindings = new Dictionary(useWeakReferences);
        }

        
        
        protected function createBinding(signal:ChangeSignal, host:*, property:String):void
        {
            if(bindings[host] == null)
            {
                bindings[host] = [];
            }
			
            if(bindings[host][property] != null && !allowOverwrites)
            {
                throw new Error("Binding previously defined");
            }
            else
            {
                if(hasBinding(host, property))
                {
                    unbind(host, property);
                }

                var binding:Binding = new Binding(signal, host, property);
                signal.add(binding);				    

                bindings[host][property] = binding;
            }
        }
    }
}