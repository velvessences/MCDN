package com.moviestarplanet.userbehavior.utils.chatfilter.userbehaviorcontrol
{
   import com.moviestarplanet.userbehavior.utils.IUserBehaviourService;
   
   public class FilterlistHandlingBase
   {
      
      public static var userBehaviourServiceProvider:IUserBehaviourService;
      
      private static var filterSymbol:String;
      
      protected var _latestCallInfo:UserBehaviorCallInfo;
      
      public function FilterlistHandlingBase()
      {
         super();
      }
      
      public static function setFilterSymbolFromCharCode(param1:int) : void
      {
         filterSymbol = String.fromCharCode(param1);
      }
      
      protected function getParts(param1:String, param2:String) : Array
      {
         var _loc6_:Object = null;
         var _loc8_:String = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:String = null;
         var _loc13_:String = null;
         var _loc3_:Array = new Array();
         var _loc4_:String = filterSymbol + "+";
         var _loc5_:RegExp = new RegExp(_loc4_,"g");
         var _loc7_:String = param2;
         while(true)
         {
            _loc6_ = _loc5_.exec(param1);
            if(_loc6_ == null)
            {
               break;
            }
            _loc9_ = int(_loc6_.index);
            _loc10_ = int(_loc6_[0].length);
            _loc11_ = _loc6_.index + _loc10_;
            _loc8_ = _loc7_.substr(0,_loc9_);
            _loc12_ = _loc7_.substr(_loc9_,_loc10_);
            _loc12_ = _loc12_.split(filterSymbol).join("*");
            _loc8_ += _loc12_;
            _loc7_ = _loc8_ = _loc8_ + _loc7_.slice(_loc11_,param2.length);
         }
         while(true)
         {
            _loc6_ = _loc5_.exec(_loc7_);
            if(_loc6_ == null)
            {
               break;
            }
            _loc13_ = param1.substr(_loc6_.index,_loc6_[0].length);
            _loc3_.push(new Array(_loc13_,_loc6_.index,_loc6_.index + _loc6_[0].length));
         }
         return _loc3_;
      }
   }
}

