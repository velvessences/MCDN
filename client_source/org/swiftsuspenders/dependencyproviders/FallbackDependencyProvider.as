package org.swiftsuspenders.dependencyproviders
{
   public interface FallbackDependencyProvider extends DependencyProvider
   {
      
      function prepareNextRequest(param1:String) : Boolean;
   }
}

