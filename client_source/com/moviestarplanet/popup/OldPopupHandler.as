package com.moviestarplanet.popup
{
   import com.moviestarplanet.Components.ViewComponent.IViewComponent;
   import com.moviestarplanet.movies.MovieStudioController;
   import flash.display.DisplayObject;
   import mx.core.IFlexDisplayObject;
   import mx.core.UIComponent;
   import mx.events.ChildExistenceChangedEvent;
   import mx.managers.PopUpManager;
   
   public class OldPopupHandler
   {
      
      private static var instance:OldPopupHandler;
      
      public var currentMainPopup:UIComponent;
      
      private var popupHasBeenShowAtLeastOneTime:Boolean;
      
      public function OldPopupHandler()
      {
         super();
      }
      
      public static function getInstance() : OldPopupHandler
      {
         if(instance == null)
         {
            instance = new OldPopupHandler();
         }
         return instance;
      }
      
      public function showMainPopup(param1:UIComponent, param2:Number, param3:Number) : void
      {
         if(param1.parent != null)
         {
            param1.parent.setChildIndex(param1,param1.parent.numChildren - 1);
            return;
         }
         var _loc4_:IViewComponent = this.currentMainPopup as IViewComponent;
         if(_loc4_ != null)
         {
            _loc4_.Exit();
         }
         if(this.currentMainPopup != null && this.currentMainPopup.parent != null)
         {
            this.currentMainPopup.parent.removeChild(this.currentMainPopup);
         }
         this.currentMainPopup = param1;
         this.showFakePopup(param1,param2,param3);
      }
      
      public function showFakePopup(param1:DisplayObject, param2:Number, param3:Number, param4:Boolean = false, param5:Boolean = false, param6:UIComponent = null) : void
      {
         var _loc7_:UIComponent = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         if(param6 != null)
         {
            _loc7_ = param6;
         }
         else if(Main.Instance.mainCanvas.applicationViewStack.mainView.popupCanvas != null)
         {
            _loc7_ = Main.Instance.mainCanvas.applicationViewStack.mainView.popupCanvas;
         }
         else
         {
            _loc7_ = Main.Instance;
         }
         if(param4)
         {
            param1.x = _loc7_.width / 2 - param1.width / 2;
            param1.y = _loc7_.height / 2 - param1.height / 2;
         }
         else
         {
            param1.x = param2;
            param1.y = param3;
         }
         _loc7_.addChild(param1);
         if(param5)
         {
            _loc8_ = param1.x + param1.width - param1.parent.width;
            _loc9_ = param1.y + param1.height - param1.parent.height;
            if(_loc8_ > 0)
            {
               param1.x -= _loc8_;
            }
            if(_loc9_ > 0)
            {
               param1.y -= _loc9_;
            }
         }
      }
      
      public function showPopup(param1:IFlexDisplayObject, param2:Number, param3:Number, param4:Boolean, param5:Boolean = false) : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         this.movePopup(param1,param2,param3);
         PopUpManager.addPopUp(param1,Main.Instance,param4);
         this.popupHasBeenShowAtLeastOneTime = true;
         if(param5)
         {
            _loc6_ = param1.x + param1.width - Main.Instance.width;
            _loc7_ = param1.y + param1.height - Main.Instance.height;
            if(_loc6_ > 0)
            {
               param1.x -= _loc6_;
            }
            if(_loc7_ > 0)
            {
               param1.y -= _loc7_;
            }
         }
         Main.Instance.mainCanvas.dispatchEvent(new ChildExistenceChangedEvent(ChildExistenceChangedEvent.CHILD_ADD,true,true,DisplayObject(param1)));
      }
      
      public function movePopup(param1:IFlexDisplayObject, param2:Number, param3:Number) : void
      {
         param1.scaleX = Main.Instance.mainCanvas.scaleX;
         param1.scaleY = Main.Instance.mainCanvas.scaleX;
         param1.x = (param2 + Main.Instance.mainCanvas.x) * Main.Instance.mainCanvas.scaleX;
         param1.y = (param3 + Main.Instance.mainCanvas.y) * Main.Instance.mainCanvas.scaleX;
      }
      
      public function closeMainPopup() : void
      {
         var done:Function;
         var ivc:IViewComponent = null;
         Main.Instance.mainCanvas.applicationViewStack.mainView.mainMenuViewStack.selectedIndex = 0;
         if(this.currentMainPopup != null)
         {
            if(MovieStudioController.getInstance().currentMovieStudioInEditMode != null)
            {
               if(MovieStudioController.getInstance().currentMovieStudioInEditMode.movieChanged)
               {
                  done = function():void
                  {
                     MovieStudioController.getInstance().currentMovieStudioInEditMode.Exit();
                  };
                  MovieStudioController.getInstance().currentMovieStudioInEditMode.RequestExit(done);
                  return;
               }
            }
            if(this.popupHasBeenShowAtLeastOneTime)
            {
               PopUpManager.removePopUp(this.currentMainPopup);
            }
            if(this.currentMainPopup != null && this.currentMainPopup.parent != null)
            {
               this.currentMainPopup.parent.removeChild(this.currentMainPopup);
            }
            ivc = this.currentMainPopup as IViewComponent;
            if(ivc != null)
            {
               ivc.Exit();
            }
            this.currentMainPopup = null;
         }
      }
   }
}

