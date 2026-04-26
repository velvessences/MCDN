package com.moviestarplanet.clientcensor
{
   import com.moviestarplanet.userbehavior.ICensor;
   import com.moviestarplanet.userbehavior.IRedifyableTextInputComponent;
   
   public class CensorWeb implements ICensor
   {
      
      public function CensorWeb()
      {
         super();
      }
      
      public function censorText(param1:String, param2:int = -1) : String
      {
         return Censor.censorText(param1,param2);
      }
      
      public function set whitelistEnabled(param1:Boolean) : void
      {
      }
      
      public function get whitelistEnabled() : Boolean
      {
         return Censor.whitelistEnabled;
      }
      
      public function get userMuted() : Boolean
      {
         return NannyBase.instance.isMuted();
      }
      
      public function checkForBadWordsAndRedify(param1:IRedifyableTextInputComponent) : Boolean
      {
         if(WhiteListBase.instance != null)
         {
            return WhiteListBase.instance.redifyBadWords(param1);
         }
         return false;
      }
      
      public function redify(param1:IRedifyableTextInputComponent) : void
      {
         Censor.redifyBadWords(param1);
      }
      
      public function containsPassword(param1:String) : int
      {
         return BlackListUtil.getInstance().containsPassword(param1);
      }
      
      public function get isModerator() : Boolean
      {
         return Censor.actorModel.isModerator;
      }
   }
}

