package com.moviestarplanet.emoticon.valueobjects
{
   public class Emoticon
   {
      
      public var CharSequence:String;
      
      public var Symbol:String;
      
      public var VipRequired:Boolean;
      
      public function Emoticon(param1:Object = null)
      {
         super();
         if(param1)
         {
            this.CharSequence = new String(param1.chars);
            this.Symbol = new String(param1.symbol);
            this.VipRequired = param1.vip as Boolean;
         }
      }
   }
}

