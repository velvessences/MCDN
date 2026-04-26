package
{
   import com.moviestarplanet.Components.LooksOverview;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import mx.binding.FunctionReturnWatcher;
   import mx.binding.IWatcherSetupUtil2;
   import mx.core.IFlexModuleFactory;
   
   public class _com_moviestarplanet_Components_LooksOverviewWatcherSetupUtil implements IWatcherSetupUtil2
   {
      
      public function _com_moviestarplanet_Components_LooksOverviewWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         LooksOverview.watcherSetupUtil = new _com_moviestarplanet_Components_LooksOverviewWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         var target:Object = param1;
         var propertyGetter:Function = param2;
         var staticPropertyGetter:Function = param3;
         var bindings:Array = param4;
         var watchers:Array = param5;
         watchers[3] = new FunctionReturnWatcher("getInstance",target,function():Array
         {
            return [];
         },null,[bindings[2]],null);
         watchers[5] = new FunctionReturnWatcher("getInstance",target,function():Array
         {
            return [];
         },null,[bindings[3]],null);
         watchers[9] = new FunctionReturnWatcher("getInstance",target,function():Array
         {
            return [];
         },null,[bindings[11]],null);
         watchers[3].updateParent(MSPLocaleManagerWeb);
         watchers[5].updateParent(MSPLocaleManagerWeb);
         watchers[9].updateParent(MSPLocaleManagerWeb);
      }
   }
}

