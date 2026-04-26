package com.moviestarplanet.bonster.valueobjects
{
   public class BonsterAnimationList
   {
      
      public var list:Array;
      
      public function BonsterAnimationList()
      {
         super();
      }
      
      public function destroy() : void
      {
         this.list = null;
      }
   }
}

