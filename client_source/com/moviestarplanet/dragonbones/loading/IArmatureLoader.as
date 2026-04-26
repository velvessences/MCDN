package com.moviestarplanet.dragonbones.loading
{
   import com.moviestarplanet.dragonbones.DragonBonesWrapper;
   import com.moviestarplanet.dragonbones.display.IArmatureDisplayWrapper;
   
   public interface IArmatureLoader
   {
      
      function loadArmature(param1:Object, param2:String, param3:String, param4:Function, param5:Function) : void;
      
      function loadArmatureWithAssetManager(param1:Object, param2:String, param3:String, param4:Function, param5:Function, param6:Function, param7:Function, param8:Function) : void;
      
      function setAlreadyLoadedData(param1:DragonBonesWrapper, param2:String, param3:Function) : void;
      
      function loadAnimationData(param1:DragonBonesWrapper, param2:String, param3:Function) : void;
      
      function createDisplayWrapper() : IArmatureDisplayWrapper;
      
      function destroy() : void;
   }
}

