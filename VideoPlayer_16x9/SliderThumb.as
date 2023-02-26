package
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class SliderThumb extends Sprite
   {
       
      
      private var image:Bitmap;
      
      private var mouseIsDown:Boolean;
      
      private var _stage:Stage;
      
      public var min:Number;
      
      public var max:Number;
      
      public function SliderThumb(param1:BitmapData, param2:Stage)
      {
         super();
         min = max = 0;
         this._stage = param2;
         image = new Bitmap(param1);
         addChild(image);
         addEventListener(Event.ADDED_TO_STAGE,init);
      }
      
      private function init(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,init);
         mouseIsDown = false;
         image.x = -Math.round(image.width / 2);
         image.y = -Math.round(image.height / 2);
         addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
         _stage.addEventListener(MouseEvent.MOUSE_UP,mouseUp);
         _stage.addEventListener(MouseEvent.MOUSE_MOVE,mouseMove);
      }
      
      public function clone() : SliderThumb
      {
         var _loc1_:SliderThumb = new SliderThumb(image.bitmapData,_stage);
         _loc1_.min = min;
         _loc1_.max = max;
         return _loc1_;
      }
      
      private function mouseDown(param1:MouseEvent) : void
      {
         mouseIsDown = true;
      }
      
      private function mouseUp(param1:MouseEvent) : void
      {
         mouseIsDown = false;
      }
      
      private function mouseMove(param1:MouseEvent) : void
      {
         if(mouseIsDown)
         {
            x = parent.globalToLocal(new Point(_stage.mouseX,0)).x;
            if(x < min)
            {
               x = min;
            }
            else if(x > max)
            {
               x = max;
            }
            dispatchEvent(new Event(Event.CHANGE));
         }
      }
   }
}
