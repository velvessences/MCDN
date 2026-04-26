package com.moviestarplanet.amf
{
   import mx.collections.ArrayCollection;
   
   public class AmfResponseFilter implements IAmfResponseFilter
   {
      
      public function AmfResponseFilter()
      {
         super();
      }
      
      public function filterResponse(param1:*) : *
      {
         if(param1 is ArrayCollection)
         {
            param1 = (param1 as ArrayCollection).source;
         }
         return param1;
      }
   }
}

