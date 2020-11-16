class com.clubpenguin.games.dancing.AnimationEngine
{
   static var COLOUR_WHITE = 15724527;
   static var COLOUR_OFF_WHITE = 14277081;
   static var COLOUR_GREEN = 13434675;
   static var COLOUR_YELLOW = 16776960;
   static var COLOUR_LIGHT_ORANGE = 16763904;
   static var COLOUR_DARK_ORANGE = 16746512;
   static var COLOUR_RED = 16730931;
   static var COLOUR_MAGENTA = 14287066;
   static var COLOUR_PURPLE = 8026836;
   static var COLOUR_DARKBLUE = 5932468;
   static var QUALITY_LOW = 0;
   static var QUALITY_MEDIUM = 1;
   static var QUALITY_HIGH = 2;
   static var RATING_BAD = 0;
   static var RATING_OK = 1;
   static var RATING_GREAT = 2;
   static var SPECIAL_NONE = 0;
   static var SPECIAL_RIVERDANCE = 1;
   static var SPECIAL_WORM = 2;
   static var SPECIAL_BREAKDANCE = 3;
   static var SPECIAL_PUFFLESPIN = 4;
   static var ARROWS_MOVIECLIP = "arrows";
   static var DANCER_MOVIECLIP = "dancer";
   static var PUFFLE_MOVIECLIP = "puffle";
   static var SCORE_MOVIECLIP = "score";
   static var MENUS_MOVIECLIP = "menus";
   static var BACKGROUND_MOVIECLIP = "background";
   static var HOLD_POPUP_MOVIECLIP = "noteHoldPopup";
   static var DANCER_MOVIECLIP_BAD = "danceBad";
   static var DANCER_MOVIECLIP_OK = "danceOK";
   static var DANCER_MOVIECLIP_GREAT = "danceGreat";
   static var DANCER_MOVIECLIP_SPECIAL = "danceSpecial";
   static var PUFFLEDANCE_SMALLHOP = 1;
   static var PUFFLEDANCE_BIGHOP = 2;
   static var PUFFLEDANCE_GROOVIN = 3;
   static var PUFFLEDANCE_SOMERSAULT = 4;
   static var PUFFLEDANCE_SPECIAL = 5;
   static var POPUPANIM_PERFECT = "perfectPopup";
   static var POPUPANIM_GREAT = "greatPopup";
   static var POPUPANIM_OK = "okPopup";
   static var POPUPANIM_ALMOST = "almostPopup";
   static var POPUPANIM_BOO = "booPopup";
   static var POPUPANIM_MISS = "missPopup";
   static var MULTIPLIER_LIMIT = com.clubpenguin.games.dancing.GameEngine.MULTIPLIER_LIMIT;
   static var MAX_RATING = com.clubpenguin.games.dancing.GameEngine.MAX_RATING;
   static var ITEM_ID_PURPLE_PUFFLE = 754;
   static var TOTAL_DANCE_FRAMES = 48;
   var specialMove = com.clubpenguin.games.dancing.AnimationEngine.SPECIAL_NONE;
   var lastColour = 1;
   var loopAgain = false;
   var hasPurplePuffle = false;
   var qualityMode = com.clubpenguin.games.dancing.AnimationEngine.QUALITY_HIGH;
   function AnimationEngine($gameEngine, $movie)
   {
      this.gameEngine = $gameEngine;
      this.movie = $movie;
      var _loc3_ = _global.getCurrentShell();
      this.hasPurplePuffle = _loc3_.isItemOnMyPlayer(com.clubpenguin.games.dancing.AnimationEngine.ITEM_ID_PURPLE_PUFFLE);
      if(this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP][com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP] == undefined)
      {
         com.clubpenguin.games.dancing.AnimationEngine.debugTrace("cannot find the dancer movieclip!",com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
      }
      if(this.movie[com.clubpenguin.games.dancing.AnimationEngine.ARROWS_MOVIECLIP] == undefined)
      {
         com.clubpenguin.games.dancing.AnimationEngine.debugTrace("cannot find the arrows movieclip!",com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
      }
      this.dancingPenguin = this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP][com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP];
      this.backgroundLightBuffer = new flash.display.BitmapData(this.movie._width,this.movie._height,true,0);
      this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].multiplier.gotoAndStop("inactive");
      this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].rating.gotoAndStop("inactive");
      this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakLabel.text = "";
      this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakValue.text = "";
      this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].score.text = "";
      this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].scoreValue.text = "";
      this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].rating.text = "";
      this.setMultiplayerScoreVisibility(false);
   }
   function setQualityMode($quality)
   {
      this.qualityMode = $quality;
      this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights._visible = this.qualityMode == com.clubpenguin.games.dancing.AnimationEngine.QUALITY_HIGH;
   }
   function startSong($timePerFrameMillis)
   {
      this.timePerFrameMillis = $timePerFrameMillis;
      this.animationTimeMillis = 0;
      this.specialMove = com.clubpenguin.games.dancing.AnimationEngine.SPECIAL_NONE;
      this.updateCurrentRating(com.clubpenguin.games.dancing.AnimationEngine.RATING_OK,0);
   }
   function endSong()
   {
      this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].crowd.gotoAndStop(1);
      if(this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].discoBall._currentframe != 1)
      {
         this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].discoBall.gotoAndPlay("NoteStreakLost");
      }
      this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].multiplier.gotoAndStop("inactive");
      this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].rating.gotoAndStop("inactive");
      this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakLabel.text = "";
      this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakValue.text = "";
      this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].score.text = "";
      this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].scoreValue.text = "";
      this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].rating.text = "";
      this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakPopup.gotoAndStop("inactive");
      this.setMultiplayerScoreVisibility(false);
      1;
      while(true)
      {
         this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].combo["light1"].gotoAndStop(1);
         2;
      }
      var _loc3_ = new flash.geom.ColorTransform();
      var _loc4_ = undefined;
      _loc4_ = new flash.geom.Transform(this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights.ambience);
      _loc3_.rgb = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_WHITE;
      _loc4_.colorTransform = _loc3_;
      _loc4_ = new flash.geom.Transform(this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights.animation.light1);
      _loc3_.rgb = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_WHITE;
      _loc4_.colorTransform = _loc3_;
      _loc4_ = new flash.geom.Transform(this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights.animation.light2);
      _loc3_.rgb = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_WHITE;
      _loc4_.colorTransform = _loc3_;
      _loc4_ = new flash.geom.Transform(this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights.animation.light3);
      _loc3_.rgb = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_WHITE;
      _loc4_.colorTransform = _loc3_;
      this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].speakerLeft.gotoAndStop("inactive");
      this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].speakerRight.gotoAndStop("inactive");
      this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights.gotoAndStop("inactive");
   }
   function updateBackground()
   {
      var _loc9_ = this.gameEngine.elapsedTimeMillis;
      var _loc8_ = this.gameEngine.currentSong;
      var _loc10_ = this.gameEngine.currentMultiplier;
      if(this.qualityMode == com.clubpenguin.games.dancing.AnimationEngine.QUALITY_MEDIUM || this.qualityMode == com.clubpenguin.games.dancing.AnimationEngine.QUALITY_LOW)
      {
         this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights._visible = false;
         return undefined;
      }
      this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights._visible = true;
      var _loc15_ = _loc9_ % (com.clubpenguin.games.dancing.data.SongData.getMillisPerBar(_loc8_) / 2) / com.clubpenguin.games.dancing.data.SongData.getMillisPerBar(_loc8_) * 2;
      var _loc12_ = Math.round(this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].speakerLeft.animation._totalframes * _loc15_);
      this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].speakerLeft.animation.gotoAndStop(_loc12_);
      this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].speakerRight.animation.gotoAndStop(_loc12_);
      _loc15_ = _loc9_ % (com.clubpenguin.games.dancing.data.SongData.getMillisPerBar(_loc8_) * 2) / com.clubpenguin.games.dancing.data.SongData.getMillisPerBar(_loc8_) / 2;
      _loc12_ = Math.round(this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights.animation._totalframes * _loc15_);
      this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights.animation.gotoAndStop(_loc12_);
      var _loc5_ = undefined;
      var _loc3_ = undefined;
      var _loc6_ = undefined;
      switch(_loc10_)
      {
         case 1:
            _loc5_ = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_OFF_WHITE;
            _loc3_ = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_WHITE;
            _loc6_ = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_OFF_WHITE;
            break;
         case 2:
            _loc5_ = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_WHITE;
            _loc3_ = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_GREEN;
            _loc6_ = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_YELLOW;
            break;
         case 3:
            _loc5_ = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_GREEN;
            _loc3_ = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_YELLOW;
            _loc6_ = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_LIGHT_ORANGE;
            break;
         case 4:
            _loc5_ = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_YELLOW;
            _loc3_ = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_LIGHT_ORANGE;
            _loc6_ = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_DARK_ORANGE;
            break;
         case 5:
            _loc5_ = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_LIGHT_ORANGE;
            _loc3_ = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_DARK_ORANGE;
            _loc6_ = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_RED;
            break;
         case 6:
            _loc5_ = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_DARK_ORANGE;
            _loc3_ = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_RED;
            _loc6_ = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_DARK_ORANGE;
            break;
         case 8:
            _loc5_ = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_DARK_ORANGE;
            _loc3_ = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_RED;
            _loc6_ = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_MAGENTA;
            break;
         case 10:
            _loc5_ = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_MAGENTA;
            _loc3_ = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_PURPLE;
            _loc6_ = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_DARKBLUE;
            break;
         default:
            com.clubpenguin.games.dancing.AnimationEngine.debugTrace("unknown multiplier! multiplier set to " + _loc10_,com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
      }
      var _loc4_ = new flash.geom.ColorTransform();
      var _loc7_ = undefined;
      _loc7_ = new flash.geom.Transform(this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights.ambience);
      _loc4_.rgb = _loc3_;
      _loc7_.colorTransform = _loc4_;
      _loc7_ = new flash.geom.Transform(this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights.animation.light1);
      _loc4_.rgb = _loc3_;
      _loc7_.colorTransform = _loc4_;
      _loc7_ = new flash.geom.Transform(this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights.animation.light2);
      _loc4_.rgb = _loc6_;
      _loc7_.colorTransform = _loc4_;
      _loc7_ = new flash.geom.Transform(this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights.animation.light3);
      _loc4_.rgb = _loc5_;
      _loc7_.colorTransform = _loc4_;
      var _loc11_ = new flash.geom.ColorTransform();
      _loc11_.alphaMultiplier = 0.45;
      this.backgroundLightBuffer.draw(this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights.animation,new flash.geom.Matrix(),_loc11_);
      var _loc2_ = new Array();
      0.95;
      _loc2_ = _loc2_.concat([1,0,0,0,0]);
      _loc2_ = _loc2_.concat([0,1,0,0,0]);
      _loc2_ = _loc2_.concat([0,0,1,0,0]);
      _loc2_ = _loc2_.concat([0,0,0,0.95,0]);
      var _loc14_ = new flash.filters.ColorMatrixFilter(_loc2_);
      this.backgroundLightBuffer.applyFilter(this.backgroundLightBuffer,this.backgroundLightBuffer.rectangle,new flash.geom.Point(0,0),_loc14_);
      this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights.createEmptyMovieClip("buffer",100);
      this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights.buffer.attachBitmap(this.backgroundLightBuffer,1,"auto",true);
   }
   function updateDancefloor()
   {
      var _loc9_ = this.gameEngine.currentTimeMillis;
      var _loc8_ = this.gameEngine.currentMultiplier;
      var _loc10_ = this.gameEngine.isDancing;
      var _loc2_ = Math.round(_loc9_ / 500) % 3;
      if(this.qualityMode == com.clubpenguin.games.dancing.AnimationEngine.QUALITY_MEDIUM || this.qualityMode == com.clubpenguin.games.dancing.AnimationEngine.QUALITY_LOW)
      {
         _loc2_ = Math.round(_loc9_ / 2000) % 3;
      }
      if(_loc2_ != this.lastColour)
      {
         this.lastColour = _loc2_;
         var _loc7_ = _loc8_ >= 6?6:_loc8_;
         var _loc4_ = new Array();
         if(!_loc10_)
         {
            6;
         }
         if(false)
         {
            _loc4_[0] = _loc8_;
            _loc4_[1] = _loc8_ + 1;
            _loc4_[2] = _loc8_ + 2;
         }
         else
         {
            0;
            while(true)
            {
               _loc4_[0] = Math.round(Math.random() * 1000) % 6 + 2;
               1;
            }
         }
         0;
         while(true)
         {
            0;
            while(true)
            {
               _loc2_ = _loc2_ <= _loc4_.length?_loc2_ + 1:0;
               var _loc5_ = Math.floor(Math.random() * 10) % 4 == 0;
               if(_loc5_)
               {
                  _loc2_ = _loc2_ <= _loc4_.length?_loc2_ + 1:0;
               }
               this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].dancefloor["light00"].gotoAndStop(_loc4_[_loc2_]);
               1;
            }
            1;
         }
      }
   }
   function updateDancer($normalisedRating)
   {
      var _loc6_ = this.gameEngine.elapsedTimeMillis;
      var _loc7_ = this.gameEngine.isPlayingGame;
      if(this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP] == undefined)
      {
         var _loc3_ = String(Math.ceil(Math.random() * 4));
         this.dancingPenguin.attachMovie(com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_OK + _loc3_,com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP,1);
         this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].gotoAndStop(1);
         if(this.hasPurplePuffle)
         {
            if(this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP] == undefined)
            {
               this.dancingPenguin.attachMovie(com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP,com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP,2);
               this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP].gotoAndStop(1);
            }
            this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP]._visible = true;
         }
         var _loc8_ = this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP]._totalframes / 4;
         this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].gotoAndStop(_loc8_ + 1);
         this.loopAgain = true;
      }
      if(_loc6_ > this.animationTimeMillis + this.timePerFrameMillis)
      {
         this.animationTimeMillis = this.animationTimeMillis + this.timePerFrameMillis;
         if(this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP]._currentframe < this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP]._totalframes)
         {
            this.updateDancerFrame(this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP]._currentframe);
         }
         else
         {
            if(this.loopAgain)
            {
               this.loopAgain = false;
               this.updateDancerFrame(0);
               return undefined;
            }
            this.loopAgain = true;
            this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].removeMovieClip();
            if(!_loc7_)
            {
               this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP]._visible = false;
               this.gameEngine.isDancing = false;
               return undefined;
            }
            _loc3_ = String(Math.ceil(Math.random() * 4));
            var _loc5_ = Math.floor(Math.random() * 10) % 2 == 0;
            var _loc2_ = undefined;
            var _loc4_ = undefined;
            switch($normalisedRating)
            {
               case com.clubpenguin.games.dancing.AnimationEngine.RATING_BAD:
                  _loc2_ = com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_BAD + _loc3_;
                  _loc4_ = Math.floor(Math.random() * 2) + 1;
                  break;
               case com.clubpenguin.games.dancing.AnimationEngine.RATING_OK:
                  if(_loc5_)
                  {
                     _loc2_ = com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_BAD + _loc3_;
                  }
                  else
                  {
                     _loc2_ = com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_OK + _loc3_;
                  }
                  _loc4_ = Math.floor(Math.random() * 3) + 1;
                  break;
               case com.clubpenguin.games.dancing.AnimationEngine.RATING_GREAT:
                  if(_loc5_)
                  {
                     _loc2_ = com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_OK + _loc3_;
                  }
                  else
                  {
                     _loc2_ = com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_GREAT + _loc3_;
                  }
                  _loc4_ = Math.floor(Math.random() * 4) + 2;
                  break;
               default:
                  com.clubpenguin.games.dancing.AnimationEngine.debugTrace("normalised current rating (" + $normalisedRating + ") is out of range, unable to do new dance move!",com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
            }
            if(this.hasPurplePuffle && !this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP]._visible)
            {
               this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP]._visible = true;
            }
            if(this.specialMove != com.clubpenguin.games.dancing.AnimationEngine.SPECIAL_NONE)
            {
               if(this.specialMove == com.clubpenguin.games.dancing.AnimationEngine.SPECIAL_PUFFLESPIN)
               {
                  this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP]._visible = false;
               }
               else
               {
                  this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP].gotoAndStop(com.clubpenguin.games.dancing.AnimationEngine.PUFFLEDANCE_SPECIAL);
               }
               _loc2_ = com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_SPECIAL + this.specialMove;
               this.specialMove = com.clubpenguin.games.dancing.AnimationEngine.SPECIAL_NONE;
            }
            this.dancingPenguin.attachMovie(_loc2_,com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP,1);
            this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].gotoAndStop(1);
            this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP].gotoAndStop(_loc4_);
            com.clubpenguin.games.dancing.AnimationEngine.debugTrace("add new dancer mc! animation name is " + _loc2_,com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
         }
         this.updateDancer($normalisedRating);
      }
   }
   function updateDancerFrame($targetFrame)
   {
      var _loc2_ = $targetFrame + 1;
      this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].gotoAndStop(_loc2_);
      this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].penguin_mc.eyes_mc.gotoAndStop(_loc2_);
      this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].penguin_mc.beak_mc.gotoAndStop(_loc2_);
      this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].penguin_mc.face_mc.gotoAndStop(_loc2_);
      this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].penguin_mc.frontArm_mc.gotoAndStop(_loc2_);
      this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].penguin_mc.frontArmLines_mc.gotoAndStop(_loc2_);
      this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].penguin_mc.backArm_mc.gotoAndStop(_loc2_);
      this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].penguin_mc.backArmLines_mc.gotoAndStop(_loc2_);
      this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].penguin_mc.body_mc.gotoAndStop(_loc2_);
      this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].penguin_mc.bodyLines_mc.gotoAndStop(_loc2_);
      this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].penguin_mc.shadow_mc.gotoAndStop(_loc2_);
      this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].penguin_mc.feet_mc.gotoAndStop(_loc2_);
      this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].penguin_mc.rightFoot_mc.gotoAndStop(_loc2_);
      this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].penguin_mc.leftFoot_mc.gotoAndStop(_loc2_);
      if(this.hasPurplePuffle)
      {
         if(_loc2_ == 1)
         {
            if(this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP].puffle_mc._totalframes > com.clubpenguin.games.dancing.AnimationEngine.TOTAL_DANCE_FRAMES)
            {
               this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP].puffle_mc.gotoAndStop(com.clubpenguin.games.dancing.AnimationEngine.TOTAL_DANCE_FRAMES + 1);
            }
            else
            {
               this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP].puffle_mc.gotoAndStop(_loc2_);
            }
         }
         else
         {
            var _loc3_ = this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP].puffle_mc._currentframe;
            if(_loc3_ > com.clubpenguin.games.dancing.AnimationEngine.TOTAL_DANCE_FRAMES)
            {
               this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP].puffle_mc.gotoAndStop(com.clubpenguin.games.dancing.AnimationEngine.TOTAL_DANCE_FRAMES + _loc2_);
            }
            else
            {
               this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP].puffle_mc.gotoAndStop(_loc2_);
            }
         }
         this.dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].penguin_mc.puffle_mc.gotoAndStop(_loc2_);
      }
   }
   function updateNoteBonus($noteType, $noteValue, $currentScore)
   {
      this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP][com.clubpenguin.games.dancing.AnimationEngine.HOLD_POPUP_MOVIECLIP + $noteType].gotoAndPlay(2);
      this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP][com.clubpenguin.games.dancing.AnimationEngine.HOLD_POPUP_MOVIECLIP + $noteType].bonus.text = "+" + $noteValue;
      this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].score.text = com.clubpenguin.util.LocaleText.getText("ui_score") + ":";
      this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].scoreValue.text = $currentScore;
   }
   function updateNoteCombo($noteResult, $consecutiveNotes, $comboLost, $currentScore, $normalisedRating)
   {
      switch($noteResult)
      {
         case com.clubpenguin.games.dancing.Note.RESULT_PERFECT:
            this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].notePopup.gotoAndPlay(com.clubpenguin.games.dancing.AnimationEngine.POPUPANIM_PERFECT);
            break;
         case com.clubpenguin.games.dancing.Note.RESULT_GREAT:
            this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].notePopup.gotoAndPlay(com.clubpenguin.games.dancing.AnimationEngine.POPUPANIM_GREAT);
            break;
         case com.clubpenguin.games.dancing.Note.RESULT_GOOD:
            this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].notePopup.gotoAndPlay(com.clubpenguin.games.dancing.AnimationEngine.POPUPANIM_OK);
            break;
         case com.clubpenguin.games.dancing.Note.RESULT_ALMOST:
            this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].notePopup.gotoAndPlay(com.clubpenguin.games.dancing.AnimationEngine.POPUPANIM_ALMOST);
            break;
         case com.clubpenguin.games.dancing.Note.RESULT_MISS:
            this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].notePopup.gotoAndPlay(com.clubpenguin.games.dancing.AnimationEngine.POPUPANIM_MISS);
            break;
         case com.clubpenguin.games.dancing.Note.RESULT_BOO:
            this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].notePopup.gotoAndPlay(com.clubpenguin.games.dancing.AnimationEngine.POPUPANIM_BOO);
      }
      if($consecutiveNotes / 100 >= 1 && $consecutiveNotes % 100 == 0 || $consecutiveNotes == 25 || $consecutiveNotes == 50 || $consecutiveNotes == 75)
      {
         switch($consecutiveNotes)
         {
            case 25:
               this.specialMove = com.clubpenguin.games.dancing.AnimationEngine.SPECIAL_RIVERDANCE;
               this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakPopup.gotoAndPlay("animation");
               var _loc7_ = Math.round(Math.random() * 100) % 2 == 0;
               if(_loc7_)
               {
                  this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakPopup.cadence.gotoAndStop("25NoteStreak1");
               }
               else
               {
                  this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakPopup.cadence.gotoAndStop("25NoteStreak2");
               }
               break;
            case 50:
               this.specialMove = com.clubpenguin.games.dancing.AnimationEngine.SPECIAL_WORM;
               this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakPopup.gotoAndPlay("animation");
               this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakPopup.cadence.gotoAndStop("50NoteStreak");
               break;
            case 75:
               if(this.hasPurplePuffle)
               {
                  this.specialMove = com.clubpenguin.games.dancing.AnimationEngine.SPECIAL_PUFFLESPIN;
               }
               if(this.qualityMode == com.clubpenguin.games.dancing.AnimationEngine.QUALITY_HIGH)
               {
                  this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].discoBall.gotoAndPlay("75NoteStreak");
                  this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakPopup.gotoAndStop(1);
               }
               break;
            default:
               this.specialMove = com.clubpenguin.games.dancing.AnimationEngine.SPECIAL_BREAKDANCE;
               this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakPopup.gotoAndPlay("animation");
               this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakPopup.cadence.gotoAndStop("100NoteStreak");
         }
         if($consecutiveNotes != 75)
         {
            this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakPopup.tween.message.text = com.clubpenguin.util.LocaleText.getTextReplaced("ui_noteCombo",[$consecutiveNotes]).toUpperCase();
         }
      }
      if($comboLost)
      {
         this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakPopup.gotoAndPlay("animation");
         this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakPopup.cadence.gotoAndStop("NoteStreakLost");
         this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakPopup.tween.message.text = com.clubpenguin.util.LocaleText.getText("ui_noteComboLost").toUpperCase();
      }
      1;
      var _loc4_ = new TextFormat();
      _loc4_.bold = true;
      switch(Math.floor($consecutiveNotes / com.clubpenguin.games.dancing.AnimationEngine.MULTIPLIER_LIMIT))
      {
         case 0:
            1;
            _loc4_.color = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_WHITE;
            break;
         case 1:
            2;
            _loc4_.color = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_GREEN;
            break;
         case 2:
            3;
            _loc4_.color = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_YELLOW;
            break;
         case 3:
            4;
            _loc4_.color = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_LIGHT_ORANGE;
            break;
         case 4:
            5;
            _loc4_.color = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_DARK_ORANGE;
            break;
         case 5:
            6;
            _loc4_.color = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_RED;
            break;
         case 6:
            7;
            _loc4_.color = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_MAGENTA;
            break;
         case 7:
            8;
            _loc4_.color = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_PURPLE;
            break;
         default:
            8;
            _loc4_.color = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_PURPLE;
      }
      if($consecutiveNotes < 10)
      {
         this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakLabel.text = "";
         this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakValue.text = "";
      }
      else
      {
         this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakLabel.text = com.clubpenguin.util.LocaleText.getText("ui_combo").toUpperCase();
         this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakValue.text = $consecutiveNotes;
      }
      this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].multiplier.gotoAndStop(8);
      this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakLabel.setTextFormat(_loc4_);
      this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakValue.setTextFormat(_loc4_);
      this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].score.text = com.clubpenguin.util.LocaleText.getText("ui_score") + ":";
      this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].scoreValue.text = $currentScore;
      var _loc6_ = $consecutiveNotes % com.clubpenguin.games.dancing.AnimationEngine.MULTIPLIER_LIMIT;
      1;
      while(true)
      {
         if(1 <= _loc6_)
         {
            this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].combo["light1"].gotoAndStop(9);
         }
         else
         {
            this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].combo["light1"].gotoAndStop(8);
         }
         2;
      }
      this.updateCurrentRating($normalisedRating,$consecutiveNotes);
   }
   function updateCurrentRating($normalisedRating, $consecutiveNotes)
   {
      "";
      switch($normalisedRating)
      {
         case com.clubpenguin.games.dancing.AnimationEngine.RATING_BAD:
            _loc3_ = com.clubpenguin.util.LocaleText.getText("ui_ratingBad");
            this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].speakerLeft.gotoAndStop(com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_BAD);
            this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].speakerRight.gotoAndStop(com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_BAD);
            this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights.gotoAndStop(com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_BAD);
            this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].rating.gotoAndStop(com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_BAD);
            break;
         case com.clubpenguin.games.dancing.AnimationEngine.RATING_OK:
            _loc3_ = com.clubpenguin.util.LocaleText.getText("ui_ratingOK");
            this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].speakerLeft.gotoAndStop(com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_OK);
            this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].speakerRight.gotoAndStop(com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_OK);
            this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights.gotoAndStop(com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_OK);
            this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].rating.gotoAndStop(com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_OK);
            break;
         case com.clubpenguin.games.dancing.AnimationEngine.RATING_GREAT:
            _loc3_ = com.clubpenguin.util.LocaleText.getText("ui_ratingGreat");
            this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].speakerLeft.gotoAndStop(com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_GREAT);
            this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].speakerRight.gotoAndStop(com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_GREAT);
            this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights.gotoAndStop(com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_GREAT);
            this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].rating.gotoAndStop(com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_GREAT);
      }
      1;
      if($consecutiveNotes > 15)
      {
         2;
      }
      if($consecutiveNotes > 35)
      {
         3;
      }
      this.movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].crowd.gotoAndStop(3);
   }
   function setMultiplayerScoreVisibility($visible)
   {
      if($visible)
      {
         this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].multiplayerLabel.text = com.clubpenguin.util.LocaleText.getText("ui_allScores");
         this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].multiplayerNames._visible = true;
      }
      else
      {
         this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].multiplayerLabel.text = "";
         this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].multiplayerNames._visible = false;
      }
   }
   function updateMultiplayerScores(playerScores)
   {
      this.setMultiplayerScoreVisibility(true);
      this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].multiplayerNames.background._height = playerScores.length * 31.25 + 12.5;
      1;
      while(true)
      {
         this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].multiplayerNames["item1"]._visible = false;
         2;
      }
      for(var _loc8_ in playerScores)
      {
         var _loc3_ = parseInt(_loc8_);
         if(_loc3_ >= 15)
         {
            break;
         }
         this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].multiplayerNames["item" + (_loc3_ + 1)]._visible = true;
         this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].multiplayerNames["item" + (_loc3_ + 1)].label.text = playerScores[_loc8_].name + ": " + playerScores[_loc8_].score;
         var _loc6_ = _global.getCurrentShell();
         var _loc7_ = _loc6_.getMyPlayerNickname();
         if(playerScores[_loc8_].name == _loc7_)
         {
            this.movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].multiplayerNames["item" + (_loc3_ + 1)].gotoAndStop(2);
         }
      }
   }
   static function debugTrace(message, priority)
   {
      if(priority == undefined)
      {
         priority = com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE;
      }
      if(com.clubpenguin.util.Reporting.DEBUG)
      {
         com.clubpenguin.util.Reporting.debugTrace("(AnimationEngine) " + message,priority);
      }
   }
}
