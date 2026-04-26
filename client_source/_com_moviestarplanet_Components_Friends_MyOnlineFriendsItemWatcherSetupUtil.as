package
{
   import com.moviestarplanet.Components.Friends.MyOnlineFriendsItem;
   import mx.binding.IWatcherSetupUtil2;
   import mx.core.IFlexModuleFactory;
   
   public class _com_moviestarplanet_Components_Friends_MyOnlineFriendsItemWatcherSetupUtil implements IWatcherSetupUtil2
   {
      
      public function _com_moviestarplanet_Components_Friends_MyOnlineFriendsItemWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         MyOnlineFriendsItem.watcherSetupUtil = new _com_moviestarplanet_Components_Friends_MyOnlineFriendsItemWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
      }
   }
}

