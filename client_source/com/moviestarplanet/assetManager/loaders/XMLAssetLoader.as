package com.moviestarplanet.assetManager.loaders
{
   import com.moviestarplanet.assetManager.IAssetUrl;
   import com.moviestarplanet.assetManager.UnionRep;
   import com.moviestarplanet.assetManager.resources.XMLResourceWrapper;
   import com.moviestarplanet.resources.GenericResourceManager;
   
   public class XMLAssetLoader extends AssetLoader
   {
      
      public static const FILE_PERMISSION_READ_ONLY:int = 1;
      
      public static const FILE_PERMISSION_READ_AND_WRITE:int = 2;
      
      private var filePermission:int;
      
      public function XMLAssetLoader(param1:UnionRep, param2:IAssetUrl, param3:int, param4:Function = null, param5:Function = null)
      {
         super(param1,param2,param4,param5);
         this.returnByteArray = true;
         this.filePermission = param3;
         if(param1 == null)
         {
            throw new Error("XMLAssetLoader can only be instantiated from AssetManager");
         }
      }
      
      final public function getXML() : XML
      {
         var _loc1_:XMLResourceWrapper = null;
         if(!GenericResourceManager.hasResource(assetKey))
         {
            new XMLResourceWrapper(assetKey,XML(payload));
         }
         _loc1_ = XMLResourceWrapper(GenericResourceManager.getResource(assetKey));
         if(this.filePermission == FILE_PERMISSION_READ_ONLY)
         {
            return _loc1_.getXML();
         }
         if(this.filePermission == FILE_PERMISSION_READ_AND_WRITE)
         {
            return _loc1_.getXML().copy();
         }
         throw new Error("XML file permission unknown");
      }
   }
}

