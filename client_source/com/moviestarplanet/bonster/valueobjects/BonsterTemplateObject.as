package com.moviestarplanet.bonster.valueobjects
{
   import flash.utils.Dictionary;
   import mx.collections.ArrayCollection;
   
   public class BonsterTemplateObject
   {
      
      public var BonsterTemplateId:int;
      
      public var Name:String;
      
      public var SkeletonPath:String;
      
      private var _BonsterAnimations:Dictionary;
      
      public function BonsterTemplateObject()
      {
         super();
      }
      
      public function set BonsterAnimations(param1:*) : void
      {
         var animationsArray:Array;
         var ba:BonsterAnim = null;
         var data:* = param1;
         this._BonsterAnimations = new Dictionary();
         animationsArray = new Array();
         if(data is ArrayCollection)
         {
            animationsArray = data.toArray();
         }
         else
         {
            if(!(data is Array))
            {
               if(data is Dictionary)
               {
                  this._BonsterAnimations = data;
                  return;
               }
               trace("Error: Failed to cast " + data + " to " + this._BonsterAnimations + " at valueobject " + this);
               return;
            }
            animationsArray = data;
         }
         try
         {
            for each(ba in animationsArray)
            {
               this._BonsterAnimations[ba.Label] = ba;
            }
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
         }
      }
      
      public function get BonsterAnimations() : Dictionary
      {
         return this._BonsterAnimations;
      }
   }
}

