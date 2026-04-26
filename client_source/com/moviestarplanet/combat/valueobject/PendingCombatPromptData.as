package com.moviestarplanet.combat.valueobject
{
   public class PendingCombatPromptData
   {
      
      public var text:String;
      
      public var title:String;
      
      public var flags:uint;
      
      public var defaultButtonFlag:uint;
      
      public var showAnchorCharacter:Boolean;
      
      public function PendingCombatPromptData(param1:String, param2:String, param3:uint, param4:uint, param5:Boolean)
      {
         super();
         this.text = param1;
         this.title = param2;
         this.flags = param3;
         this.defaultButtonFlag = param4;
         this.showAnchorCharacter = param5;
      }
   }
}

