package com.moviestarplanet.utils.swfmapping
{
   import com.moviestarplanet.utils.ComponentUtilities;
   
   public class PathSelector implements PathSelectorInterface
   {
      
      private var identifiers:Array;
      
      public function PathSelector(... rest)
      {
         super();
         this.identifiers = ComponentUtilities.flattenArray(rest);
      }
      
      public function getIdentifiers() : Array
      {
         return this.identifiers;
      }
      
      public function addPropertyIdentifiers(... rest) : PathSelectorInterface
      {
         return new PathSelector(this.identifiers,rest);
      }
   }
}

