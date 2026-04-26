package com.moviestarplanet.core.controller.commands.startupcommands
{
   import com.moviestarplanet.connections.ConnectionManager;
   
   public class StartConnectionManagerCommand
   {
      
      private static var connectionManager:Object;
      
      public function StartConnectionManagerCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         if(connectionManager == null)
         {
            connectionManager = new ConnectionManager();
         }
      }
   }
}

