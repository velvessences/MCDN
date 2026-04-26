package com.moviestarplanet.core.controller.commands
{
   import com.moviestarplanet.amf.TicketGenerator;
   import com.moviestarplanet.configurations.AppSettings;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.msgservice.IMsgService;
   import com.moviestarplanet.msgservice.MsgService;
   
   public class SetupMessagesCommand
   {
      
      public function SetupMessagesCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         var _loc1_:String = AppSettings.getInstance().getSetting(AppSettings.MESSAGE_SERVICE_ELB);
         var _loc2_:String = AppSettings.getInstance().getSetting(AppSettings.MESSAGE_SERVER_URL);
         var _loc3_:Boolean = AppSettings.getInstance().getSetting(AppSettings.SEND_MESSAGES_TO_CASSANDRA_DATABASE) == "true";
         InjectionManager.mapper().map(String,"messagesSessionTicket").toValue(TicketGenerator.createTicketHeaderNoMarking().Ticket);
         InjectionManager.mapper().map(String,"msgServiceServerUrl").toValue(_loc1_);
         InjectionManager.mapper().map(String,"oldMessagesServerUrl").toValue(_loc2_);
         InjectionManager.mapper().map(Boolean,"sendMessagesToCassandra").toValue(_loc3_);
         MsgService.initialize();
         InjectionManager.mapper().map(IMsgService).toValue(MsgService.getInstance());
      }
   }
}

