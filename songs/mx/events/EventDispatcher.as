if(!_global.mx)
{
   _global.mx = new Object();
}
§§pop();
if(!_global.mx.events)
{
   _global.mx.events = new Object();
}
§§pop();
if(!_global.mx.events.EventDispatcher)
{
   mx.events.EventDispatcher = 0;
   var _loc2_ = 0.prototype;
   0._removeEventListener = function(queue, event, handler)
   {
      if(queue != undefined)
      {
         var _loc4_ = queue.length;
         var _loc1_ = undefined;
         0;
         while(0 < _loc4_)
         {
            var _loc2_ = queue[0];
            if(_loc2_ == handler)
            {
               queue.splice(0,1);
               return undefined;
            }
            1;
         }
      }
   };
   0.initialize = function(object)
   {
      if(mx.events.EventDispatcher._fEventDispatcher == undefined)
      {
         mx.events.EventDispatcher._fEventDispatcher = new mx.events.EventDispatcher();
      }
      object.addEventListener = mx.events.EventDispatcher._fEventDispatcher.addEventListener;
      object.removeEventListener = mx.events.EventDispatcher._fEventDispatcher.removeEventListener;
      object.dispatchEvent = mx.events.EventDispatcher._fEventDispatcher.dispatchEvent;
      object.dispatchQueue = mx.events.EventDispatcher._fEventDispatcher.dispatchQueue;
   };
   _loc2_.dispatchQueue = function(queueObj, eventObj)
   {
      var _loc7_ = "__q_" + eventObj.type;
      var _loc4_ = queueObj[_loc7_];
      if(_loc4_ != undefined)
      {
         var _loc5_ = undefined;
         for(var _loc5_ in _loc4_)
         {
            var _loc1_ = _loc4_[_loc5_];
            var _loc3_ = typeof _loc1_;
            if(_loc3_ == "object" || _loc3_ == "movieclip")
            {
               if(_loc1_.handleEvent != undefined)
               {
                  _loc1_.handleEvent(eventObj);
               }
               if(_loc1_[eventObj.type] != undefined)
               {
                  if(mx.events.EventDispatcher.exceptions[eventObj.type] == undefined)
                  {
                     _loc1_[eventObj.type](eventObj);
                  }
               }
            }
            else
            {
               _loc1_.apply(queueObj,[eventObj]);
            }
         }
      }
   };
   _loc2_.dispatchEvent = function(eventObj)
   {
      if(eventObj.target == undefined)
      {
         eventObj.target = this;
      }
      this[eventObj.type + "Handler"](eventObj);
      this.dispatchQueue(this,eventObj);
   };
   _loc2_.addEventListener = function(event, handler)
   {
      var _loc3_ = "__q_" + event;
      if(this[_loc3_] == undefined)
      {
         this[_loc3_] = new Array();
      }
      _global.ASSetPropFlags(this,_loc3_,1);
      mx.events.EventDispatcher._removeEventListener(this[_loc3_],event,handler);
      this[_loc3_].push(handler);
   };
   _loc2_.removeEventListener = function(event, handler)
   {
      var _loc2_ = "__q_" + event;
      mx.events.EventDispatcher._removeEventListener(this[_loc2_],event,handler);
   };
   0._fEventDispatcher = undefined;
   0.exceptions = {move:1,draw:1,load:1};
   §§push(ASSetPropFlags(mx.events.EventDispatcher.prototype,null,1));
}
§§pop();
