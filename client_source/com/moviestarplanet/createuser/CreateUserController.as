package com.moviestarplanet.createuser
{
   import com.moviestarplanet.createuser.introduction.Introduction;
   import com.moviestarplanet.window.utils.MovieClipStateManager;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import mx.core.UIComponent;
   
   public class CreateUserController
   {
      
      public function CreateUserController()
      {
         super();
      }
      
      public static function openIntroduction(param1:DisplayObjectContainer, param2:Function = null, param3:Function = null, param4:Function = null) : void
      {
         var introduction:DisplayObject;
         var starting:Function = null;
         var preremoved:Function = null;
         var complete:Function = null;
         var statemanager:MovieClipStateManager = null;
         var uic:UIComponent = null;
         var container:DisplayObjectContainer = param1;
         var sequenceStarting:Function = param2;
         var sequencePreremove:Function = param3;
         var sequenceComplete:Function = param4;
         starting = function():void
         {
            if(sequenceStarting != null)
            {
               sequenceStarting();
            }
         };
         preremoved = function():void
         {
            if(sequencePreremove != null)
            {
               sequencePreremove();
            }
         };
         complete = function():void
         {
            container.removeChild(uic);
            statemanager.reset();
            if(sequenceComplete != null)
            {
               sequenceComplete();
            }
         };
         var root:DisplayObjectContainer = Main.Instance.mainCanvas;
         statemanager = new MovieClipStateManager(root);
         statemanager.stop();
         introduction = new Introduction(starting,preremoved,complete);
         uic = new UIComponent();
         uic.addChild(introduction);
         container.addChild(uic);
      }
   }
}

