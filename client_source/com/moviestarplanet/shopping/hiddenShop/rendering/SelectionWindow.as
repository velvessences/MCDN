package com.moviestarplanet.shopping.hiddenShop.rendering
{
   import com.moviestarplanet.IDestroyable;
   import com.moviestarplanet.controls.utils.Buttonizer;
   import com.moviestarplanet.flash.icons.ScreenIcons;
   import com.moviestarplanet.shopping.hiddenShop.HiddenShopGraphicsProvider;
   import com.moviestarplanet.shopping.hiddenShop.HiddenShopManager;
   import com.moviestarplanet.shopping.hiddenShop.managers.SettingsManager;
   import com.moviestarplanet.utils.StageReference;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class SelectionWindow extends Sprite
   {
      
      public static var provider:HiddenShopGraphicsProvider;
      
      public static var rows:int;
      
      public static const upperLeftX:int = -240;
      
      public static const upperLeftY:int = -80;
      
      private static const MOVE_INCREMENT:int = 300;
      
      public static const DEFAULT:int = 0;
      
      public static const THEMES:int = 1;
      
      private var nextYear:int;
      
      private var nextPos:Point;
      
      private var done:Function;
      
      private var selections:Array;
      
      private var preSelections:Array;
      
      private var selectMultiple:Boolean;
      
      private var multipleSelections:Object;
      
      private var cancelSelection:Selection;
      
      private var anySelection:Selection;
      
      private var okaySelection:Selection;
      
      private var haveTagsSelection:Selection;
      
      private var noTagsSelection:Selection;
      
      private var moveLeftBtn:MovieClip;
      
      private var moveRightBtn:MovieClip;
      
      public function SelectionWindow(param1:Function, param2:Array, param3:Array, param4:Boolean = false, param5:int = 0)
      {
         var onDone:Function = null;
         var id:int = 0;
         var entry:Object = null;
         var done:Function = param1;
         var dataset:Array = param2;
         var preSelections:Array = param3;
         var selectMultiple:Boolean = param4;
         var type:int = param5;
         super();
         onDone = function():void
         {
            addButtons(dataset,type);
         };
         this.done = done;
         this.preSelections = preSelections;
         this.selectMultiple = selectMultiple;
         this.selections = new Array();
         this.nextYear = new Date().fullYear;
         this.multipleSelections = new Object();
         if(selectMultiple)
         {
            for each(id in preSelections)
            {
               for each(entry in dataset)
               {
                  if(entry.key == id)
                  {
                     this.multipleSelections[id] = entry;
                  }
               }
            }
         }
         this.nextPos = new Point();
         if(HiddenShopManager.isLoaded)
         {
            this.addButtons(dataset,type);
         }
         else
         {
            HiddenShopManager.load(onDone);
         }
      }
      
      private function addButtons(param1:Array, param2:int) : void
      {
         var data:Object = null;
         var selection:Selection = null;
         var dataset:Array = param1;
         var type:int = param2;
         var handleFlags:Function = function(param1:Object):void
         {
            if((param1.key & SettingsManager.CANCEL_KEY) == SettingsManager.CANCEL_KEY)
            {
               cancelSelection = HiddenShopManager.newSelection();
               cancelSelection.init({
                  "label":"CANCEL",
                  "key":SettingsManager.CANCEL_KEY
               },cancelSelected,preSelections,DEFAULT);
               addSelection(cancelSelection);
            }
            if((param1.key & SettingsManager.ANY_KEY) == SettingsManager.ANY_KEY)
            {
               anySelection = HiddenShopManager.newSelection();
               anySelection.init({
                  "label":"ANY",
                  "key":SettingsManager.ANY_KEY
               },anySelected,preSelections,DEFAULT);
               addSelection(anySelection);
            }
            if((param1.key & SettingsManager.OKAY_KEY) == SettingsManager.OKAY_KEY)
            {
               okaySelection = HiddenShopManager.newSelection();
               okaySelection.init({
                  "label":"OKAY",
                  "key":SettingsManager.OKAY_KEY
               },okaySelected,preSelections,DEFAULT);
               addSelection(okaySelection);
            }
            if((param1.key & SettingsManager.HAVE_TAGS) == SettingsManager.HAVE_TAGS)
            {
               haveTagsSelection = HiddenShopManager.newSelection();
               haveTagsSelection.init({
                  "label":"HAVE TAGS",
                  "key":SettingsManager.HAVE_TAGS
               },haveTagsSelected,preSelections,DEFAULT);
               addSelection(haveTagsSelection);
            }
            if((param1.key & SettingsManager.HAVE_NO_TAGS) == SettingsManager.HAVE_NO_TAGS)
            {
               noTagsSelection = HiddenShopManager.newSelection();
               noTagsSelection.init({
                  "label":"NO TAGS",
                  "key":SettingsManager.HAVE_NO_TAGS
               },noTagsSelected,preSelections,DEFAULT);
               addSelection(noTagsSelection);
            }
         };
         var addSelection:Function = function(param1:Selection, param2:Object = null):void
         {
            selections.push(param1);
            addChild(param1);
            param1.x = nextPos.x;
            param1.y = nextPos.y;
            if(selections.length % rows == 0)
            {
               nextPos.y = 0;
               nextPos.x += param1.width;
            }
            else
            {
               nextPos.y += param1.height;
            }
            if(type == THEMES && param2 != null)
            {
               if(param2.year != nextYear)
               {
                  nextYear = param2.year;
                  nextPos.y += 10;
               }
            }
         };
         var i:int = 0;
         while(i < dataset.length)
         {
            data = dataset[i];
            if(i == 0)
            {
               handleFlags(data);
            }
            else
            {
               selection = HiddenShopManager.newSelection();
               selection.init(data,this.foundSelection,this.preSelections,type);
               addSelection(selection,data);
            }
            i++;
         }
         this.drawbg();
         this.addPagingArrows();
      }
      
      private function addPagingArrows() : void
      {
         if(this.nextPos.x > 1240)
         {
            this.moveLeftBtn = new ScreenIcons.ArrowButtonLeftIcon();
            this.moveRightBtn = new ScreenIcons.ArrowButtonRightIcon();
            this.moveLeftBtn.scaleX = this.moveLeftBtn.scaleY = this.moveRightBtn.scaleX = this.moveRightBtn.scaleY = 2;
            this.moveRightBtn.x = this.moveLeftBtn.width;
            StageReference.getStage().addChild(this.moveLeftBtn);
            StageReference.getStage().addChild(this.moveRightBtn);
            Buttonizer.buttonizeFrames(this.moveLeftBtn,this.onMoveLeft);
            Buttonizer.buttonizeFrames(this.moveRightBtn,this.onMoveRight);
            Buttonizer.setButtonizedEnabled(this.moveLeftBtn,false);
         }
      }
      
      private function onMoveRight(param1:MouseEvent) : void
      {
         x -= MOVE_INCREMENT;
         Buttonizer.setButtonizedEnabled(this.moveLeftBtn,true);
      }
      
      private function onMoveLeft(param1:MouseEvent) : void
      {
         x += MOVE_INCREMENT;
         if(x == upperLeftX)
         {
            Buttonizer.setButtonizedEnabled(this.moveLeftBtn,false);
         }
      }
      
      private function noTagsSelected(param1:Object) : void
      {
         this.destroy();
         this.multipleSelections = new Object();
         this.multipleSelections[param1.key] = param1;
         this.done(this.multipleSelections);
      }
      
      private function haveTagsSelected(param1:Object) : void
      {
         this.destroy();
         this.multipleSelections = new Object();
         this.multipleSelections[param1.key] = param1;
         this.done(this.multipleSelections);
      }
      
      private function okaySelected(param1:Object) : void
      {
         this.destroy();
         if(this.selectMultiple)
         {
            this.done(this.multipleSelections);
         }
         else
         {
            this.done(param1);
         }
      }
      
      private function anySelected(param1:Object) : void
      {
         this.destroy();
         this.multipleSelections = new Object();
         this.multipleSelections[param1.key] = param1;
         this.done(this.multipleSelections);
      }
      
      private function cancelSelected(param1:Object) : void
      {
         this.destroy();
         this.done(param1);
      }
      
      private function drawbg() : void
      {
         graphics.lineStyle(1,0);
         graphics.beginFill(16777215);
         graphics.drawRect(0,0,width + 10,height + 10);
         graphics.endFill();
      }
      
      private function destroy() : void
      {
         var _loc1_:IDestroyable = null;
         for each(_loc1_ in this.selections)
         {
            _loc1_.destroy();
         }
         if(this.moveRightBtn != null)
         {
            StageReference.getStage().removeChild(this.moveLeftBtn);
            StageReference.getStage().removeChild(this.moveRightBtn);
            Buttonizer.unbuttonizeFrames(this.moveLeftBtn,this.onMoveLeft);
            Buttonizer.unbuttonizeFrames(this.moveRightBtn,this.onMoveRight);
            this.moveLeftBtn = null;
            this.moveRightBtn = null;
         }
      }
      
      private function foundSelection(param1:Object) : void
      {
         if(this.anySelection != null)
         {
            this.anySelection.unselect();
         }
         if(this.selectMultiple == false)
         {
            this.destroy();
            this.done(param1);
         }
         else if(this.multipleSelections.hasOwnProperty(param1.key))
         {
            delete this.multipleSelections[param1.key];
         }
         else
         {
            this.multipleSelections[param1.key] = param1;
         }
      }
   }
}

