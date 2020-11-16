class com.clubpenguin.games.generic.GenericGameEngine
{
   var init = 0;
   var update = 0;
   static var DEFAULT_FPS = 20;
   static var fpsTarget = com.clubpenguin.games.generic.GenericGameEngine.DEFAULT_FPS;
   static var fpsFrameTime = 1000 / com.clubpenguin.games.generic.GenericGameEngine.fpsTarget;
   var frameTimer = 0;
   var debugFrameTicks = 0;
   var debugFrameTicksLast = 0;
   function GenericGameEngine(movieClip)
   {
      this.movie = movieClip;
      if(movieClip == undefined)
      {
         com.clubpenguin.games.generic.GenericGameEngine.debugTrace("(GenericGameEngine) no movieclip passed to constructor",com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
      }
      com.clubpenguin.games.generic.GenericGameEngine.debugTrace("(GenericGameEngine) about to create localeText listener, is currently set as " + this.localeTextListener);
      this.localeTextListener = new Object();
      this.localeTextListener.onLoadComplete = com.clubpenguin.util.Delegate.create(this,this.localeLoadHandler);
      com.clubpenguin.util.LocaleText.addEventListener(this.localeTextListener);
      var _loc4_ = com.clubpenguin.util.LocaleText.getGameDirectory(movieClip._url);
      com.clubpenguin.util.LocaleText.init(movieClip,undefined,_loc4_,undefined,false);
      if(com.clubpenguin.util.Reporting.DEBUG_FPS)
      {
         var _loc2_ = new TextFormat();
         _loc2_.size = 20;
         this.movie.createTextField("debugText",10,100,100,200,100);
         this.debugText.setTextFormat(_loc2_);
         this.frameTimer = 5373;
         this.debugFrameTicks = 0;
         this.debugFrameTicksLast = 0;
         setInterval(this,"updateFPS",1000);
      }
   }
   function localeLoadHandler()
   {
      com.clubpenguin.games.generic.GenericGameEngine.debugTrace("(GenericGameEngine) load complete handler called");
      com.clubpenguin.util.LocaleText.removeEventListener(this.localeTextListener);
      this.localeTextListener = undefined;
      com.clubpenguin.games.generic.GenericGameEngine.debugTrace("(GenericGameEngine) localeText listener removed");
      var _loc3_ = _global.getCurrentShell();
      _loc3_.hideLoading();
      com.clubpenguin.games.generic.GenericGameEngine.debugTrace("(GenericGameEngine) load screen removed");
      this.init();
   }
   function enterFrameHandler()
   {
      if(com.clubpenguin.util.Reporting.DEBUG_FPS)
      {
         this.debugFrameTicks++;
      }
      if(6508 > this.frameTimer + com.clubpenguin.games.generic.GenericGameEngine.fpsFrameTime)
      {
         this.frameTimer = this.frameTimer + com.clubpenguin.games.generic.GenericGameEngine.fpsFrameTime;
         this.update();
      }
   }
   function getPenguinColour()
   {
      11193582;
      var _loc3_ = _global.getCurrentShell();
      if(_loc3_.getMyPlayerHex != undefined)
      {
         _loc2_ = _loc3_.getMyPlayerHex();
      }
      return _loc2_;
   }
   function updateFPS()
   {
      var _loc2_ = this.debugFrameTicks - this.debugFrameTicksLast;
      var _loc3_ = "fps: " + _loc2_ + " (target = " + com.clubpenguin.games.generic.GenericGameEngine.fpsTarget + ") - FPS ";
      _loc3_ = _loc3_ + (_loc2_ <= com.clubpenguin.games.generic.GenericGameEngine.fpsTarget?"WARNING!":"OK");
      this.movie.debugText.text = _loc3_;
      this.debugFrameTicksLast = this.debugFrameTicks;
   }
   function setFPS(newFPS)
   {
      com.clubpenguin.games.generic.GenericGameEngine.fpsTarget = newFPS;
      com.clubpenguin.games.generic.GenericGameEngine.fpsFrameTime = 1000 / com.clubpenguin.games.generic.GenericGameEngine.fpsTarget;
   }
   static function debugTrace(message, priority)
   {
      if(com.clubpenguin.util.Reporting.DEBUG)
      {
         com.clubpenguin.util.Reporting.debugTrace(message,priority);
      }
   }
}
