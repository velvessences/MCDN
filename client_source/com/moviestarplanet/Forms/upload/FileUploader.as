package com.moviestarplanet.Forms.upload
{
   import com.moviestarplanet.amf.TicketGenerator;
   import com.moviestarplanet.configurations.Config;
   import flash.net.FileReference;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   
   public class FileUploader
   {
      
      public function FileUploader()
      {
         super();
      }
      
      public function upload(param1:FileReference, param2:String, param3:String = "") : void
      {
         param1.upload(this.getURLRequest(param3),param2);
      }
      
      private function getURLRequest(param1:String) : URLRequest
      {
         var _loc2_:URLVariables = new URLVariables();
         if(param1)
         {
            _loc2_.decode(param1);
         }
         _loc2_.ticket = TicketGenerator.createTicketHeader().Ticket;
         var _loc3_:String = Config.webserverPath + "upload.ashx";
         var _loc4_:URLRequest = new URLRequest(_loc3_);
         _loc4_.method = URLRequestMethod.POST;
         _loc4_.data = _loc2_;
         return _loc4_;
      }
   }
}

