package com.moviestarplanet.configurations
{
   public class URLUtilLite
   {
      
      private static const SQUARE_BRACKET_LEFT:String = "]";
      
      private static const SQUARE_BRACKET_RIGHT:String = "[";
      
      private static const SQUARE_BRACKET_LEFT_ENCODED:String = encodeURIComponent(SQUARE_BRACKET_LEFT);
      
      private static const SQUARE_BRACKET_RIGHT_ENCODED:String = encodeURIComponent(SQUARE_BRACKET_RIGHT);
      
      public function URLUtilLite()
      {
         super();
      }
      
      public static function getServerName(param1:String) : String
      {
         var _loc2_:String = getServerNameWithPort(param1);
         var _loc3_:int = indexOfLeftSquareBracket(_loc2_);
         _loc3_ = _loc3_ > -1 ? int(_loc2_.indexOf(":",_loc3_)) : int(_loc2_.indexOf(":"));
         if(_loc3_ > 0)
         {
            _loc2_ = _loc2_.substring(0,_loc3_);
         }
         return _loc2_;
      }
      
      private static function indexOfLeftSquareBracket(param1:String) : int
      {
         var _loc2_:int = int(param1.indexOf(SQUARE_BRACKET_LEFT));
         if(_loc2_ == -1)
         {
            _loc2_ = int(param1.indexOf(SQUARE_BRACKET_LEFT_ENCODED));
         }
         return _loc2_;
      }
      
      public static function getServerNameWithPort(param1:String) : String
      {
         var _loc2_:int = param1.indexOf("/") + 2;
         var _loc3_:int = int(param1.indexOf("/",_loc2_));
         return _loc3_ == -1 ? param1.substring(_loc2_) : param1.substring(_loc2_,_loc3_);
      }
      
      public static function getProtocol(param1:String) : String
      {
         var _loc2_:int = int(param1.indexOf("/"));
         var _loc3_:int = int(param1.indexOf(":/"));
         if(_loc3_ > -1 && _loc3_ < _loc2_)
         {
            return param1.substring(0,_loc3_);
         }
         _loc3_ = int(param1.indexOf("::"));
         if(_loc3_ > -1 && _loc3_ < _loc2_)
         {
            return param1.substring(0,_loc3_);
         }
         return "";
      }
   }
}

