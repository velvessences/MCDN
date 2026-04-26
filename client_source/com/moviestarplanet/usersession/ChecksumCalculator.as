package com.moviestarplanet.usersession
{
   import com.adobe.crypto.MD5;
   import com.adobe.rtc.util.Base64Encoder;
   import com.moviestarplanet.usersession.valueobjects.NewActorCreationData;
   import flash.utils.ByteArray;
   
   public class ChecksumCalculator
   {
      
      public function ChecksumCalculator()
      {
         super();
      }
      
      private static function ಇ(param1:String) : String
      {
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:int = 0;
         var _loc2_:String = MD5.hash(param1);
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length * 2)
         {
            _loc6_ = _loc2_.slice(_loc4_,_loc4_ + 1);
            _loc7_ = _loc2_.slice(_loc4_ + 1,_loc4_ + 2);
            _loc8_ = "0x" + _loc6_ + _loc7_;
            _loc9_ = int(int(_loc8_));
            _loc3_.writeByte(_loc9_);
            _loc4_ += 2;
         }
         _loc3_.position = 0;
         var _loc5_:Base64Encoder = new Base64Encoder();
         _loc5_.encodeBytes(_loc3_,0,16);
         return _loc5_.toString();
      }
      
      public function calculateFromNewActorCreationData(param1:NewActorCreationData) : String
      {
         return this.calculateFromStrings(param1.ChosenActorName,param1.ChosenPassword);
      }
      
      public function calculateFromStrings(param1:String, param2:String) : String
      {
         var _loc3_:String = param1 + param2 + this.ಆ();
         return ಇ(_loc3_);
      }
      
      private function ಆ() : String
      {
         var _loc1_:ByteArray = new ByteArray();
         _loc1_.writeByte(120);
         _loc1_.writeByte(-38);
         _loc1_.writeByte(99);
         _loc1_.writeByte(16);
         _loc1_.writeByte(12);
         _loc1_.writeByte(51);
         _loc1_.writeByte(41);
         _loc1_.writeByte(-118);
         _loc1_.writeByte(12);
         _loc1_.writeByte(50);
         _loc1_.writeByte(81);
         _loc1_.writeByte(73);
         _loc1_.writeByte(49);
         _loc1_.writeByte(-56);
         _loc1_.writeByte(13);
         _loc1_.writeByte(48);
         _loc1_.writeByte(54);
         _loc1_.writeByte(54);
         _loc1_.writeByte(14);
         _loc1_.writeByte(48);
         _loc1_.writeByte(46);
         _loc1_.writeByte(2);
         _loc1_.writeByte(0);
         _loc1_.writeByte(45);
         _loc1_.writeByte(-30);
         _loc1_.writeByte(4);
         _loc1_.writeByte(-16);
         _loc1_.uncompress();
         _loc1_.position = 0;
         return _loc1_.readUTF();
      }
   }
}

