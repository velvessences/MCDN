package com.moviestarplanet.Components.ViewComponent
{
   import com.moviestarplanet.movies.MovieStudioController;
   import com.moviestarplanet.popup.OldPopupHandler;
   import flash.events.Event;
   import mx.containers.ViewStack;
   import mx.core.Container;
   import mx.core.UIComponent;
   import mx.events.FlexEvent;
   import mx.events.IndexChangedEvent;
   
   public class ViewComponentViewStack extends ViewStack
   {
      
      public var CloseMainPopupWhenChanging:Boolean = true;
      
      public var allowMainPopupClosingOnCreationComplete:Boolean = true;
      
      public function ViewComponentViewStack()
      {
         super();
         x = 235;
         y = 80;
         width = 980;
         height = 500;
         clipContent = false;
         horizontalScrollPolicy = "off";
         verticalScrollPolicy = "off";
      }
      
      public function RequestSelectChild(param1:Container, param2:Function) : void
      {
         var indexChange:Function = null;
         var doneAndInitialized:Function = null;
         var child:Container = param1;
         var doneCallBack:Function = param2;
         indexChange = function(param1:IndexChangedEvent):void
         {
            removeEventListener(IndexChangedEvent.CHANGE,indexChange);
            if((selectedChild as Container).initialized)
            {
               doneCallBack(selectedChild);
            }
            else
            {
               child.addEventListener(FlexEvent.CREATION_COMPLETE,doneAndInitialized);
            }
         };
         doneAndInitialized = function(param1:Event = null):void
         {
            child.removeEventListener(FlexEvent.CREATION_COMPLETE,doneAndInitialized);
            doneCallBack(child);
         };
         if(child.parent != this)
         {
            throw new Error("Requested child is not a child of this ViewComponentViewStack");
         }
         if(child == selectedChild)
         {
            if(child.initialized)
            {
               doneCallBack(child);
            }
            else
            {
               child.addEventListener(FlexEvent.CREATION_COMPLETE,doneAndInitialized);
            }
            return;
         }
         addEventListener(IndexChangedEvent.CHANGE,indexChange);
         selectedChild = child;
      }
      
      private function TriggerExit() : void
      {
         var _loc1_:IViewComponent = selectedChild as IViewComponent;
         if(_loc1_ != null)
         {
            _loc1_.Exit();
         }
      }
      
      private function TriggerEnter() : void
      {
         var creationComplete:Function;
         var newViewComponent:IViewComponent = null;
         var uic:UIComponent = null;
         newViewComponent = selectedChild as IViewComponent;
         if(newViewComponent != null)
         {
            creationComplete = function():void
            {
               if(CloseMainPopupWhenChanging && allowMainPopupClosingOnCreationComplete)
               {
                  if(OldPopupHandler.getInstance().currentMainPopup != null && OldPopupHandler.getInstance().currentMainPopup.parent != null)
                  {
                     OldPopupHandler.getInstance().currentMainPopup.parent.removeChild(OldPopupHandler.getInstance().currentMainPopup);
                  }
               }
               newViewComponent.Enter();
            };
            uic = newViewComponent as UIComponent;
            if(uic != null && uic.initialized == false)
            {
               uic.addEventListener(FlexEvent.CREATION_COMPLETE,creationComplete);
            }
            else
            {
               if(OldPopupHandler.getInstance().currentMainPopup != null && OldPopupHandler.getInstance().currentMainPopup.parent != null)
               {
                  if(!(MovieStudioController.getInstance().currentMovieStudioInEditMode != null && MovieStudioController.getInstance().currentMovieStudioInEditMode.movieChanged))
                  {
                     if(this.CloseMainPopupWhenChanging)
                     {
                        OldPopupHandler.getInstance().currentMainPopup.parent.removeChild(OldPopupHandler.getInstance().currentMainPopup);
                     }
                  }
               }
               newViewComponent.Enter();
            }
         }
      }
      
      override public function set selectedIndex(param1:int) : void
      {
         var requestExitCallBack:Function = null;
         var value:int = param1;
         requestExitCallBack = function(param1:Boolean):void
         {
            if(param1)
            {
               doSelectIndex(value);
            }
         };
         if(selectedChild is IViewComponent)
         {
            IViewComponent(selectedChild).RequestExit(requestExitCallBack);
         }
         else
         {
            this.doSelectIndex(value);
         }
      }
      
      private function doSelectIndex(param1:int) : void
      {
         var indexChange:Function = null;
         var value:int = param1;
         this.TriggerExit();
         if(value != selectedIndex)
         {
            indexChange = function(param1:IndexChangedEvent):void
            {
               removeEventListener(IndexChangedEvent.CHANGE,indexChange);
               TriggerEnter();
            };
            addEventListener(IndexChangedEvent.CHANGE,indexChange);
            super.selectedIndex = value;
         }
         else
         {
            this.TriggerEnter();
         }
      }
   }
}

