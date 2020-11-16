class com.clubpenguin.games.dancing.NoteManager
{
   static var NOTE_ARRAY_SUBDIVISION_MILLIS = 1000;
   static var TIME_ON_SCREEN = 3500;
   static var MAX_DISTANCE_FROM_TARGET = 180;
   function NoteManager(movieClip)
   {
      this.movie = movieClip;
      this.movie._visible = false;
   }
   function init($noteTypes, $noteTimes, $noteLengths, $timeOnScreen)
   {
      if($timeOnScreen != undefined)
      {
         com.clubpenguin.games.dancing.NoteManager.TIME_ON_SCREEN = $timeOnScreen;
      }
      if($noteTypes.length != $noteTimes.length)
      {
         com.clubpenguin.games.dancing.NoteManager.debugTrace("note manager data arrays are different sizes!",com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
         //return undefined;
      }
      this.noteData = new Array();
      var _loc2_ = undefined;
      for(var _loc6_ in $noteTypes)
      {
         _loc2_ = Math.floor($noteTimes[_loc6_] / com.clubpenguin.games.dancing.NoteManager.NOTE_ARRAY_SUBDIVISION_MILLIS);
         if(this.noteData[_loc2_] == undefined)
         {
            this.noteData[_loc2_] = new Array();
         }
         com.clubpenguin.games.dancing.NoteManager.debugTrace("add new note to subarray " + _loc2_,com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
         this.noteData[_loc2_].push(new com.clubpenguin.games.dancing.Note(this.movie,$noteTypes[_loc6_],$noteTimes[_loc6_],$noteLengths[_loc6_]));
      }
      this.movie._visible = true;
   }
   function update(elapsedTime)
   {
      var _loc4_ = new Array();
      var _loc5_ = Math.floor(elapsedTime / com.clubpenguin.games.dancing.NoteManager.NOTE_ARRAY_SUBDIVISION_MILLIS) - 1;
      3;
      var _loc9_ = undefined;
      var _loc2_ = _loc5_;
      while(_loc2_ < _loc5_ + 3)
      {
         com.clubpenguin.games.dancing.NoteManager.debugTrace("update subarray " + _loc2_,com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
         for(var _loc7_ in this.noteData[_loc2_])
         {
            var _loc3_ = this.noteData[_loc2_][_loc7_].update(elapsedTime);
            if(_loc3_ == false)
            {
               _loc4_.push(this.noteData[_loc2_][_loc7_]);
            }
         }
         _loc2_ = _loc2_ + 1;
      }
      return _loc4_;
   }
   function destroy()
   {
      for(var _loc3_ in this.noteData)
      {
         for(var _loc2_ in this.noteData[_loc3_])
         {
            this.noteData[_loc3_][_loc2_].destroy();
         }
      }
   }
   function hide()
   {
      this.movie._visible = false;
   }
   function getClosestValidNote(noteType, elapsedTime)
   {
      var _loc7_ = Math.floor(elapsedTime / com.clubpenguin.games.dancing.NoteManager.NOTE_ARRAY_SUBDIVISION_MILLIS) - 1;
      3;
      var _loc3_ = undefined;
      var _loc5_ = undefined;
      var _loc4_ = undefined;
      var _loc2_ = _loc7_;
      while(_loc2_ < _loc7_ + 3)
      {
         for(var _loc9_ in this.noteData[_loc2_])
         {
            if(this.noteData[_loc2_][_loc9_].noteType == noteType)
            {
               if(this.noteData[_loc2_][_loc9_].getNotePressResult() == com.clubpenguin.games.dancing.Note.RESULT_NOT_PRESSED)
               {
                  _loc4_ = Math.abs(this.noteData[_loc2_][_loc9_].getDistanceFromTarget(elapsedTime));
                  com.clubpenguin.games.dancing.NoteManager.debugTrace("current note is noteData[" + _loc2_ + "][" + _loc9_ + "], " + "distance is " + _loc4_,com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
                  if(_loc3_ == undefined || _loc4_ < _loc5_)
                  {
                     com.clubpenguin.games.dancing.NoteManager.debugTrace("new closest note found!",com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
                     _loc3_ = this.noteData[_loc2_][_loc9_];
                     _loc5_ = Math.abs(_loc3_.getDistanceFromTarget(elapsedTime));
                  }
               }
            }
         }
         _loc2_ = _loc2_ + 1;
      }
      return _loc3_;
   }
   function handleNotePress($noteType, $elapsedTime, $closestNote)
   {
      var _loc2_ = undefined;
      if($closestNote == undefined)
      {
         _loc2_ = this.getClosestValidNote($noteType,$elapsedTime);
      }
      else
      {
         _loc2_ = $closestNote;
      }
      if(_loc2_ == undefined)
      {
         return com.clubpenguin.games.dancing.Note.RESULT_UNKNOWN;
      }
      var _loc3_ = Math.abs(_loc2_.getDistanceFromTarget($elapsedTime));
      if(_loc3_ < com.clubpenguin.games.dancing.NoteManager.MAX_DISTANCE_FROM_TARGET)
      {
         return _loc2_.handleNotePressEvent($elapsedTime);
      }
      com.clubpenguin.games.dancing.NoteManager.debugTrace("note was missed! distance = " + _loc3_);
      return com.clubpenguin.games.dancing.Note.RESULT_MISS;
   }
   function handleNoteRelease(noteType, elapsedTime)
   {
      var _loc7_ = Math.floor(elapsedTime / com.clubpenguin.games.dancing.NoteManager.NOTE_ARRAY_SUBDIVISION_MILLIS) - 1;
      3;
      var _loc3_ = undefined;
      var _loc5_ = undefined;
      var _loc4_ = undefined;
      var _loc2_ = _loc7_;
      while(_loc2_ < _loc7_ + 3)
      {
         for(var _loc9_ in this.noteData[_loc2_])
         {
            if(this.noteData[_loc2_][_loc9_].noteType == noteType)
            {
               if(this.noteData[_loc2_][_loc9_].getDuration() > 0 && this.noteData[_loc2_][_loc9_].getNotePressResult() != com.clubpenguin.games.dancing.Note.RESULT_NOT_PRESSED && this.noteData[_loc2_][_loc9_].getNoteReleaseResult() == com.clubpenguin.games.dancing.Note.RESULT_NOT_PRESSED)
               {
                  _loc4_ = Math.abs(this.noteData[_loc2_][_loc9_].getReleaseDistanceFromTarget(elapsedTime));
                  com.clubpenguin.games.dancing.NoteManager.debugTrace("current note is noteData[" + _loc2_ + "][" + _loc9_ + "], " + "distance is " + _loc4_,com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
                  if(_loc3_ == undefined || _loc4_ < _loc5_)
                  {
                     com.clubpenguin.games.dancing.NoteManager.debugTrace("new closest note found!",com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
                     _loc3_ = this.noteData[_loc2_][_loc9_];
                     _loc5_ = Math.abs(_loc3_.getReleaseDistanceFromTarget(elapsedTime));
                  }
               }
            }
         }
         _loc2_ = _loc2_ + 1;
      }
      if(_loc3_ == undefined)
      {
         return com.clubpenguin.games.dancing.Note.RESULT_UNKNOWN;
      }
      if(_loc5_ < com.clubpenguin.games.dancing.NoteManager.MAX_DISTANCE_FROM_TARGET)
      {
         return _loc3_.handleNoteReleaseEvent(elapsedTime);
      }
      com.clubpenguin.games.dancing.NoteManager.debugTrace("note release was missed! distance = " + _loc5_);
      return com.clubpenguin.games.dancing.Note.RESULT_MISS;
   }
   static function debugTrace(message, priority)
   {
      if(priority == undefined)
      {
         priority = com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE;
      }
      if(com.clubpenguin.util.Reporting.DEBUG)
      {
         com.clubpenguin.util.Reporting.debugTrace("(NoteManager) " + message,priority);
      }
   }
}
