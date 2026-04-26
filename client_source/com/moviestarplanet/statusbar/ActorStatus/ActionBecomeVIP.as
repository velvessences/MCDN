package com.moviestarplanet.statusbar.ActorStatus
{
   import com.moviestarplanet.utils.DisplayUtils;
   import com.moviestarplanet.utils.swfmapping.PathSelector;
   import com.moviestarplanet.utils.swfmapping.PropertyMappingAction;
   import com.moviestarplanet.utils.swfmapping.PropertyMappingValue;
   import com.moviestarplanet.utils.swfmapping.SWFPropertyBinder;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import flash.display.DisplayObjectContainer;
   
   public class ActionBecomeVIP implements ActionInterface
   {
      
      private static const ANIMATION_URL:String = "swf/congrats/LevelUp.swf";
      
      private static const ANIMATION_WIDTH:int = 1000;
      
      private static const ANIMATION_HEIGHT:int = 1000;
      
      private var propertyBinder:SWFPropertyBinder;
      
      private var currentContainer:DisplayObjectContainer;
      
      public function ActionBecomeVIP()
      {
         super();
         this.propertyBinder = new SWFPropertyBinder();
         this.propertyBinder.width = ANIMATION_WIDTH;
         this.propertyBinder.height = ANIMATION_HEIGHT;
         this.propertyBinder.url = ANIMATION_URL;
         this.propertyBinder.addPropertyMapping(new PropertyMappingValue(new PathSelector("TextArea1"),"text",MSPLocaleManagerWeb.getInstance().getString("ACTION_EVENT_BECOME_VIP_TITLE")));
         this.propertyBinder.addPropertyMapping(new PropertyMappingValue(new PathSelector("TextArea2"),"text",MSPLocaleManagerWeb.getInstance().getString("ACTION_EVENT_BECOME_VIP_TEXT")));
         this.propertyBinder.addPropertyMapping(new PropertyMappingAction(new PathSelector("close"),this.close));
      }
      
      private function close(... rest) : void
      {
         this.currentContainer.removeChild(this.propertyBinder);
      }
      
      public function invokeAction(param1:DisplayObjectContainer) : void
      {
         this.currentContainer = param1;
         DisplayUtils.center(this.propertyBinder,param1);
         param1.addChild(this.propertyBinder);
      }
   }
}

