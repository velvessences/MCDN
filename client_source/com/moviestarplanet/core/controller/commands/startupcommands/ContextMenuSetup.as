package com.moviestarplanet.core.controller.commands.startupcommands
{
   import com.junkbyte.console.Cc;
   import com.moviestarplanet.configurations.Config;
   import flash.display.DisplayObjectContainer;
   import flash.events.ContextMenuEvent;
   import flash.ui.ContextMenu;
   import flash.ui.ContextMenuItem;
   import mx.core.UIComponent;
   
   internal class ContextMenuSetup
   {
      
      private static const CONSOLE_SELECTED_TEXT:String = "Hide Console";
      
      private static const CONSOLE_UNSELECTED_TEXT:String = "Show Console";
      
      private var consoleSelected:Boolean;
      
      private var consoleContainer:DisplayObjectContainer;
      
      private var container:DisplayObjectContainer;
      
      public function ContextMenuSetup(param1:DisplayObjectContainer)
      {
         super();
         this.container = param1;
         this.setup();
      }
      
      private function setup() : void
      {
         var _loc1_:ContextMenu = new ContextMenu();
         _loc1_.hideBuiltInItems();
         if(Config.IsRunningInDevelopment || Config.isUploadServer)
         {
            this.setupConsole(_loc1_);
         }
         this.container.contextMenu = _loc1_;
      }
      
      private function setupConsole(param1:ContextMenu) : void
      {
         var _loc2_:ContextMenuItem = new ContextMenuItem(CONSOLE_UNSELECTED_TEXT);
         _loc2_.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.selectConsole);
         param1.customItems.push(_loc2_);
      }
      
      private function selectConsole(param1:ContextMenuEvent) : void
      {
         var _loc2_:ContextMenuItem = param1.currentTarget as ContextMenuItem;
         this.consoleSelected = this.consoleSelected ? false : true;
         if(this.consoleSelected)
         {
            _loc2_.caption = CONSOLE_SELECTED_TEXT;
            this.consoleContainer = new UIComponent();
            this.container.addChild(this.consoleContainer);
            Cc.start(this.consoleContainer);
            Cc.config.commandLineAllowed = true;
            Cc.commandLine = true;
         }
         else
         {
            _loc2_.caption = CONSOLE_UNSELECTED_TEXT;
            Cc.remove();
            this.container.removeChild(this.consoleContainer);
         }
      }
   }
}

