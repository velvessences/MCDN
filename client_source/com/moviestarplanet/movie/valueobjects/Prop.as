package com.moviestarplanet.movie.valueobjects
{
   import mx.collections.ArrayCollection;
   
   public class Prop
   {
      
      public static const TYPE_NONE:int = 0;
      
      public static const TYPE_CLOTHES:int = 1;
      
      public static const TYPE_CLICKITEM:int = 2;
      
      public static const TYPE_BONSTER:int = 3;
      
      public var ItemId:int;
      
      public var SceneId:int;
      
      public var KeyFrameProps:ArrayCollection;
      
      public var Type:int;
      
      private var _SWF:Object = null;
      
      public function Prop()
      {
         super();
      }
      
      public function get SWF() : Object
      {
         return this._SWF;
      }
      
      public function set SWF(param1:Object) : void
      {
         this._SWF = param1;
      }
   }
}

