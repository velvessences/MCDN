package com.moviestarplanet.core.model.proxy
{
   import com.moviestarplanet.amf.TicketGenerator;
   import com.moviestarplanet.model.IActorModel;
   import com.moviestarplanet.model.friends.ILoggedInUser;
   
   public class LoggedInUserProxy implements ILoggedInUser
   {
      
      [Inject]
      public var actorModel:IActorModel;
      
      public function LoggedInUserProxy()
      {
         super();
      }
      
      public function get userId() : int
      {
         return this.actorModel.actorId;
      }
      
      public function get ticket() : String
      {
         return TicketGenerator.sessionTicket;
      }
      
      public function get name() : String
      {
         return this.actorModel.actorName;
      }
      
      public function get isVip() : Boolean
      {
         return this.actorModel.isVip;
      }
      
      public function get chatEnabled() : Boolean
      {
         return false;
      }
      
      public function get hardCurrencyAmount() : int
      {
         return this.actorModel.diamonds;
      }
   }
}

