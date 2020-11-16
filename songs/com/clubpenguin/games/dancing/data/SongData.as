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
if(!_global.com.clubpenguin.games.dancing)
{
   _global.com.clubpenguin.games.dancing = new Object();
}
§§pop();
if(!_global.com.clubpenguin.games.dancing.data)
{
   _global.com.clubpenguin.games.dancing.data = new Object();
}
§§pop();
if(!_global.com.clubpenguin.games.dancing.data.SongData)
{
   com.clubpenguin.games.dancing.data.SongData = 0;
   var _loc2_ = 0.prototype;
   0.getSongData = function($song, $difficulty)
   {
      var _loc1_ = undefined;
      switch($song)
      {
         case com.clubpenguin.games.dancing.GameEngine.SONG_ONE:
            var _loc4_ = com.clubpenguin.games.dancing.data.SongData.getMillisPerBar(com.clubpenguin.games.dancing.GameEngine.SONG_ONE);
            var _loc3_ = com.clubpenguin.games.dancing.data.SongData.getSongLength(com.clubpenguin.games.dancing.GameEngine.SONG_ONE);
            _loc1_ = _loc4_ / com.clubpenguin.games.dancing.data.SongData.BEATS_PER_BAR;
            switch($difficulty)
            {
               case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EASY:
                  return com.clubpenguin.games.dancing.data.Song1Easy.getSongData(_loc1_);
               case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_MEDIUM:
                  return com.clubpenguin.games.dancing.data.Song1Medium.getSongData(_loc1_);
               case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_HARD:
                  return com.clubpenguin.games.dancing.data.Song1Hard.getSongData(_loc1_);
               case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EXPERT:
                  return com.clubpenguin.games.dancing.data.SongData.getExpertSongData(_loc1_,_loc3_);
            }
            break;
         case com.clubpenguin.games.dancing.GameEngine.SONG_TWO:
            _loc4_ = com.clubpenguin.games.dancing.data.SongData.getMillisPerBar(com.clubpenguin.games.dancing.GameEngine.SONG_TWO);
            _loc3_ = com.clubpenguin.games.dancing.data.SongData.getSongLength(com.clubpenguin.games.dancing.GameEngine.SONG_TWO);
            _loc1_ = _loc4_ / com.clubpenguin.games.dancing.data.SongData.BEATS_PER_BAR;
            switch($difficulty)
            {
               case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EASY:
                  return com.clubpenguin.games.dancing.data.Song2Easy.getSongData(_loc1_);
               case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_MEDIUM:
                  return com.clubpenguin.games.dancing.data.Song2Medium.getSongData(_loc1_);
               case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_HARD:
                  return com.clubpenguin.games.dancing.data.Song2Hard.getSongData(_loc1_);
               case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EXPERT:
                  return com.clubpenguin.games.dancing.data.SongData.getExpertSongData(_loc1_,_loc3_);
            }
            break;
         case com.clubpenguin.games.dancing.GameEngine.SONG_THREE:
            _loc4_ = com.clubpenguin.games.dancing.data.SongData.getMillisPerBar(com.clubpenguin.games.dancing.GameEngine.SONG_THREE);
            _loc3_ = com.clubpenguin.games.dancing.data.SongData.getSongLength(com.clubpenguin.games.dancing.GameEngine.SONG_THREE);
            _loc1_ = _loc4_ / com.clubpenguin.games.dancing.data.SongData.BEATS_PER_BAR;
            switch($difficulty)
            {
               case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EASY:
                  return com.clubpenguin.games.dancing.data.Song3Easy.getSongData(_loc1_);
               case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_MEDIUM:
                  return com.clubpenguin.games.dancing.data.Song3Medium.getSongData(_loc1_);
               case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_HARD:
                  return com.clubpenguin.games.dancing.data.Song3Hard.getSongData(_loc1_);
               case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EXPERT:
                  return com.clubpenguin.games.dancing.data.SongData.getExpertSongData(_loc1_,_loc3_);
            }
      }
      return undefined;
   };
   0.getMillisPerBar = function($song)
   {
      switch($song)
      {
         case com.clubpenguin.games.dancing.GameEngine.SONG_ONE:
            return 2000;
         case com.clubpenguin.games.dancing.GameEngine.SONG_TWO:
            return 2070;
         case com.clubpenguin.games.dancing.GameEngine.SONG_THREE:
            return 2666;
         default:
            return undefined;
      }
   };
   0.getSongLength = function($song)
   {
      switch($song)
      {
         case com.clubpenguin.games.dancing.GameEngine.SONG_ONE:
            return 200;
         case com.clubpenguin.games.dancing.GameEngine.SONG_TWO:
            return 216;
         case com.clubpenguin.games.dancing.GameEngine.SONG_THREE:
            return 192;
         default:
            return undefined;
      }
   };
   0.getExpertSongData = function($millisPerBeat, $songLength)
   {
      var _loc4_ = new Array();
      var _loc3_ = new Array();
      var _loc2_ = new Array();
      var _loc5_ = new Array(0,0,0,0);
      4;
      while(4 < $songLength)
      {
         if(false)
         {
            com.clubpenguin.games.dancing.data.SongData.addNote(4,4,_loc5_,$millisPerBeat,_loc2_,_loc3_,_loc4_);
            if(Math.floor(Math.random() * 2) == 0)
            {
               com.clubpenguin.games.dancing.data.SongData.addNote(4,0,_loc5_,$millisPerBeat,_loc2_,_loc3_,_loc4_);
            }
         }
         else if(true)
         {
            com.clubpenguin.games.dancing.data.SongData.addNote(4,4,_loc5_,$millisPerBeat,_loc2_,_loc3_,_loc4_);
            if(Math.floor(Math.random() * 4) == 0)
            {
               com.clubpenguin.games.dancing.data.SongData.addNote(4,0,_loc5_,$millisPerBeat,_loc2_,_loc3_,_loc4_);
            }
         }
         else if(true)
         {
            com.clubpenguin.games.dancing.data.SongData.addNote(4,2,_loc5_,$millisPerBeat,_loc2_,_loc3_,_loc4_);
         }
         else if(Math.floor(Math.random() * 4) > 0)
         {
            com.clubpenguin.games.dancing.data.SongData.addNote(4,0,_loc5_,$millisPerBeat,_loc2_,_loc3_,_loc4_);
            if(Math.floor(Math.random() * 4) == 0)
            {
               com.clubpenguin.games.dancing.data.SongData.addNote(4.5,0,_loc5_,$millisPerBeat,_loc2_,_loc3_,_loc4_);
            }
         }
         5;
      }
      return new Array(_loc2_,_loc3_,_loc4_);
   };
   0.addNote = function($beatTime, $maxBeatLength, $lastNoteTimes, $millisPerBeat, $noteTypes, $noteTimes, $noteLengths)
   {
      var _loc3_ = Math.floor(Math.random() * $maxBeatLength) * $millisPerBeat;
      var _loc2_ = $beatTime * $millisPerBeat;
      var _loc1_ = Math.floor(Math.random() * 4);
      if(_loc2_ > $lastNoteTimes[_loc1_])
      {
         $noteTypes.push(_loc1_);
         $noteTimes.push(_loc2_);
         $noteLengths.push(_loc3_);
         $lastNoteTimes[_loc1_] = _loc2_ + _loc3_;
      }
   };
   0.BEATS_PER_BAR = 4;
   §§push(ASSetPropFlags(com.clubpenguin.games.dancing.data.SongData.prototype,null,1));
}
§§pop();
