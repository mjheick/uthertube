package
{
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class RangeSlider extends Sprite
   {
       
      
      private var background:BitmapData;
      
      private var sliders:Array;
      
      public function RangeSlider(param1:BitmapData, param2:SliderThumb, param3:Number)
      {
         var background:BitmapData = param1;
         var slider:SliderThumb = param2;
         var size:Number = param3;
         super();
         this.background = background;
         slider.min = 0;
         slider.max = size;
         sliders = [slider,slider.clone()];
         for each(slider in sliders)
         {
            addChild(slider);
            slider.addEventListener(Event.CHANGE,function(param1:Event):*
            {
               dispatchEvent(param1);
            });
         }
         sliders[1].x = size;
         this.size = size;
      }
      
      public function set size(param1:Number) : void
      {
         graphics.clear();
         graphics.beginBitmapFill(background);
         graphics.drawRect(0,0,param1,background.height);
         graphics.endFill();
      }
      
      public function get min() : Number
      {
         return sliders[0].x < sliders[1].x ? Number(sliders[0].x) : Number(sliders[1].x);
      }
      
      public function get max() : Number
      {
         return sliders[1].x > sliders[0].x ? Number(sliders[1].x) : Number(sliders[0].x);
      }
   }
}
