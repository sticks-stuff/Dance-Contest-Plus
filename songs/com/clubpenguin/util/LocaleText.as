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
if(!_global.com.clubpenguin.util.LocaleText)
{
   com.clubpenguin.util.LocaleText = 0;
   var _loc2_ = 0.prototype;
   0.init = function($parent, $languageID, $movieLocation, $versionNumber, $useLoader)
   {
      com.clubpenguin.util.LocaleText.debugTrace("initialise locale text");
      com.clubpenguin.util.LocaleText.ready = false;
      if(com.clubpenguin.util.LocaleText.eventSource == undefined)
      {
         com.clubpenguin.util.LocaleText.eventSource = new Object();
         mx.events.EventDispatcher.initialize(com.clubpenguin.util.LocaleText.eventSource);
      }
      if($useLoader == undefined)
      {
         false;
      }
      if($languageID == undefined)
      {
         $languageID = com.clubpenguin.util.LocaleText.getLocaleID();
      }
      com.clubpenguin.util.LocaleText.localeID = $languageID;
      var _loc1_ = com.clubpenguin.util.LocaleText.getLocale(com.clubpenguin.util.LocaleText.localeID);
      com.clubpenguin.util.LocaleText.locale = com.clubpenguin.util.LocaleText.getLocale(com.clubpenguin.util.LocaleText.localeID);
      if($versionNumber == undefined)
      {
         if(com.clubpenguin.util.LocaleText.localeVersion == undefined)
         {
            _loc1_ = com.clubpenguin.util.LocaleText.LANG_LOC_DIRECTORY + "/" + _loc1_ + "/" + com.clubpenguin.util.LocaleText.LANG_LOC_FILENAME + com.clubpenguin.util.LocaleText.LANG_LOC_FILETYPE;
         }
         else
         {
            _loc1_ = com.clubpenguin.util.LocaleText.LANG_LOC_DIRECTORY + "/" + _loc1_ + "/" + com.clubpenguin.util.LocaleText.LANG_LOC_FILENAME + com.clubpenguin.util.LocaleText.localeVersion + com.clubpenguin.util.LocaleText.LANG_LOC_FILETYPE;
         }
      }
      else
      {
         _loc1_ = com.clubpenguin.util.LocaleText.LANG_LOC_DIRECTORY + "/" + _loc1_ + "/" + com.clubpenguin.util.LocaleText.LANG_LOC_FILENAME + $versionNumber + com.clubpenguin.util.LocaleText.LANG_LOC_FILETYPE;
      }
      com.clubpenguin.util.LocaleText.localeDataMC = $parent.createEmptyMovieClip("localeDataMC",$parent.getNextHighestDepth());
      var _loc2_ = new Object();
      var _loc3_ = new MovieClipLoader();
      if($languageID == com.clubpenguin.util.LocaleText.LANG_ID_LOADERROR)
      {
         _loc2_.onLoadError = function($targetMC, $errorMessage)
         {
            com.clubpenguin.util.LocaleText.debugTrace("load error: " + $errorMessage,com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
            com.clubpenguin.util.LocaleText.handleLoadComplete($targetMC);
         };
      }
      else
      {
         _loc2_.onLoadError = function($targetMC)
         {
            com.clubpenguin.util.LocaleText.init($targetMC,com.clubpenguin.util.LocaleText.LANG_ID_LOADERROR);
         };
      }
      if($movieLocation != undefined)
      {
         _loc1_ = $movieLocation + _loc1_;
      }
      if(false)
      {
         _loc2_.onLoadProgress = function($targetMC, $loadProgress, $loadTotal)
         {
            com.clubpenguin.util.Loader.handleLoadProgress($targetMC,$loadProgress,$loadTotal);
         };
         _loc2_.onLoadInit = function($targetMC)
         {
            com.clubpenguin.util.LocaleText.handleLoadComplete($targetMC);
            com.clubpenguin.util.Loader.handleLoadComplete($targetMC);
         };
         com.clubpenguin.util.LocaleText.debugTrace("load filename " + _loc1_ + " using Loader class");
         _loc3_.addListener(_loc2_);
         _loc3_.loadClip(_loc1_,com.clubpenguin.util.LocaleText.localeDataMC);
         com.clubpenguin.util.Loader.addProgressObject(_loc3_.getProgress(com.clubpenguin.util.LocaleText.localeDataMC));
      }
      else
      {
         _loc2_.onLoadInit = function($targetMC)
         {
            com.clubpenguin.util.LocaleText.handleLoadComplete($targetMC);
         };
         com.clubpenguin.util.LocaleText.debugTrace("load filename " + _loc1_ + " standalone");
         _loc3_.addListener(_loc2_);
         _loc3_.loadClip(_loc1_,com.clubpenguin.util.LocaleText.localeDataMC);
      }
   };
   0.handleLoadComplete = function($data)
   {
      com.clubpenguin.util.LocaleText.debugTrace("locale text loaded OK!");
      com.clubpenguin.util.LocaleText.dataArray = new Array();
      for(var _loc2_ in $data.localeText)
      {
         com.clubpenguin.util.LocaleText.dataArray[$data.localeText[_loc2_].id] = $data.localeText[_loc2_].value;
         com.clubpenguin.util.LocaleText.debugTrace("dataArray[" + $data.localeText[_loc2_].id + "] = " + $data.localeText[_loc2_].value);
      }
      var _loc3_ = new Object();
      _loc3_.target = com.clubpenguin.util.LocaleText;
      _loc3_.type = com.clubpenguin.util.LocaleText.EVENT_LOAD_COMPLETED;
      com.clubpenguin.util.LocaleText.ready = true;
      com.clubpenguin.util.LocaleText.eventSource.dispatchEvent(_loc3_);
      com.clubpenguin.util.LocaleText.debugTrace("dispatched LOAD_COMPLETED event");
   };
   0.addEventListener = function($listener)
   {
      if(com.clubpenguin.util.LocaleText.eventSource == undefined)
      {
         com.clubpenguin.util.LocaleText.eventSource = new Object();
         mx.events.EventDispatcher.initialize(com.clubpenguin.util.LocaleText.eventSource);
      }
      com.clubpenguin.util.LocaleText.eventSource.addEventListener(com.clubpenguin.util.LocaleText.EVENT_LOAD_COMPLETED,$listener);
   };
   0.removeEventListener = function($listener)
   {
      com.clubpenguin.util.LocaleText.eventSource.removeEventListener(com.clubpenguin.util.Loader.EVENT_LOAD_COMPLETED,$listener);
   };
   0.getText = function($stringID)
   {
      if(!com.clubpenguin.util.LocaleText.ready)
      {
         com.clubpenguin.util.LocaleText.debugTrace("getText called when not ready",com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
         return "[id:" + $stringID + " not ready]";
      }
      if(com.clubpenguin.util.LocaleText.dataArray[$stringID] == undefined)
      {
         com.clubpenguin.util.LocaleText.debugTrace("load error for string: " + $stringID,com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
         return "[id:" + $stringID + " undefined]";
      }
      return com.clubpenguin.util.LocaleText.dataArray[$stringID];
   };
   0.getTextReplaced = function($stringID, $replacements)
   {
      var _loc2_ = com.clubpenguin.util.LocaleText.getText($stringID);
      var _loc3_ = $replacements.length;
      0;
      while(0 < _loc3_)
      {
         _loc2_ = _loc2_.split("%0").join($replacements[0]);
         1;
      }
      return _loc2_;
   };
   0.getLocale = function($localeID)
   {
      switch($localeID)
      {
         case com.clubpenguin.util.LocaleText.LANG_ID_EN:
            return com.clubpenguin.util.LocaleText.LANG_LOC_EN;
         case com.clubpenguin.util.LocaleText.LANG_ID_PT:
            return com.clubpenguin.util.LocaleText.LANG_LOC_PT;
         case com.clubpenguin.util.LocaleText.LANG_ID_FR:
            return com.clubpenguin.util.LocaleText.LANG_LOC_FR;
         case com.clubpenguin.util.LocaleText.LANG_ID_ES_419:
            return com.clubpenguin.util.LocaleText.LANG_LOC_ES_419;
         case com.clubpenguin.util.LocaleText.LANG_ID_DE:
            return com.clubpenguin.util.LocaleText.LANG_LOC_DE;
         case com.clubpenguin.util.LocaleText.LANG_ID_IT:
            return com.clubpenguin.util.LocaleText.LANG_LOC_IT;
         case com.clubpenguin.util.LocaleText.LANG_ID_ES:
            return com.clubpenguin.util.LocaleText.LANG_LOC_ES;
         case com.clubpenguin.util.LocaleText.LANG_ID_ZH:
            return com.clubpenguin.util.LocaleText.LANG_LOC_ZH;
         case com.clubpenguin.util.LocaleText.LANG_ID_JA:
            return com.clubpenguin.util.LocaleText.LANG_LOC_JA;
         case com.clubpenguin.util.LocaleText.LANG_ID_LOADERROR:
            com.clubpenguin.util.LocaleText.debugTrace("load error occurred! reload using default language",com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
            return com.clubpenguin.util.LocaleText.LANG_LOC_EN;
         default:
            com.clubpenguin.util.LocaleText.debugTrace("unknown language id: " + $localeID + ", using default language instead",com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
            return com.clubpenguin.util.LocaleText.LANG_LOC_EN;
      }
   };
   0.setLocaleVersion = function($localeVersion)
   {
      com.clubpenguin.util.LocaleText.localeVersion = $localeVersion;
   };
   0.setLocaleID = function($localeID)
   {
      com.clubpenguin.util.LocaleText.localeID = $localeID;
   };
   0.getLocaleID = function()
   {
      return com.clubpenguin.util.LocaleText.localeID;
   };
   0.isReady = function()
   {
      return com.clubpenguin.util.LocaleText.ready;
   };
   0.attachLocaleClip = function($stringID, $target)
   {
      var _loc1_ = com.clubpenguin.util.LocaleText.localeDataMC.attachMovie($stringID,$stringID + "_mc",com.clubpenguin.util.LocaleText.localeDataMC.getNextHighestDepth());
      var _loc2_ = new flash.display.BitmapData(_loc1_._width,_loc1_._height,true,0);
      _loc2_.draw(_loc1_,new flash.geom.Matrix(),new flash.geom.ColorTransform(),"normal");
      $target.attachBitmap(_loc2_,$target.getNextHighestDepth());
      _loc1_.removeMovieClip();
   };
   0.getGameDirectory = function($url)
   {
      if($url == undefined)
      {
         if(com.clubpenguin.util.LocaleText.localeDirectoryURL == undefined)
         {
            com.clubpenguin.util.LocaleText.debugTrace("using cached locale directory url that hasn\'t been set yet!",com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
         }
         return com.clubpenguin.util.LocaleText.localeDirectoryURL;
      }
      var _loc2_ = $url.split("/");
      "";
      0;
      while(0 < _loc2_.length - 1)
      {
         _loc3_ = "" + (_loc2_[0] + "/");
         1;
      }
      com.clubpenguin.util.LocaleText.localeDirectoryURL = _loc3_;
      return com.clubpenguin.util.LocaleText.localeDirectoryURL;
   };
   0.debugTrace = function($message, $priority)
   {
      if($priority == undefined)
      {
         $priority = com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE;
      }
      if(com.clubpenguin.util.Reporting.DEBUG_LOCALE)
      {
         com.clubpenguin.util.Reporting.debugTrace("(LocaleText) " + $message,$priority);
      }
   };
   0.EVENT_LOAD_COMPLETED = "onLoadComplete";
   0.LANG_ID_DEFAULT = com.clubpenguin.util.LocaleText.LANG_ID_EN;
   0.LANG_ID_LOADERROR = 0;
   0.LANG_ID_EN = 1;
   0.LANG_ID_PT = 2;
   0.LANG_ID_FR = 3;
   0.LANG_ID_ES_419 = 4;
   0.LANG_ID_DE = 5;
   0.LANG_ID_IT = 6;
   0.LANG_ID_ES = 7;
   0.LANG_ID_ZH = 8;
   0.LANG_ID_JA = 9;
   0.LANG_LOC_FILENAME = "locale";
   0.LANG_LOC_FILETYPE = ".swf";
   0.LANG_LOC_DIRECTORY = "lang";
   0.LANG_LOC_EN = "en";
   0.LANG_LOC_PT = "pt";
   0.LANG_LOC_FR = "fr";
   0.LANG_LOC_ES_419 = "es_419";
   0.LANG_LOC_DE = "de";
   0.LANG_LOC_IT = "it";
   0.LANG_LOC_ES = "es";
   0.LANG_LOC_ZH = "zh";
   0.LANG_LOC_JA = "ja";
   0.localeVersion = undefined;
   0.localeID = 0;
   0.ready = false;
   §§push(ASSetPropFlags(com.clubpenguin.util.LocaleText.prototype,null,1));
}
§§pop();
