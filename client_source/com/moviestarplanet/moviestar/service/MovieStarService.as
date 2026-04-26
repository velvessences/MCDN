package com.moviestarplanet.moviestar.service
{
   import com.moviestarplanet.amf.AmfCaller;
   import com.moviestarplanet.amf.PagerResultObject;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.globalsharedutils.SerializeUtils;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.model.IActorModel;
   import com.moviestarplanet.moviestar.ClothingCategories;
   import com.moviestarplanet.moviestar.utils.MovieStarRegistrator;
   import com.moviestarplanet.moviestar.valueObjects.Actor;
   import com.moviestarplanet.moviestar.valueObjects.ActorClothesRel;
   import com.moviestarplanet.msg.ActionEvent;
   
   public class MovieStarService implements IMovieStarService
   {
      
      private static var amfCaller:AmfCaller = new AmfCaller("MovieStarPlanet.WebService.MovieStar.AMFMovieStarService");
      
      private static var instance:MovieStarService = null;
      
      private var _myActorGiftableItems:Array;
      
      public function MovieStarService()
      {
         super();
         new MovieStarRegistrator().registerClassAliases();
      }
      
      public static function getInstance() : MovieStarService
      {
         if(!instance)
         {
            instance = new MovieStarService();
         }
         return instance;
      }
      
      public function loadMovieStarActor(param1:int, param2:Function, param3:Function = null) : void
      {
         var amfDone:Function = null;
         var amfFail:Function = null;
         var actorId:int = param1;
         var callback:Function = param2;
         var failCallback:Function = param3;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         amfFail = function(param1:Object):void
         {
            if(failCallback != null)
            {
               failCallback();
            }
         };
         if(actorId < 0)
         {
            callback(Actor.CreateEmptyActor(-actorId));
            return;
         }
         amfCaller.callFunction("LoadMovieStar",[actorId],false,amfDone,amfFail);
      }
      
      public function loadMovieStarActorFlat(param1:int, param2:Function, param3:Function = null) : void
      {
         var amfDone:Function = null;
         var amfFail:Function = null;
         var actorId:int = param1;
         var callback:Function = param2;
         var failCallback:Function = param3;
         amfDone = function(param1:Object):void
         {
            if(param1.Object == null || !checkHash(param1.Object,param1.Seq))
            {
               amfFail(null);
            }
            else
            {
               callback(param1.Object);
            }
         };
         amfFail = function(param1:Object):void
         {
            if(failCallback != null)
            {
               failCallback();
            }
         };
         if(actorId < 0)
         {
            callback(Actor.CreateEmptyActor(-actorId));
            return;
         }
         amfCaller.callFunction("LoadMovieStarFlat",[actorId],false,amfDone,amfFail);
      }
      
      private function checkHash(param1:Actor, param2:String) : Boolean
      {
         var _loc3_:String = this.createHashString(param1);
         return SerializeUtils.checkHash(_loc3_,param2);
      }
      
      private function createHashString(param1:Actor) : String
      {
         var _loc2_:String = "!22#3jshd4#$%^" + param1.ActorId.toString() + param1.Name;
         var _loc3_:int = int(param1.ActorClothesRels.length);
         if(param1.Nose != null)
         {
            _loc2_ += param1.Nose.NoseId.toString();
         }
         if(param1.Mouth != null)
         {
            _loc2_ += param1.Mouth.MouthId.toString();
         }
         if(param1.Eye != null)
         {
            _loc2_ += param1.Eye.EyeId.toString();
         }
         if(param1.EyeShadow != null)
         {
            _loc2_ += param1.EyeShadow.EyeShadowId.toString();
         }
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ += (param1.ActorClothesRels[_loc4_] as ActorClothesRel).ClothesId.toString();
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function loadMovieStarActorList(param1:Array, param2:Function) : void
      {
         var amfDone:Function = null;
         var actorIds:Array = param1;
         var callback:Function = param2;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         amfCaller.callFunction("LoadMovieStarList",[actorIds],false,amfDone,null);
      }
      
      public function LoadDataForRegisterNewUser(param1:Function) : void
      {
         var amfDone:Function = null;
         var callback:Function = param1;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         amfCaller.callFunction("LoadDataForRegisterNewUser",[],false,amfDone,null);
      }
      
      public function getActorClothesRel(param1:int, param2:Function) : void
      {
         var amfDone:Function = null;
         var relId:int = param1;
         var callback:Function = param2;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         amfCaller.callFunction("GetActorClothesRel",[relId],false,amfDone,null);
      }
      
      public function getActorClothesRelList(param1:Array, param2:Function) : void
      {
         var amfDone:Function = null;
         var rels:Array = param1;
         var callback:Function = param2;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         amfCaller.callFunction("GetActorClothesRelList",[rels],false,amfDone);
      }
      
      public function getPagedActorAllClothesByDate(param1:Number, param2:int, param3:int, param4:Function) : void
      {
         var amfDone:Function = null;
         var actorId:Number = param1;
         var pageindex:int = param2;
         var pagesize:int = param3;
         var callback:Function = param4;
         amfDone = function(param1:Object):void
         {
            var _loc2_:Object = param1 as Object;
            var _loc3_:Boolean = _loc2_.items.length == pagesize;
            var _loc4_:PagerResultObject = new PagerResultObject(_loc2_.totalRecords,_loc3_,_loc2_.items,pageindex);
            callback(_loc4_);
         };
         var sendParams:Array = new Array();
         sendParams.push(actorId);
         sendParams.push(ClothingCategories.AllClothesCategories.categories);
         sendParams.push(pageindex);
         sendParams.push(pagesize);
         amfCaller.callFunction("GetPagedActorClothesByCategories",sendParams,false,amfDone,null);
      }
      
      public function getPagedActorClothesByCategories(param1:Array, param2:int, param3:int, param4:Function) : void
      {
         var amfDone:Function = null;
         var params:Array = param1;
         var pageindex:int = param2;
         var pagesize:int = param3;
         var callback:Function = param4;
         amfDone = function(param1:Object):void
         {
            var _loc2_:Object = param1 as Object;
            var _loc3_:Boolean = _loc2_.items.length == pagesize;
            var _loc4_:PagerResultObject = new PagerResultObject(_loc2_.totalRecords,_loc3_,_loc2_.items,pageindex);
            callback(_loc4_);
         };
         var sendParams:Array = params.slice();
         sendParams.push(pageindex);
         sendParams.push(pagesize);
         amfCaller.callFunction("GetPagedActorClothesByCategories",sendParams,false,amfDone,null);
      }
      
      public function getActorClothesByCategories(param1:Number, param2:Array, param3:Function, param4:Function) : void
      {
         var amfDone:Function = null;
         var actorId:Number = param1;
         var categories:Array = param2;
         var callback:Function = param3;
         var failCallback:Function = param4;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         amfCaller.callFunction("GetActorClothesByCategories",[actorId,categories],false,amfDone,failCallback);
      }
      
      public function LoadActorItems(param1:int, param2:Function, param3:Function = null) : void
      {
         var amfDone:Function = null;
         var actorId:int = param1;
         var callback:Function = param2;
         var failCallback:Function = param3;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         amfCaller.callFunction("LoadActorItems",[actorId],false,amfDone,failCallback);
      }
      
      public function LoadActorGiftableItems(param1:int, param2:Function) : void
      {
         var amfDone:Function;
         var actorId:int = param1;
         var callback:Function = param2;
         if(this._myActorGiftableItems == null)
         {
            amfDone = function(param1:Array):void
            {
               _myActorGiftableItems = param1;
               MessageCommunicator.subscribe(ActionEvent.BUY_CLOTHES,onBoughtItems);
               callback(_myActorGiftableItems);
            };
            amfCaller.callFunction("LoadActorGiftableItems",[actorId],false,amfDone,null);
         }
         else
         {
            callback(this._myActorGiftableItems);
         }
      }
      
      public function ResetGiftableItems() : void
      {
         this._myActorGiftableItems = null;
      }
      
      private function onBoughtItems(param1:MsgEvent) : void
      {
         var _loc4_:ActorClothesRel = null;
         var _loc2_:Array = param1.data;
         var _loc3_:IActorModel = InjectionManager.manager().getInstance(IActorModel);
         for each(_loc4_ in _loc2_)
         {
            if(_loc4_.Design == null || _loc4_.Design.ActorId != _loc3_.actorId)
            {
               this._myActorGiftableItems.push(_loc4_);
            }
         }
      }
      
      public function LoadClothesBythemeId(param1:int, param2:Function) : void
      {
         var amfDone:Function = null;
         var themeId:int = param1;
         var callback:Function = param2;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         amfCaller.callFunction("LoadClothesFromThemeId",[themeId],true,amfDone);
      }
      
      public function LoadClothes(param1:Number, param2:Number, param3:Function) : void
      {
         var amfDone:Function = null;
         var skinId:Number = param1;
         var shopId:Number = param2;
         var callback:Function = param3;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         amfCaller.callFunction("LoadClothes",[skinId,shopId],false,amfDone);
      }
      
      public function LoadClothesByIds(param1:Array, param2:Function) : void
      {
         var amfDone:Function = null;
         var clothesIds:Array = param1;
         var callback:Function = param2;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         amfCaller.callFunction("LoadClothesByIds",[clothesIds],false,amfDone);
      }
      
      public function LoadClothesWithThemeByIds(param1:Array, param2:Function) : void
      {
         var amfDone:Function = null;
         var clothesIds:Array = param1;
         var callback:Function = param2;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         amfCaller.callFunction("LoadClothesWithThemeByIds",[clothesIds],false,amfDone);
      }
      
      public function UpdateClothes(param1:int, param2:Array, param3:Function) : void
      {
         var amfDone:Function = null;
         var actorId:int = param1;
         var actorClothesRelIds:Array = param2;
         var callback:Function = param3;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         amfCaller.callFunction("UpdateClothes",[actorId,actorClothesRelIds],true,amfDone,null);
      }
      
      public function loadRoomItems(param1:Number, param2:Function) : void
      {
         var amfDone:Function = null;
         var actorId:Number = param1;
         var callback:Function = param2;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         amfCaller.callFunction("LoadRoomItems",[actorId],false,amfDone,null);
      }
      
      public function getRandomClothesByType(param1:String, param2:Boolean, param3:int, param4:Function) : void
      {
         var amfDone:Function = null;
         var slotType:String = param1;
         var isFemale:Boolean = param2;
         var amount:int = param3;
         var callback:Function = param4;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         amfCaller.callFunction("getRandomClothesByType",[slotType,isFemale,amount],false,amfDone);
      }
      
      public function GetFacePartDefinitions(param1:Function) : void
      {
         var amfDone:Function = null;
         var callback:Function = param1;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         amfCaller.callFunction("LoadFaceParts",[],false,amfDone);
      }
      
      public function LoadContextClothes(param1:int, param2:int, param3:Function) : void
      {
         var amfDone:Function = null;
         var actorId:int = param1;
         var contextId:int = param2;
         var callback:Function = param3;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         amfCaller.callFunction("GetContextClothes",[actorId,contextId],false,amfDone);
      }
   }
}

