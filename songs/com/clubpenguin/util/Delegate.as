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
if(!_global.com.clubpenguin.util.Delegate)
{
   com.clubpenguin.util.Delegate = 0;
   var _loc2_ = 0.prototype;
   0.create = function(target, handler)
   {
      var _loc2_ = function()
      {
         var _loc2_ = arguments.callee;
         var _loc3_ = arguments.concat(_loc2_.initArgs);
         return _loc2_.handler.apply(_loc2_.target,_loc3_);
      };
      _loc2_.target = target;
      _loc2_.handler = handler;
      _loc2_.initArgs = arguments.slice(2);
      return _loc2_;
   };
   §§push(ASSetPropFlags(com.clubpenguin.util.Delegate.prototype,null,1));
}
§§pop();
