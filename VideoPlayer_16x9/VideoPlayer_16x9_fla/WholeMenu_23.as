package VideoPlayer_16x9_fla
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public dynamic class WholeMenu_23 extends MovieClip
   {
       
      
      public var menuItemContainer:MovieClip;
      
      public var invisiClip:MovieClip;
      
      public var mainBtn1:SimpleButton;
      
      public function WholeMenu_23()
      {
         super();
      }
      
      public function main1Over(param1:MouseEvent) : void
      {
         if(this.currentFrame == 1)
         {
            gotoAndPlay("down1");
         }
      }
      
      public function invisClipOver(param1:MouseEvent) : void
      {
         gotoAndStop(1);
      }
   }
}
