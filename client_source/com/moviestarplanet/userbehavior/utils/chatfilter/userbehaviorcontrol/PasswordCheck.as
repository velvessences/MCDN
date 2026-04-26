package com.moviestarplanet.userbehavior.utils.chatfilter.userbehaviorcontrol
{
   public class PasswordCheck
   {
      
      private static var _passwordRegExpr:RegExp;
      
      private static const passwordTextEnRegExpr:RegExp = /password/gi;
      
      private static const passwordTextDkRegExpr:RegExp = /kode/gi;
      
      private static const passwordTextSeRegExpr:RegExp = /lösenord/gi;
      
      private static const passwordTextNoRegExpr:RegExp = /passord/gi;
      
      private static const passwordTextFiRegExpr:RegExp = /salasana/gi;
      
      private static const passwordTextDeRegExpr:RegExp = /passwort/gi;
      
      private static const passwordTextNlRegExpr:RegExp = /wachtwoord/gi;
      
      private static const passwordTextFrRegExpr:RegExp = /mot de passe/gi;
      
      private static const passwordTextTrRegExpr:RegExp = /şifre/gi;
      
      public function PasswordCheck()
      {
         super();
      }
      
      public static function containsUserPassword(param1:String, param2:String) : Boolean
      {
         var _loc4_:String = null;
         if(param2 == "")
         {
            return false;
         }
         if(_passwordRegExpr == null)
         {
            initPasswordRegExp(param2);
         }
         _passwordRegExpr.lastIndex = 0;
         var _loc3_:Boolean = Boolean(_passwordRegExpr.exec(param1));
         if(_loc3_ == false)
         {
            _passwordRegExpr.lastIndex = 0;
            _loc4_ = param1.split("").reverse().join("");
            _loc3_ = Boolean(_passwordRegExpr.exec(_loc4_));
         }
         return _loc3_;
      }
      
      private static function initPasswordRegExp(param1:String) : void
      {
         var _loc2_:String = ".*";
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ += param1.charAt(_loc3_) + ".*";
            _loc3_++;
         }
         _passwordRegExpr = new RegExp(_loc2_,"gi");
      }
      
      public static function containsWordPassword(param1:String) : Boolean
      {
         passwordTextEnRegExpr.lastIndex = 0;
         passwordTextDkRegExpr.lastIndex = 0;
         passwordTextSeRegExpr.lastIndex = 0;
         passwordTextNoRegExpr.lastIndex = 0;
         passwordTextFiRegExpr.lastIndex = 0;
         passwordTextDeRegExpr.lastIndex = 0;
         passwordTextNlRegExpr.lastIndex = 0;
         passwordTextFrRegExpr.lastIndex = 0;
         passwordTextTrRegExpr.lastIndex = 0;
         return Boolean(passwordTextEnRegExpr.exec(param1)) || Boolean(passwordTextDkRegExpr.exec(param1)) || Boolean(passwordTextSeRegExpr.exec(param1)) || Boolean(passwordTextNoRegExpr.exec(param1)) || Boolean(passwordTextFiRegExpr.exec(param1)) || Boolean(passwordTextDeRegExpr.exec(param1)) || Boolean(passwordTextNlRegExpr.exec(param1)) || Boolean(passwordTextFrRegExpr.exec(param1)) || Boolean(passwordTextTrRegExpr.exec(param1));
      }
   }
}

