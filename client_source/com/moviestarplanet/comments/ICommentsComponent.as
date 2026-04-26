package com.moviestarplanet.comments
{
   public interface ICommentsComponent
   {
      
      function showCommentsComponent(param1:Number, param2:Function) : void;
      
      function showCommentsComponentOnce(param1:Number, param2:Function, param3:int) : void;
      
      function setSaveCommentCallback(param1:Function) : void;
   }
}

