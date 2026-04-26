package
{
   import com.moviestarplanet.mainview.CornerAdGlowBox;
   import mx.binding.IWatcherSetupUtil2;
   import mx.core.IFlexModuleFactory;
   
   public class _com_moviestarplanet_mainview_CornerAdGlowBoxWatcherSetupUtil implements IWatcherSetupUtil2
   {
      
      public function _com_moviestarplanet_mainview_CornerAdGlowBoxWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         CornerAdGlowBox.watcherSetupUtil = new _com_moviestarplanet_mainview_CornerAdGlowBoxWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
      }
   }
}

