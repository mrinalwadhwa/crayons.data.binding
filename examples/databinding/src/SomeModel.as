package
{   
  import crayons.signals.ChangeSignal;
  
  public class SomeModel
  {
    private var _data:String;
    public var dataChanged:ChangeSignal;
    
    public function SomeModel()
    {
      dataChanged = new ChangeSignal("data");
    }

    public function get data():String
    {
      return _data;
    }
    
    public function set data(value:String):void 
    {
      if(_data == value)
          return;
      
      var old:String = value;    
      _data = value;
      // dispatch change signal whenever data changes
      dataChanged.dispatch(old, value); 
    }
  }
}