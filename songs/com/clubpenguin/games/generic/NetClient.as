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
if(!_global.com.clubpenguin.games)
{
   _global.com.clubpenguin.games = new Object();
}
§§pop();
if(!_global.com.clubpenguin.games.generic)
{
   _global.com.clubpenguin.games.generic = new Object();
}
§§pop();
if(!_global.com.clubpenguin.games.generic.NetClient)
{
   com.clubpenguin.games.generic.NetClient = 0;
   var _loc2_ = 0.prototype;
   _loc2_.init = function()
   {
      this.SHELL = _global.getCurrentShell();
      this.AIRTOWER = _global.getCurrentAirtower();
      this.AIRTOWER.addListener(com.clubpenguin.games.generic.NetClient.MESSAGE_GET_GAME,this.handleGetGameMessage,this);
      this.AIRTOWER.addListener(com.clubpenguin.games.generic.NetClient.MESSAGE_JOIN_GAME,this.handleJoinGameMessage,this);
      this.AIRTOWER.addListener(com.clubpenguin.games.generic.NetClient.MESSAGE_LEAVE_GAME,this.handleAbortGameMessage,this);
      this.AIRTOWER.addListener(com.clubpenguin.games.generic.NetClient.MESSAGE_UPDATE_PLAYERLIST,this.handleUpdateGameMessage,this);
      this.AIRTOWER.addListener(com.clubpenguin.games.generic.NetClient.MESSAGE_START_GAME,this.handleStartGameMessage,this);
      this.AIRTOWER.addListener(com.clubpenguin.games.generic.NetClient.MESSAGE_ABORT_GAME,this.handleCloseGameMessage,this);
      this.AIRTOWER.addListener(com.clubpenguin.games.generic.NetClient.MESSAGE_PLAYER_ACTION,this.handlePlayerActionMessage,this);
      this.AIRTOWER.addListener(com.clubpenguin.games.generic.NetClient.MESSAGE_GAME_OVER,this.handleGameOverMessage,this);
      this.roomID = this.SHELL.getCurrentGameRoomId();
      this.roomID = 49;
   };
   _loc2_.destroy = function()
   {
      this.AIRTOWER.removeListener(com.clubpenguin.games.generic.NetClient.MESSAGE_GET_GAME,this.handleGetGameMessage,this);
      this.AIRTOWER.removeListener(com.clubpenguin.games.generic.NetClient.MESSAGE_JOIN_GAME,this.handleJoinGameMessage,this);
      this.AIRTOWER.removeListener(com.clubpenguin.games.generic.NetClient.MESSAGE_LEAVE_GAME,this.handleAbortGameMessage,this);
      this.AIRTOWER.removeListener(com.clubpenguin.games.generic.NetClient.MESSAGE_UPDATE_PLAYERLIST,this.handleUpdateGameMessage,this);
      this.AIRTOWER.removeListener(com.clubpenguin.games.generic.NetClient.MESSAGE_START_GAME,this.handleStartGameMessage,this);
      this.AIRTOWER.removeListener(com.clubpenguin.games.generic.NetClient.MESSAGE_ABORT_GAME,this.handleCloseGameMessage,this);
      this.AIRTOWER.removeListener(com.clubpenguin.games.generic.NetClient.MESSAGE_PLAYER_ACTION,this.handlePlayerActionMessage,this);
      this.AIRTOWER.removeListener(com.clubpenguin.games.generic.NetClient.MESSAGE_GAME_OVER,this.handleGameOverMessage,this);
   };
   _loc2_.sendGetGameMessage = function()
   {
      com.clubpenguin.games.generic.NetClient.debugTrace("sendGetGameMessage");
      this.AIRTOWER.send(com.clubpenguin.games.generic.NetClient.SERVER_SIDE_EXTENSION_NAME,com.clubpenguin.games.generic.NetClient.MESSAGE_GET_GAME,"",com.clubpenguin.games.generic.NetClient.SERVER_SIDE_MESSAGE_TYPE,this.roomID);
   };
   _loc2_.sendJoinGameMessage = function()
   {
      com.clubpenguin.games.generic.NetClient.debugTrace("sendJoinGameMessage");
      this.AIRTOWER.send(com.clubpenguin.games.generic.NetClient.SERVER_SIDE_EXTENSION_NAME,com.clubpenguin.games.generic.NetClient.MESSAGE_JOIN_GAME,"",com.clubpenguin.games.generic.NetClient.SERVER_SIDE_MESSAGE_TYPE,this.roomID);
   };
   _loc2_.sendLeaveGameMessage = function()
   {
      com.clubpenguin.games.generic.NetClient.debugTrace("sendLeaveGameMessage");
      this.AIRTOWER.send(com.clubpenguin.games.generic.NetClient.SERVER_SIDE_EXTENSION_NAME,com.clubpenguin.games.generic.NetClient.MESSAGE_LEAVE_GAME,"",com.clubpenguin.games.generic.NetClient.SERVER_SIDE_MESSAGE_TYPE,this.roomID);
   };
   _loc2_.sendAbortGameMessage = function()
   {
      com.clubpenguin.games.generic.NetClient.debugTrace("sendAbortGameMessage");
      this.AIRTOWER.send(com.clubpenguin.games.generic.NetClient.SERVER_SIDE_EXTENSION_NAME,com.clubpenguin.games.generic.NetClient.MESSAGE_ABORT_GAME,"",com.clubpenguin.games.generic.NetClient.SERVER_SIDE_MESSAGE_TYPE,this.roomID);
   };
   _loc2_.sendPlayerActionMessage = function(messageData)
   {
      com.clubpenguin.games.generic.NetClient.debugTrace("sendPlayerActionMessage - messageData is...");
      for(var _loc3_ in messageData)
      {
         com.clubpenguin.games.generic.NetClient.debugTrace("messageData[" + _loc3_ + "] = " + messageData[_loc3_]);
      }
      this.AIRTOWER.send(com.clubpenguin.games.generic.NetClient.SERVER_SIDE_EXTENSION_NAME,com.clubpenguin.games.generic.NetClient.MESSAGE_PLAYER_ACTION,messageData,com.clubpenguin.games.generic.NetClient.SERVER_SIDE_MESSAGE_TYPE,this.roomID);
   };
   _loc2_.handleGetGameMessage = function(resObj)
   {
      com.clubpenguin.games.generic.NetClient.debugTrace("handleGetGameMessage - not implemented!",com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
   };
   _loc2_.handleJoinGameMessage = function(resObj)
   {
      com.clubpenguin.games.generic.NetClient.debugTrace("handleJoinGameMessage - not implemented!",com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
   };
   _loc2_.handleStartGameMessage = function(resObj)
   {
      com.clubpenguin.games.generic.NetClient.debugTrace("handleStartGameMessage - not implemented!",com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
   };
   _loc2_.handleUpdateGameMessage = function(resObj)
   {
      com.clubpenguin.games.generic.NetClient.debugTrace("handleUpdateGameMessage - not implemented!",com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
   };
   _loc2_.handlePlayerActionMessage = function(resObj)
   {
      com.clubpenguin.games.generic.NetClient.debugTrace("handlePlayerActionMessage - not implemented!",com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
   };
   _loc2_.handleCloseGameMessage = function(resObj)
   {
      com.clubpenguin.games.generic.NetClient.debugTrace("handleCloseGameMessage - not implemented!",com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
   };
   _loc2_.handleAbortGameMessage = function(resObj)
   {
      com.clubpenguin.games.generic.NetClient.debugTrace("handleAbortGameMessage - not implemented!",com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
   };
   _loc2_.handleGameOverMessage = function(resObj)
   {
      com.clubpenguin.games.generic.NetClient.debugTrace("handleGameOverMessage - not implemented!",com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
   };
   0.debugTrace = function(message, priority)
   {
      if(priority == undefined)
      {
         priority = com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE;
      }
      if(com.clubpenguin.util.Reporting.DEBUG)
      {
         com.clubpenguin.util.Reporting.debugTrace("(NetClient) " + message,priority);
      }
   };
   0.MESSAGE_GET_GAME = "gz";
   0.MESSAGE_JOIN_GAME = "jz";
   0.MESSAGE_LEAVE_GAME = "lz";
   0.MESSAGE_PLAYER_ACTION = "zm";
   0.MESSAGE_START_GAME = "sz";
   0.MESSAGE_UPDATE_PLAYERLIST = "uz";
   0.MESSAGE_ABORT_GAME = "cz";
   0.MESSAGE_GAME_OVER = "zo";
   0.SERVER_SIDE_EXTENSION_NAME = "z";
   0.SERVER_SIDE_MESSAGE_TYPE = "str";
   §§push(ASSetPropFlags(com.clubpenguin.games.generic.NetClient.prototype,null,1));
}
§§pop();
