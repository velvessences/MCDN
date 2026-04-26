package com.moviestarplanet.Components.GamesSelector
{
   import com.moviestarplanet.Components.BasePopupCanvas;
   import com.moviestarplanet.Forms.GamesManager;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import flash.accessibility.*;
   import flash.debugger.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   import mx.binding.*;
   import mx.controls.Text;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.PopUpManager;
   import mx.styles.*;
   
   public class PlayerSelectorInfo extends BasePopupCanvas
   {
      
      private var _8129268lblGameLabel:Text;
      
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
         "type":BasePopupCanvas,
         "events":{"creationComplete":"___PlayerSelectorInfo_BasePopupCanvas1_creationComplete"},
         "propertiesFactory":function():Object
         {
            return {
               "width":400,
               "height":140,
               "childDescriptors":[new UIComponentDescriptor({
                  "type":Text,
                  "id":"lblGameLabel",
                  "stylesFactory":function():void
                  {
                     this.color = 0;
                     this.fontSize = 20;
                     this.textAlign = "center";
                     this.fontWeight = "bold";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "top":20,
                        "bottom":10,
                        "left":30,
                        "right":30,
                        "width":400,
                        "mouseChildren":false
                     };
                  }
               })]
            };
         }
      });
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      public var closedOnButton:Boolean = false;
      
      private var _gameLabel:String;
      
      public function PlayerSelectorInfo()
      {
         super();
         mx_internal::_document = this;
         this.width = 400;
         this.height = 140;
         this.addEventListener("creationComplete",this.___PlayerSelectorInfo_BasePopupCanvas1_creationComplete);
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function onCreationComplete() : void
      {
         var _loc1_:int = 0;
         this.lblGameLabel.text = MSPLocaleManagerWeb.getInstance().getString("CHATROOM_GAMES_INVITE",[this.gameLabel]);
         MessageCommunicator.subscribe(MSPEvent.CHATROOM_CLOSED,this.close);
      }
      
      public function set gameLabel(param1:String) : void
      {
         this._gameLabel = param1;
         if(this.lblGameLabel != null)
         {
            this.lblGameLabel.text = MSPLocaleManagerWeb.getInstance().getString("CHATROOM_GAMES_INVITE",[this.gameLabel]);
         }
      }
      
      public function get gameLabel() : String
      {
         return this._gameLabel;
      }
      
      public function closeWindow() : void
      {
         this.close();
      }
      
      override protected function close(param1:Event = null) : void
      {
         GamesManager.resetSelectedGame();
         PopUpManager.removePopUp(this);
         super.close();
      }
      
      public function ___PlayerSelectorInfo_BasePopupCanvas1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete();
      }
      
      [Bindable(event="propertyChange")]
      public function get lblGameLabel() : Text
      {
         return this._8129268lblGameLabel;
      }
      
      public function set lblGameLabel(param1:Text) : void
      {
         var _loc2_:Object = this._8129268lblGameLabel;
         if(_loc2_ !== param1)
         {
            this._8129268lblGameLabel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lblGameLabel",_loc2_,param1));
            }
         }
      }
   }
}

