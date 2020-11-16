class com.clubpenguin.games.dancing.Note
{
   static var TYPE_LEFT = 0;
   static var TYPE_RIGHT = 1;
   static var TYPE_UP = 2;
   static var TYPE_DOWN = 3;
   static var RESULT_PERFECT = 0;
   static var RESULT_GREAT = 1;
   static var RESULT_GOOD = 2;
   static var RESULT_ALMOST = 3;
   static var RESULT_BOO = 4;
   static var RESULT_MISS = 5;
   static var RESULT_NOT_PRESSED = -1;
   static var RESULT_ALREADY_PRESSED = -2;
   static var RESULT_UNKNOWN = -3;
   static var LEFT_NOTE_MOVIECLIP = "notePressLeft";
   static var RIGHT_NOTE_MOVIECLIP = "notePressRight";
   static var UP_NOTE_MOVIECLIP = "notePressUp";
   static var DOWN_NOTE_MOVIECLIP = "notePressDown";
   static var LEFT_BASE_MOVIECLIP = "noteBaseLeft";
   static var RIGHT_BASE_MOVIECLIP = "noteBaseRight";
   static var UP_BASE_MOVIECLIP = "noteBaseUp";
   static var DOWN_BASE_MOVIECLIP = "noteBaseDown";
   static var LEFT_STEM_MOVIECLIP = "noteStemLeft";
   static var RIGHT_STEM_MOVIECLIP = "noteStemRight";
   static var UP_STEM_MOVIECLIP = "noteStemUp";
   static var DOWN_STEM_MOVIECLIP = "noteStemDown";
   static var BASE_MOVIECLIP = "noteBase";
   static var STEM_MOVIECLIP = "noteStem";
   static var TOP_MOVIECLIP = "noteTop";
   static var ANIMATION_HIT = "hit";
   static var ANIMATION_HOLD = "hold";
   static var ANIMATION_FADE = "fade";
   static var LEFT_TARGET_MOVIECLIP = "noteTargetLeft";
   static var RIGHT_TARGET_MOVIECLIP = "noteTargetRight";
   static var UP_TARGET_MOVIECLIP = "noteTargetUp";
   static var DOWN_TARGET_MOVIECLIP = "noteTargetDown";
   static var START_MOVIECLIP = "noteStart";
   static var TARGET_MOVIECLIP = "noteTarget";
   static var END_MOVIECLIP = "noteFade";
   static var DOWN_ARROW_YSHIFT = 6;
   function Note(parentMovieClip, type, time, duration)
   {
      com.clubpenguin.games.dancing.Note.debugTrace("make new note: " + type + " at " + time + " for " + duration + "ms",com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
      if(duration == undefined)
      {
         0;
      }
      this.parentMovie = parentMovieClip;
      this.noteType = type;
      this.noteTime = time;
      this.noteDuration = 0;
      this.sentToServer = false;
      var _loc3_ = this.parentMovie[com.clubpenguin.games.dancing.Note.START_MOVIECLIP]._y - this.parentMovie[com.clubpenguin.games.dancing.Note.TARGET_MOVIECLIP]._y;
      this.noteHeight = _loc3_ * this.noteDuration / com.clubpenguin.games.dancing.NoteManager.TIME_ON_SCREEN;
      this.noteYPos = this.parentMovie[com.clubpenguin.games.dancing.Note.START_MOVIECLIP]._y;
      switch(this.noteType)
      {
         case com.clubpenguin.games.dancing.Note.TYPE_LEFT:
            this.noteXPos = this.parentMovie[com.clubpenguin.games.dancing.Note.LEFT_TARGET_MOVIECLIP]._x;
            break;
         case com.clubpenguin.games.dancing.Note.TYPE_RIGHT:
            this.noteXPos = this.parentMovie[com.clubpenguin.games.dancing.Note.RIGHT_TARGET_MOVIECLIP]._x;
            break;
         case com.clubpenguin.games.dancing.Note.TYPE_UP:
            this.noteXPos = this.parentMovie[com.clubpenguin.games.dancing.Note.UP_TARGET_MOVIECLIP]._x;
            break;
         case com.clubpenguin.games.dancing.Note.TYPE_DOWN:
            this.noteXPos = this.parentMovie[com.clubpenguin.games.dancing.Note.DOWN_TARGET_MOVIECLIP]._x;
            break;
         default:
            com.clubpenguin.games.dancing.Note.debugTrace("note type " + this.noteType + " is unknown!",com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
      }
      this.pressTime = com.clubpenguin.games.dancing.Note.RESULT_NOT_PRESSED;
      this.releaseTime = com.clubpenguin.games.dancing.Note.RESULT_NOT_PRESSED;
   }
   function update(currentTimeMillis)
   {
      this.setNotePosition(currentTimeMillis);
      if(this.noteYPos + this.noteHeight > this.parentMovie[com.clubpenguin.games.dancing.Note.END_MOVIECLIP]._y && this.noteYPos < this.parentMovie[com.clubpenguin.games.dancing.Note.START_MOVIECLIP]._y)
      {
         if(this.movie == undefined)
         {
            this.addNote();
         }
         if(this.getNotePressResult() == com.clubpenguin.games.dancing.Note.RESULT_NOT_PRESSED)
         {
            this.updateNote();
         }
         else if(this.noteDuration > 0)
         {
            this.resizeNote(currentTimeMillis);
         }
      }
      else
      {
         if(this.getNotePressResult() == com.clubpenguin.games.dancing.Note.RESULT_NOT_PRESSED && this.movie != undefined)
         {
            this.destroy();
            return false;
         }
         this.destroy();
      }
      return true;
   }
   function addNote()
   {
      var _loc6_ = "note_" + this.noteType + "_" + Math.round(this.noteTime);
      var _loc5_ = this.parentMovie.getNextHighestDepth();
      var _loc2_ = undefined;
      if(this.noteDuration > 0)
      {
         this.movie = this.parentMovie.createEmptyMovieClip(_loc6_,_loc5_);
         var _loc3_ = undefined;
         var _loc4_ = undefined;
         switch(this.noteType)
         {
            case com.clubpenguin.games.dancing.Note.TYPE_LEFT:
               _loc2_ = com.clubpenguin.games.dancing.Note.LEFT_NOTE_MOVIECLIP;
               _loc3_ = com.clubpenguin.games.dancing.Note.LEFT_BASE_MOVIECLIP;
               _loc4_ = com.clubpenguin.games.dancing.Note.LEFT_STEM_MOVIECLIP;
               break;
            case com.clubpenguin.games.dancing.Note.TYPE_RIGHT:
               _loc2_ = com.clubpenguin.games.dancing.Note.RIGHT_NOTE_MOVIECLIP;
               _loc3_ = com.clubpenguin.games.dancing.Note.RIGHT_BASE_MOVIECLIP;
               _loc4_ = com.clubpenguin.games.dancing.Note.RIGHT_STEM_MOVIECLIP;
               break;
            case com.clubpenguin.games.dancing.Note.TYPE_UP:
               _loc2_ = com.clubpenguin.games.dancing.Note.UP_NOTE_MOVIECLIP;
               _loc3_ = com.clubpenguin.games.dancing.Note.UP_BASE_MOVIECLIP;
               _loc4_ = com.clubpenguin.games.dancing.Note.UP_STEM_MOVIECLIP;
               break;
            case com.clubpenguin.games.dancing.Note.TYPE_DOWN:
               _loc2_ = com.clubpenguin.games.dancing.Note.DOWN_NOTE_MOVIECLIP;
               _loc3_ = com.clubpenguin.games.dancing.Note.DOWN_BASE_MOVIECLIP;
               _loc4_ = com.clubpenguin.games.dancing.Note.DOWN_STEM_MOVIECLIP;
               break;
            default:
               com.clubpenguin.games.dancing.Note.debugTrace("note type " + this.noteType + " is unknown!",com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
         }
         this.movie.attachMovie(_loc3_,com.clubpenguin.games.dancing.Note.BASE_MOVIECLIP,1);
         this.movie.attachMovie(_loc4_,com.clubpenguin.games.dancing.Note.STEM_MOVIECLIP,2);
         this.movie.attachMovie(_loc2_,com.clubpenguin.games.dancing.Note.TOP_MOVIECLIP,3);
         this.movie[com.clubpenguin.games.dancing.Note.STEM_MOVIECLIP]._height = this.noteHeight;
         this.movie[com.clubpenguin.games.dancing.Note.BASE_MOVIECLIP]._y = this.noteHeight;
         if(this.noteType == com.clubpenguin.games.dancing.Note.TYPE_DOWN)
         {
            this.movie[com.clubpenguin.games.dancing.Note.STEM_MOVIECLIP]._height = this.movie[com.clubpenguin.games.dancing.Note.STEM_MOVIECLIP]._height - com.clubpenguin.games.dancing.Note.DOWN_ARROW_YSHIFT;
            this.movie[com.clubpenguin.games.dancing.Note.STEM_MOVIECLIP]._y = this.movie[com.clubpenguin.games.dancing.Note.STEM_MOVIECLIP]._y + com.clubpenguin.games.dancing.Note.DOWN_ARROW_YSHIFT;
         }
      }
      else
      {
         switch(this.noteType)
         {
            case com.clubpenguin.games.dancing.Note.TYPE_LEFT:
               _loc2_ = com.clubpenguin.games.dancing.Note.LEFT_NOTE_MOVIECLIP;
               break;
            case com.clubpenguin.games.dancing.Note.TYPE_RIGHT:
               _loc2_ = com.clubpenguin.games.dancing.Note.RIGHT_NOTE_MOVIECLIP;
               break;
            case com.clubpenguin.games.dancing.Note.TYPE_UP:
               _loc2_ = com.clubpenguin.games.dancing.Note.UP_NOTE_MOVIECLIP;
               break;
            case com.clubpenguin.games.dancing.Note.TYPE_DOWN:
               _loc2_ = com.clubpenguin.games.dancing.Note.DOWN_NOTE_MOVIECLIP;
               break;
            default:
               com.clubpenguin.games.dancing.Note.debugTrace("note type " + this.noteType + " is unknown!",com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
         }
         this.movie = this.parentMovie.attachMovie(_loc2_,_loc6_,_loc5_);
         com.clubpenguin.games.dancing.Note.debugTrace("make new note movie: " + this.parentMovie + " attach " + _loc2_ + " as " + _loc6_ + " at " + _loc5_,com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
      }
   }
   function resizeNote(currentTimeMillis)
   {
      if(this.getNoteReleaseResult() == com.clubpenguin.games.dancing.Note.RESULT_NOT_PRESSED)
      {
         var _loc4_ = this.parentMovie[com.clubpenguin.games.dancing.Note.START_MOVIECLIP]._y - this.parentMovie[com.clubpenguin.games.dancing.Note.TARGET_MOVIECLIP]._y;
         var _loc3_ = this.noteDuration + this.pressTime - currentTimeMillis;
         var _loc2_ = _loc4_ * _loc3_ / com.clubpenguin.games.dancing.NoteManager.TIME_ON_SCREEN;
         if(_loc2_ >= 0)
         {
            this.movie[com.clubpenguin.games.dancing.Note.STEM_MOVIECLIP]._height = _loc2_;
            if(this.noteType == com.clubpenguin.games.dancing.Note.TYPE_DOWN)
            {
               this.movie[com.clubpenguin.games.dancing.Note.STEM_MOVIECLIP]._height = this.movie[com.clubpenguin.games.dancing.Note.STEM_MOVIECLIP]._height - com.clubpenguin.games.dancing.Note.DOWN_ARROW_YSHIFT;
               if(this.movie[com.clubpenguin.games.dancing.Note.STEM_MOVIECLIP]._height <= com.clubpenguin.games.dancing.Note.DOWN_ARROW_YSHIFT)
               {
                  this.movie[com.clubpenguin.games.dancing.Note.STEM_MOVIECLIP]._visible = false;
                  this.movie[com.clubpenguin.games.dancing.Note.BASE_MOVIECLIP]._visible = false;
               }
            }
            this.movie[com.clubpenguin.games.dancing.Note.BASE_MOVIECLIP]._y = _loc2_;
         }
         else
         {
            this.movie[com.clubpenguin.games.dancing.Note.STEM_MOVIECLIP]._visible = false;
            this.movie[com.clubpenguin.games.dancing.Note.BASE_MOVIECLIP]._visible = false;
            this.handleNoteReleaseEvent(currentTimeMillis);
         }
      }
   }
   function updateNote()
   {
      this.movie._x = this.noteXPos;
      this.movie._y = this.noteYPos;
   }
   function destroy()
   {
      if(this.movie != undefined)
      {
         this.movie.removeMovieClip();
         this.movie = undefined;
      }
   }
   function setNotePosition(currentTimeMillis)
   {
      this.noteYPos = this.parentMovie[com.clubpenguin.games.dancing.Note.TARGET_MOVIECLIP]._y + this.getDistanceFromTarget(currentTimeMillis);
   }
   function handleNotePressEvent(timePressedMillis)
   {
      if(this.pressTime != com.clubpenguin.games.dancing.Note.RESULT_NOT_PRESSED)
      {
         return com.clubpenguin.games.dancing.Note.RESULT_ALREADY_PRESSED;
      }
      this.pressTime = timePressedMillis;
      if(this.movie == undefined)
      {
         com.clubpenguin.games.dancing.Note.debugTrace("note is undefined on note press event!",com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
      }
      else if(this.noteDuration == 0)
      {
         this.movie.gotoAndPlay(com.clubpenguin.games.dancing.Note.ANIMATION_HIT);
      }
      else
      {
         this.movie[com.clubpenguin.games.dancing.Note.TOP_MOVIECLIP].gotoAndPlay(com.clubpenguin.games.dancing.Note.ANIMATION_HOLD);
         this.movie[com.clubpenguin.games.dancing.Note.BASE_MOVIECLIP].gotoAndPlay(com.clubpenguin.games.dancing.Note.ANIMATION_HOLD);
         this.movie[com.clubpenguin.games.dancing.Note.STEM_MOVIECLIP].gotoAndPlay(com.clubpenguin.games.dancing.Note.ANIMATION_HOLD);
      }
      com.clubpenguin.games.dancing.Note.debugTrace("press distance from target is " + this.getDistanceFromTarget());
      return this.getNotePressResult();
   }
   function getNotePressResult()
   {
      if(this.pressTime == com.clubpenguin.games.dancing.Note.RESULT_NOT_PRESSED)
      {
         return com.clubpenguin.games.dancing.Note.RESULT_NOT_PRESSED;
      }
      var _loc2_ = Math.abs(this.getDistanceFromTarget(this.pressTime));
      if(_loc2_ < 5)
      {
         return com.clubpenguin.games.dancing.Note.RESULT_PERFECT;
      }
      if(_loc2_ < 10)
      {
         return com.clubpenguin.games.dancing.Note.RESULT_GREAT;
      }
      if(_loc2_ < 25)
      {
         return com.clubpenguin.games.dancing.Note.RESULT_GOOD;
      }
      if(_loc2_ < 50)
      {
         return com.clubpenguin.games.dancing.Note.RESULT_ALMOST;
      }
      return com.clubpenguin.games.dancing.Note.RESULT_BOO;
   }
   function handleNoteReleaseEvent(timeReleasedMillis)
   {
      if(this.releaseTime != com.clubpenguin.games.dancing.Note.RESULT_NOT_PRESSED)
      {
         return com.clubpenguin.games.dancing.Note.RESULT_ALREADY_PRESSED;
      }
      this.releaseTime = timeReleasedMillis;
      if(this.movie == undefined)
      {
         com.clubpenguin.games.dancing.Note.debugTrace("note is undefined on note release event!",com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
      }
      else if(this.noteDuration > 0)
      {
         this.movie[com.clubpenguin.games.dancing.Note.BASE_MOVIECLIP].gotoAndPlay(com.clubpenguin.games.dancing.Note.ANIMATION_FADE);
         this.movie[com.clubpenguin.games.dancing.Note.STEM_MOVIECLIP].gotoAndPlay(com.clubpenguin.games.dancing.Note.ANIMATION_FADE);
         this.movie[com.clubpenguin.games.dancing.Note.TOP_MOVIECLIP].gotoAndPlay(com.clubpenguin.games.dancing.Note.ANIMATION_FADE);
      }
      com.clubpenguin.games.dancing.Note.debugTrace("release distance from target is " + this.getReleaseDistanceFromTarget());
      com.clubpenguin.games.dancing.Note.debugTrace("note hold length is " + this.getNoteHoldLength());
      return this.getNoteHoldLength();
   }
   function getNoteReleaseResult()
   {
      if(this.releaseTime == com.clubpenguin.games.dancing.Note.RESULT_NOT_PRESSED)
      {
         return com.clubpenguin.games.dancing.Note.RESULT_NOT_PRESSED;
      }
      var _loc2_ = Math.abs(this.getReleaseDistanceFromTarget(this.releaseTime));
      if(_loc2_ < 5)
      {
         return com.clubpenguin.games.dancing.Note.RESULT_PERFECT;
      }
      if(_loc2_ < 10)
      {
         return com.clubpenguin.games.dancing.Note.RESULT_GREAT;
      }
      if(_loc2_ < 25)
      {
         return com.clubpenguin.games.dancing.Note.RESULT_GOOD;
      }
      if(_loc2_ < 50)
      {
         return com.clubpenguin.games.dancing.Note.RESULT_ALMOST;
      }
      return com.clubpenguin.games.dancing.Note.RESULT_BOO;
   }
   function getNoteHoldLength()
   {
      var _loc2_ = this.releaseTime - this.pressTime;
      if(_loc2_ > this.noteDuration)
      {
         _loc2_ = this.noteDuration;
      }
      return _loc2_;
   }
   function getDistanceFromTarget(currentTimeMillis)
   {
      if(currentTimeMillis == undefined)
      {
         currentTimeMillis = this.pressTime;
      }
      var _loc2_ = this.parentMovie[com.clubpenguin.games.dancing.Note.START_MOVIECLIP]._y - this.parentMovie[com.clubpenguin.games.dancing.Note.TARGET_MOVIECLIP]._y;
      var _loc4_ = (this.noteTime - currentTimeMillis) / com.clubpenguin.games.dancing.NoteManager.TIME_ON_SCREEN;
      return _loc2_ * _loc4_;
   }
   function getReleaseDistanceFromTarget(currentTimeMillis)
   {
      if(currentTimeMillis == undefined)
      {
         currentTimeMillis = this.releaseTime;
      }
      return this.getDistanceFromTarget(currentTimeMillis - this.noteDuration);
   }
   function getDuration()
   {
      return this.noteDuration;
   }
   static function debugTrace(message, priority)
   {
      if(priority == undefined)
      {
         priority = com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE;
      }
      if(com.clubpenguin.util.Reporting.DEBUG)
      {
         com.clubpenguin.util.Reporting.debugTrace("(Note) " + message,priority);
      }
   }
}
