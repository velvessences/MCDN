package com.moviestarplanet.Forms.world.elements
{
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.msg.AreaEvent;
   import com.moviestarplanet.msg.events.CareerQuestEvent;
   import com.moviestarplanet.msg.events.CareerQuestsGoToDestinations;
   import com.moviestarplanet.musicshop.OpenMusicShopCommand;
   import com.moviestarplanet.shopping.ShoppingModuleManager;
   import com.moviestarplanet.shopping.module.ShoppingModuleManager;
   
   public class ShoppingElement extends BaseWorldElement
   {
      
      private static var _allItems:Array = [];
      
      public static const FASHION_GIRL:ShoppingElement = new ShoppingElement("CLOTHING_SHOP","fashionGirls");
      
      public static const FASHION_BOY:ShoppingElement = new ShoppingElement("CLOTHING_SHOP","fashionBoys");
      
      public static const BEAUTYCLINIC_GIRL:ShoppingElement = new ShoppingElement("BEAUTY_CLINIC","beautyGirls");
      
      public static const BEAUTYCLINIC_BOY:ShoppingElement = new ShoppingElement("BEAUTY_CLINIC","BeautyBoys");
      
      public static const HOME:ShoppingElement = new ShoppingElement("ITEM_SHOP","items");
      
      public static const ANIMATIONS:ShoppingElement = new ShoppingElement("ANIMATIONS","Animation");
      
      public static const BACKGROUNDS:ShoppingElement = new ShoppingElement("ARTBOOK_DYN_CAT_BACKGROUNDS","Backgrounds");
      
      public static const MUSIC:ShoppingElement = new ShoppingElement("MUSIC","music");
      
      public static const DIAMOND:ShoppingElement = new ShoppingElement("DYNTXT_LAYOUT_BUTTONS_DIAMONDSHOP","DiamondShop");
      
      public function ShoppingElement(param1:String, param2:String)
      {
         _allItems.push(this);
         super(param1,param2);
      }
      
      public static function get allItems() : Array
      {
         return _allItems;
      }
      
      override public function enter() : void
      {
         switch(this)
         {
            case FASHION_BOY:
            case FASHION_GIRL:
               MessageCommunicator.send(new MsgEvent(CareerQuestEvent.USER_CLICKED_BUTTON,CareerQuestsGoToDestinations.ENTER_SHOPPING));
               com.moviestarplanet.shopping.ShoppingModuleManager.getInstance().openClothesShop();
               break;
            case BEAUTYCLINIC_GIRL:
            case BEAUTYCLINIC_BOY:
               com.moviestarplanet.shopping.ShoppingModuleManager.getInstance().openBeautyClinic();
               MessageCommunicator.send(new MsgEvent(CareerQuestEvent.USER_CLICKED_BUTTON,CareerQuestsGoToDestinations.BEAUTY_CLINIC));
               break;
            case HOME:
               com.moviestarplanet.shopping.ShoppingModuleManager.getInstance().openItemsShop();
               break;
            case ANIMATIONS:
               com.moviestarplanet.shopping.module.ShoppingModuleManager.getInstance().openAnimationShop();
               MessageCommunicator.send(new AreaEvent(AreaEvent.SHOPPING_ANIMATIONS));
               break;
            case BACKGROUNDS:
               com.moviestarplanet.shopping.ShoppingModuleManager.getInstance().openBackgroundShop();
               break;
            case DIAMOND:
               com.moviestarplanet.shopping.module.ShoppingModuleManager.getInstance().openDiamondShop();
               break;
            case MUSIC:
               new OpenMusicShopCommand().execute();
         }
      }
   }
}

