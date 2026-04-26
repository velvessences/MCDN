package com.moviestarplanet.design.service
{
   import com.moviestarplanet.commoninterfaces.IRegistrator;
   import com.moviestarplanet.design.valueobjects.DesignListItem;
   import com.moviestarplanet.design.valueobjects.SaveDesignResult;
   import com.moviestarplanet.moviestar.valueObjects.Design;
   import flash.net.registerClassAlias;
   
   public class DesignRegistrator implements IRegistrator
   {
      
      private static var hasRegistered:Boolean = false;
      
      public function DesignRegistrator()
      {
         super();
      }
      
      public function registerClassAliases() : void
      {
         if(!hasRegistered)
         {
            registerClassAlias("MovieStarPlanet.WebService.DesignStudio.DesignListItem",DesignListItem);
            registerClassAlias("MovieStarPlanet.WebService.DesignStudio.SaveDesignResult",SaveDesignResult);
            registerClassAlias("MovieStarPlanet.DBML.Design",Design);
            hasRegistered = true;
         }
      }
   }
}

