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
if(!_global.com.clubpenguin.games.dancing.data.Song1Easy)
{
   com.clubpenguin.games.dancing.data.Song1Easy = 0;
   var _loc2_ = 0.prototype;
   0.getSongData = function($millisPerBeat)
   {
      var _loc4_ = new Array(com.clubpenguin.games.dancing.Note.TYPE_UP,com.clubpenguin.games.dancing.Note.TYPE_DOWN,com.clubpenguin.games.dancing.Note.TYPE_LEFT,com.clubpenguin.games.dancing.Note.TYPE_RIGHT,com.clubpenguin.games.dancing.Note.TYPE_RIGHT,com.clubpenguin.games.dancing.Note.TYPE_DOWN,com.clubpenguin.games.dancing.Note.TYPE_UP,com.clubpenguin.games.dancing.Note.TYPE_LEFT,com.clubpenguin.games.dancing.Note.TYPE_LEFT,com.clubpenguin.games.dancing.Note.TYPE_UP,com.clubpenguin.games.dancing.Note.TYPE_DOWN,com.clubpenguin.games.dancing.Note.TYPE_LEFT,com.clubpenguin.games.dancing.Note.TYPE_RIGHT,com.clubpenguin.games.dancing.Note.TYPE_RIGHT,com.clubpenguin.games.dancing.Note.TYPE_DOWN,com.clubpenguin.games.dancing.Note.TYPE_UP,com.clubpenguin.games.dancing.Note.TYPE_LEFT,com.clubpenguin.games.dancing.Note.TYPE_UP,com.clubpenguin.games.dancing.Note.TYPE_RIGHT,com.clubpenguin.games.dancing.Note.TYPE_DOWN,com.clubpenguin.games.dancing.Note.TYPE_UP,com.clubpenguin.games.dancing.Note.TYPE_DOWN,com.clubpenguin.games.dancing.Note.TYPE_LEFT,com.clubpenguin.games.dancing.Note.TYPE_RIGHT,com.clubpenguin.games.dancing.Note.TYPE_RIGHT,com.clubpenguin.games.dancing.Note.TYPE_DOWN,com.clubpenguin.games.dancing.Note.TYPE_UP,com.clubpenguin.games.dancing.Note.TYPE_RIGHT,com.clubpenguin.games.dancing.Note.TYPE_DOWN,com.clubpenguin.games.dancing.Note.TYPE_UP,com.clubpenguin.games.dancing.Note.TYPE_UP,com.clubpenguin.games.dancing.Note.TYPE_DOWN,com.clubpenguin.games.dancing.Note.TYPE_LEFT,com.clubpenguin.games.dancing.Note.TYPE_RIGHT,com.clubpenguin.games.dancing.Note.TYPE_DOWN,com.clubpenguin.games.dancing.Note.TYPE_DOWN,com.clubpenguin.games.dancing.Note.TYPE_DOWN,com.clubpenguin.games.dancing.Note.TYPE_UP,com.clubpenguin.games.dancing.Note.TYPE_UP,com.clubpenguin.games.dancing.Note.TYPE_UP,com.clubpenguin.games.dancing.Note.TYPE_RIGHT,com.clubpenguin.games.dancing.Note.TYPE_LEFT,com.clubpenguin.games.dancing.Note.TYPE_RIGHT,com.clubpenguin.games.dancing.Note.TYPE_DOWN,com.clubpenguin.games.dancing.Note.TYPE_LEFT,com.clubpenguin.games.dancing.Note.TYPE_UP,com.clubpenguin.games.dancing.Note.TYPE_RIGHT,com.clubpenguin.games.dancing.Note.TYPE_DOWN,com.clubpenguin.games.dancing.Note.TYPE_UP,com.clubpenguin.games.dancing.Note.TYPE_LEFT,com.clubpenguin.games.dancing.Note.TYPE_RIGHT,com.clubpenguin.games.dancing.Note.TYPE_DOWN,com.clubpenguin.games.dancing.Note.TYPE_UP,com.clubpenguin.games.dancing.Note.TYPE_LEFT,com.clubpenguin.games.dancing.Note.TYPE_UP,com.clubpenguin.games.dancing.Note.TYPE_UP,com.clubpenguin.games.dancing.Note.TYPE_DOWN,com.clubpenguin.games.dancing.Note.TYPE_DOWN,com.clubpenguin.games.dancing.Note.TYPE_UP,com.clubpenguin.games.dancing.Note.TYPE_DOWN,com.clubpenguin.games.dancing.Note.TYPE_UP,com.clubpenguin.games.dancing.Note.TYPE_DOWN,com.clubpenguin.games.dancing.Note.TYPE_LEFT,com.clubpenguin.games.dancing.Note.TYPE_RIGHT,com.clubpenguin.games.dancing.Note.TYPE_UP,com.clubpenguin.games.dancing.Note.TYPE_UP,com.clubpenguin.games.dancing.Note.TYPE_DOWN,com.clubpenguin.games.dancing.Note.TYPE_DOWN,com.clubpenguin.games.dancing.Note.TYPE_UP,com.clubpenguin.games.dancing.Note.TYPE_DOWN,com.clubpenguin.games.dancing.Note.TYPE_UP,com.clubpenguin.games.dancing.Note.TYPE_DOWN,com.clubpenguin.games.dancing.Note.TYPE_LEFT,com.clubpenguin.games.dancing.Note.TYPE_RIGHT,com.clubpenguin.games.dancing.Note.TYPE_DOWN,com.clubpenguin.games.dancing.Note.TYPE_DOWN,com.clubpenguin.games.dancing.Note.TYPE_UP,com.clubpenguin.games.dancing.Note.TYPE_UP,com.clubpenguin.games.dancing.Note.TYPE_LEFT,com.clubpenguin.games.dancing.Note.TYPE_LEFT);
      var _loc2_ = new Array($millisPerBeat * 16,$millisPerBeat * 12,$millisPerBeat * 8,$millisPerBeat * 20,$millisPerBeat * 36,$millisPerBeat * 28,$millisPerBeat * 32,$millisPerBeat * 24,$millisPerBeat * 60,$millisPerBeat * 92,$millisPerBeat * 96,$millisPerBeat * 100,$millisPerBeat * 88,$millisPerBeat * 104,$millisPerBeat * 112,$millisPerBeat * 108,$millisPerBeat * 116,$millisPerBeat * 56,$millisPerBeat * 72,$millisPerBeat * 76,$millisPerBeat * 176,$millisPerBeat * 172,$millisPerBeat * 168,$millisPerBeat * 180,$millisPerBeat * 220,$millisPerBeat * 216,$millisPerBeat * 212,$millisPerBeat * 222,$millisPerBeat * 218,$millisPerBeat * 214,$millisPerBeat * 156,$millisPerBeat * 160,$millisPerBeat * 164,$millisPerBeat * 152,$millisPerBeat * 232,$millisPerBeat * 236,$millisPerBeat * 238,$millisPerBeat * 224,$millisPerBeat * 228,$millisPerBeat * 230,$millisPerBeat * 240,$millisPerBeat * 240,$millisPerBeat * 58,$millisPerBeat * 62,$millisPerBeat * 68,$millisPerBeat * 64,$millisPerBeat * 66,$millisPerBeat * 70,$millisPerBeat * 74,$millisPerBeat * 78,$millisPerBeat * 80,$millisPerBeat * 84,$millisPerBeat * 82,$millisPerBeat * 86,$millisPerBeat * 128,$millisPerBeat * 132,$millisPerBeat * 120,$millisPerBeat * 124,$millisPerBeat * 134,$millisPerBeat * 126,$millisPerBeat * 144,$millisPerBeat * 140,$millisPerBeat * 136,$millisPerBeat * 148,$millisPerBeat * 40,$millisPerBeat * 44,$millisPerBeat * 48,$millisPerBeat * 52,$millisPerBeat * 46,$millisPerBeat * 54,$millisPerBeat * 188,$millisPerBeat * 192,$millisPerBeat * 196,$millisPerBeat * 184,$millisPerBeat * 208,$millisPerBeat * 210,$millisPerBeat * 204,$millisPerBeat * 206,$millisPerBeat * 200,$millisPerBeat * 202);
      var _loc3_ = new Array($millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0,$millisPerBeat * 0);
      return new Array(_loc4_,_loc2_,_loc3_);
   };
   §§push(ASSetPropFlags(com.clubpenguin.games.dancing.data.Song1Easy.prototype,null,1));
}
§§pop();
