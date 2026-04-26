package com.moviestarplanet.xmppConnection
{
   public class XMPPStatus
   {
      
      public static var server:String;
      
      public static var port:int;
      
      public static var xmppUseLocalhost:Boolean;
      
      public static const XMPP_STATUS_AMS:int = 0;
      
      public static const XMPP_STATUS_DUAL_MODE:int = 1;
      
      public static const XMPP_STATUS_XMPP_ONLY:int = 2;
      
      public static var currentXMPPStatus:int = XMPP_STATUS_AMS;
      
      public static var AMS:String = "AMS";
      
      public static var AMSXMPP:String = "AMS+XMPP";
      
      public static var XMPP:String = "XMPP";
      
      public function XMPPStatus()
      {
         super();
      }
      
      public static function getProtocolNameByType(param1:int) : String
      {
         switch(param1)
         {
            case XMPP_STATUS_AMS:
               return AMS;
            case XMPP_STATUS_DUAL_MODE:
               return AMSXMPP;
            case XMPP_STATUS_XMPP_ONLY:
               return XMPP;
            default:
               return null;
         }
      }
      
      public static function getTypeByProtocolName(param1:String) : int
      {
         switch(param1)
         {
            case AMS:
               return XMPP_STATUS_AMS;
            case AMSXMPP:
               return XMPP_STATUS_DUAL_MODE;
            case XMPP:
               return XMPP_STATUS_XMPP_ONLY;
            default:
               return -1;
         }
      }
   }
}

