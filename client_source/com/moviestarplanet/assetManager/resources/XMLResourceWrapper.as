package com.moviestarplanet.assetManager.resources
{
   import com.moviestarplanet.resources.ResourceWrapper;
   
   public class XMLResourceWrapper extends ResourceWrapper
   {
      
      private var xml:XML;
      
      public function XMLResourceWrapper(param1:String, param2:XML)
      {
         this.xml = param2;
         super(param1);
      }
      
      public function getXML() : XML
      {
         return this.xml;
      }
   }
}

