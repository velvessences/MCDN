package com.moviestarplanet.services.upload
{
   import com.moviestarplanet.amf.AmfCaller;
   import com.moviestarplanet.globalsharedutils.SerializeUtils;
   import com.moviestarplanet.media.valueobjects.Animation;
   import com.moviestarplanet.media.valueobjects.Background;
   import com.moviestarplanet.media.valueobjects.Music;
   import com.moviestarplanet.moviestar.valueObjects.Cloth;
   import com.moviestarplanet.scrapitems.valueobjects.ClipArt;
   import com.moviestarplanet.services.shopcontentservice.valueObjects.ClothUpdater;
   
   public class AMFUploadService
   {
      
      private var amfCaller:AmfCaller = new AmfCaller("MovieStarPlanet.WebService.Upload.AMFUploadService");
      
      public function AMFUploadService()
      {
         super();
      }
      
      public function updateAnimation(param1:Animation, param2:int, param3:Function) : void
      {
         var amfDone:Function = null;
         var animation:Animation = param1;
         var themeID:int = param2;
         var callback:Function = param3;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         var copy:Animation = SerializeUtils.clone(animation) as Animation;
         copy.AnimationCategory = null;
         this.amfCaller.callFunction("updateAnimation",[copy,themeID],true,amfDone);
      }
      
      public function updateBackground(param1:Background, param2:int, param3:Function) : void
      {
         var amfDone:Function = null;
         var background:Background = param1;
         var themeID:int = param2;
         var callback:Function = param3;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         var copy:Background = SerializeUtils.clone(background) as Background;
         copy.BackgroundCategory = null;
         this.amfCaller.callFunction("updateBackground",[copy,themeID],true,amfDone);
      }
      
      public function uploadBonster(param1:String, param2:int, param3:String, param4:int, param5:int, param6:Boolean, param7:Boolean, param8:Boolean, param9:String, param10:String, param11:Function) : void
      {
         var amfDone:Function = null;
         var templateName:String = param1;
         var templateId:int = param2;
         var armatureName:String = param3;
         var price:int = param4;
         var diamondsPrice:int = param5;
         var isVIP:Boolean = param6;
         var deleted:Boolean = param7;
         var specialEggCrate:Boolean = param8;
         var scale:String = param9;
         var scaleWeb:String = param10;
         var callback:Function = param11;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         this.amfCaller.callFunction("uploadBonster",[templateName,templateId,armatureName,price,diamondsPrice,isVIP,deleted,specialEggCrate,scale,scaleWeb],true,amfDone);
      }
      
      public function updateBonsterColors(param1:int, param2:String, param3:Function) : void
      {
         var amfDone:Function = null;
         var bonsterId:int = param1;
         var colorMatrix:String = param2;
         var callback:Function = param3;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         this.amfCaller.callFunction("updateBonsterColors",[bonsterId,colorMatrix],true,amfDone);
      }
      
      public function updateMusic(param1:Music, param2:Function) : void
      {
         var amfDone:Function = null;
         var music:Music = param1;
         var callback:Function = param2;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         var copy:Music = SerializeUtils.clone(music) as Music;
         copy.MusicCategory = null;
         this.amfCaller.callFunction("updateMusic",[copy],true,amfDone);
      }
      
      public function updateCloth(param1:Cloth, param2:Function) : void
      {
         var amfDone:Function = null;
         var cloth:Cloth = param1;
         var callback:Function = param2;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         var clothUpdater:ClothUpdater = new ClothUpdater();
         clothUpdater.ClothesCategoryId = cloth.ClothesCategoryId;
         clothUpdater.ClothesId = cloth.ClothesId;
         clothUpdater.Filename = cloth.Filename;
         clothUpdater.Name = cloth.Name;
         clothUpdater.Price = cloth.Price;
         clothUpdater.DiamondsPrice = cloth.DiamondsPrice;
         clothUpdater.RegNewUser = cloth.RegNewUser;
         clothUpdater.Scale = cloth.Scale;
         clothUpdater.ShopId = cloth.ShopId;
         clothUpdater.SkinId = cloth.SkinId;
         clothUpdater.sortorder = cloth.sortorder;
         clothUpdater.SWF = cloth.SWF;
         clothUpdater.Vip = cloth.Vip;
         clothUpdater.isNew = cloth.isNew;
         clothUpdater.Discount = cloth.Discount;
         clothUpdater.MouseAction = cloth.MouseAction;
         clothUpdater.AvailableUntil = cloth.AvailableUntil;
         clothUpdater.MainThemeId = cloth.ThemeId;
         this.amfCaller.callFunction("updateCloth",[clothUpdater],true,amfDone);
      }
      
      public function getAllStuffForModeratorMode(param1:Function) : void
      {
         var amfDone:Function = null;
         var callback:Function = param1;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         this.amfCaller.callFunction("getAllStuffForModeratorMode",[],true,amfDone);
      }
      
      public function editFacepart(param1:Number, param2:String, param3:String, param4:String, param5:String, param6:int, param7:Number, param8:Number, param9:Number, param10:Number, param11:Number, param12:int, param13:int, param14:Function) : void
      {
         var amfDone:Function = null;
         var facepartId:Number = param1;
         var type:String = param2;
         var gender:String = param3;
         var name:String = param4;
         var fileName:String = param5;
         var price:int = param6;
         var checkvip:Number = param7;
         var checknew:Number = param8;
         var checkreg:Number = param9;
         var discount:Number = param10;
         var sortorder:Number = param11;
         var themeID:int = param12;
         var priceDiamonds:int = param13;
         var callback:Function = param14;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         this.amfCaller.callFunction("EditFacepart",[facepartId,type,gender,name,fileName,price,checkvip,checknew,checkreg,discount,sortorder,themeID,priceDiamonds],true,amfDone);
      }
      
      public function deleteFacepart(param1:int, param2:String, param3:Function) : void
      {
         var amfDone:Function = null;
         var facepartId:int = param1;
         var type:String = param2;
         var callback:Function = param3;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         this.amfCaller.callFunction("DeleteFacepart",[facepartId,type],true,amfDone);
      }
      
      public function saveClothUpdater(param1:ClothUpdater, param2:int, param3:Function) : void
      {
         var amfDone:Function = null;
         var cloth:ClothUpdater = param1;
         var themeID:int = param2;
         var callback:Function = param3;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         this.amfCaller.callFunction("saveClothUpdater",[cloth,themeID],true,amfDone);
      }
      
      public function editAnimation(param1:int, param2:String, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:int, param10:int, param11:Function) : void
      {
         var amfDone:Function = null;
         var animationId:int = param1;
         var name:String = param2;
         var price:int = param3;
         var discount:int = param4;
         var checkVip:int = param5;
         var checkNew:int = param6;
         var checkDeleted:int = param7;
         var animCategoryId:int = param8;
         var themeID:int = param9;
         var priceDiamonds:int = param10;
         var callback:Function = param11;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         this.amfCaller.callFunction("EditAnimation",[animationId,name,price,discount,checkVip,checkNew,checkDeleted,animCategoryId,themeID,priceDiamonds],true,amfDone);
      }
      
      public function InsertWallpaper(param1:Number, param2:Number, param3:String, param4:String, param5:Function) : void
      {
         var amfDone:Function = null;
         var type:Number = param1;
         var roomtype:Number = param2;
         var name:String = param3;
         var filepath:String = param4;
         var callback:Function = param5;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         this.amfCaller.callFunction("InsertWallpaper",[type,roomtype,name,filepath],true,amfDone);
      }
      
      public function deleteWallpaper(param1:Number, param2:Function) : void
      {
         var amfDone:Function = null;
         var wallpaperId:Number = param1;
         var callback:Function = param2;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         this.amfCaller.callFunction("DeleteWallpaper",[wallpaperId],true,amfDone);
      }
      
      public function getClipArtPath(param1:ClipArt, param2:Function) : void
      {
         var amfDone:Function = null;
         var clipart:ClipArt = param1;
         var callback:Function = param2;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         this.amfCaller.callFunction("GetClipArtPath",[clipart],true,amfDone);
      }
      
      public function InsertClipArt(param1:Number, param2:Number, param3:String, param4:Number, param5:Number, param6:Number, param7:int, param8:int, param9:String, param10:Function) : void
      {
         var amfDone:Function = null;
         var type:Number = param1;
         var category:Number = param2;
         var fileName:String = param3;
         var checkvip:Number = param4;
         var checkNew:Number = param5;
         var sortorder:Number = param6;
         var price:int = param7;
         var diamondPrice:int = param8;
         var colorScheme:String = param9;
         var callback:Function = param10;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         this.amfCaller.callFunction("InsertClipArt",[type,category,fileName,checkvip,checkNew,sortorder,price,diamondPrice,colorScheme],true,amfDone);
      }
      
      public function editClipArt(param1:ClipArt, param2:String, param3:String, param4:Boolean, param5:Boolean, param6:int, param7:int, param8:Function) : void
      {
         var amfDone:Function = null;
         var clipart:ClipArt = param1;
         var subpath:String = param2;
         var sort:String = param3;
         var checkvip:Boolean = param4;
         var checknew:Boolean = param5;
         var price:int = param6;
         var diamondsPrice:int = param7;
         var callback:Function = param8;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         this.amfCaller.callFunction("EditClipArt",[clipart,subpath,sort,checkvip,checknew,price,diamondsPrice],true,amfDone);
      }
      
      public function deleteClipArt(param1:ClipArt, param2:String, param3:Function) : void
      {
         var amfDone:Function = null;
         var clipart:ClipArt = param1;
         var subpath:String = param2;
         var callback:Function = param3;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         this.amfCaller.callFunction("DeleteClipArt",[clipart,subpath],true,amfDone);
      }
      
      public function getClipArtTypes(param1:Function) : void
      {
         var amfDone:Function = null;
         var callback:Function = param1;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         this.amfCaller.callFunction("getClipArtTypes",[],true,amfDone);
      }
      
      public function getClipArtCategoryNames(param1:Number, param2:Function) : void
      {
         var amfDone:Function = null;
         var paramid:Number = param1;
         var callback:Function = param2;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         this.amfCaller.callFunction("getClipArtCategoryNames",[paramid],true,amfDone);
      }
      
      public function InsertBackground(param1:String, param2:int, param3:int, param4:int, param5:String, param6:int, param7:Function) : void
      {
         var amfDone:Function = null;
         var name:String = param1;
         var price:int = param2;
         var backgroundCategory:int = param3;
         var vip:int = param4;
         var fileName:String = param5;
         var themeID:int = param6;
         var callback:Function = param7;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         this.amfCaller.callFunction("InsertBackground",[name,price,backgroundCategory,vip,fileName,themeID],true,amfDone);
      }
      
      public function getAnimationCategories(param1:Function) : void
      {
         var amfDone:Function = null;
         var callback:Function = param1;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         this.amfCaller.callFunction("GetAnimationCategories",[],true,amfDone);
      }
      
      public function InsertAnimation(param1:String, param2:int, param3:int, param4:int, param5:int, param6:String, param7:int, param8:Function) : void
      {
         var amfDone:Function = null;
         var name:String = param1;
         var price:int = param2;
         var diamondsprice:int = param3;
         var animCategory:int = param4;
         var vip:int = param5;
         var fileName:String = param6;
         var themeID:int = param7;
         var callback:Function = param8;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         this.amfCaller.callFunction("InsertAnimation",[name,price,diamondsprice,animCategory,vip,fileName,themeID],true,amfDone);
      }
      
      public function insertFacepart(param1:String, param2:int, param3:String, param4:String, param5:int, param6:int, param7:Number, param8:Boolean, param9:String, param10:Number, param11:Number, param12:Number, param13:Number, param14:int, param15:Boolean, param16:Date, param17:Function) : void
      {
         var amfDone:Function = null;
         var type:String = param1;
         var gender:int = param2;
         var name:String = param3;
         var fileName:String = param4;
         var price:int = param5;
         var diamondPrice:int = param6;
         var checkvip:Number = param7;
         var dragonBone:Boolean = param8;
         var defaultColors:String = param9;
         var checknew:Number = param10;
         var checkreg:Number = param11;
         var discount:Number = param12;
         var sortorder:Number = param13;
         var themeID:int = param14;
         var hidden:Boolean = param15;
         var date:Date = param16;
         var callback:Function = param17;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         this.amfCaller.callFunction("InsertFacepart",[type,gender,name,fileName,price,diamondPrice,checkvip,dragonBone,defaultColors,checknew,checkreg,discount,sortorder,themeID,date,hidden],true,amfDone);
      }
      
      public function getAllColorschemelessClothes(param1:int, param2:int, param3:Function) : void
      {
         var amfDone:Function = null;
         var pageIdx:int = param1;
         var pageSize:int = param2;
         var callback:Function = param3;
         amfDone = function(param1:Object):void
         {
            callback(param1);
         };
         this.amfCaller.callFunction("getAllColorschemelessClothes",[pageIdx,pageSize],true,amfDone);
      }
      
      public function setClothColorSchemes(param1:Array, param2:Function) : void
      {
         var amfDone:Function = null;
         var clothColorSchemes:Array = param1;
         var callback:Function = param2;
         amfDone = function(param1:Object):void
         {
            callback();
         };
         this.amfCaller.callFunction("setClothColorSchemes",[clothColorSchemes],true,amfDone);
      }
      
      public function fileExistsCheck(param1:String, param2:Function) : void
      {
         var amfDone:Function = null;
         var key:String = param1;
         var callback:Function = param2;
         amfDone = function(param1:Object):void
         {
            callback(param1.Result);
         };
         key = key.toLowerCase();
         this.amfCaller.callFunction("FileExistsCheck",[key],false,amfDone);
      }
   }
}

