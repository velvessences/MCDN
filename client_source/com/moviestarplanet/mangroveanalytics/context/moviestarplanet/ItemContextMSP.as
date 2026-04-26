package com.moviestarplanet.mangroveanalytics.context.moviestarplanet
{
   import com.moviestarplanet.mangroveanalytics.context.MangroveBaseContext;
   
   public class ItemContextMSP extends MangroveBaseContext
   {
      
      private const ID:String = "id";
      
      private const NAME:String = "name";
      
      private const TYPE:String = "type";
      
      private const CATEGORY:String = "category";
      
      private const IS_VIP:String = "is_vip";
      
      private const THEME:String = "theme";
      
      private const SCHEMA_DEFINITION:String = "item_context/jsonschema/2-0-2";
      
      private const EVENT_NAME:String = "item_context";
      
      public function ItemContextMSP(param1:String, param2:String, param3:Boolean = false, param4:String = null, param5:String = null, param6:String = null)
      {
         schemaDefinition = "item_context/jsonschema/2-0-2";
         schemaName = "item_context";
         super();
         addData("id",param1);
         addData("type",param2);
         addData("name",param4);
         addData("category",param5);
         addData("is_vip",param3);
         addData("theme",param6);
      }
   }
}

