package
{
   import com.moviestarplanet.mainview.ApplicationViewStack;
   import mx.binding.IWatcherSetupUtil2;
   import mx.core.IFlexModuleFactory;
   
   public class _com_moviestarplanet_mainview_ApplicationViewStackWatcherSetupUtil implements IWatcherSetupUtil2
   {
      
      public function _com_moviestarplanet_mainview_ApplicationViewStackWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         ApplicationViewStack.watcherSetupUtil = new _com_moviestarplanet_mainview_ApplicationViewStackWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
      }
   }
}

