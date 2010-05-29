package
{   
  import flash.text.TextField;
  import flash.display.Sprite;
  import crayons.data.binding.Binder;
  
  public class Example extends Sprite
  {
    private var source:SomeModel;
    private var target:TextField;
    
    private var binder:Binder;
    
    public function Example()
    {
      super();
      
      // you only need one of these throughout your app
      binder = new Binder(); 
      
      source = new SomeModel();
      target = new TextField();
      
      addChild(target);
      
      // this binds source.data to target.text, 
      // provided source dispatches dataChanged when its data property changes
      binder.bind(source.dataChanged, target, "text");  
      
      // this should set the data in the target text field  
      source.data = "Data Binding !";  
    }
  }
}