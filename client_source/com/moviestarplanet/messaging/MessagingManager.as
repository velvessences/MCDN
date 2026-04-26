package com.moviestarplanet.messaging
{
   import com.moviestarplanet.Module.AbstractModuleManager;
   import com.moviestarplanet.Module.ModuleInterface;
   import com.moviestarplanet.messaging.module.moduleparts.IMessagingModule;
   import flash.net.registerClassAlias;
   
   public class MessagingManager extends AbstractModuleManager implements MessagingManagerInterface
   {
      
      private static var manager:MessagingManager = new MessagingManager();
      
      public function MessagingManager()
      {
         super();
         registerClassAlias("MessagingModule",IMessagingModule);
      }
      
      private static function get module() : IMessagingModule
      {
         return manager.moduleAccessor() as IMessagingModule;
      }
      
      private static function moduleInvoke(param1:String, param2:Array = null, param3:Function = null) : void
      {
         var iInvokeProperty:Function = null;
         var propertyName:String = param1;
         var parameters:Array = param2;
         var result:Function = param3;
         iInvokeProperty = function():void
         {
            var _loc2_:Object = null;
            var _loc1_:Object = module[propertyName];
            if(_loc1_ is Function)
            {
               _loc2_ = (_loc1_ as Function).apply(null,parameters);
               if(result != null)
               {
                  result.apply(null,[_loc2_]);
               }
            }
         };
         if(module == null)
         {
            manager.loadModule(iInvokeProperty);
         }
         else
         {
            iInvokeProperty.apply(null,[]);
         }
      }
      
      public static function openMessagingViewWithConversation(param1:String) : void
      {
         moduleInvoke("openMessagingViewWithConversation",[param1]);
      }
      
      public static function openMessagingViewWithActor(param1:int) : void
      {
         moduleInvoke("openMessagingViewWithActor",[param1]);
      }
      
      public static function openMessagingView() : void
      {
         moduleInvoke("openMessagingView");
      }
      
      public static function createChatView(param1:String, param2:int, param3:Boolean, param4:Function) : void
      {
         moduleInvoke("createChatView",[param1,param2,param3,param4]);
      }
      
      override protected function getLoadingThemeColor() : uint
      {
         return 0;
      }
      
      override protected function get moduleName() : String
      {
         return "MessagingModule";
      }
      
      internal function moduleAccessor() : ModuleInterface
      {
         return manager.getModule();
      }
   }
}

