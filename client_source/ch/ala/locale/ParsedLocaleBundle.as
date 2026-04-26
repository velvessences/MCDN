package ch.ala.locale
{
   import flash.utils.Dictionary;
   
   public class ParsedLocaleBundle
   {
      
      public var localeChain:String;
      
      public var bundleName:String;
      
      public var parsedData:Dictionary;
      
      public function ParsedLocaleBundle(param1:String = null, param2:String = null, param3:Dictionary = null)
      {
         super();
         if(param1 != null)
         {
            localeChain = param1;
         }
         if(param2 != null)
         {
            bundleName = param2;
         }
         if(param3 != null)
         {
            parsedData = param3;
         }
      }
      
      public function destroy() : void
      {
         trace("DESTROYYYYY THIS PARSEDLOCALEBUNDLE");
      }
   }
}

