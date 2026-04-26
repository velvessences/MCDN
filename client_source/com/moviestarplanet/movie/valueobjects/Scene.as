package com.moviestarplanet.movie.valueobjects
{
   import mx.collections.ArrayCollection;
   
   public class Scene
   {
      
      public var SceneId:int;
      
      public var MovieId:int;
      
      public var SceneNumber:int;
      
      public var Background:String;
      
      public var BackgroundId:int;
      
      public var Sound:String;
      
      public var SecsPrFrame:int;
      
      public var KeyFrameCount:int;
      
      public var SceneNumberSpeech:int;
      
      public var Manuscript:String;
      
      public var KeyFrameActors:ArrayCollection;
      
      public var PropsInScene:ArrayCollection;
      
      public var LastUpdated:Date;
      
      private var _visibleActorsCount:int = 0;
      
      public function Scene()
      {
         super();
      }
      
      public function get visibleActorsCount() : int
      {
         return this._visibleActorsCount;
      }
      
      public function set visibleActorsCount(param1:int) : void
      {
         this._visibleActorsCount = param1;
      }
   }
}

