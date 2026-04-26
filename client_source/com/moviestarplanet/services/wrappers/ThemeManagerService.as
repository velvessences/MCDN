package com.moviestarplanet.services.wrappers
{
   import com.moviestarplanet.services.ServiceManager;
   import com.moviestarplanet.services.ThemeManagerService.ThemeManagerService;
   import com.moviestarplanet.services.shopcontentservice.valueObjects.Theme;
   import mx.collections.ArrayCollection;
   import mx.rpc.CallResponder;
   
   public class ThemeManagerService extends WebService
   {
      
      private static var _themeManagerServiceInstance:com.moviestarplanet.services.ThemeManagerService.ThemeManagerService;
      
      private static var tmServiceManager:ServiceManager;
      
      public function ThemeManagerService()
      {
         super();
      }
      
      private static function getTMService() : com.moviestarplanet.services.ThemeManagerService.ThemeManagerService
      {
         if(_themeManagerServiceInstance == null)
         {
            _themeManagerServiceInstance = new com.moviestarplanet.services.ThemeManagerService.ThemeManagerService();
            _themeManagerServiceInstance.manager = new ServiceManager(_themeManagerServiceInstance);
         }
         return _themeManagerServiceInstance;
      }
      
      public static function GetAllThemes(param1:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var doneCallback:Function = param1;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            doneCallback(param1.result as ArrayCollection);
         };
         var service:com.moviestarplanet.services.ThemeManagerService.ThemeManagerService = getTMService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.GetAllThemes(),webMethodDone);
      }
      
      public static function InsertTheme(param1:String, param2:int, param3:Date, param4:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var name:String = param1;
         var themeType:int = param2;
         var publishableDate:Date = param3;
         var doneCallback:Function = param4;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            doneCallback();
         };
         var service:com.moviestarplanet.services.ThemeManagerService.ThemeManagerService = getTMService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.InsertTheme(name,themeType,publishableDate),webMethodDone);
      }
      
      public static function UpdateTheme(param1:Theme, param2:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var theme:Theme = param1;
         var doneCallback:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            doneCallback();
         };
         var service:com.moviestarplanet.services.ThemeManagerService.ThemeManagerService = getTMService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.UpdateTheme(theme),webMethodDone);
      }
      
      public static function DeleteTheme(param1:int, param2:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var themeID:int = param1;
         var doneCallback:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            doneCallback();
         };
         var service:com.moviestarplanet.services.ThemeManagerService.ThemeManagerService = getTMService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.DeleteTheme(themeID),webMethodDone);
      }
      
      public static function PublishTheme(param1:int, param2:Function = null) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var themeID:int = param1;
         var doneCallback:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            doneCallback();
         };
         var service:com.moviestarplanet.services.ThemeManagerService.ThemeManagerService = getTMService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.PublishTheme(themeID),webMethodDone);
      }
      
      public static function RetrieveThemeID(param1:int, param2:int, param3:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var shoppingTypeID:int = param1;
         var itemID:int = param2;
         var doneCallback:Function = param3;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            doneCallback(param1.result as int);
         };
         var service:com.moviestarplanet.services.ThemeManagerService.ThemeManagerService = getTMService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.RetrieveThemeID(shoppingTypeID,itemID),webMethodDone);
      }
      
      public static function SortShoppingItems(param1:ArrayCollection, param2:int, param3:int, param4:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var itemIDs:ArrayCollection = param1;
         var shoppingTypeID:int = param2;
         var sortingCategoryID:int = param3;
         var doneCallback:Function = param4;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            doneCallback(param1.result as int);
         };
         var service:com.moviestarplanet.services.ThemeManagerService.ThemeManagerService = getTMService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.SortShoppingItems(itemIDs,shoppingTypeID,sortingCategoryID),webMethodDone);
      }
      
      public static function GetCurrectNewCategorySortIndex(param1:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var doneCallback:Function = param1;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            doneCallback(param1.result as int);
         };
         var service:com.moviestarplanet.services.ThemeManagerService.ThemeManagerService = getTMService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.GetCurrectNewCategorySortIndex(),webMethodDone);
      }
   }
}

