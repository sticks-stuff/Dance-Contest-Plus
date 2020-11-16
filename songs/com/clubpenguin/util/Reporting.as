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
if(!_global.com.clubpenguin.util.Reporting)
{
   com.clubpenguin.util.Reporting = 0;
   var _loc2_ = 0.prototype;
   0.addDebugOutput = function(debugText)
   {
      if(com.clubpenguin.util.Reporting.output == undefined)
      {
         com.clubpenguin.util.Reporting.output = new Array();
      }
      com.clubpenguin.util.Reporting.output.push(debugText);
   };
   0.setDebugLevel = function(level)
   {
      if(com.clubpenguin.util.Reporting.debugLevel > com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR || com.clubpenguin.util.Reporting.debugLevel < com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE)
      {
         com.clubpenguin.util.Reporting.debugTrace("(Reporting) incorrect debug level given in setDebugLevel: " + level,com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
      }
      else
      {
         com.clubpenguin.util.Reporting.debugLevel = level;
      }
   };
   0.debugTrace = function(message, priority)
   {
      if(priority == undefined)
      {
         priority = com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE;
      }
      if(com.clubpenguin.util.Reporting.DEBUG)
      {
         if(com.clubpenguin.util.Reporting.debugLevel <= priority)
         {
            var _loc1_ = undefined;
            switch(priority)
            {
               case com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR:
                  _loc1_ = "ERROR! " + message;
                  break;
               case com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING:
                  _loc1_ = "WARNING: " + message;
                  break;
               case com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE:
                  _loc1_ = "MESSAGE: " + message;
                  break;
               case com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE:
               default:
                  _loc1_ = "VERBOSE: " + message;
            }
            for(var _loc2_ in com.clubpenguin.util.Reporting.output)
            {
               com.clubpenguin.util.Reporting.output[_loc2_].text = _loc1_ + "\n" + com.clubpenguin.util.Reporting.output[_loc2_].text;
            }
         }
      }
   };
   0.DEBUG = true;
   0.DEBUG_FPS = com.clubpenguin.util.Reporting.DEBUG && true;
   0.DEBUG_SOUNDS = com.clubpenguin.util.Reporting.DEBUG && true;
   0.DEBUG_LOCALE = com.clubpenguin.util.Reporting.DEBUG && true;
   0.DEBUG_SECURITY = com.clubpenguin.util.Reporting.DEBUG && true;
   0.DEBUGLEVEL_VERBOSE = 0;
   0.DEBUGLEVEL_MESSAGE = 1;
   0.DEBUGLEVEL_WARNING = 2;
   0.DEBUGLEVEL_ERROR = 3;
   0.debugLevel = com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE;
   §§push(ASSetPropFlags(com.clubpenguin.util.Reporting.prototype,null,1));
}
§§pop();
