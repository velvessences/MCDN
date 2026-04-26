package com.moviestarplanet.services.snapshotservice
{
   import com.moviestarplanet.amf.AmfCaller;
   import com.moviestarplanet.amf.ServiceUrlUtil;
   import com.moviestarplanet.amf.TicketGenerator;
   import flash.utils.ByteArray;
   
   public class SnapshotAmfService
   {
      
      private static var amfCaller:AmfCaller = new AmfCaller("SnapshotService.WebService.AMFBaseWebService");
      
      public function SnapshotAmfService()
      {
         super();
      }
      
      public static function SaveSnapshotInAWS(param1:int, param2:int, param3:String, param4:String, param5:ByteArray, param6:Function = null) : void
      {
         SaveSnapshotInAWSNew(param1,[param2],param3,param4,param5,param6);
      }
      
      public static function SaveSnapshotInAWSNew(param1:int, param2:Array, param3:String, param4:String, param5:ByteArray, param6:Function = null, param7:Function = null) : void
      {
         amfCaller.callFunction("SaveSnapshotInAWSNew",["msp",sessionID,param1,param2,param3,param4,param5],false,param6,param7,ServiceUrlUtil.snapshotServiceHostName);
      }
      
      public static function SaveSnapshotInAWSWithHash(param1:int, param2:Array, param3:String, param4:String, param5:ByteArray, param6:String, param7:Function = null, param8:Function = null) : void
      {
         amfCaller.callFunction("SaveSnapshotInAWSNewWithHash",["msp",sessionID,param1,param2,param3,param4,param5,param6],false,param7,null,ServiceUrlUtil.snapshotServiceHostName);
      }
      
      public static function SaveSnapshotSecure(param1:int, param2:int, param3:String, param4:String, param5:String, param6:ByteArray, param7:String, param8:Function = null, param9:Function = null) : void
      {
         var _loc10_:ByteArray = new ByteArray();
         _loc10_.writeByte(param3.length);
         _loc10_.writeUTFBytes(param3);
         _loc10_.writeBytes(param6);
         amfCaller.callFunction("SaveSnapshotSecure",["msp",sessionID,param1,param2,param4,param5,_loc10_,param7],false,param8,param9,ServiceUrlUtil.snapshotServiceHostName);
      }
      
      public static function UploadPictureToAWS(param1:int, param2:String, param3:String, param4:ByteArray, param5:Function = null, param6:Function = null) : void
      {
         amfCaller.callFunction("UploadPictureToAWS",["msp",sessionID,param1,param2,param3,param4],false,param5,param6,ServiceUrlUtil.snapshotServiceHostName);
      }
      
      public static function UploadPictureThumbnailToAWS(param1:int, param2:String, param3:String, param4:ByteArray, param5:Function = null, param6:Function = null) : void
      {
         amfCaller.callFunction("UploadPictureThumbnailToAWS",["msp",sessionID,param1,param2,param3,param4],false,param5,param6,ServiceUrlUtil.snapshotServiceHostName);
      }
      
      public static function get sessionID() : String
      {
         return TicketGenerator.createTicketHeader().Ticket;
      }
   }
}

