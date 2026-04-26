package com.moviestarplanet.core.controller.commands
{
   import com.moviestarplanet.blob.service.AmfBlobService;
   import com.moviestarplanet.blob.service.IBlobService;
   import com.moviestarplanet.bonster.service.BonsterAMFService;
   import com.moviestarplanet.bonster.service.IBonsterService;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.messaging.MessagingProvider;
   import com.moviestarplanet.payment.services.IPaymentService;
   import com.moviestarplanet.payment.services.PaymentAmfService;
   import com.moviestarplanet.pet.service.IPetService;
   import com.moviestarplanet.pet.service.PetAMFService;
   import com.moviestarplanet.services.messagingservice.MessagingAmfService;
   
   public class ConfigureServicesCommand
   {
      
      private var messagingService:MessagingAmfService;
      
      public function ConfigureServicesCommand()
      {
         super();
         this.messagingService = new MessagingAmfService();
      }
      
      public function execute() : void
      {
         MessagingProvider.messagingService = this.messagingService;
         InjectionManager.mapper().map(IBlobService).toSingleton(AmfBlobService);
         InjectionManager.mapper().map(IBonsterService).toSingleton(BonsterAMFService);
         InjectionManager.mapper().map(IPetService).toSingleton(PetAMFService);
         InjectionManager.mapper().map(IPaymentService).toSingleton(PaymentAmfService);
      }
   }
}

