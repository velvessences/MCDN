package com.moviestarplanet.artbook
{
   import com.moviestarplanet.Module.AbstractFlashModuleManager;
   import com.moviestarplanet.Module.IFlashModule;
   import com.moviestarplanet.award.visualization.AwardVisualizationController;
   import com.moviestarplanet.flash.components.comments.CommentsComponent;
   import com.moviestarplanet.model.ActorModel;
   import com.moviestarplanet.scrapblog.lists.SubmitScrapBlogToCompetition;
   import com.moviestarplanet.scrapitems.service.ClipArtAMFService;
   import com.moviestarplanet.utils.EntityTypeType;
   import com.moviestarplanet.utils.FontManager;
   import com.moviestarplanet.window.stack.WindowStack;
   
   public class ArtBookModuleManager extends AbstractFlashModuleManager
   {
      
      private static var instance:ArtBookModuleManager;
      
      public function ArtBookModuleManager(param1:SingletonEnforcer)
      {
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use getInstance() instead of new.");
         }
      }
      
      public static function getInstance() : ArtBookModuleManager
      {
         if(instance == null)
         {
            instance = new ArtBookModuleManager(new SingletonEnforcer());
         }
         return instance;
      }
      
      override protected function get moduleName() : String
      {
         return "ArtBookModule";
      }
      
      private function getArtBookModule(param1:Function) : void
      {
         var moduleComplete:Function;
         var callback:Function = param1;
         var module:IFlashModule = getModule();
         if(module == null)
         {
            moduleComplete = function():void
            {
               initModule();
               callback(IArtBookModule(getModule()));
            };
            loadModule(moduleComplete);
         }
         else
         {
            callback(IArtBookModule(module));
         }
      }
      
      private function initModule() : void
      {
         (getModule() as IArtBookModule).setAwardSpawner(AwardVisualizationController.getInstance());
         (getModule() as IArtBookModule).setActorModel(ActorModel.getInstance());
         (getModule() as IArtBookModule).setCommentsComponent(CommentsComponent.getInstance(EntityTypeType.SCRAPBLOG));
         (getModule() as IArtBookModule).setClipArtProvider(new ClipArtAMFService());
         (getModule() as IArtBookModule).setFontManager(new FontManager());
      }
      
      public function openArtBookBrowser() : void
      {
         var moduleLoaded:Function = null;
         moduleLoaded = function(param1:IArtBookModule):void
         {
            param1.openArtBookBrowser();
         };
         this.getArtBookModule(moduleLoaded);
      }
      
      public function openArtBookCreator(param1:int = 0, param2:int = 3) : void
      {
         var moduleLoaded:Function = null;
         var id:int = param1;
         var _z_index:int = param2;
         moduleLoaded = function(param1:IArtBookModule):void
         {
            param1.openArtBookCreator(id,_z_index);
         };
         this.getArtBookModule(moduleLoaded);
      }
      
      public function openArtBookViewer(param1:int, param2:int = 3) : void
      {
         var moduleLoaded:Function = null;
         var id:int = param1;
         var _z_index:int = param2;
         moduleLoaded = function(param1:IArtBookModule):void
         {
            param1.openArtBookViewer(id,_z_index);
         };
         this.getArtBookModule(moduleLoaded);
      }
      
      public function openBio(param1:int, param2:int, param3:Boolean = false, param4:int = 3) : void
      {
         var moduleLoaded:Function = null;
         var bioId:int = param1;
         var actorId:int = param2;
         var convertToNew:Boolean = param3;
         var _z_index:int = param4;
         moduleLoaded = function(param1:IArtBookModule):void
         {
            param1.openBio(bioId,actorId,convertToNew,_z_index);
         };
         this.getArtBookModule(moduleLoaded);
      }
      
      public function submitArtbookToCompetition(param1:int, param2:int, param3:String) : void
      {
         var moduleLoaded:Function = null;
         var actorID:int = param1;
         var MovieCompetitionId:int = param2;
         var competitionName:String = param3;
         moduleLoaded = function(param1:IArtBookModule):void
         {
            var _loc2_:SubmitScrapBlogToCompetition = new SubmitScrapBlogToCompetition();
            _loc2_.actorId = actorID;
            _loc2_.competitionId = MovieCompetitionId;
            _loc2_.competitionName = competitionName;
            WindowStack.showViewStackable(_loc2_,230,0,WindowStack.Z_INFO);
         };
         this.getArtBookModule(moduleLoaded);
      }
      
      public function getContent(param1:Number, param2:Function, param3:Boolean = false, param4:Number = 0, param5:Number = 0) : void
      {
         var moduleLoaded:Function = null;
         var scrapBlogId:Number = param1;
         var callback:Function = param2;
         var hideWhileLoading:Boolean = param3;
         var requestedWidth:Number = param4;
         var requestedHeight:Number = param5;
         moduleLoaded = function(param1:IArtBookModule):void
         {
            param1.getContent(scrapBlogId,hideWhileLoading,callback,requestedWidth,requestedHeight);
         };
         this.getArtBookModule(moduleLoaded);
      }
      
      public function openArtBookViewerExternal(param1:Number) : void
      {
         var moduleLoaded:Function = null;
         var id:Number = param1;
         moduleLoaded = function(param1:IArtBookModule):void
         {
            param1.openArtBookViewerExternal(id,WindowStack.Z_CONTENT);
         };
         this.getArtBookModule(moduleLoaded);
      }
   }
}

class SingletonEnforcer
{
   
   public function SingletonEnforcer()
   {
      super();
   }
}
