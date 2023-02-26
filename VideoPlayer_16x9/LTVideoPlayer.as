package
{
   import fl.data.DataProvider;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.StageDisplayState;
   import flash.events.AsyncErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.events.NetStatusEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.TimerEvent;
   import flash.external.ExternalInterface;
   import flash.filters.DropShadowFilter;
   import flash.geom.Rectangle;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.media.Video;
   import flash.net.LocalConnection;
   import flash.net.NetConnection;
   import flash.net.NetStream;
   import flash.net.SharedObject;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import flash.system.LoaderContext;
   import flash.system.Security;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.ui.ContextMenu;
   import flash.ui.ContextMenuBuiltInItems;
   import flash.ui.ContextMenuItem;
   import flash.utils.Timer;
   
   public class LTVideoPlayer extends MovieClip
   {
       
      
      public var loadinganim:MovieClip;
      
      public var mcTimelineBubble:MovieClip;
      
      public var erroranim:MovieClip;
      
      public var mcPopup:MovieClip;
      
      public var tagDialog:MovieClip;
      
      public var txtFinished:TextField;
      
      public var ui:MovieClip;
      
      public var thumbPreviewBox:MovieClip;
      
      public var init:Boolean;
      
      public var progressSeek:Boolean;
      
      public var volumeSeek:Boolean;
      
      public var progressDrag:Boolean;
      
      public var volumeDrag:Boolean;
      
      public var flashSettings:SharedObject;
      
      public var hideTimeLineTimer:Timer;
      
      private var connection:NetConnection;
      
      private var stream:NetStream;
      
      private var video:Video;
      
      private var videoSrc:String = "";
      
      private var isMuted:Boolean = false;
      
      private var isPlaying:Boolean = false;
      
      private var isPaused:Boolean = false;
      
      private var originalVolume:Number = 0;
      
      private var customClient:Object;
      
      private var currentVideoAspect:Object;
      
      private var metaData:Object;
      
      private var metaReceived:Boolean = false;
      
      private var currentPosition:String = "";
      
      private var currentPercentage:Number = 0;
      
      private var currentDuration:String = "";
      
      private var currentPositionOffset:Number = 0;
      
      private var originalDuration:Number = -1;
      
      private var allowProgressUpdate:Boolean = true;
      
      private var updateOnNextSeek:Boolean = false;
      
      private var lastVolumeLevel:Number = 0.6;
      
      private var currentBufferPercentage:Number = 0;
      
      private var currentBufferPosition:Number = 0;
      
      private var initializedFirstFrame:Boolean = false;
      
      private var flvPositions:Array = null;
      
      private var flvTimes:Array = null;
      
      private var hitAdded:Boolean = false;
      
      private var popupLength:Number = 5000;
      
      private var xmlTagLoader:URLLoader;
      
      private var xmlLoader:URLLoader;
      
      private var xmlPayoutLoader:URLLoader;
      
      private var xmlTagData:XML;
      
      private var xmlData:XML;
      
      private var xmlPayoutData:XML;
      
      private var displayTimer:Timer;
      
      private var videoWatchedLengthTimer:Timer;
      
      private var popupTimer:Timer;
      
      private var totalTimeWatched:Number = 0;
      
      private var payoutTriggered:Boolean = false;
      
      private var imageLoader:Loader;
      
      private var loaderContext:LoaderContext;
      
      private var newImage:Object;
      
      private var loadTimer:Timer;
      
      private var swfTimer:Timer;
      
      private var swfLoader:Loader;
      
      private var relVideos:Array;
      
      private var isTagging:Boolean = false;
      
      private var slider:RangeSlider;
      
      private var numberOfTags:Number;
      
      private var aspsessid:String;
      
      private var PayoutTriggerSeconds:Number = 120;
      
      private var popupMessages:Array;
      
      public var SERVER:String = "http://tc-cdn-1.porned.com/Thumbs/";
      
      public var RECOMMENDEDVIDEOSURL:String = "/flash/RecommendedVideos.swf";
      
      public var SRC:String = "";
      
      public var CURRENTTHUMBPOSITION:Number = 1;
      
      public var THUMBEXTENSION:String = ".jpg";
      
      public var currentImageUrl:String = "";
      
      public var PLAYLIST:String = "";
      
      public var BUFFERTIME:Number = 16;
      
      public var SMOOTHING:Boolean = true;
      
      public var FLASHSERVER:String = "";
      
      public var VIDEOURL:String = "";
      
      public var VIEWHITURL:String = "http://www.uthertube.com/api/AddView.aspx?id=";
      
      public var XMLURL:String = "http://www.uthertube.com/api/VideoXML.aspx?id=";
      
      public var ADDTAGURL:String = "http://www.uthertube.com/api/AddTimeLineTag.aspx";
      
      public var TAGXMLURL:String = "http://www.uthertube.com/api/TagXML.aspx?id=";
      
      public var VIDEOIDENTIFIER:String = "";
      
      public var FORMAT:Number = 0;
      
      public var MAINTAINASPECT:Boolean = true;
      
      public var FORCEASPECT:Number = 0;
      
      public var WIDTH:Number = 640;
      
      public var HEIGHT:Number = 355;
      
      public var STREAMHACK:Boolean = true;
      
      public var STARTTIMECODE:Number = 0;
      
      public var TITLE:String = "";
      
      public var DATEADDED:String = "";
      
      public var RATING:Number = 0;
      
      public var REFERER:String = "";
      
      public var NOCOUNT:Number = 0;
      
      public var VIDEOID:Number = 0;
      
      public var GUID:String = "";
      
      public var SHORTGUID:String = "";
      
      public var CURRENTDOMAIN:String = "";
      
      public var CURRENTURL:String = "";
      
      public var CLICKURL:String = "";
      
      public var CLICKURLWINDOW:String = "_blank";
      
      public var AUTOPLAY:Boolean = false;
      
      public var QUALITY:String = "SD";
      
      public var VIDEOCODEC:String = "FLV";
      
      public var VIDEOBITRATE:Number = 0;
      
      public var AUDIOBITRATE:Number = 0;
      
      public var PROFILENAME:String = "none";
      
      public var REGISTERED:Boolean = false;
      
      public var SHOWPOPUPS:Boolean = false;
      
      public var OVERLAYLOGO:Boolean = true;
      
      public function LTVideoPlayer()
      {
         customClient = new Object();
         currentVideoAspect = new Object();
         metaData = new Object();
         xmlTagLoader = new URLLoader();
         xmlLoader = new URLLoader();
         xmlPayoutLoader = new URLLoader();
         xmlTagData = new XML();
         xmlData = new XML();
         xmlPayoutData = new XML();
         loaderContext = new LoaderContext();
         relVideos = [];
         popupMessages = [{
            "message":"TIP: REGISTER TODAY AND GET 3.50 RAYS FOR FREE!!!",
            "url":"http://www.uthertube.com/payouts"
         },{
            "message":"TIP: GET 6.00 RAYS FOR CONFIRMING YOUR EMAIL ADDRESS",
            "url":"http://www.uthertube.com/payouts"
         },{
            "message":"TIP: YOU COULD BE GETTING PAID FOR WATCHING THIS VIDEO",
            "url":"http://www.uthertube.com/payouts"
         },{
            "message":"TIP: GET PAID FOR WATCHING VIDEOS!",
            "url":"http://www.uthertube.com/payouts"
         },{
            "message":"TIP: REGISTER SO YOU CAN FAVORITE YOUR VIDEOS",
            "url":"http://www.uthertube.com/payouts"
         },{
            "message":"TIP: REGISTERED USERS HAVE ACCESS TO HD & HIGH QUALITY VIDEOS!",
            "url":"http://www.uthertube.com/payouts"
         },{
            "message":"TIP: REGISTER FOR FREE AND WE WILL PAY YOU TO WATCH VIDEOS!",
            "url":"http://www.uthertube.com/payouts"
         }];
         super();
         trace("LiveChannelPlayer created.");
         Security.allowDomain("www.uthertube.com");
         if(this.loaderInfo.parameters.URL != null)
         {
            if(this.loaderInfo.parameters.URL.indexOf("www.uthertube.com") == -1)
            {
               this.VIDEOIDENTIFIER = this.loaderInfo.parameters.URL;
            }
            else
            {
               this.XMLURL = this.loaderInfo.parameters.URL;
            }
         }
         if(this.loaderInfo.parameters.WIDTH != null)
         {
            this.WIDTH = this.loaderInfo.parameters.WIDTH;
         }
         if(this.loaderInfo.parameters.HEIGHT != null)
         {
            this.HEIGHT = this.loaderInfo.parameters.HEIGHT;
         }
         if(this.loaderInfo.parameters.MAINTAINASPECT != null)
         {
            this.MAINTAINASPECT = toBoolean(this.loaderInfo.parameters.MAINTAINASPECT);
         }
         if(this.loaderInfo.parameters.BUFFERTIME != null)
         {
            this.BUFFERTIME = this.loaderInfo.parameters.BUFFERTIME;
         }
         if(this.loaderInfo.parameters.FLASHSERVER != null)
         {
            this.FLASHSERVER = this.loaderInfo.parameters.FLASHSERVER;
         }
         if(this.loaderInfo.parameters.STREAMHACK != null)
         {
            this.STREAMHACK = toBoolean(this.loaderInfo.parameters.STREAMHACK);
         }
         if(this.loaderInfo.parameters.STARTTIMECODE != null)
         {
            this.STARTTIMECODE = Number(this.loaderInfo.parameters.STARTTIMECODE);
         }
         if(this.loaderInfo.parameters.REFERER != null)
         {
            this.REFERER = this.loaderInfo.parameters.REFERER;
         }
         if(this.loaderInfo.parameters.FORMAT != null)
         {
            this.FORMAT = Number(this.loaderInfo.parameters.FORMAT);
         }
         if(this.loaderInfo.parameters.ASPSESSID != null)
         {
            aspsessid = this.loaderInfo.parameters.ASPSESSID;
         }
         addEventListener(Event.ENTER_FRAME,onFrameEvent,false,0,true);
         displayTimer = new Timer(100);
         displayTimer.addEventListener(TimerEvent.TIMER,displayTimer_Tick,false,0,true);
         videoWatchedLengthTimer = new Timer(1000);
         videoWatchedLengthTimer.addEventListener(TimerEvent.TIMER,videoWatchedLengthTimer_Tick,false,0,true);
         erroranim.visible = false;
         displayTimer.start();
         popupTimer = new Timer(popupLength);
         popupTimer.addEventListener(TimerEvent.TIMER,popupTimer_Tick,false,0,true);
         xmlTagLoader.addEventListener(Event.COMPLETE,LoadXMLTagEvent,false,0,true);
         xmlTagLoader.addEventListener(IOErrorEvent.IO_ERROR,XmlTagErrorEvent,false,0,true);
         xmlLoader.addEventListener(Event.COMPLETE,LoadXMLEvent,false,0,true);
         xmlLoader.addEventListener(IOErrorEvent.IO_ERROR,XmlErrorEvent,false,0,true);
         xmlPayoutLoader.addEventListener(Event.COMPLETE,LoadXMLPayoutEvent,false,0,true);
         xmlPayoutLoader.addEventListener(IOErrorEvent.IO_ERROR,XmlPayoutErrorEvent,false,0,true);
         getCurrentDomain();
         ExternalInterface.addCallback("GetTimeWatched",GetTimeWatched);
         ExternalInterface.addCallback("GetVideoId",GetVideoId);
         ExternalInterface.addCallback("GetVideoGuid",GetVideoGuid);
         ExternalInterface.addCallback("GetVideoShortGuid",GetVideoShortGuid);
         createBasicContextMenu();
      }
      
      public function pickUp(param1:MouseEvent) : void
      {
         tagDialog.startDrag(false,new Rectangle(0,0,stage.width - tagDialog.width,stage.height - tagDialog.height));
      }
      
      public function dropDown(param1:MouseEvent) : void
      {
         tagDialog.stopDrag();
      }
      
      public function onPlayClick(param1:MouseEvent) : void
      {
         TogglePause();
      }
      
      public function onToggleStretchMode(param1:MouseEvent) : void
      {
         ToggleStretchMode();
         if(flashSettings != null)
         {
            flashSettings.data.stretchMode = StretchMode;
            flashSettings.flush();
         }
         ui.videoMenu.menuItemContainer.mcStretchOn.visible = !StretchMode;
      }
      
      public function onGoFullScreen(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         if(stage.displayState == StageDisplayState.NORMAL)
         {
            try
            {
               stage.displayState = StageDisplayState.FULL_SCREEN;
               stage.addEventListener(MouseEvent.MOUSE_MOVE,resetMovementTimer,false,0,true);
               resetMovementTimer();
            }
            catch(e:SecurityError)
            {
               trace("Unable to change display mode, make sure allowFullScreen is set to true in the HTML.");
            }
         }
         else if(stage.displayState == StageDisplayState.FULL_SCREEN)
         {
            try
            {
               if(hideTimeLineTimer != null)
               {
                  hideTimeLineTimer.stop();
                  hideTimeLineTimer.removeEventListener(TimerEvent.TIMER,hideTimeLine);
               }
               stage.removeEventListener(MouseEvent.MOUSE_MOVE,resetMovementTimer);
               stage.displayState = StageDisplayState.NORMAL;
               if(!ui.visible)
               {
                  video.y -= 12.5;
                  ui.visible = true;
               }
            }
            catch(e:SecurityError)
            {
               trace("Unable to change display mode, make sure allowFullScreen is set to true in the HTML.");
            }
         }
      }
      
      public function resetMovementTimer(param1:MouseEvent = null) : void
      {
         if(ui.visible)
         {
            if(hideTimeLineTimer != null)
            {
               hideTimeLineTimer.stop();
               hideTimeLineTimer.removeEventListener(TimerEvent.TIMER,hideTimeLine);
            }
            hideTimeLineTimer = new Timer(3000,1);
            hideTimeLineTimer.addEventListener(TimerEvent.TIMER,hideTimeLine,false,0,true);
            hideTimeLineTimer.start();
         }
         else
         {
            video.y -= 12.5;
            ui.visible = true;
         }
      }
      
      public function hideTimeLine(param1:TimerEvent) : void
      {
         ui.visible = false;
         video.y += 12.5;
      }
      
      public function UpdateTimecode() : void
      {
         ui.VideoGadget.txtTimecode.text = CurrentPosition;
         ui.VideoGadget.txtDuration.text = Duration;
         ui.VideoGadget.txtQuality.text = QUALITY;
      }
      
      public function UpdatePlayButton() : void
      {
         ui.btnPlay.visible = IsPaused;
         ui.btnPause.visible = !IsPaused;
      }
      
      public function UpdateVolumeUI() : void
      {
         var _loc1_:Number = Volume;
         trace(_loc1_);
         ui.VolumeLevelContainer.ProgressBar.width = (ui.VolumeLevelTrack.width - ui.VolumeLevelContainer.ProgressBarKnob.width - 4) * _loc1_;
         ui.VolumeLevelContainer.ProgressBarKnob.x = ui.VolumeLevelContainer.ProgressBar.width;
      }
      
      public function UpdateBufferBar() : void
      {
         var _loc1_:Number = CurrentBufferPercentage;
         var _loc2_:Number = CurrentBufferStartPercentage;
         var _loc3_:Number = ui.ProgressBarTrack.width - 4 - (ui.BufferBar.x - ui.ProgressBarTrack.x);
         ui.BufferBar.width = _loc3_ * _loc1_;
         ui.txtBufferStatus.autoSize = TextFieldAutoSize.RIGHT;
         ui.txtBufferStatus.alpha = 0.08;
         if(_loc1_ < 1)
         {
            ui.txtBufferStatus.text = Math.floor(_loc1_ * 100) + "%";
         }
         else
         {
            ui.txtBufferStatus.text = "DOWNLOAD COMPLETE";
         }
         ui.BufferBar.x = ui.ProgressBarTrack.x + 2 + (ui.ProgressBarTrack.width - 4) * _loc2_;
         ui.txtBufferStatus.x = ui.BufferBar.x + ui.BufferBar.width - ui.txtBufferStatus.width;
         if(ui.txtBufferStatus.x > ui.ProgressBarContainer.x + ui.ProgressBarContainer.width + 2)
         {
            ui.txtBufferStatus.visible = true;
         }
         else
         {
            ui.txtBufferStatus.visible = false;
         }
      }
      
      public function mouseReleased(param1:MouseEvent) : void
      {
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         if(progressSeek || progressDrag)
         {
            mcTimelineBubble.visible = false;
            thumbPreviewBox.visible = false;
            _loc2_ = Number(ui.ProgressBarContainer.x);
            _loc3_ = ui.ProgressBarTrack.width - 4 - ui.ProgressBarContainer.ProgressBarKnob.width;
            _loc4_ = param1.stageX - ui.ProgressBarContainer.ProgressBarKnob.width / 2;
            if(progressDrag)
            {
               trace("ProgressBarContainer.x: " + ui.ProgressBarContainer.x);
               _loc4_ = ui.ProgressBarContainer.x + ui.ProgressBarContainer.ProgressBarKnob.x;
            }
            if(_loc4_ < _loc2_)
            {
               _loc4_ = _loc2_;
            }
            if(_loc4_ > _loc2_ + _loc3_)
            {
               _loc4_ = _loc2_ + _loc3_;
            }
            _loc5_ = 1 - (_loc3_ - (_loc4_ - _loc2_)) / _loc3_;
            ui.ProgressBarContainer.ProgressBarKnob.stopDrag();
            SeekToPerc(_loc5_);
            EnableProgressBarUpdates();
         }
         if(volumeSeek || volumeDrag)
         {
            _loc2_ = Number(ui.VolumeLevelContainer.x);
            _loc3_ = ui.VolumeLevelTrack.width - 4 - ui.VolumeLevelContainer.ProgressBarKnob.width;
            _loc4_ = param1.stageX - ui.VolumeLevelContainer.ProgressBarKnob.width / 2;
            if(volumeDrag)
            {
               _loc4_ = ui.VolumeLevelContainer.x + ui.VolumeLevelContainer.ProgressBarKnob.x;
            }
            trace("POS:" + _loc4_);
            if(_loc4_ < _loc2_)
            {
               _loc4_ = _loc2_;
            }
            if(_loc4_ > _loc2_ + _loc3_)
            {
               _loc4_ = _loc2_ + _loc3_;
            }
            _loc5_ = 1 - (_loc3_ - (_loc4_ - _loc2_)) / _loc3_;
            ui.VolumeLevelContainer.ProgressBarKnob.stopDrag();
            SetVolume(_loc5_);
            trace(_loc5_);
            if(flashSettings != null)
            {
               flashSettings.data.volumeLevel = _loc5_;
               flashSettings.flush();
            }
            if(volumeSeek)
            {
               UpdateVolumeUI();
            }
         }
         progressSeek = false;
         progressDrag = false;
         volumeSeek = false;
         volumeDrag = false;
      }
      
      public function onTimelineOver(param1:MouseEvent) : void
      {
      }
      
      public function onTimelineOut(param1:MouseEvent) : void
      {
         if(!ui.ProgressBarTrack.hitTestPoint(param1.stageX,param1.stageY,true))
         {
            mcTimelineBubble.visible = false;
            PreviewBoxHide();
         }
      }
      
      public function onTimelineHover(param1:MouseEvent) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:String = null;
         if(ui.ProgressBarTrack.hitTestPoint(param1.stageX,param1.stageY,true))
         {
            _loc2_ = 0;
            _loc3_ = 0;
            _loc4_ = 0;
            _loc5_ = 0;
            _loc2_ = Number(ui.ProgressBarContainer.x);
            _loc3_ = ui.ProgressBarTrack.width - 4 - ui.ProgressBarContainer.ProgressBarKnob.width;
            if((_loc4_ = param1.stageX - ui.ProgressBarContainer.ProgressBarKnob.width / 2) < _loc2_)
            {
               _loc4_ = _loc2_;
            }
            if(_loc4_ > _loc2_ + _loc3_)
            {
               _loc4_ = _loc2_ + _loc3_;
            }
            _loc5_ = 1 - (_loc3_ - (_loc4_ - _loc2_)) / _loc3_;
            _loc6_ = ConvertToMSS(_loc5_ * DurationSeconds);
            mcTimelineBubble.label.text = _loc6_;
            mcTimelineBubble.x = stage.mouseX;
            mcTimelineBubble.visible = true;
            thumbPreviewBox.x = stage.mouseX - mcTimelineBubble.width / 2 - 1;
            PreviewBoxShow(_loc5_ * DurationSeconds,_loc6_);
         }
         else
         {
            PreviewBoxHide();
            mcTimelineBubble.visible = false;
         }
      }
      
      public function onTimelineScrub(param1:MouseEvent) : void
      {
         if(!progressDrag)
         {
            progressSeek = true;
         }
      }
      
      public function onVolumeScrub(param1:MouseEvent) : void
      {
         if(!volumeDrag)
         {
            volumeSeek = true;
         }
      }
      
      public function onTimelineDrag(param1:MouseEvent) : void
      {
         trace("TIMELINE DRAG");
         progressDrag = true;
         ui.ProgressBarContainer.ProgressBarKnob.startDrag(false,new Rectangle(0,0,Math.round(ui.ProgressBarTrack.width) - ui.ProgressBarContainer.ProgressBarKnob.width - 4,0));
         DisableProgressBarUpdates();
      }
      
      public function onVolumeDrag(param1:MouseEvent) : void
      {
         volumeDrag = true;
         ui.VolumeLevelContainer.ProgressBarKnob.startDrag(false,new Rectangle(0,0,Math.round(ui.VolumeLevelTrack.width) - ui.VolumeLevelContainer.ProgressBarKnob.width - 4,0));
      }
      
      public function mouseMove(param1:MouseEvent) : void
      {
         if(progressDrag)
         {
            ui.ProgressBarContainer.ProgressBar.width = ui.ProgressBarContainer.ProgressBarKnob.x - ui.ProgressBarContainer.ProgressBar.x;
         }
         if(volumeDrag)
         {
            ui.VolumeLevelContainer.ProgressBar.width = ui.VolumeLevelContainer.ProgressBarKnob.x - ui.VolumeLevelContainer.ProgressBar.x;
         }
      }
      
      public function onVolumeDown(param1:MouseEvent) : void
      {
         SetVolumeDown();
         UpdateVolumeUI();
      }
      
      public function onVolumeUp(param1:MouseEvent) : void
      {
         SetVolumeUp();
         UpdateVolumeUI();
      }
      
      public function frameHandler(param1:Event) : void
      {
         UpdatePlayButton();
         UpdateTimecode();
         UpdateBufferBar();
         if(!init)
         {
            UpdateVolumeUI();
         }
         init = true;
      }
      
      public function get IsPlaying() : Boolean
      {
         return isPlaying;
      }
      
      public function get IsPaused() : Boolean
      {
         return isPaused;
      }
      
      public function get Volume() : Number
      {
         return getVolume();
      }
      
      public function get AllowProgressUpdate() : Boolean
      {
         return allowProgressUpdate;
      }
      
      public function get CurrentPosition() : String
      {
         return currentPosition;
      }
      
      public function get CurrentPositionOffset() : Number
      {
         return currentPositionOffset;
      }
      
      public function get CurrentBufferStartPercentage() : Number
      {
         if(metaReceived)
         {
            return currentPositionOffset / metaData.duration;
         }
         return 0;
      }
      
      public function get CurrentBufferPercentage() : Number
      {
         return currentBufferPercentage;
      }
      
      public function get Duration() : String
      {
         return currentDuration;
      }
      
      public function get DurationSeconds() : Number
      {
         if(metaReceived)
         {
            return metaData.duration;
         }
         return 0;
      }
      
      public function get StretchMode() : Boolean
      {
         return MAINTAINASPECT;
      }
      
      public function set StretchMode(param1:Boolean) : void
      {
         MAINTAINASPECT = param1;
      }
      
      internal function GetTimeWatched() : Number
      {
         return totalTimeWatched;
      }
      
      internal function GetVideoId() : Number
      {
         return VIDEOID;
      }
      
      internal function GetVideoGuid() : String
      {
         return GUID;
      }
      
      internal function GetVideoShortGuid() : String
      {
         return SHORTGUID;
      }
      
      internal function videoWatchedLengthTimer_Tick(param1:TimerEvent) : *
      {
         totalTimeWatched += videoWatchedLengthTimer.delay;
         if(totalTimeWatched / 1000 >= PayoutTriggerSeconds && !payoutTriggered)
         {
            payoutTriggered = true;
            trace("Triggering Payout request");
            Payout();
         }
      }
      
      internal function onFrameEvent(param1:Event) : void
      {
         if(stage.stageWidth > 0 && stage.stageHeight > 0)
         {
            trace("First Frame Loaded.");
            setProgressBarPosition(0);
            removeEventListener(Event.ENTER_FRAME,onFrameEvent);
            CreateConnection();
         }
      }
      
      internal function getCurrentDomain() : *
      {
         var lc:LocalConnection = new LocalConnection();
         this.CURRENTDOMAIN = lc.domain;
         try
         {
            this.CURRENTURL = ExternalInterface.call("window.location.href.toString");
         }
         catch(err:Error)
         {
            this.CURRENTURL = this.loaderInfo.loaderURL;
         }
         if(this.CURRENTURL == null || this.CURRENTURL.length == 0)
         {
            this.CURRENTURL = this.loaderInfo.loaderURL;
         }
         if(this.CURRENTURL == null || this.CURRENTURL.length == 0)
         {
            this.CURRENTURL = this.CURRENTDOMAIN;
         }
         if(this.REFERER.length > 0)
         {
            this.CURRENTURL = this.REFERER;
         }
         trace("Current Domain is: " + this.CURRENTDOMAIN);
      }
      
      public function Popup(param1:String, param2:String = "") : *
      {
         trace("POPUP(\'" + param1 + "\')");
         mcPopup.visible = true;
         mcPopup.gotoAndPlay("start");
         mcPopup.mcText.txtMessage.text = param1;
         if(param2 != "")
         {
            mcPopup.gotoUrl = param2;
            mcPopup.useHandCursor = true;
            mcPopup.buttonMode = true;
            mcPopup.addEventListener(MouseEvent.CLICK,popupClick,false,0,true);
         }
         popupTimer.start();
      }
      
      internal function popupTimer_Tick(param1:TimerEvent) : void
      {
         mcPopup.gotoAndPlay("close");
         mcPopup.removeEventListener(MouseEvent.CLICK,popupClick);
         popupTimer.stop();
      }
      
      internal function popupClick(param1:MouseEvent) : *
      {
         trace("Loading URL");
         navigateToURL(new URLRequest(mcPopup.gotoUrl));
      }
      
      public function PreviewBoxShow(param1:Number, param2:String) : *
      {
         var _loc3_:Number = NaN;
         if(swfLoader == null || !swfLoader.visible)
         {
            if(imageLoader != null)
            {
               imageLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,imageLoading);
               imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,imageLoaded);
               imageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,imageLoadError);
            }
            if(loadTimer != null)
            {
               loadTimer.removeEventListener("timer",timerHandler);
            }
            _loc3_ = Math.floor(param1 / 20);
            CURRENTTHUMBPOSITION = _loc3_ == 0 ? 1 : _loc3_;
            loadTimer = new Timer(50,1);
            loadTimer.addEventListener("timer",timerHandler);
            loadTimer.start();
         }
      }
      
      public function PreviewBoxHide() : *
      {
         thumbPreviewBox.visible = false;
         if(loadTimer != null)
         {
            loadTimer.removeEventListener("timer",timerHandler);
         }
      }
      
      public function timerHandler(param1:TimerEvent) : void
      {
         LoadImage();
         if(!thumbPreviewBox.visible)
         {
            thumbPreviewBox.visible = true;
            thumbPreviewBox.gotoAndPlay("start");
            thumbPreviewBox.errorAnimThumb.visible = false;
         }
      }
      
      public function LoadImage() : *
      {
         if(SRC != "")
         {
            loaderContext.checkPolicyFile = true;
            currentImageUrl = SERVER + SRC + CURRENTTHUMBPOSITION + THUMBEXTENSION;
            if(imageLoader != null)
            {
               try
               {
                  imageLoader.unload();
                  imageLoader.close();
               }
               catch(error:Error)
               {
               }
               imageLoader = null;
            }
            imageLoader = new Loader();
            imageLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,imageLoading);
            imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,imageLoaded);
            imageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,imageLoadError);
            imageLoader.load(new URLRequest(currentImageUrl),loaderContext);
         }
      }
      
      private function imageLoaded(param1:Event) : void
      {
         trace("Image loaded.");
         newImage = imageLoader.contentLoaderInfo.content;
         if(newImage != null)
         {
            newImage.x = newImage.y = -1;
            newImage.width = thumbPreviewBox.thumbBorder.width - 1;
            newImage.height = thumbPreviewBox.thumbBorder.height - 1;
            if(thumbPreviewBox.picBox.numChildren > 0)
            {
               thumbPreviewBox.picBox.removeChildAt(0);
            }
            thumbPreviewBox.picBox.addChildAt(DisplayObject(newImage),0);
            thumbPreviewBox.innerText.txtMessage.text = "";
            thumbPreviewBox.errorAnimThumb.visible = false;
         }
      }
      
      private function imageLoading(param1:ProgressEvent) : void
      {
         thumbPreviewBox.errorAnimThumb.visible = true;
         var _loc2_:Number = param1.bytesLoaded / param1.bytesTotal * 100;
         trace("  - loading " + _loc2_ + "%");
      }
      
      private function imageLoadError(param1:IOErrorEvent) : void
      {
         thumbPreviewBox.innerText.txtMessage.text = "FAILED";
      }
      
      internal function previewClick(param1:MouseEvent) : *
      {
         var _loc2_:uint = 16763904;
         var _loc3_:uint = 80;
         var _loc4_:uint = 9;
         thumbPreviewBox.graphics.beginFill(_loc2_);
         thumbPreviewBox.graphics.drawRoundRect(0,0,_loc3_,_loc3_,_loc4_);
         thumbPreviewBox.graphics.endFill();
      }
      
      public function LoadXML() : void
      {
         var _loc1_:String = "";
         _loc1_ = this.XMLURL + this.VIDEOIDENTIFIER;
         if(this.FORMAT > 0)
         {
            _loc1_ += "&profileid=" + this.FORMAT;
         }
         trace("@@@ Loading " + _loc1_ + " @@@");
         var _loc2_:URLRequest = new URLRequest(_loc1_);
         _loc2_.method = URLRequestMethod.POST;
         var _loc3_:URLVariables = new URLVariables();
         _loc3_.ASPSESSID = aspsessid;
         _loc3_.referer = this.CURRENTURL;
         _loc3_.domain = this.CURRENTDOMAIN;
         _loc2_.data = _loc3_;
         xmlLoader.load(_loc2_);
      }
      
      public function LoadTagXML() : void
      {
         var _loc1_:String = this.TAGXMLURL + this.VIDEOID;
         trace("@@@ Loading " + _loc1_ + " @@@");
         var _loc2_:URLRequest = new URLRequest(_loc1_);
         _loc2_.method = URLRequestMethod.POST;
         var _loc3_:URLVariables = new URLVariables();
         _loc3_.ASPSESSID = aspsessid;
         _loc2_.data = _loc3_;
         xmlTagLoader.load(_loc2_);
      }
      
      private function Payout() : void
      {
         trace("Triggering payout @ " + this.XMLURL + this.VIDEOIDENTIFIER + "&p=1");
         var _loc1_:URLRequest = new URLRequest(this.XMLURL + this.VIDEOIDENTIFIER + "&p=1");
         _loc1_.method = URLRequestMethod.POST;
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.ASPSESSID = aspsessid;
         _loc2_.referer = this.CURRENTURL;
         _loc2_.domain = this.CURRENTDOMAIN;
         _loc1_.data = _loc2_;
         xmlPayoutLoader.load(_loc1_);
      }
      
      private function PausePayoutTimer() : *
      {
         trace("PAUSE Payout Timer");
         videoWatchedLengthTimer.stop();
      }
      
      private function ResumePayoutTimer() : *
      {
         trace("RESUME Payout Timer");
         videoWatchedLengthTimer.start();
      }
      
      private function ResetPayoutTimer() : *
      {
         trace("RESET Payout Timer");
         ui.VideoGadget.txtPayout.visible = false;
         totalTimeWatched = 0;
         payoutTriggered = false;
      }
      
      public function ToggleStretchMode() : *
      {
         this.MAINTAINASPECT = !this.MAINTAINASPECT;
         SetVideoAspect();
      }
      
      public function AddVideoViewHit() : void
      {
      }
      
      public function DrawSlider() : *
      {
         var _loc1_:Number = Number(ui.ProgressBarContainer.x);
         var _loc2_:Number = ui.ProgressBarTrack.width - 4 - ui.ProgressBarContainer.ProgressBarKnob.width;
         var _loc3_:SliderThumb = new SliderThumb(new BitmapData(4,ui.ProgressBarTrack.height),stage);
         slider = new RangeSlider(new BitmapData(1,1,false,0),_loc3_,_loc2_);
         slider.x = _loc1_ + ui.ProgressBarContainer.ProgressBarKnob.width / 2;
         slider.y = ui.ProgressBarTrack.y + slider.height / 2;
         slider.addEventListener(Event.CHANGE,updateDialog);
         ui.addChild(slider);
         updateDialog();
      }
      
      private function updateDialog(param1:Event = null) : void
      {
         var _loc2_:Number = ui.ProgressBarTrack.width - 4 - ui.ProgressBarContainer.ProgressBarKnob.width;
         var _loc3_:* = Number(metaData.duration) * slider.min / _loc2_;
         var _loc4_:* = Number(metaData.duration) * slider.max / _loc2_;
         tagDialog.startTime.text = ConvertToMMSS(_loc3_);
         tagDialog.endTime.text = ConvertToMMSS(_loc4_);
      }
      
      private function tsDownHandler(param1:Event) : *
      {
         isTagging = true;
         var _loc2_:Sprite = Sprite(param1.target);
         var _loc3_:Rectangle = new Rectangle(ui.ProgressBarTrack.x,ui.ProgressBarTrack.y,ui.ProgressBarTrack.width - _loc2_.width,ui.ProgressBarTrack.height - _loc2_.height);
         _loc2_.addEventListener(MouseEvent.MOUSE_MOVE,mouseMoveHandler);
         _loc2_.startDrag(false,_loc3_);
      }
      
      private function tsUpHandler(param1:Event) : *
      {
         var _loc2_:Sprite = Sprite(param1.target);
         _loc2_.stopDrag();
         _loc2_.removeEventListener(MouseEvent.MOUSE_MOVE,tsUpHandler);
         isTagging = false;
      }
      
      private function mouseMoveHandler(param1:MouseEvent) : void
      {
         param1.updateAfterEvent();
      }
      
      internal function openDialog(param1:MouseEvent) : void
      {
         ui.videoMenu.gotoAndPlay("down1");
         if(!tagDialog.visible)
         {
            tagDialog.visible = true;
            DrawSlider();
         }
      }
      
      internal function closeDialog(param1:MouseEvent) : void
      {
         tagDialog.visible = false;
         ui.removeChild(slider);
      }
      
      public function sendTag(param1:MouseEvent) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc2_:* = tagDialog.tagCombo.selectedItem.data;
         if(slider != null && _loc2_ != "None")
         {
            _loc3_ = ui.ProgressBarTrack.width - 4 - ui.ProgressBarContainer.ProgressBarKnob.width;
            _loc4_ = slider.min;
            _loc5_ = slider.max;
            trace("Min: " + _loc4_ + " Max: " + _loc5_);
            if(_loc4_ == 0 && (_loc5_ == 0 || _loc5_ == _loc3_))
            {
               Popup("Please use the timeline to mark your tag.");
               return;
            }
            _loc6_ = Number(metaData.duration) * _loc4_ / _loc3_;
            _loc7_ = Number(metaData.duration) * _loc5_ / _loc3_;
            trace("Sending: " + _loc2_ + ", " + _loc6_ + ", " + _loc7_);
            addTag(_loc2_,Math.round(_loc6_),Math.round(_loc7_));
         }
         tagDialog.visible = false;
         ui.removeChild(slider);
      }
      
      private function addTag(param1:String, param2:Number, param3:Number) : void
      {
         var _loc4_:URLRequest;
         (_loc4_ = new URLRequest(ADDTAGURL)).method = URLRequestMethod.POST;
         var _loc5_:URLVariables;
         (_loc5_ = new URLVariables()).ASPSESSID = aspsessid;
         _loc5_.videoid = VIDEOID;
         _loc5_.start = param2;
         _loc5_.end = param3;
         _loc5_.tag = param1;
         _loc4_.data = _loc5_;
         var _loc6_:URLLoader;
         (_loc6_ = new URLLoader()).addEventListener(Event.COMPLETE,onTagSubmitComplete,false,0,true);
         _loc6_.addEventListener(IOErrorEvent.IO_ERROR,onTagSubmitError,false,0,true);
         _loc6_.load(_loc4_);
      }
      
      internal function onTagSubmitComplete(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(param1.target.data != "Ok")
         {
            Popup(param1.target.data);
         }
         else
         {
            Popup("Tag submitted successfully");
            _loc2_ = 0;
            while(_loc2_ < numberOfTags)
            {
               ui.removeChild(ui.getChildByName("tag_" + _loc2_));
               _loc2_++;
            }
            LoadTagXML();
         }
      }
      
      internal function onTagSubmitError(param1:IOErrorEvent) : *
      {
         ShowMessage("ERROR SUBMITTING NEW TAG\n" + param1);
      }
      
      internal function LoadXMLEvent(param1:Event) : void
      {
         xmlData = new XML(param1.target.data);
         ParseXML(xmlData);
      }
      
      internal function LoadXMLTagEvent(param1:Event) : void
      {
         xmlTagData = new XML(param1.target.data);
         ParseTagXML(xmlTagData);
      }
      
      internal function LoadXMLPayoutEvent(param1:Event) : void
      {
         xmlPayoutData = new XML(param1.target.data);
         ParsePayoutXML(xmlPayoutData);
      }
      
      internal function XmlErrorEvent(param1:IOErrorEvent) : void
      {
         trace("Error loading response XML - " + param1.text);
         var _loc2_:String = "";
         if(param1.text.indexOf("Error #2032:") != -1)
         {
            _loc2_ = "Could not open xml due missing or broken script.";
         }
         else
         {
            _loc2_ = param1.text;
         }
         trace(_loc2_);
         ShowMessage(_loc2_);
      }
      
      internal function XmlTagErrorEvent(param1:IOErrorEvent) : void
      {
         trace("Error loading tag XML - " + param1.text);
         var _loc2_:String = "";
         if(param1.text.indexOf("Error #2032:") != -1)
         {
            _loc2_ = "Could not open xml due missing or broken script.";
         }
         else
         {
            _loc2_ = param1.text;
         }
         trace(_loc2_);
         ShowMessage(_loc2_);
      }
      
      internal function XmlPayoutErrorEvent(param1:IOErrorEvent) : void
      {
         trace("Error loading payout response XML - " + param1.text);
         var _loc2_:String = "";
         if(param1.text.indexOf("Error #2032:") != -1)
         {
            _loc2_ = "Could not open xml due missing or broken script.";
         }
         else
         {
            _loc2_ = param1.text;
         }
         trace(_loc2_);
      }
      
      internal function ParsePayoutXML(param1:XML) : *
      {
         var _loc4_:Boolean = false;
         var _loc5_:NewCoinFade = null;
         var _loc6_:DropShadowFilter = null;
         var _loc7_:Array = null;
         var _loc8_:Number = NaN;
         var _loc9_:DingSound = null;
         var _loc10_:SoundChannel = null;
         var _loc11_:SoundTransform = null;
         var _loc2_:XMLList = param1.error;
         var _loc3_:XMLList = param1.video;
         if(_loc2_.length() > 0 && _loc2_[0].toString().length > 0)
         {
            trace("XML Payout Error: " + _loc2_[0]);
         }
         if(_loc3_.length() > 0)
         {
            _loc4_ = false;
            if(_loc3_.payout.toLowerCase() == "true")
            {
               _loc4_ = true;
            }
            else if(_loc3_.payout.toLowerCase() == "false")
            {
               _loc4_ = false;
            }
            else if(_loc3_.payout.toLowerCase() == "alreadypaid")
            {
               _loc4_ = false;
               Popup("You have previously been paid for this video!");
            }
            if(_loc4_)
            {
               trace("PAYOUT SUCCESSFUL");
               (_loc5_ = new NewCoinFade()).x = 473;
               _loc5_.y = 390;
               _loc5_.width = 28.2;
               _loc5_.height = 28.8;
               (_loc6_ = new DropShadowFilter()).color = 0;
               _loc6_.blurX = _loc6_.blurY = 5;
               _loc6_.angle = 100;
               _loc6_.alpha = 0.5;
               _loc6_.distance = 5;
               _loc7_ = new Array(_loc6_);
               _loc5_.filters = _loc7_;
               _loc8_ = getChildIndex(ui);
               addChildAt(_loc5_,_loc8_);
               setChildIndex(ui,_loc8_ + 1);
               trace("playing sound");
               _loc9_ = new DingSound();
               _loc10_ = new SoundChannel();
               _loc11_ = new SoundTransform();
               _loc10_ = _loc9_.play();
               _loc11_.volume = getVolume();
               _loc10_.soundTransform = _loc11_;
               ui.VideoGadget.txtPayout.visible = true;
               try
               {
                  ExternalInterface.call("PayoutSuccessful");
               }
               catch(error:Error)
               {
               }
            }
            else
            {
               trace("PAYOUT UN-SUCCESSFUL");
            }
         }
      }
      
      internal function ParseXML(param1:XML) : *
      {
         var _loc4_:XMLList = null;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc2_:XMLList = param1.error;
         var _loc3_:XMLList = param1.video;
         if(_loc2_.length() > 0 && _loc2_[0].toString().length > 0)
         {
            trace("XML Error: " + _loc2_[0]);
            ShowMessage("Error: " + _loc2_[0]);
         }
         if(_loc3_.length() > 0)
         {
            trace(_loc3_);
            CLICKURL = _loc3_.url;
            CLICKURLWINDOW = _loc3_.urlwindow;
            VIDEOURL = _loc3_.src;
            AUTOPLAY = toBoolean(_loc3_.autoplay);
            TITLE = _loc3_.title;
            DATEADDED = _loc3_.dateadded;
            RATING = _loc3_.rating;
            VIDEOID = _loc3_.videoid;
            GUID = _loc3_.guid;
            SHORTGUID = _loc3_.friendlyguid;
            PayoutTriggerSeconds = Number(_loc3_.payouttrigger);
            QUALITY = _loc3_.quality;
            VIDEOBITRATE = Number(_loc3_.videobitrate);
            AUDIOBITRATE = Number(_loc3_.audiobitrate);
            PROFILENAME = _loc3_.profilename;
            VIDEOCODEC = _loc3_.videocodec;
            REGISTERED = toBoolean(_loc3_.registered);
            SHOWPOPUPS = toBoolean(_loc3_.popups);
            _loc4_ = _loc3_.post_roll;
            _loc5_ = 0;
            while(_loc5_ < _loc4_.Video.length())
            {
               _loc6_ = String(_loc4_.Video[_loc5_].Title.text());
               _loc7_ = String(_loc4_.Video[_loc5_].Thumbnail.text());
               _loc8_ = String(_loc4_.Video[_loc5_].Url.text());
               _loc9_ = String(_loc4_.Video[_loc5_].Views.text());
               relVideos.push({
                  "art":_loc7_,
                  "title":_loc6_,
                  "views":_loc9_,
                  "link":_loc8_,
                  "loaded":false
               });
               _loc5_++;
            }
            SRC = CreateHexPath(GUID,"/") + "1_";
            trace("PLAYING " + VIDEOURL);
            PlayVideo(VIDEOURL);
         }
      }
      
      internal function ParseTagXML(param1:XML) : *
      {
         var _loc5_:DataProvider = null;
         var _loc6_:int = 0;
         var _loc7_:TextFormat = null;
         var _loc8_:TextFormat = null;
         var _loc9_:String = null;
         var _loc10_:* = undefined;
         var _loc11_:int = 0;
         var _loc12_:MovieClip = null;
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         var _loc15_:* = undefined;
         var _loc16_:* = undefined;
         var _loc17_:* = undefined;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:* = undefined;
         var _loc2_:XMLList = param1.error;
         var _loc3_:XMLList = param1.timeLineTags.tag;
         var _loc4_:XMLList = param1.assignmentTags.tag;
         if(_loc2_.length() > 0 && _loc2_[0].toString().length > 0)
         {
            trace("XML Error: " + _loc2_[0]);
            ShowMessage("Error: " + _loc2_[0]);
            return;
         }
         if(_loc4_.length() > 0)
         {
            _loc5_ = new DataProvider();
            _loc6_ = 0;
            while(_loc6_ < _loc4_.length())
            {
               _loc9_ = _loc4_[_loc6_].tagName.text();
               _loc5_.addItem({
                  "label":_loc9_,
                  "data":_loc9_
               });
               _loc6_++;
            }
            tagDialog.tagCombo.dataProvider = _loc5_;
            (_loc7_ = new TextFormat("FFF Corporate",8,16763904)).align = "center";
            _loc8_ = new TextFormat("FFF Corporate",8,0);
            tagDialog.tagCombo.textField.setStyle("textFormat",_loc7_);
            tagDialog.tagCombo.dropdown.setRendererStyle("textFormat",_loc8_);
            numberOfTags = _loc3_.length();
            if(numberOfTags > 0)
            {
               _loc10_ = ui.ProgressBarTrack.y + ui.ProgressBarTrack.height;
               _loc11_ = 0;
               while(_loc11_ < _loc3_.length())
               {
                  (_loc12_ = new MovieClip()).name = "tag_" + _loc11_;
                  _loc13_ = 16777215 * Math.random();
                  _loc14_ = _loc3_[_loc11_].startTime.text();
                  _loc15_ = _loc3_[_loc11_].endTime.text();
                  _loc12_.tagName = _loc3_[_loc11_].tagName.text();
                  _loc12_.startTime = _loc14_;
                  _loc12_.endTime = _loc15_;
                  _loc12_.transparency = Number(_loc3_[_loc11_].timeLineWeight.text()) * 0.2;
                  _loc16_ = Number(_loc14_) / Number(metaData.duration);
                  _loc17_ = Number(_loc15_) / Number(metaData.duration);
                  _loc18_ = Number(ui.ProgressBarContainer.x);
                  _loc20_ = (_loc19_ = ui.ProgressBarTrack.width - 4 - ui.ProgressBarContainer.ProgressBarKnob.width) * (_loc17_ - _loc16_);
                  _loc12_.graphics.beginFill(_loc13_);
                  _loc12_.graphics.drawRect(1,0,_loc20_ - 1,5);
                  _loc12_.graphics.endFill();
                  _loc12_.graphics.lineStyle(2,_loc13_,1,false,"normal","square");
                  _loc12_.graphics.moveTo(0,-10);
                  _loc12_.graphics.lineTo(0,4);
                  _loc12_.graphics.moveTo(_loc20_,-10);
                  _loc12_.graphics.lineTo(_loc20_,4);
                  _loc12_.alpha = _loc12_.transparency;
                  _loc12_.y = _loc10_;
                  _loc12_.x = _loc19_ - (1 - _loc16_) * _loc19_ + ui.ProgressBarContainer.ProgressBarKnob.width / 2 + _loc18_;
                  _loc12_.addEventListener(MouseEvent.MOUSE_OVER,onTagOver,false,0,true);
                  _loc12_.addEventListener(MouseEvent.MOUSE_OUT,onTagOut,false,0,true);
                  _loc12_.addEventListener(MouseEvent.CLICK,onTagClick,false,0,true);
                  ui.addChild(_loc12_);
                  _loc12_.depth = ui.getChildIndex(_loc12_);
                  _loc11_++;
               }
            }
            return;
         }
      }
      
      public function PlayVideo(param1:String) : void
      {
         originalDuration = -1;
         this.VIDEOURL = param1;
         metaReceived = false;
         metaData = null;
         erroranim.visible = false;
         trace("@@@ Loading " + param1 + " @@@");
         trace("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
         if(stream != null)
         {
            if(this.STARTTIMECODE > 0)
            {
               video.visible = false;
            }
            stream.play(this.VIDEOURL + "?start=0");
         }
         else
         {
            trace("ERROR: Stream object is null or connection is closed!");
         }
      }
      
      public function pauseOnScreenClick() : void
      {
         var playerRegion:Sprite = new Sprite();
         playerRegion.graphics.beginFill(0,0);
         playerRegion.graphics.drawRect(0,0,stage.width,380);
         playerRegion.graphics.endFill();
         playerRegion.x = 0;
         playerRegion.y = 0;
         playerRegion.addEventListener(MouseEvent.CLICK,function():*
         {
            TogglePause();
         });
         addChildAt(playerRegion,0);
      }
      
      public function Pause() : void
      {
         if(stream != null)
         {
            PausePayoutTimer();
            stream.pause();
            isPaused = true;
         }
      }
      
      public function TogglePause() : void
      {
         if(stream != null)
         {
            if(isPlaying)
            {
               if(!isPaused)
               {
                  PausePayoutTimer();
                  stream.pause();
               }
               else
               {
                  ResumePayoutTimer();
                  stream.resume();
                  AddVideoViewHit();
               }
               isPaused = !isPaused;
            }
            else
            {
               ResumePayoutTimer();
               stream.seek(0);
               isPaused = false;
               AddVideoViewHit();
            }
         }
      }
      
      public function EnableProgressBarUpdates() : void
      {
         trace("EnableProgressBarUpdates");
         allowProgressUpdate = false;
         updateOnNextSeek = true;
      }
      
      public function DisableProgressBarUpdates() : void
      {
         trace("DisableProgressBarUpdates");
         allowProgressUpdate = false;
         updateOnNextSeek = false;
      }
      
      public function SeekToTime(param1:Number) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc2_:Number = param1 / Number(metaData.duration);
         if(param1 <= Number(metaData.duration))
         {
            PausePayoutTimer();
            if(param1 >= currentPositionOffset && param1 <= currentBufferPosition || !STREAMHACK)
            {
               if(flvPositions == null)
               {
                  _loc3_ = param1 - currentPositionOffset;
                  trace("SEEKING TO " + ConvertToMMSS(param1) + " (REL: " + ConvertToMMSS(_loc3_) + "), " + _loc2_ + "%");
                  stream.seek(_loc3_);
               }
               else
               {
                  trace("SEEKING TO " + ConvertToMMSS(param1) + ", " + _loc2_ + "%");
                  stream.seek(param1);
               }
            }
            else if(flvPositions == null)
            {
               trace("PLAY AT " + ConvertToMMSS(param1) + ", " + _loc2_ + "%");
               currentPositionOffset = param1;
               currentBufferPercentage = 0;
               stream.play(this.VIDEOURL + "?start=" + param1);
            }
            else
            {
               currentPositionOffset = param1;
               _loc4_ = 0;
               _loc5_ = 0;
               if((_loc4_ = Math.floor(_loc2_ * flvTimes.length) - 1) < 0)
               {
                  _loc5_ = 0;
               }
               _loc5_ = Number(flvPositions[_loc4_]);
               trace("FLV PLAY AT " + ConvertToMMSS(param1) + ", " + _loc2_ + "%" + ", FLV Offset: " + _loc5_ + ", FLV Time: " + flvTimes[_loc4_] + ", Duration: " + ConvertToMMSS(Number(metaData.duration)));
               currentBufferPercentage = 0;
               stream.play(this.VIDEOURL + "?start=" + _loc5_);
            }
         }
         else
         {
            trace("Invalid seek position: " + param1);
         }
      }
      
      public function SeekToPerc(param1:Number) : void
      {
         var _loc2_:Number = Number(metaData.duration) * param1;
         SeekToTime(_loc2_);
      }
      
      public function SetVolume(param1:Number) : void
      {
         lastVolumeLevel = param1;
         setVolume(param1);
      }
      
      internal function ShowMessage(param1:String) : void
      {
         txtFinished.text = param1.toUpperCase();
         erroranim.visible = true;
         loadinganim.visible = false;
         txtFinished.visible = true;
         isPlaying = false;
         isPaused = true;
         video.visible = false;
      }
      
      internal function ShowDebug(param1:String) : void
      {
      }
      
      internal function OnVideoStart() : void
      {
         trace("Video started.");
         erroranim.visible = false;
         txtFinished.visible = false;
         isPlaying = true;
         isPaused = false;
         video.visible = true;
         if(swfLoader != null)
         {
            swfLoader.visible = false;
         }
      }
      
      internal function OnVideoStartPlay() : void
      {
         var _loc1_:Number = NaN;
         if(!this.REGISTERED)
         {
            if(this.SHOWPOPUPS)
            {
               if(popupMessages.length > 0)
               {
                  _loc1_ = RandRange(0,popupMessages.length - 1);
                  Popup(popupMessages[_loc1_].message,popupMessages[_loc1_].url);
               }
            }
         }
      }
      
      internal function OnVideoEnd() : void
      {
         var _loc2_:URLRequest = null;
         trace("Video ended.");
         PausePayoutTimer();
         isPlaying = false;
         isPaused = true;
         video.visible = false;
         var _loc1_:String = ExternalInterface.call("NextVideo");
         if(xmlData != null)
         {
            if(swfLoader == null)
            {
               swfLoader = new Loader();
               swfLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,onRelatedVideosLoadComplete,false,0,true);
               swfLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,onRelatedVideosLoadProgress,false,0,true);
               swfLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onRelatedVideosLoadError,false,0,true);
               _loc2_ = new URLRequest(RECOMMENDEDVIDEOSURL);
               swfLoader.load(_loc2_);
            }
            else
            {
               swfLoader.visible = true;
            }
         }
      }
      
      internal function onRelatedVideosLoadProgress(param1:ProgressEvent) : *
      {
         var _loc2_:Number = param1.bytesLoaded / param1.bytesTotal;
         _loc2_ = Math.round(_loc2_ * 100);
         trace("loading related videos: " + _loc2_ + "%");
      }
      
      internal function onRelatedVideosLoadError(param1:IOErrorEvent) : *
      {
         ShowMessage("ERROR LOADING RECOMMENDEDVIDEOS\n" + param1);
      }
      
      internal function handleSending(param1:TimerEvent) : *
      {
         trace("Send called");
         var _loc2_:LocalConnection = new LocalConnection();
         _loc2_.allowDomain("*.uthertube.com");
         _loc2_.send("RelatedVideosDataConnection","setVideoData",relVideos);
         thumbPreviewBox.visible = false;
         swfLoader.visible = true;
      }
      
      internal function onRelatedVideosLoadComplete(param1:Event) : *
      {
         swfTimer = new Timer(1000,1);
         swfTimer.addEventListener("timer",handleSending);
         swfTimer.start();
         addChild(swfLoader);
         swfLoader.visible = false;
      }
      
      internal function CreateConnection() : void
      {
         connection = new NetConnection();
         connection.addEventListener(NetStatusEvent.NET_STATUS,netStatusEvent,false,0,true);
         connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR,securityErrorEvent,false,0,true);
         connection.client = customClient;
         if(FLASHSERVER.length == 0)
         {
            connection.connect(null);
         }
         else
         {
            connection.connect(this.FLASHSERVER);
         }
      }
      
      internal function connectStream() : void
      {
         stream = new NetStream(connection);
         stream.addEventListener(NetStatusEvent.NET_STATUS,netStatusEvent,false,0,true);
         stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR,asyncErrorEvent,false,0,true);
         customClient.onMetaData = metaDataEvent;
         stream.client = customClient;
         stream.bufferTime = this.BUFFERTIME;
         setVolume(lastVolumeLevel);
         if(video != null)
         {
            trace("removing old video object");
            removeChild(getChildByName("video"));
         }
         video = new Video();
         video.name = "video";
         video.smoothing = this.SMOOTHING;
         video.attachNetStream(stream);
         originalVolume = stream.soundTransform.volume;
         video.width = this.WIDTH;
         video.height = this.HEIGHT;
         video.visible = true;
         addChildAt(video,0);
         LoadXML();
      }
      
      internal function netStatusEvent(param1:NetStatusEvent) : void
      {
         trace("[netStatusEvent]" + param1.info.code);
         switch(param1.info.code)
         {
            case "NetConnection.Connect.Success":
               trace("Connecting stream!");
               connectStream();
               break;
            case "NetStream.Play.StreamNotFound":
               ShowMessage("Could not load video - File not found.");
               trace("Could not load video - stream not found!");
               PausePayoutTimer();
               break;
            case "NetStream.Buffer.Empty":
               if(isPlaying)
               {
                  loadinganim.visible = true;
                  PausePayoutTimer();
               }
               break;
            case "NetStream.Buffer.Full":
               loadinganim.visible = false;
               ResumePayoutTimer();
               OnVideoStartPlay();
               break;
            case "NetStream.Play.Stop":
               loadinganim.visible = false;
               OnVideoEnd();
               break;
            case "NetStream.Play.Start":
               loadinganim.visible = true;
               OnVideoStart();
               if(updateOnNextSeek)
               {
                  allowProgressUpdate = true;
               }
               break;
            case "NetStream.Seek.Notify":
               if(!isPlaying)
               {
                  OnVideoStart();
               }
               if(updateOnNextSeek)
               {
                  allowProgressUpdate = true;
               }
               break;
            case "NetStream.Seek.InvalidTime":
               loadinganim.visible = false;
               OnVideoEnd();
               if(updateOnNextSeek)
               {
                  allowProgressUpdate = true;
               }
               break;
            case "NetConnection.Connect.Failed":
               ShowMessage("Connection Failed.");
               PausePayoutTimer();
               break;
            case "NetConnection.Connect.Closed":
               ShowMessage("Connection Closed.");
               PausePayoutTimer();
               break;
            case "NetStream.Play.FileStructureInvalid":
               ShowMessage("The video file could not be found:\n" + this.VIDEOURL);
               PausePayoutTimer();
         }
      }
      
      internal function metaDataEvent(param1:Object) : void
      {
         if(!metaReceived)
         {
            metaData = param1;
            trace("*** Video Meta data received. ***");
            trace("   Meta Duration: " + metaData.duration);
            trace("   Meta Resolution: " + metaData.width + "x" + metaData.height);
            if(metaData.keyframes != null)
            {
               trace("FLV File positions received!");
               flvPositions = metaData.keyframes.filepositions;
               flvTimes = metaData.keyframes.times;
               if(this.STARTTIMECODE > 0)
               {
                  SeekToTime(this.STARTTIMECODE);
                  video.visible = true;
               }
            }
            if(originalDuration == -1)
            {
               currentDuration = ConvertToMMSS(Number(metaData.duration));
               originalDuration = Number(metaData.duration);
            }
            if(metaData.width != null && metaData.height != null)
            {
               currentVideoAspect = new Object();
               currentVideoAspect.width = Number(metaData.width);
               currentVideoAspect.height = Number(metaData.height);
               currentVideoAspect.aspect = Number(currentVideoAspect.height) / Number(currentVideoAspect.width);
               trace("   Meta Aspect: " + currentVideoAspect.aspect);
               if(this.FORCEASPECT != 0)
               {
                  currentVideoAspect.aspect = this.FORCEASPECT;
                  trace("   Forcing Aspect: " + this.FORCEASPECT);
               }
               SetVideoAspect();
            }
            else
            {
               currentVideoAspect = null;
            }
            trace("*********************************");
            metaReceived = true;
            createContextMenu();
            ResetPayoutTimer();
            LoadTagXML();
            ExternalInterface.addCallback("setPositionInFlash",getPositionFromJavaScript);
         }
      }
      
      internal function SetVideoAspect() : *
      {
         if(this.MAINTAINASPECT)
         {
            video.width = this.WIDTH;
            video.height = video.width * currentVideoAspect.aspect;
            if(video.height > this.HEIGHT)
            {
               video.height = this.HEIGHT;
               video.width = this.HEIGHT / currentVideoAspect.aspect;
            }
            trace("   [Maintain Aspect Ratio] Setting video to " + video.width + "x" + video.height);
            video.x = this.WIDTH / 2 - video.width / 2;
            video.y = this.HEIGHT / 2 - video.height / 2;
         }
         else
         {
            video.width = this.WIDTH;
            video.height = this.HEIGHT;
            video.x = video.y = 0;
            trace("   [Force Aspect Ratio] Setting video to " + video.width + "x" + video.height);
         }
      }
      
      internal function asyncErrorEvent(param1:AsyncErrorEvent) : void
      {
         trace("Async Error: " + param1);
         ShowMessage("Async Error: " + param1);
      }
      
      internal function securityErrorEvent(param1:SecurityErrorEvent) : void
      {
         trace("Security Error: " + param1);
         ShowMessage("Security Error: " + param1);
      }
      
      internal function displayTimer_Tick(param1:TimerEvent) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(stream != null)
         {
            if(metaData != null)
            {
               _loc2_ = currentPositionOffset;
               if(flvPositions != null)
               {
                  _loc2_ = 0;
               }
               _loc3_ = Number(stream.time + _loc2_) / Number(metaData.duration);
               currentPercentage = _loc3_;
               currentPosition = ConvertToMMSS(Number(stream.time + _loc2_));
               currentBufferPercentage = stream.bytesLoaded / stream.bytesTotal;
               currentBufferPosition = Number(metaData.duration) * currentBufferPercentage;
               if(_loc3_ > 1)
               {
                  _loc3_ = 1;
               }
               if(_loc3_ < 0)
               {
                  _loc3_ = 0;
               }
               if(allowProgressUpdate)
               {
                  setProgressBarPosition(_loc3_);
               }
            }
         }
      }
      
      internal function setProgressBarPosition(param1:Number) : *
      {
         var _loc2_:Number = ui.ProgressBarTrack.width - ui.ProgressBarContainer.ProgressBarKnob.width - 4;
         ui.ProgressBarContainer.ProgressBar.width = _loc2_ * param1;
         ui.ProgressBarContainer.ProgressBarKnob.x = ui.ProgressBarContainer.ProgressBar.width;
      }
      
      internal function createBasicContextMenu() : *
      {
         var _loc1_:ContextMenu = new ContextMenu();
         _loc1_.hideBuiltInItems();
         var _loc2_:ContextMenuBuiltInItems = _loc1_.builtInItems;
         _loc2_.print = true;
         var _loc3_:ContextMenuItem = new ContextMenuItem("Uthertube.com Video Player");
         _loc1_.customItems.push(_loc3_);
         var _loc4_:ContextMenuItem = new ContextMenuItem("Video loading... please wait!");
         _loc1_.customItems.push(_loc4_);
         this.contextMenu = _loc1_;
      }
      
      internal function createContextMenu() : *
      {
         var _loc1_:ContextMenu = new ContextMenu();
         _loc1_.hideBuiltInItems();
         var _loc2_:ContextMenuBuiltInItems = _loc1_.builtInItems;
         _loc2_.print = true;
         var _loc3_:ContextMenuItem = new ContextMenuItem("Uthertube.com Video Player");
         _loc1_.customItems.push(_loc3_);
         var _loc4_:ContextMenuItem;
         (_loc4_ = new ContextMenuItem("Title: " + TITLE)).enabled = false;
         _loc4_.separatorBefore = true;
         _loc1_.customItems.push(_loc4_);
         var _loc5_:String = "unknown format";
         _loc5_ = VIDEOCODEC.toUpperCase();
         var _loc6_:ContextMenuItem = new ContextMenuItem("Datarate: " + Math.round((AUDIOBITRATE + VIDEOBITRATE) / 1000) + " kbps (" + Math.floor(AUDIOBITRATE / 1000) + " kbps audio, " + Math.floor(VIDEOBITRATE / 1000) + " kbps video) " + _loc5_);
         _loc1_.customItems.push(_loc6_);
         var _loc7_:ContextMenuItem = new ContextMenuItem("Duration: " + ConvertToMSS(metaData.duration));
         _loc1_.customItems.push(_loc7_);
         var _loc8_:ContextMenuItem = new ContextMenuItem("Framerate: " + metaData.framerate + " fps");
         _loc1_.customItems.push(_loc8_);
         var _loc9_:String = "Standard Definition";
         if(QUALITY == "HD")
         {
            _loc9_ = "High Definition";
         }
         if(QUALITY == "HQ")
         {
            _loc9_ = "High Quality";
         }
         if(QUALITY == "MO")
         {
            _loc9_ = "Mobile Resolution";
         }
         var _loc10_:ContextMenuItem = new ContextMenuItem("Resolution: " + metaData.width + "x" + metaData.height + " (" + _loc9_ + ")");
         _loc1_.customItems.push(_loc10_);
         this.contextMenu = _loc1_;
      }
      
      internal function onTagOver(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         if(!isTagging)
         {
            _loc2_ = MovieClip(param1.target);
            ui.swapChildren(_loc2_,ui.getChildAt(ui.numChildren - 1));
            _loc2_.alpha = 1;
            ui.VideoGadget.txtTimecode.visible = false;
            ui.VideoGadget.txtDuration.visible = false;
            ui.VideoGadget.txtQuality.visible = false;
            ui.VideoGadget.separator.visible = false;
            ui.VideoGadget.tagName.text = param1.target.tagName;
            ui.VideoGadget.tagName.visible = true;
            ExternalInterface.call("highLightTag(\'" + _loc2_.tagName + "\')");
         }
      }
      
      internal function onTagOut(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = MovieClip(param1.target);
         _loc2_.alpha = _loc2_.transparency;
         ui.VideoGadget.txtTimecode.visible = true;
         ui.VideoGadget.txtDuration.visible = true;
         ui.VideoGadget.txtQuality.visible = true;
         ui.VideoGadget.separator.visible = true;
         ui.VideoGadget.tagName.visible = false;
         ExternalInterface.call("restoreTag(\'" + _loc2_.tagName + "\')");
      }
      
      internal function onTagClick(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:Number = NaN;
         if(!isTagging)
         {
            _loc2_ = MovieClip(param1.target);
            _loc3_ = Number(_loc2_.startTime);
            trace("Tag SeekToTime: " + _loc3_);
            SeekToTime(_loc3_);
         }
      }
      
      public function ConvertToMMSS(param1:Number) : String
      {
         var _loc2_:Number = Math.floor(param1 / 60 % 60);
         var _loc3_:Number = Math.floor(param1 % 60);
         return padNum(_loc2_.toString()) + ":" + padNum(_loc3_.toString());
      }
      
      public function ConvertToMSS(param1:Number) : String
      {
         var _loc2_:Number = Math.floor(param1 / 60 % 60);
         var _loc3_:Number = Math.floor(param1 % 60);
         return _loc2_.toString() + ":" + padNum(_loc3_.toString());
      }
      
      private function RandRange(param1:Number, param2:Number) : Number
      {
         return Math.floor(Math.random() * (param2 - param1 + 1)) + param1;
      }
      
      public function SetVolumeDown() : void
      {
         setVolume(getVolume() - 0.1);
      }
      
      public function SetVolumeUp() : void
      {
         setVolume(getVolume() + 0.1);
      }
      
      internal function getVolume() : Number
      {
         var _loc1_:SoundTransform = null;
         if(stream != null)
         {
            _loc1_ = stream.soundTransform;
            return _loc1_.volume;
         }
         return 0;
      }
      
      internal function setVolume(param1:Number = 0) : void
      {
         var _loc2_:* = undefined;
         if(stream != null)
         {
            if(param1 > 1)
            {
               param1 = 1;
            }
            if(param1 < 0)
            {
               param1 = 0;
            }
            _loc2_ = new SoundTransform(param1);
            stream.soundTransform = _loc2_;
         }
      }
      
      internal function padNum(param1:String, param2:Number = 2) : String
      {
         while(param1.length < param2)
         {
            param1 = "0" + param1;
         }
         return param1;
      }
      
      internal function toBoolean(param1:String) : Boolean
      {
         if(param1.toLowerCase() == "true")
         {
            return true;
         }
         if(param1.toLowerCase() == "false")
         {
            return false;
         }
         if(param1 == "1")
         {
            return true;
         }
         if(param1 == "0")
         {
            return false;
         }
         return true;
      }
      
      internal function CreateHexPath(param1:String, param2:String) : String
      {
         var _loc3_:Number = 2;
         var _loc4_:Number = 10;
         var _loc5_:String = "";
         var _loc6_:RegExp = /-/g;
         param1 = param1.replace(_loc6_,"");
         var _loc7_:int = 0;
         while(_loc7_ < _loc4_ * 2)
         {
            _loc5_ += param1.substring(_loc7_,_loc7_ + _loc3_) + param2;
            _loc7_ += _loc3_;
         }
         if(param1.length / 2 > _loc4_)
         {
            _loc5_ += param1.substring(_loc4_ * 2,_loc4_ * 2 + param1.length - _loc4_ * 2) + param2;
         }
         return _loc5_;
      }
      
      internal function getPositionFromJavaScript(param1:Number) : *
      {
         if(param1 >= 0 && param1 <= metaData.duration)
         {
            SeekToTime(param1);
         }
      }
   }
}
