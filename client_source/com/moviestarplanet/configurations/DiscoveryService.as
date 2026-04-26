package com.moviestarplanet.configurations
{
   import com.moviestarplanet.configurations.environment.Environment;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestHeader;
   
   public class DiscoveryService
   {
      
      public static const ENVIRONMENT_URL:String = "https://frontpage.mspcdns.com/htmlapi/api/v1/environments/";
      
      private var mOnSuccess:Function;
      
      private var mOnFail:Function;
      
      private var mEnvironment:Environment;
      
      public function DiscoveryService()
      {
         super();
      }
      
      public function loadEnvironmentForMyIp(param1:Function, param2:Function) : void
      {
         this.mOnSuccess = param1;
         this.mOnFail = param2;
         this.validateCallbacks(param1,param2);
         var _loc3_:String = ENVIRONMENT_URL + "?ip=detect&game=msp";
         this.executeLoad(_loc3_);
      }
      
      public function loadEnvironment(param1:String, param2:Function, param3:Function) : void
      {
         this.mOnSuccess = param2;
         this.mOnFail = param3;
         this.validateCallbacks(param2,param3);
         var _loc4_:String = ENVIRONMENT_URL + "msp-" + param1;
         this.executeLoad(_loc4_);
      }
      
      private function executeLoad(param1:String) : void
      {
         var _loc2_:URLRequest = new URLRequest(param1);
         var _loc3_:URLLoader = new URLLoader();
         var _loc4_:URLRequestHeader = new URLRequestHeader("ACCEPT","application/json");
         _loc2_.requestHeaders.push(_loc4_);
         _loc3_.addEventListener(Event.COMPLETE,this.onEnvironmentLoadSuccess);
         _loc3_.addEventListener(IOErrorEvent.IO_ERROR,this.onFail);
         _loc3_.load(_loc2_);
      }
      
      private function onEnvironmentLoadSuccess(param1:Event) : void
      {
         var environmentData:Object = null;
         var event:Event = param1;
         try
         {
            environmentData = JSON.parse(event.target.data as String);
            this.mEnvironment = Environment.fromJson(environmentData[0]);
         }
         catch(e:Error)
         {
            mOnFail();
            return;
         }
         this.loadServiceEndpoints();
      }
      
      private function loadServiceEndpoints() : void
      {
         var _loc1_:URLRequest = new URLRequest(this.mEnvironment.ServiceDiscoveryUrl);
         var _loc2_:URLLoader = new URLLoader();
         var _loc3_:URLRequestHeader = new URLRequestHeader("ACCEPT","application/json");
         _loc1_.requestHeaders.push(_loc3_);
         _loc2_.addEventListener(Event.COMPLETE,this.onEndpointsLoaded);
         _loc2_.addEventListener(IOErrorEvent.IO_ERROR,this.onFail);
         _loc2_.load(_loc1_);
      }
      
      private function onFail(param1:IOErrorEvent) : void
      {
         this.mOnFail();
      }
      
      private function onEndpointsLoaded(param1:Event) : void
      {
         var discoData:Object = null;
         var cdnAssets:String = null;
         var cdnContent:String = null;
         var webServer:String = null;
         var event:Event = param1;
         try
         {
            discoData = JSON.parse(event.target.data);
            cdnAssets = this.getService("assets",discoData.Services);
            cdnContent = this.getService("content",discoData.Services);
            webServer = this.getService("mspwebservice",discoData.Services);
            this.mEnvironment.cdnContentPath = this.sanitizeURL(cdnContent);
            this.mEnvironment.cdnAssetPath = this.sanitizeURL(cdnAssets);
            this.mEnvironment.webServerPath = this.sanitizeURL(webServer);
         }
         catch(e:Error)
         {
            mOnFail(mEnvironment);
            return;
         }
         this.mOnSuccess(this.mEnvironment);
      }
      
      private function getService(param1:String, param2:Array) : String
      {
         var _loc3_:int = 0;
         var _loc4_:Object = null;
         _loc3_ = 0;
         while(_loc3_ < param2.length)
         {
            _loc4_ = param2[_loc3_];
            if(_loc4_.Id == param1)
            {
               return _loc4_.Endpoint;
            }
            _loc3_++;
         }
         return null;
      }
      
      private function sanitizeURL(param1:String) : String
      {
         if(param1.charAt(param1.length - 1) != "/")
         {
            param1 += "/";
         }
         return param1;
      }
      
      private function validateCallbacks(param1:Function, param2:Function) : void
      {
         if(param1.length != 1 || param2.length != 0)
         {
            throw new Error("MobileDiscoveryService wrong callback parameters specified.");
         }
      }
   }
}

