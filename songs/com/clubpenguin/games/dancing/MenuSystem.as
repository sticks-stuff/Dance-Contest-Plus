class com.clubpenguin.games.dancing.MenuSystem
{
   static var MENU_START_MULTIPLAYER_SONG = -300;
   static var MENU_START_SONG = -200;
   static var MENU_NONE = -100;
   static var MENU_WELCOME_INTRO = 100;
   static var MENU_WELCOME = 101;
   static var MENU_WELCOME_OPTIONS = 102;
   static var MENU_SINGLEPLAYER_INTRO = 103;
   static var MENU_SINGLEPLAYER_SONG = 104;
   static var MENU_SINGLEPLAYER_DIFFICULTY = 105;
   static var MENU_SINGLEPLAYER_PREGAME = 106;
   static var MENU_SINGLEPLAYER_POSTGAME_INTRO = 107;
   static var MENU_SINGLEPLAYER_COINSWON = 108;
   static var MENU_SINGLEPLAYER_POSTGAME = 109;
   static var MENU_SINGLEPLAYER_POSTGAME_STATS = 110;
   static var MENU_SINGLEPLAYER_DIFFICULTY_SECRET = 111;
   static var MENU_HOW_TO_PLAY_INTRO_WALK = 200;
   static var MENU_HOW_TO_PLAY_INTRO = 201;
   static var MENU_HOW_TO_PLAY_TIMING_ANIM = 202;
   static var MENU_HOW_TO_PLAY_TIMING = 203;
   static var MENU_HOW_TO_PLAY_TIMING_KEYPRESS = 204;
   static var MENU_HOW_TO_PLAY_MULTIPLE_ANIM = 205;
   static var MENU_HOW_TO_PLAY_MULTIPLE = 206;
   static var MENU_HOW_TO_PLAY_MULTIPLE_KEYPRESS = 207;
   static var MENU_HOW_TO_PLAY_HOLD_ANIM = 208;
   static var MENU_HOW_TO_PLAY_HOLD = 209;
   static var MENU_HOW_TO_PLAY_HOLD_KEYPRESS = 210;
   static var MENU_HOW_TO_PLAY_HOLD_OUTRO = 211;
   static var MENU_HOW_TO_PLAY_MULTIPLIER_ANIM = 212;
   static var MENU_HOW_TO_PLAY_MULTIPLIER = 213;
   static var MENU_HOW_TO_PLAY_MULTIPLIER_DOWN = 214;
   static var MENU_HOW_TO_PLAY_MULTIPLIER_LEFT_ANIM = 215;
   static var MENU_HOW_TO_PLAY_MULTIPLIER_LEFT = 216;
   static var MENU_HOW_TO_PLAY_MULTIPLIER_RIGHT_ANIM = 217;
   static var MENU_HOW_TO_PLAY_MULTIPLIER_RIGHT = 218;
   static var MENU_HOW_TO_PLAY_MULTIPLIER_OUTRO = 219;
   static var MENU_HOW_TO_PLAY_OUTRO = 220;
   static var MENU_HOW_TO_PLAY_OUTRO_WALK = 221;
   static var MENU_MULTIPLAYER_CONNECTING = 300;
   static var MENU_MULTIPLAYER_JOIN_GAME = 301;
   static var MENU_MULTIPLAYER_JOINING = 302;
   static var MENU_MULTIPLAYER_QUEUEING = 303;
   static var MENU_MULTIPLAYER_SERVERFULL = 304;
   static var MENU_MULTIPLAYER_DIFFICULTY = 305;
   static var MENU_MULTIPLAYER_POSTGAME_INTRO = 306;
   static var MENU_MULTIPLAYER_COINSWON = 307;
   static var MENU_MULTIPLAYER_POSTGAME = 308;
   static var MENU_MULTIPLAYER_POSTGAME_STATS = 309;
   static var MOVIE_HOST_COMPERE = "host";
   static var MOVIE_SPEECH_BUBBLE = "speech";
   static var MOVIE_OPTIONS_MENU = "options";
   static var MOVIE_OPTIONS_BACKGROUND = "background";
   static var MOVIE_OPTIONS_ITEM = "item";
   static var MOVIE_HOW_TO_PLAY_ANIM = "howtoplay";
   static var ANIM_FRAME_WALK_ON = "enter";
   static var ANIM_FRAME_TALK = "talk";
   static var ANIM_FRAME_WAIT = "wait";
   static var ANIM_FRAME_WALK_OFF = "exit";
   static var ANIM_FRAME_HELP_ON = "help_on";
   static var ANIM_FRAME_HELP_OFF = "help_off";
   static var ANIM_FRAME_HELP_TALK = "help_talk";
   static var ANIM_FRAME_HELP_WAIT = "help_wait";
   static var ANIM_FRAME_HOWTOPLAY_HITNOTE = "howtoplay_hitnote";
   static var ANIM_FRAME_HOWTOPLAY_TWOATONCE = "howtoplay_twoatonce";
   static var ANIM_FRAME_HOWTOPLAY_HOLDNOTE = "howtoplay_holdnote";
   static var ANIM_FRAME_HOWTOPLAY_COMBO = "howtoplay_combo";
   static var ANIM_FRAME_SECRET_DIFFICULTY = "secret_difficulty";
   static var ANIM_FRAME_POSTGAME_STATS = "postgame_stats";
   static var SPEECH_NORMAL_XPOSITION = 72.5;
   static var SPEECH_HELPANIM_XPOSITION = 180;
   var menuData = new Array();
   var currentMenu = com.clubpenguin.games.dancing.MenuSystem.MENU_NONE;
   var talking = false;
   function MenuSystem($parent, $movie)
   {
      this.movie = $movie;
      this.gameEngine = $parent;
      this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME_INTRO);
   }
   function getCurrentMenu()
   {
      return this.currentMenu;
   }
   function loadMenu($menuID)
   {
      if($menuID == undefined)
      {
         this.currentMenu++;
      }
      else
      {
         this.currentMenu = $menuID;
      }
      switch(this.currentMenu)
      {
         case com.clubpenguin.games.dancing.MenuSystem.MENU_NONE:
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_START_SONG:
         case com.clubpenguin.games.dancing.MenuSystem.MENU_START_MULTIPLAYER_SONG:
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_WALK_OFF);
            this.hideSpeechBubble();
            this.hideMenuOptions();
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME_INTRO:
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_WALK_ON);
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].nextMenu = com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME;
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
            this.hideSpeechBubble();
            this.hideMenuOptions();
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME:
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_TALK);
            switch(this.gameEngine.allSongsLoaded())
            {
               case com.clubpenguin.games.dancing.GameEngine.SONG_LOAD_OK:
                  this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_welcome_intro"));
                  break;
               case com.clubpenguin.games.dancing.GameEngine.SONG_LOAD_ERROR:
                  this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_loading_songs_error"));
                  break;
               case com.clubpenguin.games.dancing.GameEngine.SONG_LOAD_IN_PROGRESS:
                  this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_loading_songs"));
            }
            this.hideMenuOptions();
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME_OPTIONS:
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_WAIT);
            var _loc5_ = new Array();
            _loc5_.push(com.clubpenguin.util.LocaleText.getText("menu_welcome_item_singleplayer"));
            _loc5_.push(com.clubpenguin.util.LocaleText.getText("menu_welcome_item_multiplayer"));
            _loc5_.push(com.clubpenguin.util.LocaleText.getText("menu_welcome_item_howtoplay"));
            this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_welcome_choice"));
            this.showMenuOptions(_loc5_);
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_INTRO:
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_TALK);
            this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_singleplayer_intro") + "\n" + this.gameEngine.getRandomTipText(true));
            this.hideMenuOptions();
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_SONG:
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_WAIT);
            var _loc3_ = new Array();
            _loc3_.push(com.clubpenguin.util.LocaleText.getText("menu_song_item_0"));
            _loc3_.push(com.clubpenguin.util.LocaleText.getText("menu_song_item_1"));
            _loc3_.push(com.clubpenguin.util.LocaleText.getText("menu_song_item_2"));
            _loc3_.push(com.clubpenguin.util.LocaleText.getText("menu_song_item_back"));
            this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_song_choice"));
            this.showMenuOptions(_loc3_);
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_DIFFICULTY:
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_WAIT);
            var _loc2_ = new Array();
            _loc2_.push(com.clubpenguin.util.LocaleText.getText("menu_difficulty_item_easy"));
            _loc2_.push(com.clubpenguin.util.LocaleText.getText("menu_difficulty_item_medium"));
            _loc2_.push(com.clubpenguin.util.LocaleText.getText("menu_difficulty_item_hard"));
            _loc2_.push(com.clubpenguin.util.LocaleText.getText("menu_difficulty_item_back"));
            this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_difficulty_choice"));
            this.showMenuOptions(_loc2_);
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = true;
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_SECRET_DIFFICULTY);
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_DIFFICULTY_SECRET:
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_WAIT);
            _loc2_ = new Array();
            _loc2_.push(com.clubpenguin.util.LocaleText.getText("menu_difficulty_confirm_secret"));
            _loc2_.push(com.clubpenguin.util.LocaleText.getText("menu_difficulty_change"));
            this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_difficulty_choice_secret"));
            this.showMenuOptions(_loc2_);
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_PREGAME:
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_TALK);
            this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_singleplayer_pregame"));
            this.hideMenuOptions();
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_POSTGAME_INTRO:
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_WALK_ON);
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].nextMenu = com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_COINSWON;
            this.hideSpeechBubble();
            this.hideMenuOptions();
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_COINSWON:
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_TALK);
            this.showSpeechBubble(this.gameEngine.getJudgesOpinion());
            this.hideMenuOptions();
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_POSTGAME:
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_WAIT);
            var _loc4_ = new Array();
            _loc4_.push(com.clubpenguin.util.LocaleText.getText("menu_postgame_viewstats"));
            _loc4_.push(com.clubpenguin.util.LocaleText.getText("menu_postgame_playagain"));
            _loc4_.push(com.clubpenguin.util.LocaleText.getText("menu_postgame_newsong"));
            _loc4_.push(com.clubpenguin.util.LocaleText.getText("menu_postgame_mainmenu"));
            this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_singleplayer_postgame"));
            this.showMenuOptions(_loc4_);
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_POSTGAME_STATS:
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_TALK);
            this.showSpeechBubble(this.gameEngine.getPostGameStatsSpeechBubble());
            this.hideMenuOptions();
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = true;
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_POSTGAME_STATS);
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_INTRO_WALK:
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_HELP_ON);
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
            this.hideSpeechBubble();
            this.hideMenuOptions();
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_INTRO:
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_HELP_TALK);
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
            this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_howtoplay_intro"));
            this.hideMenuOptions();
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_TIMING_ANIM:
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_HELP_WAIT);
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = true;
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_HOWTOPLAY_HITNOTE);
            this.hideSpeechBubble();
            this.hideMenuOptions();
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_TIMING:
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_HELP_TALK);
            this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_howtoplay_timing"));
            this.hideMenuOptions();
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLE_ANIM:
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_HELP_WAIT);
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = true;
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_HOWTOPLAY_TWOATONCE);
            this.hideSpeechBubble();
            this.hideMenuOptions();
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLE:
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_HELP_TALK);
            this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_howtoplay_multiple"));
            this.hideMenuOptions();
            this.keyPressTest = [false,false];
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_HOLD_ANIM:
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_HELP_WAIT);
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = true;
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_HOWTOPLAY_HOLDNOTE);
            this.hideSpeechBubble();
            this.hideMenuOptions();
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_HOLD:
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_HELP_TALK);
            this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_howtoplay_hold"));
            this.hideMenuOptions();
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLIER_ANIM:
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_HELP_WAIT);
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = true;
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_HOWTOPLAY_COMBO);
            this.hideSpeechBubble();
            this.hideMenuOptions();
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLIER:
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_HELP_TALK);
            this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_howtoplay_multiplier"));
            this.hideMenuOptions();
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLIER_LEFT_ANIM:
         case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLIER_RIGHT_ANIM:
         case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLIER_OUTRO:
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM].animation.play();
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_OUTRO:
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_HELP_TALK);
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
            this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_howtoplay_outro"));
            this.hideMenuOptions();
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_OUTRO_WALK:
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_HELP_OFF);
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
            this.hideSpeechBubble();
            this.hideMenuOptions();
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_CONNECTING:
         case com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_JOINING:
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_WAIT);
            this.hideSpeechBubble();
            this.hideMenuOptions();
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_JOIN_GAME:
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_TALK);
            this.showSpeechBubble(this.gameEngine.getJoinGameSpeechBubble());
            this.showMenuOptions(this.gameEngine.getJoinGameOptions());
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_QUEUEING:
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_TALK);
            this.showSpeechBubble(this.gameEngine.getWaitingSpeechBubble());
            var _loc6_ = new Array();
            _loc6_.push(com.clubpenguin.util.LocaleText.getText("menu_difficulty_change") + " " + this.gameEngine.getCurrentDifficulty());
            _loc6_.push(com.clubpenguin.util.LocaleText.getText("menu_multiplayer_response_mainmenu"));
            this.showMenuOptions(_loc6_);
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_SERVERFULL:
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_TALK);
            this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_multiplayer_serverfull"));
            this.hideMenuOptions();
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_DIFFICULTY:
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_WAIT);
            _loc2_ = new Array();
            _loc2_.push(com.clubpenguin.util.LocaleText.getText("menu_difficulty_item_easy"));
            _loc2_.push(com.clubpenguin.util.LocaleText.getText("menu_difficulty_item_medium"));
            _loc2_.push(com.clubpenguin.util.LocaleText.getText("menu_difficulty_item_hard"));
            _loc2_.push(com.clubpenguin.util.LocaleText.getText("menu_difficulty_item_expert"));
            this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_difficulty_choice"));
            this.showMenuOptions(_loc2_);
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = true;
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_SECRET_DIFFICULTY);
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_POSTGAME_INTRO:
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_WALK_ON);
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].nextMenu = com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_COINSWON;
            this.hideSpeechBubble();
            this.hideMenuOptions();
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_COINSWON:
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_TALK);
            this.showSpeechBubble(this.gameEngine.getMultiplayerCoinsWon());
            this.hideMenuOptions();
            this.gameEngine.setMultiplayerScoreVisibility(true);
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_POSTGAME:
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_WAIT);
            _loc4_ = new Array();
            _loc4_.push(com.clubpenguin.util.LocaleText.getText("menu_postgame_viewstats"));
            _loc4_.push(com.clubpenguin.util.LocaleText.getText("menu_postgame_joinqueue"));
            _loc4_.push(com.clubpenguin.util.LocaleText.getText("menu_postgame_mainmenu"));
            this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_singleplayer_postgame"));
            this.showMenuOptions(_loc4_);
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
            this.gameEngine.setMultiplayerScoreVisibility(false);
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_POSTGAME_STATS:
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_TALK);
            this.showSpeechBubble(this.gameEngine.getPostGameStatsSpeechBubble());
            this.hideMenuOptions();
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = true;
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_POSTGAME_STATS);
            this.gameEngine.setMultiplayerScoreVisibility(true);
            break;
         default:
            com.clubpenguin.games.dancing.MenuSystem.debugTrace("unknown menu id entered: " + this.currentMenu,com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
      }
   }
   function handleClick($buttonID)
   {
      switch(this.currentMenu)
      {
         case com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME_INTRO:
            this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME);
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME:
            switch(this.gameEngine.allSongsLoaded())
            {
               case com.clubpenguin.games.dancing.GameEngine.SONG_LOAD_OK:
                  this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME_OPTIONS);
                  break;
               case com.clubpenguin.games.dancing.GameEngine.SONG_LOAD_ERROR:
                  this.gameEngine.destroy();
                  break;
               case com.clubpenguin.games.dancing.GameEngine.SONG_LOAD_IN_PROGRESS:
            }
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME_OPTIONS:
            switch($buttonID)
            {
               case 1:
                  this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_INTRO);
                  break;
               case 2:
                  this.gameEngine.joinMultiplayerServer();
                  this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_CONNECTING);
                  break;
               case 3:
                  this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_INTRO_WALK);
                  break;
               default:
                  return undefined;
            }
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_INTRO:
            this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_SONG);
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_SONG:
            switch($buttonID)
            {
               case 1:
                  this.gameEngine.setSong(com.clubpenguin.games.dancing.GameEngine.SONG_ONE);
                  break;
               case 2:
                  this.gameEngine.setSong(com.clubpenguin.games.dancing.GameEngine.SONG_TWO);
                  break;
               case 3:
                  this.gameEngine.setSong(com.clubpenguin.games.dancing.GameEngine.SONG_THREE);
                  break;
               case 4:
                  this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME_OPTIONS);
                  return undefined;
                  break;
               default:
                  return undefined;
            }
            this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_DIFFICULTY);
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_DIFFICULTY:
            switch($buttonID)
            {
               case 1:
                  this.gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EASY);
                  break;
               case 2:
                  this.gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_MEDIUM);
                  break;
               case 3:
                  this.gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_HARD);
                  break;
               case 4:
                  this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_SONG);
                  return undefined;
                  break;
               case 5:
                  this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_DIFFICULTY_SECRET);
                  return undefined;
                  break;
               default:
                  return undefined;
            }
            this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_PREGAME);
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_DIFFICULTY_SECRET:
            switch($buttonID)
            {
               case 1:
                  this.gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EXPERT);
                  this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_PREGAME);
                  return undefined;
               case 2:
                  this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_DIFFICULTY);
                  return undefined;
            }
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_PREGAME:
            this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_START_SONG);
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_COINSWON:
            this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_POSTGAME);
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_POSTGAME:
            switch($buttonID)
            {
               case 1:
                  this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_POSTGAME_STATS);
                  break;
               case 2:
                  this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_PREGAME);
                  break;
               case 3:
                  this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_SONG);
                  break;
               case 4:
                  this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME_OPTIONS);
                  break;
               default:
                  return undefined;
            }
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_POSTGAME_STATS:
            if($buttonID == 1)
            {
               this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_POSTGAME);
            }
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_INTRO:
         case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_OUTRO:
            this.loadMenu(this.currentMenu + 1);
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_TIMING_KEYPRESS:
            if($buttonID == 40)
            {
               this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLE_ANIM);
            }
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLE_KEYPRESS:
            if($buttonID == 37)
            {
               this.keyPressTest[0] = true;
               if(this.keyPressTest[1])
               {
                  this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_HOLD_ANIM);
                  break;
               }
            }
            if($buttonID == 39)
            {
               this.keyPressTest[1] = true;
               if(this.keyPressTest[0])
               {
                  this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_HOLD_ANIM);
                  break;
               }
            }
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_HOLD_KEYPRESS:
            if($buttonID == 40)
            {
               this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLIER_ANIM);
            }
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLIER_DOWN:
            if($buttonID == 40)
            {
               this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLIER_LEFT_ANIM);
            }
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLIER_LEFT:
            if($buttonID == 37)
            {
               this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLIER_RIGHT_ANIM);
            }
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLIER_RIGHT:
            if($buttonID == 39)
            {
               this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLIER_OUTRO);
            }
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_JOIN_GAME:
            if($buttonID == undefined)
            {
               return undefined;
            }
            if(this.gameEngine.multiplayerJoinAvailable() && $buttonID == 1)
            {
               this.gameEngine.joinMultiplayerGame();
               this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_JOINING);
            }
            else
            {
               this.gameEngine.leaveMultiplayerServer();
               this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME_OPTIONS);
            }
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_QUEUEING:
            switch($buttonID)
            {
               case 1:
                  this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_DIFFICULTY);
                  break;
               case 2:
                  this.gameEngine.leaveMultiplayerServer();
                  this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME_OPTIONS);
                  break;
               default:
                  return undefined;
            }
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_SERVERFULL:
            this.gameEngine.leaveMultiplayerServer();
            this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME_OPTIONS);
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_DIFFICULTY:
            switch($buttonID)
            {
               case 1:
                  this.gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EASY);
                  break;
               case 2:
                  this.gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_MEDIUM);
                  break;
               case 3:
                  this.gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_HARD);
                  break;
               case 4:
                  this.gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EXPERT);
            }
            if(this.gameEngine.getNetClientState() == com.clubpenguin.games.dancing.DanceNetClient.STATE_QUEUEING)
            {
               this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_QUEUEING);
            }
            else if(this.gameEngine.getNetClientState() == com.clubpenguin.games.dancing.DanceNetClient.STATE_DISCONNECTED)
            {
               this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_SERVERFULL);
            }
            else
            {
               this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_JOINING);
            }
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_COINSWON:
            this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_POSTGAME);
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_POSTGAME:
            switch($buttonID)
            {
               case 1:
                  this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_POSTGAME_STATS);
                  break;
               case 2:
                  this.gameEngine.rejoinMultiplayerServer();
                  this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_CONNECTING);
                  break;
               case 3:
                  this.gameEngine.leaveMultiplayerServer();
                  this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME_OPTIONS);
                  break;
               default:
                  return undefined;
            }
            break;
         case com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_POSTGAME_STATS:
            if($buttonID == 1)
            {
               this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_POSTGAME);
               break;
            }
      }
   }
   function showSpeechBubble($text)
   {
      this.movie.speech.message.text = $text;
      this.updateSpeechBubble();
      this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_SPEECH_BUBBLE]._visible = true;
      if(this.currentMenu >= com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_INTRO_WALK && this.currentMenu <= com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_OUTRO_WALK)
      {
         this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_SPEECH_BUBBLE]._x = com.clubpenguin.games.dancing.MenuSystem.SPEECH_HELPANIM_XPOSITION;
      }
      else
      {
         this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_SPEECH_BUBBLE]._x = com.clubpenguin.games.dancing.MenuSystem.SPEECH_NORMAL_XPOSITION;
      }
   }
   function hideSpeechBubble()
   {
      this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_SPEECH_BUBBLE]._visible = false;
   }
   function updateSpeechBubble()
   {
      80;
      24;
      12;
      5;
      1;
      while(true)
      {
         if(this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_SPEECH_BUBBLE].message.textHeight < 36)
         {
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_SPEECH_BUBBLE].bubble._height = 104;
            break;
         }
         2;
      }
   }
   function showMenuOptions($menuOptions)
   {
      27;
      14;
      3.5;
      this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_OPTIONS_MENU][com.clubpenguin.games.dancing.MenuSystem.MOVIE_OPTIONS_BACKGROUND]._height = $menuOptions.length * 27 + ($menuOptions.length - 1) * 3.5 + 14;
      0;
      while(true)
      {
         1;
         if(true)
         {
            this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_OPTIONS_MENU][com.clubpenguin.games.dancing.MenuSystem.MOVIE_OPTIONS_ITEM + 1]._visible = false;
            continue;
         }
         break;
      }
      0;
      while(0 < $menuOptions.length)
      {
         this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_OPTIONS_MENU][com.clubpenguin.games.dancing.MenuSystem.MOVIE_OPTIONS_ITEM + 1].label.text = $menuOptions[0];
         this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_OPTIONS_MENU][com.clubpenguin.games.dancing.MenuSystem.MOVIE_OPTIONS_ITEM + 1]._visible = true;
         1;
      }
      this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_OPTIONS_MENU]._visible = true;
      this.talking = false;
   }
   function hideMenuOptions()
   {
      this.movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_OPTIONS_MENU]._visible = false;
      this.talking = true;
   }
   function isTalking()
   {
      return this.talking;
   }
   static function debugTrace(message, priority)
   {
      if(priority == undefined)
      {
         priority = com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE;
      }
      if(com.clubpenguin.util.Reporting.DEBUG)
      {
         com.clubpenguin.util.Reporting.debugTrace("(MenuSystem) " + message,priority);
      }
   }
}
