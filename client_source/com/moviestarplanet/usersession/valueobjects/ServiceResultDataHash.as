package com.moviestarplanet.usersession.valueobjects
{
   import com.moviestarplanet.globalsharedutils.SerializeUtils;
   
   public class ServiceResultDataHash
   {
      
      public var Hash:String;
      
      public var ActorId:int;
      
      public var Data:Boolean;
      
      public var Description:String;
      
      public var Code:int;
      
      public function ServiceResultDataHash(param1:String, param2:Boolean, param3:String, param4:int, param5:int)
      {
         super();
         this.Hash = param1;
         this.Data = param2;
         this.Description = param3;
         this.Code = param4;
         this.ActorId = param5;
      }
      
      public function isTamperedWith(param1:int) : Boolean
      {
         if(param1 != this.ActorId)
         {
            return true;
         }
         return SerializeUtils.checkHash("!2*;d@&.,jhf" + this.getToHashValues(param1),this.Hash) == false;
      }
      
      private function getToHashValues(param1:int) : String
      {
         return "0" + this.Data + this.Description + this.Code + param1;
      }
   }
}

