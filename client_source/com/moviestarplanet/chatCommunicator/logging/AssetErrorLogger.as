package com.moviestarplanet.chatCommunicator.logging
{
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.LogEvent;
   import com.moviestarplanet.events.MessageCommunicator;
   
   public class AssetErrorLogger
   {
      
      public function AssetErrorLogger()
      {
         super();
      }
      
      public static function sendErrorEventToLoggly(param1:String) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:int = int(param1.lastIndexOf("/"));
         if(_loc2_ == -1)
         {
            return;
         }
         var _loc3_:String = param1.substring(0,_loc2_);
         var _loc4_:String = getContentName(param1,_loc2_);
         var _loc5_:Object = {
            "path":_loc3_,
            "contentName":_loc4_
         };
         var _loc6_:String = getContentNameWithoutNumbers(_loc4_);
         if(_loc6_ != _loc4_)
         {
            _loc5_.contentNameWithoutNumbers = _loc6_;
         }
         var _loc7_:Object = new Object();
         _loc7_.missingAsset = _loc5_;
         MessageCommunicator.send(new LogEvent(LogEvent.ERROR,LogEvent.ASSET_CANNOT_BE_LOADED,_loc7_));
      }
      
      private static function getContentName(param1:String, param2:int) : String
      {
         var _loc3_:String = param1.substring(param2 + 1);
         param2 = int(_loc3_.lastIndexOf("?v="));
         if(param2 != -1)
         {
            _loc3_ = _loc3_.substring(0,param2);
         }
         return _loc3_;
      }
      
      private static function getContentNameWithoutNumbers(param1:String) : String
      {
         var _loc2_:RegExp = /[0-9]/g;
         return param1.replace(_loc2_,"");
      }
   }
}

