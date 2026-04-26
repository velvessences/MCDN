package com.moviestarplanet.school.schoolsettings
{
   import com.moviestarplanet.school.schoolsettings.controller.SchoolSettingsController;
   import com.moviestarplanet.school.schoolsettings.model.SchoolSettingsModel;
   import com.moviestarplanet.school.schoolsettings.view.SchoolSettingsView;
   import com.moviestarplanet.window.stack.WebWindowOpener;
   import flash.display.MovieClip;
   import flash.geom.Point;
   
   public class SchoolSettings extends MovieClip
   {
      
      public var model:SchoolSettingsModel;
      
      public var view:SchoolSettingsView;
      
      public var controller:SchoolSettingsController;
      
      public function SchoolSettings(param1:Function, param2:Point, param3:Function = null, param4:Function = null)
      {
         super();
         x = param2.x;
         y = param2.y;
         this.model = new SchoolSettingsModel();
         this.view = new SchoolSettingsView();
         this.controller = new SchoolSettingsController(param1,param4);
         this.model.mvc(this.view,this.controller);
         this.view.mvc(this.model,this.controller);
         this.controller.mvc(this.model,this.view);
         this.controller.initialize(param3);
         addChild(this.view);
      }
      
      public function destroy() : void
      {
         this.view.destroy();
         this.view = null;
         this.model.destroy();
         this.model = null;
         this.controller.destroy();
         this.controller = null;
         removeChildren();
         WebWindowOpener.instance().closeWindow(this);
      }
   }
}

