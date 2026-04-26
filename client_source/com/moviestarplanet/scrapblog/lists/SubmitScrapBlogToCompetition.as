package com.moviestarplanet.scrapblog.lists
{
   import com.moviestarplanet.Components.CloseButton;
   import com.moviestarplanet.Components.GradientCanvas;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.scrapblog.service.ScrapBlogAMFHelper;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import com.moviestarplanet.window.stack.WindowStack;
   import com.moviestarplanet.window.stack.WindowStackableInterface;
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
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class SubmitScrapBlogToCompetition extends GradientCanvas implements WindowStackableInterface, IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
      
      private var _3322014list:SubmissibleScrapBlogList;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      public var competitionId:Number;
      
      public var competitionName:String;
      
      public var actorId:Number;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function SubmitScrapBlogToCompetition()
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":GradientCanvas,
            "events":{"creationComplete":"___SubmitScrapBlogToCompetition_GradientCanvas1_creationComplete"},
            "stylesFactory":function():void
            {
               this.cornerRadius = 10;
            },
            "propertiesFactory":function():Object
            {
               return {
                  "width":490,
                  "height":500,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":SubmissibleScrapBlogList,
                     "id":"list",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "left":0,
                           "top":0,
                           "bottom":0
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":CloseButton,
                     "events":{"click":"___SubmitScrapBlogToCompetition_CloseButton1_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":464,
                           "y":5
                        };
                     }
                  })]
               };
            }
         });
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         bindings = this._SubmitScrapBlogToCompetition_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_com_moviestarplanet_scrapblog_lists_SubmitScrapBlogToCompetitionWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return SubmitScrapBlogToCompetition[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.styleName = "blackOverlay";
         this.width = 490;
         this.height = 500;
         this.addEventListener("creationComplete",this.___SubmitScrapBlogToCompetition_GradientCanvas1_creationComplete);
         i = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function show(param1:Number) : void
      {
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         SubmitScrapBlogToCompetition._watcherSetupUtil = param1;
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         var factory:IFlexModuleFactory = param1;
         super.moduleFactory = factory;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
         if(!this.styleDeclaration)
         {
            this.styleDeclaration = new CSSStyleDeclaration(null,styleManager);
         }
         this.styleDeclaration.defaultFactory = function():void
         {
            this.cornerRadius = 10;
         };
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      private function close(param1:Event = null) : void
      {
         WindowStack.removeViewStackable(this);
      }
      
      private function onCreationComplete() : void
      {
         MessageCommunicator.subscribe(MSPEvent.COMPETITION_ENTRY_SUBMITTED,this.close);
      }
      
      public function ___SubmitScrapBlogToCompetition_GradientCanvas1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete();
      }
      
      public function ___SubmitScrapBlogToCompetition_CloseButton1_click(param1:MouseEvent) : void
      {
         this.close();
      }
      
      private function _SubmitScrapBlogToCompetition_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,null,null,"list.loadParam","actorId");
         result[1] = new Binding(this,null,null,"list.competitionId","competitionId");
         result[2] = new Binding(this,null,null,"list.competitionName","competitionName");
         result[3] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("SUBMIT_ARTBOOK");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"list.label");
         result[4] = new Binding(this,function():Function
         {
            return ScrapBlogAMFHelper.getSubmissibleScrapBlogs;
         },null,"list.serverFunction");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get list() : SubmissibleScrapBlogList
      {
         return this._3322014list;
      }
      
      public function set list(param1:SubmissibleScrapBlogList) : void
      {
         var _loc2_:Object = this._3322014list;
         if(_loc2_ !== param1)
         {
            this._3322014list = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"list",_loc2_,param1));
            }
         }
      }
   }
}

