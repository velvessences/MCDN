package com.moviestarplanet.pictures
{
   import com.moviestarplanet.Module.IFlashModule;
   import com.moviestarplanet.comments.ICommentsComponent;
   
   public interface IPictureUploadModule extends IFlashModule
   {
      
      function openPictureUpload(param1:int = -1) : void;
      
      function setCommentsComponent(param1:ICommentsComponent) : void;
   }
}

