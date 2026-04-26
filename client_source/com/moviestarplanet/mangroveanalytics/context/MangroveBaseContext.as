package com.moviestarplanet.mangroveanalytics.context
{
   import com.moviestarplanet.mangroveanalytics.configuration.MangroveConfig;
   import com.snowplowanalytics.snowplow.tracker.payload.SchemaPayload;
   import com.snowplowanalytics.snowplow.tracker.payload.TrackerPayload;
   
   public class MangroveBaseContext extends SchemaPayload
   {
      
      protected const SCHEMA_URL:String = "iglu:com.moviestarplanet/";
      
      protected var schemaDefinition:String;
      
      protected var schemaName:String;
      
      private var data:TrackerPayload;
      
      private var enabled:Boolean;
      
      public function MangroveBaseContext()
      {
         super();
         if(schemaDefinition == null)
         {
            throw new Error("[MangroveBaseContext] schemaDefinition MUST be set with the right schema URL from iglu");
         }
         if(schemaName == null)
         {
            throw new Error("[MangroveBaseEvent] eventName MUST be set with the right schema name");
         }
         enabled = MangroveConfig.isSchemaEnabled(schemaName);
         if(enabled)
         {
            data = new TrackerPayload();
            this.setSchema("iglu:com.moviestarplanet/" + schemaDefinition);
            this.setData(data);
         }
      }
      
      protected function addData(param1:String, param2:*) : void
      {
         if(enabled && data != null)
         {
            data.add(param1,param2);
         }
      }
      
      public function get isEnabled() : Boolean
      {
         return enabled;
      }
   }
}

