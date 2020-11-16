class com.clubpenguin.games.dancing.GameEngine extends com.clubpenguin.games.generic.GenericGameEngine
{
   static var DIFFICULTY_EASY = 0;
   static var DIFFICULTY_MEDIUM = 1;
   static var DIFFICULTY_HARD = 2;
   static var DIFFICULTY_EXPERT = 3;
   static var SPECIAL_NONE = 0;
   static var SPECIAL_RIVERDANCE = 1;
   static var SPECIAL_WORM = 2;
   static var SPECIAL_BREAKDANCE = 3;
   static var SPECIAL_PUFFLESPIN = 4;
   static var SONG_ONE = 0;
   static var SONG_TWO = 1;
   static var SONG_THREE = 2;
   static var SONG_ONE_DATA = "songs/songData1.swf";
   static var SONG_TWO_DATA = "songs/songData2.swf";
   static var SONG_THREE_DATA = "songs/songData3.swf";
   static var TOTAL_SONGS = 3;
   static var SONG_LOAD_OK = 0;
   static var SONG_LOAD_ERROR = 1;
   static var SONG_LOAD_IN_PROGRESS = 2;
   static var KEY_PRESSED_LEFT = false;
   static var KEY_PRESSED_RIGHT = false;
   static var KEY_PRESSED_UP = false;
   static var KEY_PRESSED_DOWN = false;
   static var MULTIPLIER_LIMIT = 10;
   static var MAX_RATING = 30;
   var currentRating = 0;
   var consecutiveNotes = 0;
   var currentMultiplier = 1;
   var currentScore = 0;
   var statsLongestChain = 0;
   var statsNotesHit = 0;
   var statsTotalNotes = 0;
   var currentSong = 1;
   var currentDifficulty = 1;
   var randomTip = 1;
   var loadedSongs = 0;
   var hasPurplePuffle = false;
   function GameEngine($movieClip, $gameFilename)
   {
      super($movieClip);
      if(com.clubpenguin.games.dancing.GameEngine.instance != undefined)
      {
         com.clubpenguin.games.dancing.GameEngine.debugTrace("there is already an active instance of GameEngine. overwriting it!",com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
      }
      com.clubpenguin.games.dancing.GameEngine.instance = this;
      this.gameFilename = $gameFilename;
   }
   function init()
   {
      com.clubpenguin.games.dancing.GameEngine.debugTrace("init function started");
      this.loadedSongs = 0;
      this.musicPlayer = new Array();
      var _loc3_ = this.gameFilename.split("/");
      "";
      0;
      while(0 < _loc3_.length - 1)
      {
         _loc4_ = "" + (_loc3_[0] + "/");
         1;
      }
      com.clubpenguin.games.dancing.GameEngine.debugTrace("game root directory is \'" + _loc4_ + "\'");
      this.loadSong(_loc4_ + com.clubpenguin.games.dancing.GameEngine.SONG_ONE_DATA,com.clubpenguin.games.dancing.GameEngine.SONG_ONE);
      this.loadSong(_loc4_ + com.clubpenguin.games.dancing.GameEngine.SONG_TWO_DATA,com.clubpenguin.games.dancing.GameEngine.SONG_TWO);
      this.loadSong(_loc4_ + com.clubpenguin.games.dancing.GameEngine.SONG_THREE_DATA,com.clubpenguin.games.dancing.GameEngine.SONG_THREE);
      this.keyListener = new Object();
      this.keyListener.onKeyDown = com.clubpenguin.util.Delegate.create(this,this.handleKeyDown);
      this.keyListener.onKeyUp = com.clubpenguin.util.Delegate.create(this,this.handleKeyUp);
      Key.addListener(this.keyListener);
      this.timeOnScreenMillis = new Array();
      this.timeOnScreenMillis[com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EASY] = 4000;
      this.timeOnScreenMillis[com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_MEDIUM] = 2500;
      this.timeOnScreenMillis[com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_HARD] = 1750;
      this.timeOnScreenMillis[com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EXPERT] = 1500;
      this.animationEngine = new com.clubpenguin.games.dancing.AnimationEngine(this,this.movie);
      this.noteManager = new com.clubpenguin.games.dancing.NoteManager(this.movie[com.clubpenguin.games.dancing.AnimationEngine.ARROWS_MOVIECLIP]);
      this.netClient = new com.clubpenguin.games.dancing.DanceNetClient(this);
      this.menuSystem = new com.clubpenguin.games.dancing.MenuSystem(this,this.movie[com.clubpenguin.games.dancing.AnimationEngine.MENUS_MOVIECLIP]);
      this.currentDifficulty = com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_MEDIUM;
      this.isPlayingGame = false;
      this.isDancing = false;
   }
   function destroy()
   {
      this.leaveMultiplayerServer();
      var _loc3_ = new Object();
      _loc3_.score = 0;
      _loc3_.coins = 0;
      _root.showWindow("Game Over",_loc3_);
   }
   function loadSong($songLocation, $songID)
   {
      var _loc2_ = new Object();
      var _loc3_ = new MovieClipLoader();
      this.musicPlayer[$songID] = this.movie.createEmptyMovieClip("songData" + $songID,this.movie.getNextHighestDepth());
      _loc2_.onLoadInit = com.clubpenguin.util.Delegate.create(this,this.handleSongLoadComplete);
      _loc2_.onLoadError = com.clubpenguin.util.Delegate.create(this,this.handleSongLoadError);
      _loc3_.addListener(_loc2_);
      _loc3_.loadClip($songLocation,this.musicPlayer[$songID]);
   }
   function handleSongLoadComplete()
   {
      if(this.loadedSongs < 0)
      {
         return undefined;
      }
      this.loadedSongs++;
      if(this.allSongsLoaded() == com.clubpenguin.games.dancing.GameEngine.SONG_LOAD_OK)
      {
         if(this.getCurrentMenu() != com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME_INTRO)
         {
            this.menuSystem.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME);
         }
      }
   }
   function handleSongLoadError()
   {
      this.loadedSongs = -1;
      if(this.getCurrentMenu() != com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME_INTRO)
      {
         this.menuSystem.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME);
      }
   }
   function handleSoundComplete()
   {
      if(this.netClient.currentState == com.clubpenguin.games.dancing.DanceNetClient.STATE_DISCONNECTED)
      {
         this.endSong();
      }
   }
   function allSongsLoaded()
   {
      if(this.loadedSongs < 0)
      {
         return com.clubpenguin.games.dancing.GameEngine.SONG_LOAD_ERROR;
      }
      if(this.loadedSongs >= com.clubpenguin.games.dancing.GameEngine.TOTAL_SONGS)
      {
         return com.clubpenguin.games.dancing.GameEngine.SONG_LOAD_OK;
      }
      return com.clubpenguin.games.dancing.GameEngine.SONG_LOAD_IN_PROGRESS;
   }
   function setDifficulty($difficulty)
   {
      this.currentDifficulty = $difficulty;
      if(this.netClient.currentState != com.clubpenguin.games.dancing.DanceNetClient.STATE_DISCONNECTED)
      {
         this.netClient.sendDifficultyLevelMessage(this.currentDifficulty);
      }
   }
   function setSong($song)
   {
      this.currentSong = $song;
   }
   function startTimer()
   {
      this.startTimeMillis = 5211;
      this.currentTimeMillis = this.startTimeMillis;
      this.elapsedTimeMillis = 0;
   }
   function startSong()
   {
      if(this.netClient.currentState != com.clubpenguin.games.dancing.DanceNetClient.STATE_DISCONNECTED && this.netClient.currentState != com.clubpenguin.games.dancing.DanceNetClient.STATE_IN_GAME)
      {
         com.clubpenguin.games.dancing.GameEngine.debugTrace("startSong called when in an unknown net state: " + this.netClient.currentState);
         return undefined;
      }
      if(this.isPlayingGame)
      {
         com.clubpenguin.games.dancing.GameEngine.debugTrace("startSong called when song already started!");
         return undefined;
      }
      this.noteManager.destroy();
      var _loc3_ = undefined;
      if(this.netClient.currentState == com.clubpenguin.games.dancing.DanceNetClient.STATE_DISCONNECTED)
      {
         var _loc2_ = com.clubpenguin.games.dancing.data.SongData.getSongData(this.currentSong,this.currentDifficulty);
         this.noteManager.init(_loc2_[0],_loc2_[1],_loc2_[2],this.timeOnScreenMillis[this.currentDifficulty]);
         _loc3_ = com.clubpenguin.games.dancing.data.SongData.getMillisPerBar(this.currentSong) / com.clubpenguin.games.dancing.AnimationEngine.TOTAL_DANCE_FRAMES;
      }
      else
      {
         this.noteManager.init(this.netClient.songData[0],this.netClient.songData[1],this.netClient.songData[2],this.timeOnScreenMillis[this.currentDifficulty]);
         _loc3_ = this.netClient.millisPerBar / com.clubpenguin.games.dancing.AnimationEngine.TOTAL_DANCE_FRAMES;
      }
      this.keyPresses = new Array();
      if(this.netClient.currentState == com.clubpenguin.games.dancing.DanceNetClient.STATE_IN_GAME)
      {
         this.netClient.keyPressIDs = new Array();
      }
      this.animationEngine.startSong(_loc3_);
      this.startTimer();
      this.currentRating = com.clubpenguin.games.dancing.GameEngine.MAX_RATING / 2;
      this.consecutiveNotes = 0;
      this.currentMultiplier = 1;
      this.currentScore = 0;
      this.statsLongestChain = 0;
      this.statsNotesHit = 0;
      this.statsNoteBreakdown = [0,0,0,0,0,0];
      this.statsTotalNotes = _loc2_[0].length;
      this.musicPlayer[this.currentSong].playSound();
      this.handleScoreUpdate(1.7976931348623157e308);
      this.isPlayingGame = true;
      this.isDancing = true;
   }
   function startSongCustom($notes, $noteTimes, $noteLengths)
   {
      trace("start song custom succesfully callled!");
      trace($notes);
      trace($noteTimes);
      trace($noteLengths);
      this.noteManager.destroy();
      var _loc3_ = undefined;
      //var _loc2_ = com.clubpenguin.games.dancing.data.SongData.getSongData(this.currentSong,this.currentDifficulty);
      this.noteManager.init($notes,$noteTimes,$noteLengths,1250);
      _loc3_ = com.clubpenguin.games.dancing.data.SongData.getMillisPerBar(this.currentSong) / com.clubpenguin.games.dancing.AnimationEngine.TOTAL_DANCE_FRAMES;
      this.keyPresses = new Array();
      this.animationEngine.startSong(_loc3_);
      this.startTimer();
      this.currentRating = com.clubpenguin.games.dancing.GameEngine.MAX_RATING / 2;
      this.consecutiveNotes = 0;
      this.currentMultiplier = 1;
      this.currentScore = 0;
      this.statsLongestChain = 0;
      this.statsNotesHit = 0;
      this.statsNoteBreakdown = [0,0,0,0,0,0];
      this.statsTotalNotes = _loc2_[0].length;
      this.musicPlayer[this.currentSong].playSound();
      this.handleScoreUpdate(1.7976931348623157e308);
      this.isPlayingGame = true;
      this.isDancing = true;
   }
   function endSong()
   {
      com.clubpenguin.games.dancing.GameEngine.debugTrace("song ends");
      this.animationEngine.endSong();
      this.noteManager.hide();
      this.musicPlayer.stopSequence("music");
      var _loc2_ = undefined;
      if(this.netClient.currentState == com.clubpenguin.games.dancing.DanceNetClient.STATE_DISCONNECTED)
      {
         _loc2_ = com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_POSTGAME_INTRO;
      }
      else
      {
         _loc2_ = com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_POSTGAME_INTRO;
      }
      this.menuSystem.loadMenu(_loc2_);
      this.isPlayingGame = false;
   }
   function update()
   {
      com.clubpenguin.games.dancing.GameEngine.debugTrace("update function started",com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
      this.currentTimeMillis = 8020;
      this.elapsedTimeMillis = this.currentTimeMillis - this.startTimeMillis;
      com.clubpenguin.games.dancing.GameEngine.debugTrace("elapsed time = " + this.elapsedTimeMillis,com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
      if(this.isDancing)
      {
         if(this.isPlayingGame)
         {
            var _loc3_ = this.noteManager.update(this.elapsedTimeMillis);
            if(_loc3_.length > 0)
            {
               com.clubpenguin.games.dancing.GameEngine.debugTrace(_loc3_.length + " notes missed",com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
               0;
               while(0 < _loc3_.length)
               {
                  this.handleScoreUpdate(com.clubpenguin.games.dancing.Note.RESULT_MISS);
                  1;
               }
            }
         }
         var _loc4_ = Math.floor(this.currentRating / (com.clubpenguin.games.dancing.GameEngine.MAX_RATING / 3));
         this.animationEngine.updateDancer(_loc4_);
         this.animationEngine.updateBackground();
         if(this.netClient.currentState == com.clubpenguin.games.dancing.DanceNetClient.STATE_IN_GAME)
         {
            this.netClient.updateKeyPresses(this.keyPresses);
         }
      }
      else
      {
         this.updateMenus();
      }
      this.animationEngine.updateDancefloor();
   }
   function updateMenus()
   {
      if(this.menuSystem.getCurrentMenu() == com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_JOIN_GAME || this.menuSystem.getCurrentMenu() == com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_QUEUEING)
      {
         this.startTimeMillis = this.currentTimeMillis;
         this.netClient.timeToNextSong = this.netClient.timeToNextSong - this.elapsedTimeMillis;
         this.loadMenu(this.menuSystem.getCurrentMenu());
      }
      if(this.menuSystem.getCurrentMenu() == com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_DIFFICULTY || this.menuSystem.getCurrentMenu() == com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_QUEUEING)
      {
         if(this.netClient.timeToNextSong <= 0 && this.menuSystem.getCurrentMenu() != com.clubpenguin.games.dancing.MenuSystem.MENU_START_MULTIPLAYER_SONG)
         {
            this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_START_MULTIPLAYER_SONG);
         }
      }
   }
   function handleScoreUpdate($noteResult)
   {
      false;
      0;
      switch($noteResult)
      {
         case com.clubpenguin.games.dancing.Note.RESULT_PERFECT:
            10;
            this.currentRating = this.currentRating + 1;
            this.consecutiveNotes++;
            break;
         case com.clubpenguin.games.dancing.Note.RESULT_GREAT:
            5;
            this.currentRating = this.currentRating + 1;
            this.consecutiveNotes++;
            break;
         case com.clubpenguin.games.dancing.Note.RESULT_GOOD:
            2;
            this.consecutiveNotes++;
            break;
         case com.clubpenguin.games.dancing.Note.RESULT_ALMOST:
            if(this.consecutiveNotes > 50)
            {
               true;
            }
            1;
            this.currentRating = this.currentRating - 2;
            this.consecutiveNotes = 0;
            break;
         case com.clubpenguin.games.dancing.Note.RESULT_MISS:
            if(this.consecutiveNotes > 50)
            {
               true;
            }
            0;
            this.currentRating = this.currentRating - 5;
            this.consecutiveNotes = 0;
            break;
         case com.clubpenguin.games.dancing.Note.RESULT_BOO:
            if(this.consecutiveNotes > 50)
            {
               true;
            }
            0;
            this.currentRating = this.currentRating - 5;
            this.consecutiveNotes = 0;
            break;
         default:
            com.clubpenguin.games.dancing.GameEngine.debugTrace("incorrect note result " + $noteResult + " in handleScoreUpdate",com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
            return undefined;
      }
      this.statsNoteBreakdown[$noteResult]++;
      if(this.consecutiveNotes > this.statsLongestChain)
      {
         this.statsLongestChain = this.consecutiveNotes;
      }
      if(this.consecutiveNotes > 0)
      {
         this.statsNotesHit++;
      }
      if(this.currentRating >= com.clubpenguin.games.dancing.GameEngine.MAX_RATING)
      {
         this.currentRating = com.clubpenguin.games.dancing.GameEngine.MAX_RATING - 1;
      }
      if(this.currentRating < 0)
      {
         this.currentRating = 0;
      }
      com.clubpenguin.games.dancing.GameEngine.debugTrace("current rating updated to " + this.currentRating + ", absolute rating is " + Math.floor(this.currentRating / (com.clubpenguin.games.dancing.GameEngine.MAX_RATING / 3)),com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
      switch(Math.floor(this.consecutiveNotes / com.clubpenguin.games.dancing.GameEngine.MULTIPLIER_LIMIT))
      {
         case 0:
            this.currentMultiplier = 1;
            break;
         case 1:
            this.currentMultiplier = 2;
            break;
         case 2:
            this.currentMultiplier = 3;
            break;
         case 3:
            this.currentMultiplier = 4;
            break;
         case 4:
            this.currentMultiplier = 5;
            break;
         case 5:
            this.currentMultiplier = 6;
            break;
         case 6:
            this.currentMultiplier = 8;
            break;
         case 7:
            this.currentMultiplier = 10;
            break;
         default:
            this.currentMultiplier = 10;
      }
      _loc2_ = 0 * this.currentMultiplier;
      if(this.currentDifficulty == com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EXPERT)
      {
         _loc2_ = _loc2_ * 2;
      }
      this.currentScore = this.currentScore + _loc2_;
      var _loc5_ = Math.floor(this.currentRating / (com.clubpenguin.games.dancing.GameEngine.MAX_RATING / 3));
      this.animationEngine.updateNoteCombo($noteResult,this.consecutiveNotes,true,this.currentScore,_loc5_);
   }
   function handleKeyDown()
   {
      if(this.isPlayingGame)
      {
         var _loc4_ = undefined;
         var _loc3_ = com.clubpenguin.games.dancing.Note.RESULT_UNKNOWN;
         var _loc2_ = undefined;
         if(Key.getCode() == 37 && !com.clubpenguin.games.dancing.GameEngine.KEY_PRESSED_LEFT)
         {
            _loc2_ = com.clubpenguin.games.dancing.Note.TYPE_LEFT;
            com.clubpenguin.games.dancing.GameEngine.KEY_PRESSED_LEFT = true;
         }
         if(Key.getCode() == 39 && !com.clubpenguin.games.dancing.GameEngine.KEY_PRESSED_RIGHT)
         {
            _loc2_ = com.clubpenguin.games.dancing.Note.TYPE_RIGHT;
            com.clubpenguin.games.dancing.GameEngine.KEY_PRESSED_RIGHT = true;
         }
         if(Key.getCode() == 38 && !com.clubpenguin.games.dancing.GameEngine.KEY_PRESSED_UP)
         {
            _loc2_ = com.clubpenguin.games.dancing.Note.TYPE_UP;
            com.clubpenguin.games.dancing.GameEngine.KEY_PRESSED_UP = true;
         }
         if(Key.getCode() == 40 && !com.clubpenguin.games.dancing.GameEngine.KEY_PRESSED_DOWN)
         {
            _loc2_ = com.clubpenguin.games.dancing.Note.TYPE_DOWN;
            com.clubpenguin.games.dancing.GameEngine.KEY_PRESSED_DOWN = true;
         }
         _loc4_ = this.noteManager.getClosestValidNote(_loc2_,this.elapsedTimeMillis);
         _loc3_ = this.noteManager.handleNotePress(_loc2_,this.elapsedTimeMillis,_loc4_);
         if(_loc3_ != com.clubpenguin.games.dancing.Note.RESULT_UNKNOWN)
         {
            com.clubpenguin.games.dancing.GameEngine.debugTrace("note was pressed at " + this.elapsedTimeMillis + ", the result is " + _loc3_,com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
            var _loc6_ = this.keyPresses.push(_loc4_);
            if(this.netClient.currentState == com.clubpenguin.games.dancing.DanceNetClient.STATE_IN_GAME)
            {
               this.netClient.keyPressIDs.push(_loc6_ - 1);
            }
            this.handleScoreUpdate(_loc3_);
         }
      }
      else
      {
         switch(this.menuSystem.getCurrentMenu())
         {
            case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_TIMING_KEYPRESS:
            case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLE_KEYPRESS:
            case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_HOLD_KEYPRESS:
            case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLIER_DOWN:
            case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLIER_LEFT:
            case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLIER_RIGHT:
               var _loc5_ = Key.getCode();
               switch(_loc5_)
               {
                  case 37:
                     this.menuSystem.handleClick(37);
                     break;
                  case 39:
                     this.menuSystem.handleClick(39);
                     break;
                  case 38:
                     this.menuSystem.handleClick(38);
                     break;
                  case 40:
                     this.menuSystem.handleClick(40);
               }
         }
      }
   }
   function handleKeyUp()
   {
      if(this.isPlayingGame)
      {
         var _loc3_ = undefined;
         if(Key.getCode() == 37 && com.clubpenguin.games.dancing.GameEngine.KEY_PRESSED_LEFT)
         {
            _loc3_ = com.clubpenguin.games.dancing.Note.TYPE_LEFT;
            com.clubpenguin.games.dancing.GameEngine.KEY_PRESSED_LEFT = false;
         }
         if(Key.getCode() == 39 && com.clubpenguin.games.dancing.GameEngine.KEY_PRESSED_RIGHT)
         {
            _loc3_ = com.clubpenguin.games.dancing.Note.TYPE_RIGHT;
            com.clubpenguin.games.dancing.GameEngine.KEY_PRESSED_RIGHT = false;
         }
         if(Key.getCode() == 38 && com.clubpenguin.games.dancing.GameEngine.KEY_PRESSED_UP)
         {
            _loc3_ = com.clubpenguin.games.dancing.Note.TYPE_UP;
            com.clubpenguin.games.dancing.GameEngine.KEY_PRESSED_UP = false;
         }
         if(Key.getCode() == 40 && com.clubpenguin.games.dancing.GameEngine.KEY_PRESSED_DOWN)
         {
            _loc3_ = com.clubpenguin.games.dancing.Note.TYPE_DOWN;
            com.clubpenguin.games.dancing.GameEngine.KEY_PRESSED_DOWN = false;
         }
         if(_loc3_ != undefined)
         {
            var _loc2_ = this.keyPresses.length - 1;
            while(_loc2_ > 0)
            {
               if(this.keyPresses[_loc2_].noteType == _loc3_)
               {
                  this.keyPresses[_loc2_].handleNoteReleaseEvent(this.elapsedTimeMillis);
                  this.handleHoldBonus(this.keyPresses[_loc2_].noteType,this.keyPresses[_loc2_].getNotePressResult(),this.keyPresses[_loc2_].getNoteHoldLength());
                  com.clubpenguin.games.dancing.GameEngine.debugTrace("note was released at " + this.elapsedTimeMillis + " with length " + this.keyPresses[_loc2_].getNoteHoldLength(),com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
                  break;
               }
               _loc2_ = _loc2_ - 1;
            }
         }
      }
   }
   function handleHoldBonus($noteType, $noteResult, $noteLength)
   {
      if($noteLength <= 0)
      {
         return undefined;
      }
      0;
      switch($noteResult)
      {
         case com.clubpenguin.games.dancing.Note.RESULT_PERFECT:
            10;
            break;
         case com.clubpenguin.games.dancing.Note.RESULT_GREAT:
            5;
            break;
         case com.clubpenguin.games.dancing.Note.RESULT_GOOD:
            2;
            break;
         case com.clubpenguin.games.dancing.Note.RESULT_ALMOST:
            1;
            break;
         default:
            return undefined;
      }
      _loc2_ = 1 * this.currentMultiplier;
      _loc2_ = _loc2_ * ($noteLength / 500);
      _loc2_ = Math.round(_loc2_);
      if(this.currentDifficulty == com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EXPERT)
      {
         _loc2_ = _loc2_ * 2;
      }
      if(_loc2_ > 0)
      {
         this.currentScore = this.currentScore + _loc2_;
         this.animationEngine.updateNoteBonus($noteType,_loc2_,this.currentScore);
      }
   }
   function getPostGameStatsSpeechBubble()
   {
      var _loc2_ = com.clubpenguin.util.LocaleText.getText("menu_singleplayer_rating") + "\n";
      var _loc3_ = this.statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_PERFECT] + this.statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_GREAT] + this.statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_GOOD] + this.statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_ALMOST] + this.statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_BOO] + this.statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_MISS];
      var _loc4_ = Math.round(this.statsNotesHit / _loc3_ * 1000) / 10 + "%";
      _loc2_ = _loc2_ + (com.clubpenguin.util.LocaleText.getTextReplaced("menu_singleplayer_rating_note_percent",[_loc4_]) + "\n");
      _loc2_ = _loc2_ + com.clubpenguin.util.LocaleText.getTextReplaced("menu_singleplayer_rating_biggest_combo",[this.statsLongestChain + ""]);
      return _loc2_;
   }
   function getPostGameStatsBreakdown()
   {
      var _loc5_ = this.statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_PERFECT] + this.statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_GREAT] + this.statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_GOOD] + this.statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_ALMOST] + this.statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_BOO] + this.statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_MISS];
      var _loc4_ = Math.round(this.statsNotesHit / _loc5_ * 1000) / 10;
      var _loc2_ = new Array();
      _loc2_[com.clubpenguin.games.dancing.Note.RESULT_PERFECT] = com.clubpenguin.util.LocaleText.getText("game_note_perfect") + ": " + this.statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_PERFECT];
      _loc2_[com.clubpenguin.games.dancing.Note.RESULT_GREAT] = com.clubpenguin.util.LocaleText.getText("game_note_great") + ": " + this.statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_GREAT];
      _loc2_[com.clubpenguin.games.dancing.Note.RESULT_GOOD] = com.clubpenguin.util.LocaleText.getText("game_note_good") + ": " + this.statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_GOOD];
      _loc2_[com.clubpenguin.games.dancing.Note.RESULT_ALMOST] = com.clubpenguin.util.LocaleText.getText("game_note_almost") + ": " + this.statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_ALMOST];
      _loc2_[com.clubpenguin.games.dancing.Note.RESULT_BOO] = com.clubpenguin.util.LocaleText.getText("game_note_boo") + ": " + this.statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_BOO];
      _loc2_[com.clubpenguin.games.dancing.Note.RESULT_MISS] = com.clubpenguin.util.LocaleText.getText("game_note_miss") + ": " + this.statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_MISS];
      if(_loc4_ < 50)
      {
         _loc2_[6] = com.clubpenguin.util.LocaleText.getText("menu_singleplayer_rating_D") + "\n";
      }
      else if(_loc4_ < 75)
      {
         _loc2_[6] = com.clubpenguin.util.LocaleText.getText("menu_singleplayer_rating_C") + "\n";
      }
      else if(_loc4_ < 100)
      {
         _loc2_[6] = com.clubpenguin.util.LocaleText.getText("menu_singleplayer_rating_B") + "\n";
      }
      else if(this.statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_PERFECT] == this.statsTotalNotes)
      {
         _loc2_[6] = com.clubpenguin.util.LocaleText.getText("menu_singleplayer_rating_AAA") + "\n";
      }
      else if(this.statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_PERFECT] + this.statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_GREAT] == this.statsTotalNotes)
      {
         _loc2_[6] = com.clubpenguin.util.LocaleText.getText("menu_singleplayer_rating_AA") + "\n";
      }
      else
      {
         _loc2_[6] = com.clubpenguin.util.LocaleText.getText("menu_singleplayer_rating_A") + "\n";
      }
      for(var _loc3_ in _loc2_)
      {
         _loc2_[_loc3_] = _loc2_[_loc3_].toUpperCase();
      }
      return _loc2_;
   }
   function getCoinsWon()
   {
      0;
      if(this.currentScore <= 10000)
      {
         _loc2_ = Math.round(this.currentScore / 25);
      }
      else
      {
         _loc2_ = 400 + Math.round((this.currentScore - 10000) / 100);
      }
      return _loc2_;
   }
   function getJudgesOpinion()
   {
      "";
      "";
      var _loc5_ = this.statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_PERFECT] + this.statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_GREAT] + this.statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_GOOD] + this.statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_ALMOST] + this.statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_BOO] + this.statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_MISS];
      var _loc4_ = Math.round(this.statsNotesHit / _loc5_ * 1000) / 10;
      if(_loc4_ < 66)
      {
         _loc2_ = com.clubpenguin.util.LocaleText.getText("menu_singleplayer_result_bad");
      }
      else if(_loc4_ < 85)
      {
         _loc2_ = com.clubpenguin.util.LocaleText.getText("menu_singleplayer_result_OK");
      }
      else if(_loc4_ < 95)
      {
         _loc2_ = com.clubpenguin.util.LocaleText.getText("menu_singleplayer_result_great");
         if(this.currentDifficulty != com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EXPERT && this.currentDifficulty != com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_HARD)
         {
            _loc3_ = " " + com.clubpenguin.util.LocaleText.getText("menu_singleplayer_level_up");
         }
      }
      else
      {
         _loc2_ = com.clubpenguin.util.LocaleText.getText("menu_singleplayer_result_awesome");
         if(this.currentDifficulty == com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_HARD)
         {
            _loc3_ = " " + com.clubpenguin.util.LocaleText.getText("menu_singleplayer_level_up_hard");
         }
         else if(this.currentDifficulty == com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EXPERT)
         {
            _loc3_ = " " + com.clubpenguin.util.LocaleText.getText("menu_singleplayer_level_up_expert");
         }
         else
         {
            _loc3_ = " " + com.clubpenguin.util.LocaleText.getText("menu_singleplayer_level_up");
         }
      }
      _loc2_ = _loc2_ + (" " + com.clubpenguin.util.LocaleText.getTextReplaced("menu_singleplayer_coinswon",[this.getCoinsWon()]) + _loc3_);
      return _loc2_;
   }
   function handleButtonClick($menuOption)
   {
      this.menuSystem.handleClick($menuOption);
   }
   function loadMenu($menu)
   {
      this.menuSystem.loadMenu($menu);
   }
   function getCurrentMenu()
   {
      return this.menuSystem.getCurrentMenu();
   }
   function setQualityMode($quality)
   {
      this.animationEngine.setQualityMode($quality);
   }
   function getCurrentDifficulty()
   {
      switch(this.currentDifficulty)
      {
         case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EASY:
            return com.clubpenguin.util.LocaleText.getText("menu_difficulty_current_easy");
         case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_MEDIUM:
            return com.clubpenguin.util.LocaleText.getText("menu_difficulty_current_medium");
         case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_HARD:
            return com.clubpenguin.util.LocaleText.getText("menu_difficulty_current_hard");
         case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EXPERT:
            return com.clubpenguin.util.LocaleText.getText("menu_difficulty_current_expert");
         default:
      }
   }
   function getRandomTipText($random)
   {
      var _loc2_ = ["menu_tip_multiplier","menu_tip_longnotes","menu_tip_dances","menu_tip_lights","menu_tip_multiplier_light","menu_tip_practice","menu_tip_expert_mode","menu_tip_note_combos"];
      if($random || this.randomTip == undefined)
      {
         this.randomTip = Math.floor(Math.random() * _loc2_.length);
      }
      return com.clubpenguin.util.LocaleText.getText(_loc2_[this.randomTip]);
   }
   function joinMultiplayerServer()
   {
      this.netClient.init(this);
      this.netClient.sendGetGameMessage();
   }
   function rejoinMultiplayerServer()
   {
      this.netClient.sendGetGameAgainMessage();
   }
   function joinMultiplayerGame()
   {
      this.netClient.sendJoinGameMessage();
      this.netClient.sendDifficultyLevelMessage(this.currentDifficulty);
   }
   function leaveMultiplayerServer()
   {
      this.netClient.sendAbortGameMessage();
      this.netClient.destroy();
   }
   function getNetClientState()
   {
      return this.netClient.currentState;
   }
   function getTimeToNextSong()
   {
      return this.netClient.timeToNextSong;
   }
   function multiplayerJoinAvailable()
   {
      return this.netClient.freeSlots > 0;
   }
   function updateMultiplayerScores(playerScores)
   {
      if(playerScores != null)
      {
         this.multiplayerScores = playerScores;
      }
      this.animationEngine.updateMultiplayerScores(playerScores);
   }
   function setMultiplayerScoreVisibility($visible)
   {
      this.animationEngine.setMultiplayerScoreVisibility($visible);
   }
   function getJoinGameSpeechBubble()
   {
      "";
      if(this.netClient.gameInProgress)
      {
         _loc2_ = com.clubpenguin.util.LocaleText.getTextReplaced("menu_multiplayer_inprogress",[this.netClient.songName]);
      }
      else
      {
         var _loc3_ = [this.netClient.songName,this.formatTime(Math.round(this.netClient.timeToNextSong / 1000))];
         _loc2_ = com.clubpenguin.util.LocaleText.getTextReplaced("menu_multiplayer_waiting",_loc3_);
      }
      _loc2_ = _loc2_ + " ";
      if(this.netClient.freeSlots > 0)
      {
         _loc2_ = _loc2_ + com.clubpenguin.util.LocaleText.getTextReplaced("menu_multiplayer_spaces",[this.netClient.freeSlots]);
      }
      else
      {
         _loc2_ = _loc2_ + com.clubpenguin.util.LocaleText.getText("menu_multiplayer_no_spaces");
      }
      return _loc2_;
   }
   function getJoinGameOptions()
   {
      var _loc2_ = new Array();
      if(this.netClient.freeSlots > 0)
      {
         _loc2_.push(com.clubpenguin.util.LocaleText.getText("menu_multiplayer_response_join"));
      }
      _loc2_.push(com.clubpenguin.util.LocaleText.getText("menu_multiplayer_response_mainmenu"));
      return _loc2_;
   }
   function getWaitingSpeechBubble()
   {
      "";
      var _loc2_ = Math.round(this.netClient.timeToNextSong / 1000);
      var _loc5_ = Math.round(_loc2_ / 10);
      if(_loc2_ < 15 || _loc5_ % 2 == 0)
      {
         var _loc4_ = [this.netClient.songName,this.formatTime(_loc2_)];
         _loc3_ = com.clubpenguin.util.LocaleText.getTextReplaced("menu_multiplayer_waiting",_loc4_);
         this.randomTip = undefined;
      }
      else
      {
         _loc3_ = this.getRandomTipText(false);
      }
      return _loc3_;
   }
   function getMultiplayerCoinsWon()
   {
      var _loc6_ = undefined;
      var _loc7_ = undefined;
      var _loc4_ = undefined;
      if(this.multiplayerScores != null)
      {
         var _loc8_ = _global.getCurrentShell();
         var _loc3_ = _loc8_.getMyPlayerNickname();
         if(this.multiplayerScores[0].name == _loc3_)
         {
            _loc7_ = com.clubpenguin.util.LocaleText.getText("menu_multiplayer_postgame_you");
            "";
         }
         else
         {
            _loc7_ = this.multiplayerScores[0].name;
            for(var _loc5_ in this.multiplayerScores)
            {
               if(this.multiplayerScores[_loc5_].name == _loc3_)
               {
                  _loc4_ = com.clubpenguin.util.LocaleText.getTextReplaced("menu_multiplayer_postgame",[this.multiplayerScores[_loc5_].score]);
                  break;
               }
            }
         }
         _loc6_ = com.clubpenguin.util.LocaleText.getTextReplaced("menu_multiplayer_postgame",[_loc7_,this.multiplayerScores[0].score]);
         _loc6_ = _loc6_ + (" " + _loc4_);
      }
      else
      {
         _loc6_ = this.getJudgesOpinion();
      }
      return _loc6_;
   }
   static function debugTrace(message, priority)
   {
      if(priority == undefined)
      {
         priority = com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE;
      }
      if(com.clubpenguin.util.Reporting.DEBUG)
      {
         com.clubpenguin.util.Reporting.debugTrace("(GameEngine) " + message,priority);
      }
   }
   function formatTime($timeInSeconds)
   {
      "";
      var _loc3_ = Math.floor($timeInSeconds / 60);
      var _loc2_ = $timeInSeconds % 60;
      _loc1_ = _loc2_ >= 10?_loc2_:"0" + _loc2_;
      if(_loc3_ > 0)
      {
         _loc1_ = _loc3_ + ":" + _loc1_;
      }
      return _loc1_;
   }
}
