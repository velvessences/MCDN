package com.moviestarplanet.globalsharedutils
{
   import com.hurlant.crypto.hash.MD5;
   import com.hurlant.util.Base64;
   import com.hurlant.util.Hex;
   import flash.utils.ByteArray;
   
   public class SerializeUtils
   {
      
      public function SerializeUtils()
      {
         super();
      }
      
      public static function serialize(param1:Object) : ByteArray
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         return _loc2_;
      }
      
      public static function deserialize(param1:ByteArray) : *
      {
         var value:ByteArray = param1;
         var result:Object = null;
         if(value == null)
         {
            return null;
         }
         try
         {
            value.position = 0;
            if(value.bytesAvailable > 0)
            {
               result = value.readObject();
            }
         }
         catch(error:Error)
         {
            return null;
         }
         return result;
      }
      
      public static function serializeAndCompress(param1:Object) : ByteArray
      {
         var _loc2_:ByteArray = serialize(param1);
         _loc2_.compress();
         return _loc2_;
      }
      
      public static function uncompressAndDeserialize(param1:ByteArray, param2:String = "zlib") : *
      {
         param1.uncompress(param2);
         return deserialize(param1);
      }
      
      public static function serializeToString(param1:Object) : String
      {
         if(param1 == null)
         {
            throw new Error("null isn\'t a legal serialization candidate");
         }
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return Base64.encodeByteArray(_loc2_);
      }
      
      public static function base64JsonToObject(param1:String) : Object
      {
         var result:Object = null;
         var bytes:ByteArray = null;
         var json:String = null;
         var value:String = param1;
         if(value == null)
         {
            return null;
         }
         try
         {
            bytes = Base64.decodeToByteArray(value);
            if(!bytes)
            {
               return null;
            }
            json = bytes.toString();
            if(!json)
            {
               return null;
            }
            result = JSON.parse(json);
         }
         catch(error:Error)
         {
            return null;
         }
         return result;
      }
      
      public static function deserializeFromString(param1:String) : *
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:ByteArray = Base64.decodeToByteArray(param1);
         return deserialize(_loc2_);
      }
      
      public static function checkHash(param1:String, param2:String) : Boolean
      {
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUTFBytes(param1);
         _loc3_.position = 0;
         var _loc4_:MD5 = new MD5();
         var _loc5_:String = Hex.fromArray(_loc4_.hash(_loc3_));
         return _loc5_ == param2;
      }
      
      public static function hashString(param1:String) : String
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeUTFBytes(param1);
         _loc2_.position = 0;
         var _loc3_:MD5 = new MD5();
         return Hex.fromArray(_loc3_.hash(_loc2_));
      }
      
      public static function clone(param1:Object) : *
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return _loc2_.readObject();
      }
   }
}

