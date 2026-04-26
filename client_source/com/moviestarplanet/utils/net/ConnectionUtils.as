package com.moviestarplanet.utils.net
{
   import com.moviestarplanet.globalsharedutils.SerializeUtils;
   import flash.net.SharedObject;
   import flash.utils.ByteArray;
   
   public class ConnectionUtils
   {
      
      public function ConnectionUtils()
      {
         super();
      }
      
      public static function sendTextToSo(param1:SharedObject, param2:String) : void
      {
         setTextInSo(param1,"tmp",param2);
         param1.send();
      }
      
      public static function setTextInSo(param1:SharedObject, param2:String, param3:String) : void
      {
         param1.setProperty(param2,param3);
         setObjectInSo("obj",null,param1);
      }
      
      public static function setObjectInSo(param1:String, param2:Object, param3:SharedObject) : void
      {
         var _loc4_:ByteArray = null;
         if(param2 != null)
         {
            _loc4_ = SerializeUtils.serialize(param2);
            _loc4_.compress();
            param3.setProperty(param1,_loc4_);
            param3.setDirty(param1);
         }
         else
         {
            param3.setProperty(param1,null);
         }
      }
   }
}

