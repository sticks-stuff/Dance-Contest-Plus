class com.clubpenguin.games.dancing.DanceNetClient extends com.clubpenguin.games.generic.NetClient
{
   static var MESSAGE_CHANGE_DIFFICULTY = "zd";
   static var MESSAGE_FINISH_GAME = "zf";
   static var MESSAGE_GET_GAME_AGAIN = "zr";
   static var NET_SEND_INTERVAL = 3000;
   static var STATE_DISCONNECTED = 0;
   static var STATE_ATTEMPT_TO_JOIN = 1;
   static var STATE_QUEUEING = 2;
   static var STATE_IN_GAME = 3;
   function DanceNetClient()
   {
      super();
      this.currentState = com.clubpenguin.games.dancing.DanceNetClient.STATE_DISCONNECTED;
      this.freeSlots = 0;
      this.timeToNextSong = 0;
      this.gameInProgress = false;
      this.songName = "undefined";
   }
   function init($gameEngine)
   {
      super.init();
      this.gameEngine = $gameEngine;
      this.AIRTOWER.addListener(com.clubpenguin.games.dancing.DanceNetClient.MESSAGE_FINISH_GAME,this.handleEndGameMessage,this);
   }
   function destroy()
   {
      super.destroy();
      this.AIRTOWER.removeListener(com.clubpenguin.games.dancing.DanceNetClient.MESSAGE_FINISH_GAME,this.handleEndGameMessage,this);
   }
   function updateKeyPresses($keyPresses)
   {
      var _loc8_ = this.gameEngine.elapsedTimeMillis;
      if(_loc8_ > this.netSendTimeMillis + com.clubpenguin.games.dancing.DanceNetClient.NET_SEND_INTERVAL)
      {
         this.netSendTimeMillis = this.netSendTimeMillis + com.clubpenguin.games.dancing.DanceNetClient.NET_SEND_INTERVAL;
         var _loc5_ = new Array();
         var _loc4_ = new Array();
         _loc4_.push(this.gameEngine.currentScore);
         for(var _loc7_ in this.keyPressIDs)
         {
            var _loc2_ = $keyPresses[this.keyPressIDs[_loc7_]];
            if(_loc2_.noteDuration == 0 || _loc2_.releaseTime != com.clubpenguin.games.dancing.Note.RESULT_NOT_PRESSED)
            {
               var _loc3_ = _loc2_.noteType + "," + _loc2_.pressTime + "," + _loc2_.releaseTime + "," + _loc2_.getNotePressResult();
               _loc4_.push(_loc3_);
            }
            else
            {
               _loc5_.push(this.keyPressIDs[_loc7_]);
            }
         }
         this.keyPressIDs = _loc5_;
         this.sendPlayerActionMessage(_loc4_);
      }
   }
   function handleGetGameMessage(resObj)
   {
      com.clubpenguin.games.generic.NetClient.debugTrace("(DanceNetClient) handleGetGameMessage called",com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
      com.clubpenguin.games.generic.NetClient.debugTrace("smartRoomID: " + resObj[0]);
      com.clubpenguin.games.generic.NetClient.debugTrace("serialisedPlayerInfo: " + resObj[1]);
      com.clubpenguin.games.generic.NetClient.debugTrace("freeSlots: " + resObj[2]);
      com.clubpenguin.games.generic.NetClient.debugTrace("songName: " + com.clubpenguin.util.LocaleText.getText("menu_song_item_" + resObj[3]));
      com.clubpenguin.games.generic.NetClient.debugTrace("timeToNextSong: " + resObj[4]);
      com.clubpenguin.games.generic.NetClient.debugTrace("gameInProgress: " + resObj[5]);
      this.freeSlots = parseInt(resObj[2]);
      this.songName = com.clubpenguin.util.LocaleText.getText("menu_song_item_" + resObj[3]);
      this.timeToNextSong = parseInt(resObj[4]);
      this.gameInProgress = resObj[5] == "true";
      this.currentState = com.clubpenguin.games.dancing.DanceNetClient.STATE_ATTEMPT_TO_JOIN;
      this.gameEngine.setSong(parseInt(resObj[3]));
      this.gameEngine.startTimer();
      this.gameEngine.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_JOIN_GAME);
   }
   function handleJoinGameMessage(resObj)
   {
      com.clubpenguin.games.generic.NetClient.debugTrace("(DanceNetClient) handleJoinGameMessage called",com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
      com.clubpenguin.games.generic.NetClient.debugTrace("smartRoomID: " + resObj[0]);
      com.clubpenguin.games.generic.NetClient.debugTrace("success: " + resObj[1]);
      var _loc3_ = resObj[1] == "true";
      if(_loc3_)
      {
         this.currentState = com.clubpenguin.games.dancing.DanceNetClient.STATE_QUEUEING;
         this.gameEngine.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_QUEUEING);
      }
      else
      {
         this.currentState = com.clubpenguin.games.dancing.DanceNetClient.STATE_DISCONNECTED;
         this.gameEngine.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_SERVERFULL);
      }
   }
   function handleStartGameMessage(resObj)
   {
      com.clubpenguin.games.generic.NetClient.debugTrace("(DanceNetClient) handleStartGameMessage called",com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
      com.clubpenguin.games.generic.NetClient.debugTrace("smartRoomID: " + resObj[0]);
      com.clubpenguin.games.generic.NetClient.debugTrace("noteTimes: " + resObj[1]);
      com.clubpenguin.games.generic.NetClient.debugTrace("noteTypes: " + resObj[2]);
      com.clubpenguin.games.generic.NetClient.debugTrace("noteLengths: " + resObj[3]);
      com.clubpenguin.games.generic.NetClient.debugTrace("millisPerBar: " + resObj[4]);
      var _loc4_ = resObj[1].split(",");
      var _loc2_ = resObj[2].split(",");
      var _loc5_ = resObj[3].split(",");
      this.songData = [[],[],[]];
      for(var _loc6_ in _loc2_)
      {
         this.songData[0][_loc6_] = parseInt(_loc2_[_loc6_]);
         this.songData[1][_loc6_] = parseInt(_loc4_[_loc6_]);
         this.songData[2][_loc6_] = parseInt(_loc5_[_loc6_]);
      }
      this.millisPerBar = parseInt(resObj[4]);
      this.netSendTimeMillis = 0;
      this.currentState = com.clubpenguin.games.dancing.DanceNetClient.STATE_IN_GAME;
      this.gameEngine.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_START_MULTIPLAYER_SONG);
      this.gameEngine.startSong();
   }
   function handleEndGameMessage(resObj)
   {
      com.clubpenguin.games.generic.NetClient.debugTrace("(DanceNetClient) handleEndGameMessage called",com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
      this.handlePlayerActionMessage(resObj);
      this.gameEngine.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_START_MULTIPLAYER_SONG);
      this.gameEngine.endSong();
   }
   function handleUpdateGameMessage(resObj)
   {
      com.clubpenguin.games.generic.NetClient.debugTrace("handleUpdateGameMessage - not implemented!",com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
   }
   function handlePlayerActionMessage(resObj)
   {
      com.clubpenguin.games.generic.NetClient.debugTrace("(DanceNetClient) handlePlayerActionMessage called",com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
      com.clubpenguin.games.generic.NetClient.debugTrace("smartRoomID: " + resObj[0]);
      com.clubpenguin.games.generic.NetClient.debugTrace("playerScores: " + resObj[1]);
      var _loc4_ = resObj[1].split(",");
      var _loc5_ = new Array();
      for(var _loc6_ in _loc4_)
      {
         var _loc2_ = _loc4_[_loc6_].split("|");
         com.clubpenguin.games.generic.NetClient.debugTrace("smartID[" + _loc6_ + "]: " + _loc2_[0]);
         com.clubpenguin.games.generic.NetClient.debugTrace("name[" + _loc6_ + "]: " + _loc2_[1]);
         com.clubpenguin.games.generic.NetClient.debugTrace("score[" + _loc6_ + "]: " + _loc2_[2]);
         com.clubpenguin.games.generic.NetClient.debugTrace("rating[" + _loc6_ + "]: " + _loc2_[3]);
         com.clubpenguin.games.generic.NetClient.debugTrace("noteStreak[" + _loc6_ + "]: " + _loc2_[4]);
         var _loc3_ = new Object();
         _loc3_.smartID = parseInt(_loc2_[0]);
         _loc3_.name = _loc2_[1];
         _loc3_.score = parseInt(_loc2_[2]);
         _loc3_.rating = parseInt(_loc2_[3]);
         _loc3_.streak = parseInt(_loc2_[4]);
         if(_loc3_.name != undefined && _loc3_.name != "undefined")
         {
            _loc5_.push(_loc3_);
         }
      }
      _loc5_.sortOn("score",Array.DESCENDING | Array.NUMERIC);
      if(_loc5_.length > 0)
      {
         this.gameEngine.updateMultiplayerScores(_loc5_);
      }
   }
   function handleCloseGameMessage(resObj)
   {
      com.clubpenguin.games.generic.NetClient.debugTrace("handleCloseGameMessage - not implemented!",com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
   }
   function handleAbortGameMessage(resObj)
   {
      com.clubpenguin.games.generic.NetClient.debugTrace("handleAbortGameMessage - not implemented!",com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
   }
   function sendDifficultyLevelMessage($difficulty)
   {
      com.clubpenguin.games.generic.NetClient.debugTrace("sendDifficultyLevelMessage - difficulty is " + $difficulty);
      this.AIRTOWER.send(com.clubpenguin.games.generic.NetClient.SERVER_SIDE_EXTENSION_NAME,com.clubpenguin.games.dancing.DanceNetClient.MESSAGE_CHANGE_DIFFICULTY,[$difficulty],com.clubpenguin.games.generic.NetClient.SERVER_SIDE_MESSAGE_TYPE,this.roomID);
   }
   function sendGetGameAgainMessage()
   {
      com.clubpenguin.games.generic.NetClient.debugTrace("sendGetGameAgainMessage");
      this.AIRTOWER.send(com.clubpenguin.games.generic.NetClient.SERVER_SIDE_EXTENSION_NAME,com.clubpenguin.games.dancing.DanceNetClient.MESSAGE_GET_GAME_AGAIN,"",com.clubpenguin.games.generic.NetClient.SERVER_SIDE_MESSAGE_TYPE,this.roomID);
   }
}
