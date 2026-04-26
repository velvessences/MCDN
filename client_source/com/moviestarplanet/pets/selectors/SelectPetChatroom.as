package com.moviestarplanet.pets.selectors
{
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   
   public class SelectPetChatroom extends SelectPetBase
   {
      
      public function SelectPetChatroom()
      {
         super();
      }
      
      override protected function getTitleText() : String
      {
         return MSPLocaleManagerWeb.getInstance().getString("SELECT_BOONE") || "";
      }
      
      override protected function getNoPetsText() : String
      {
         return MSPLocaleManagerWeb.getInstance().getString("ONLY_BOONIE") || "";
      }
      
      override public function open() : void
      {
         x = 420;
         y = 300;
         super.open();
      }
   }
}

