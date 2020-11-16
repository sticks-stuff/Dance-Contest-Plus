if(!_global.com)
{
   _global.com = new Object();
}
§§pop();
if(!_global.com.clubpenguin)
{
   _global.com.clubpenguin = new Object();
}
§§pop();
if(!_global.com.clubpenguin.util)
{
   _global.com.clubpenguin.util = new Object();
}
§§pop();
if(!_global.com.clubpenguin.util.Loader)
{
   com.clubpenguin.util.Loader = 0;
   var _loc2_ = 0.prototype;
   0.loadAllMovies = function($parent, $movieLocations, $initLocaleText)
   {
      if(com.clubpenguin.util.Loader.eventSource == undefined)
      {
         com.clubpenguin.util.Loader.eventSource = new Object();
         mx.events.EventDispatcher.initialize(com.clubpenguin.util.Loader.eventSource);
      }
      com.clubpenguin.util.Loader.submovieProgress = new Array();
      com.clubpenguin.util.Loader.loadedMovies = 0;
      if($initLocaleText == undefined)
      {
         true;
      }
      if($movieLocations == undefined)
      {
         com.clubpenguin.util.Loader.debugTrace("no movieLocations array given!",com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
      }
      else
      {
         var _loc3_ = $movieLocations[0].split("/");
         "";
         0;
         while(0 < _loc3_.length - 1)
         {
            _loc4_ = "" + (_loc3_[0] + "/");
            1;
         }
         com.clubpenguin.util.Loader.debugTrace("root directory is \'" + _loc4_ + "\'");
         var _loc7_ = com.clubpenguin.util.Loader.localeOverride != undefined?com.clubpenguin.util.Loader.localeOverride:com.clubpenguin.util.LocaleText.LANG_ID_EN;
         var _loc6_ = com.clubpenguin.util.Loader.localeVersion != undefined?com.clubpenguin.util.Loader.localeVersion:com.clubpenguin.util.Loader.localeVersion;
         if(true)
         {
            com.clubpenguin.util.LocaleText.init($parent,_loc7_,_loc4_,_loc6_,true);
         }
      }
      0;
      while(0 < $movieLocations.length)
      {
         com.clubpenguin.util.Loader.loadSubmovie($parent,$movieLocations[0],0);
         1;
      }
   };
   0.loadSubmovie = function($parent, $movieLocation, $movieNum)
   {
      com.clubpenguin.util.Loader.debugTrace("load submovie");
      if($parent == undefined)
      {
         com.clubpenguin.util.Loader.debugTrace("cannot load movie, parent movie is undefined!",com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
         return undefined;
      }
      if($movieLocation == undefined)
      {
         com.clubpenguin.util.Loader.debugTrace("cannot load movie, movie location is undefined!",com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
         return undefined;
      }
      var _loc3_ = $parent.createEmptyMovieClip("loadDataMC" + $movieNum,$parent.getNextHighestDepth());
      var _loc1_ = new Object();
      var _loc2_ = new MovieClipLoader();
      _loc1_.onLoadInit = function($targetMC)
      {
         com.clubpenguin.util.Loader.handleLoadComplete($targetMC);
      };
      _loc1_.onLoadProgress = function($targetMC, $loadProgress, $loadTotal)
      {
         com.clubpenguin.util.Loader.handleLoadProgress($targetMC,$loadProgress,$loadTotal);
      };
      _loc1_.onLoadError = function($targetMC, $errorMessage)
      {
         com.clubpenguin.util.Loader.debugTrace("error loading submovie: " + $errorMessage,com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
      };
      _loc2_.addListener(_loc1_);
      _loc2_.loadClip($movieLocation,_loc3_);
      com.clubpenguin.util.Loader.addProgressObject(_loc2_.getProgress(_loc3_));
   };
   0.handleLoadProgress = function($mainMovie, $loadProgress, $loadTotal)
   {
      0;
      0;
      0;
      while(0 < com.clubpenguin.util.Loader.submovieProgress.length)
      {
         if(com.clubpenguin.util.Loader.submovieProgress[0].movieClip == $mainMovie)
         {
            com.clubpenguin.util.Loader.submovieProgress[0].bytesLoaded = $loadProgress;
            com.clubpenguin.util.Loader.submovieProgress[0].bytesTotal = $loadTotal;
         }
         _loc2_ = 0 + com.clubpenguin.util.Loader.submovieProgress[0].bytesLoaded;
         _loc3_ = 0 + com.clubpenguin.util.Loader.submovieProgress[0].bytesTotal;
         1;
      }
      var _loc7_ = _loc2_ / _loc3_ * 100;
      com.clubpenguin.util.Loader.debugTrace("updated load progress. movie is now " + Math.round(_loc7_) + "% loaded");
   };
   0.handleLoadComplete = function($mainMovie)
   {
      com.clubpenguin.util.Loader.debugTrace("submovie loaded OK! are all loaded?");
      if($mainMovie._name != "loadDataMC0")
      {
         $mainMovie.removeMovieClip();
      }
      com.clubpenguin.util.Loader.loadedMovies++;
      if(com.clubpenguin.util.Loader.loadedMovies >= com.clubpenguin.util.Loader.submovieProgress.length)
      {
         com.clubpenguin.util.Loader.debugTrace("all movies loaded OK!");
         var _loc1_ = new Object();
         _loc1_.target = com.clubpenguin.util.Loader;
         _loc1_.type = com.clubpenguin.util.Loader.EVENT_LOAD_COMPLETED;
         com.clubpenguin.util.Loader.eventSource.dispatchEvent(_loc1_);
         com.clubpenguin.util.Loader.debugTrace("dispatched LOAD_COMPLETED event");
      }
   };
   0.addEventListener = function($listener)
   {
      if(com.clubpenguin.util.Loader.eventSource == undefined)
      {
         com.clubpenguin.util.Loader.eventSource = new Object();
         mx.events.EventDispatcher.initialize(com.clubpenguin.util.Loader.eventSource);
      }
      com.clubpenguin.util.Loader.eventSource.addEventListener(com.clubpenguin.util.Loader.EVENT_LOAD_COMPLETED,$listener);
   };
   0.removeEventListener = function($listener)
   {
      com.clubpenguin.util.Loader.eventSource.removeEventListener(com.clubpenguin.util.Loader.EVENT_LOAD_COMPLETED,$listener);
   };
   0.setLocale = function($locale)
   {
      com.clubpenguin.util.Loader.localeOverride = $locale;
   };
   0.setLocaleVersion = function($localeVersion)
   {
      com.clubpenguin.util.Loader.localeVersion = $localeVersion;
   };
   0.addProgressObject = function($progress)
   {
      com.clubpenguin.util.Loader.submovieProgress.push($progress);
   };
   0.debugTrace = function($message, $priority)
   {
      if($priority == undefined)
      {
         $priority = com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE;
      }
      if(com.clubpenguin.util.Reporting.DEBUG_LOCALE)
      {
         com.clubpenguin.util.Reporting.debugTrace("(Loader) " + $message,$priority);
      }
   };
   0.EVENT_LOAD_COMPLETED = "onLoadComplete";
   0.EVENT_LOAD_IN_PROGRESS = "onLoadProgress";
   0.loadedMovies = 0;
   0.submovieProgress = new Array();
   0.localeVersion = undefined;
   0.localeOverride = undefined;
   §§push(ASSetPropFlags(com.clubpenguin.util.Loader.prototype,null,1));
}
§§pop();
