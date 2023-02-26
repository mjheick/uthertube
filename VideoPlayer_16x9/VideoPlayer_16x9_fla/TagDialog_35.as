package VideoPlayer_16x9_fla
{
   import fl.controls.ComboBox;
   import fl.data.DataProvider;
   import fl.data.SimpleCollectionItem;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public dynamic class TagDialog_35 extends MovieClip
   {
       
      
      public var startTime:TextField;
      
      public var OkButton:SimpleButton;
      
      public var tagCombo:ComboBox;
      
      public var CloseButton:SimpleButton;
      
      public var endTime:TextField;
      
      public function TagDialog_35()
      {
         super();
         __setProp_tagCombo_TagDialog_CloseButton_0();
      }
      
      public function nothing(param1:MouseEvent) : *
      {
         param1.stopPropagation();
      }
      
      internal function __setProp_tagCombo_TagDialog_CloseButton_0() : *
      {
         var _loc2_:SimpleCollectionItem = null;
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc6_:* = undefined;
         try
         {
            tagCombo["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         var _loc1_:DataProvider = new DataProvider();
         _loc3_ = [{
            "label":"None",
            "data":0
         }];
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc2_ = new SimpleCollectionItem();
            _loc4_ = _loc3_[_loc5_];
            for(_loc6_ in _loc4_)
            {
               _loc2_[_loc6_] = _loc4_[_loc6_];
            }
            _loc1_.addItem(_loc2_);
            _loc5_++;
         }
         tagCombo.dataProvider = _loc1_;
         tagCombo.editable = false;
         tagCombo.enabled = true;
         tagCombo.prompt = "";
         tagCombo.restrict = "";
         tagCombo.rowCount = 5;
         tagCombo.visible = true;
         try
         {
            tagCombo["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
