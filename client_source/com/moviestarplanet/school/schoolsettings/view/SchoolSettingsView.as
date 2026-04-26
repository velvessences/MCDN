package com.moviestarplanet.school.schoolsettings.view
{
   import com.moviestarplanet.IDestroyable;
   import com.moviestarplanet.clientcensor.textfield.InstructionalTextFieldController;
   import com.moviestarplanet.controls.dropdowns.SwipeableDropDown;
   import com.moviestarplanet.controls.utils.Buttonizer;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.locale.ILocaleManager;
   import com.moviestarplanet.school.schoolsettings.controller.SchoolSettingsController;
   import com.moviestarplanet.school.schoolsettings.model.SchoolSettingsModel;
   import com.moviestarplanet.schoolfriends.ui.AutoComplete;
   import com.moviestarplanet.schoolfriends.ui.AutoCompleteEvent;
   import com.moviestarplanet.utils.FlashUtils;
   import com.moviestarplanet.utils.StringUtilities;
   import com.moviestarplanet.utils.displayobject.DisplayObjectUtilities;
   import com.moviestarplanet.utils.displayobject.FlattenUtilities;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import com.moviestarplanet.utils.ui.FlashInstanceUtils;
   import com.moviestarplanet.window.loading.LoadingBar;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   
   public class SchoolSettingsView extends MovieClip implements IDestroyable
   {
      
      private const classes:Vector.<String> = Vector.<String>(["A","B","C","D","E","F","V","W","X","Y","Z","?"]);
      
      private const hasSchoolDataFontColor:uint = 16777215;
      
      private var model:SchoolSettingsModel;
      
      private var controller:SchoolSettingsController;
      
      private var asset:SchoolSettingsAsset;
      
      public var isAssetLoaded:Boolean;
      
      private var loadingBar:LoadingBar;
      
      private var _skipButton:MovieClip;
      
      public var autoComplete:AutoComplete;
      
      private var dropDownScrollerClass:Class;
      
      private var dropDownYear:SwipeableDropDown;
      
      private var dropDownClass:SwipeableDropDown;
      
      [Inject]
      public var localeManager:ILocaleManager;
      
      private const LOCALE_PREFIX_CLASS:String = "MSP_MY_SCHOOL_CLASS_";
      
      private const LOCALE_PREFIX_YEAR:String = "MSP_MY_SCHOOL_YEAR_";
      
      private const LOCALE_SUFFIX_SPECIAL_VALUE:String = "OTHER";
      
      private var onInitializedCallback:Function;
      
      private var _schoolInputInstructController:InstructionalTextFieldController;
      
      private var _nameInputInstructController:InstructionalTextFieldController;
      
      public function SchoolSettingsView()
      {
         super();
         InjectionManager.manager().injectMe(this);
      }
      
      public function mvc(param1:SchoolSettingsModel, param2:SchoolSettingsController) : void
      {
         this.model = param1;
         this.controller = param2;
      }
      
      public function initialize(param1:Function) : void
      {
         this.onInitializedCallback = param1;
         this.isAssetLoaded = false;
         this.createPlaceHolder();
         this.loadingBar = new LoadingBar();
         this.loadingBar.show();
         if(this.onInitializedCallback != null)
         {
            this.asset = new SchoolSettingsAssetWithAnchorCharacter();
         }
         else
         {
            this.asset = new SchoolSettingsAsset();
         }
         this.asset.loadAsset(this.assetLoaded);
      }
      
      public function showLoading() : void
      {
         this.loadingBar.show();
      }
      
      public function hideLoading() : void
      {
         this.loadingBar.hide();
      }
      
      private function assetLoaded() : void
      {
         this.initAsset();
         this.isAssetLoaded = true;
         this.controller.viewLoadedHandler();
      }
      
      public function placeAssets() : void
      {
         addChild(this.asset.Container);
      }
      
      public function initAsset() : void
      {
         this.setFirstNameEnabled(false);
         this.setInstructionsEnabled(true);
         this.asset.SchoolNameValueText.type = TextFieldType.DYNAMIC;
         this.asset.SchoolNameValueText.selectable = false;
         if(this.asset.FindMoviestarsText != null)
         {
            this.asset.FindMoviestarsText.text = MSPLocaleManagerWeb.getInstance().getString("MSP_MY_SCHOOL_HEADLINE_1");
         }
         this.asset.FillInDetailsText.text = MSPLocaleManagerWeb.getInstance().getString("MSP_MY_SCHOOL_HEADLINE_2");
         this.asset.SchoolTitleText.text = MSPLocaleManagerWeb.getInstance().getString("SCHOOL") + ":";
         this.asset.YearTitleText.text = MSPLocaleManagerWeb.getInstance().getString("SCHOOL_GRADE") + ":";
         this.asset.ClassTitleText.text = MSPLocaleManagerWeb.getInstance().getString("MSP_MY_SCHOOL_CLASS") + ":";
         this.asset.FirstNameTitleText.text = MSPLocaleManagerWeb.getInstance().getString("MSP_MY_SCHOOL_FIRST_NAME_2") + ":";
         this.asset.FirstNameValueText.text = "";
         this.asset.InfoTextNoEdit.text = MSPLocaleManagerWeb.getInstance().getString("SCHOOL_LIMIT_WARNING_WEB");
         FlattenUtilities.flattenSprite(this.asset.Decorations,1.5);
         this.asset.OkButton.ButtonText.text = MSPLocaleManagerWeb.getInstance().getString("OK");
         Buttonizer.buttonizeFrames(this.asset.OkButton,this.okButtonClicked);
         this.asset.FirstNameValueText.addEventListener(Event.CHANGE,this.firstNameValueChanged);
         this.validateInput();
         var _loc1_:Sprite = FlashUtils.duplicateDisplayObject(this.asset.dropDownSwf) as Sprite;
         var _loc2_:int = -6;
         var _loc3_:int = -2;
         this.dropDownClass = new SwipeableDropDown(_loc1_,this.generateLocalesList(this.LOCALE_PREFIX_CLASS),0,this.classSelected);
         this.dropDownClass.x = this.asset.SchoolBar.x + this.asset.SchoolBar.width - _loc1_.width + _loc3_;
         this.dropDownClass.y = this.asset.ClassTitleText.y + _loc2_ + 1;
         this.asset.Container.addChild(this.dropDownClass);
         var _loc4_:Sprite = FlashUtils.duplicateDisplayObject(this.asset.dropDownSwf) as Sprite;
         this.dropDownYear = new SwipeableDropDown(_loc4_,this.generateLocalesList(this.LOCALE_PREFIX_YEAR),0,this.yearSelected);
         this.dropDownYear.x = this.asset.SchoolBar.x + _loc3_;
         this.dropDownYear.y = this.asset.YearTitleText.y + _loc2_;
         this.asset.Container.addChild(this.dropDownYear);
         if(!this._nameInputInstructController)
         {
            this._nameInputInstructController = new InstructionalTextFieldController(MSPLocaleManagerWeb.getInstance().getString("MSP_MY_SCHOOL_TYPE_FIRST_NAME"),this.asset.FirstNameValueText);
         }
         this.initAutoComplete();
         if(this.onInitializedCallback != null)
         {
            this.onInitializedCallback(this.asset.AvatarPlaceholder,this.asset.AnchorCharacterPlaceholder,this.asset.SpeechbubblePlaceholder);
            FlashInstanceUtils.addAtPlaceholder(this._skipButton,this.asset.SkipButtonPlaceholder,this.asset.SkipButtonPlaceholder.parent,true,true);
         }
      }
      
      private function removeOkButton() : void
      {
         if(this.asset.OkButton != null)
         {
            Buttonizer.unbuttonizeFrames(this.asset.OkButton,this.okButtonClicked);
            this.asset.OkButton.visible = false;
            this.asset.OkButton.mouseEnabled = false;
         }
      }
      
      private function removeEditInputs() : void
      {
         if(this.autoComplete)
         {
            this.asset.SchoolBar.removeChild(this.autoComplete);
         }
         if(this.dropDownClass)
         {
            this.asset.Container.removeChild(this.dropDownClass);
         }
         if(this.dropDownYear)
         {
            this.asset.Container.removeChild(this.dropDownYear);
         }
         this.asset.SchoolBar.visible = false;
         this.asset.SchoolBar.mouseEnabled = false;
         this._schoolInputInstructController.switchTextDisplay(true);
         this.asset.YearValueText.visible = false;
         this.asset.YearValueText.mouseEnabled = false;
         this.asset.ClassValueText.visible = false;
         this.asset.ClassValueText.mouseEnabled = false;
         this.asset.FirstNameTitleText.visible = false;
         this.asset.FirstNameValueText.visible = false;
         this.asset.NameBar.visible = false;
         this._nameInputInstructController.switchTextDisplay(true);
      }
      
      public function setFirstNameEnabled(param1:Boolean) : void
      {
         this.asset.FirstNameTitleText.visible = param1;
         this.asset.FirstNameValueText.visible = param1;
         this.asset.NameBar.visible = param1;
      }
      
      private function setInstructionsEnabled(param1:Boolean) : void
      {
         if(this.asset.FindMoviestarsText != null)
         {
            this.asset.FindMoviestarsText.visible = param1;
         }
         this.asset.FillInDetailsText.visible = param1;
         this.asset.TextSchoolName.visible = !param1;
      }
      
      private function firstNameValueChanged(param1:Event) : void
      {
         param1.target.text = StringUtilities.removeNewLinesAndTabs(param1.target.text);
         this.controller.firstNameValueChangedHandler(param1.target.text);
         this.validateInput();
      }
      
      private function generateLocalesList(param1:String) : Array
      {
         var _loc2_:Array = new Array();
         _loc2_.push(this.localeManager.getString(param1 + this.LOCALE_SUFFIX_SPECIAL_VALUE));
         var _loc3_:int = 1;
         var _loc4_:String = this.localeManager.getString(param1 + _loc3_.toString());
         while(_loc4_ != null && _loc4_ != "" && _loc4_.indexOf("#MISSING_LOCALE") < 0 && _loc4_ != "null" && _loc4_ != "UNUSED")
         {
            _loc2_.push(_loc4_);
            _loc3_++;
            _loc4_ = this.localeManager.getString(param1 + _loc3_.toString());
         }
         return _loc2_;
      }
      
      private function yearSelected(param1:int, param2:String) : void
      {
         this.model.schoolYear = param1;
         this.validateInput();
      }
      
      private function classSelected(param1:int, param2:String) : void
      {
         this.model.schoolClass = param1;
         this.validateInput();
      }
      
      private function initAutoComplete() : void
      {
         this.asset.Container.setChildIndex(this.asset.SchoolBar,this.asset.Container.numChildren - 1);
         this.autoComplete = new AutoComplete(this.asset.SchoolNameValueText.width,this.asset.SchoolNameValueText.height,25,MSPLocaleManagerWeb.getInstance().getString("NO_RESULTS_FOUND"),15,300,this.asset.SchoolNameValueText.defaultTextFormat);
         this.autoComplete.addEventListener(AutoCompleteEvent.SHOW_LIST,this.listDepth);
         this.autoComplete.addEventListener(AutoCompleteEvent.TEXT_CHANGED,this.userACTyped);
         this.autoComplete.addEventListener(AutoCompleteEvent.MADE_CHOICE,this.userACChosen);
         this.autoComplete.x = 3;
         if(!this._schoolInputInstructController)
         {
            this._schoolInputInstructController = new InstructionalTextFieldController(MSPLocaleManagerWeb.getInstance().getString("MSP_MY_SCHOOL_TYPE_SCHOOL_NAME"),this.autoComplete.getTextField());
         }
         this.asset.SchoolBar.addChild(this.autoComplete);
      }
      
      private function userACChosen(param1:Object) : void
      {
         this.model.schoolId = param1.data.data;
         this.model.schoolName = param1.data.label;
         this.validateInput();
      }
      
      private function validateInput() : void
      {
         this.toggleOkButton(this.controller.isInputValid());
      }
      
      public function toggleOkButton(param1:Boolean) : void
      {
         DisplayObjectUtilities.setButtonizedEnabled(this.asset.OkButton,param1);
      }
      
      private function listDepth(param1:Event) : void
      {
         this.autoComplete.parent.setChildIndex(this.autoComplete,this.autoComplete.parent.numChildren - 1);
      }
      
      private function userACTyped(param1:AutoCompleteEvent) : void
      {
         var _loc2_:String = param1.data as String;
         this.controller.schoolInputChangedHandler(_loc2_);
      }
      
      private function createPlaceHolder() : void
      {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(0,0);
         _loc1_.graphics.drawRect(0,0,980,500);
         addChild(_loc1_);
      }
      
      private function okButtonClicked(param1:MouseEvent) : void
      {
         this.controller.okButtonClickedHandler();
      }
      
      private function deleteButtonClicked(param1:MouseEvent) : void
      {
         this.controller.deletSchoolSettings();
      }
      
      public function setEditable(param1:Boolean) : void
      {
         this.autoComplete.toggleEdit(param1);
         this.asset.SchoolNameValueText.visible = !param1;
         this.autoComplete.visible = param1;
         this.asset.FirstNameValueText.selectable = param1;
         this.asset.ClassValueText.visible = !param1;
         this.asset.YearValueText.visible = !param1;
         this.dropDownClass.visible = param1;
         this.dropDownYear.visible = param1;
         this._schoolInputInstructController.switchTextDisplay(param1);
         this._nameInputInstructController.switchTextDisplay(param1);
         if(param1)
         {
            this.asset.FirstNameValueText.type = TextFieldType.INPUT;
         }
         else
         {
            this.asset.FirstNameValueText.type = TextFieldType.DYNAMIC;
         }
      }
      
      public function setLocked(param1:int) : void
      {
         this.removeEditInputs();
         this.removeOkButton();
         if(this.asset.FindMoviestarsText != null)
         {
            this.asset.FindMoviestarsText.visible = false;
         }
         this.asset.FillInDetailsText.visible = false;
         this.asset.YearTitleText.visible = false;
         this.asset.ClassTitleText.visible = false;
         this.asset.TextSchoolName.text = this.localeManager.getString("MSP_MY_SCHOOL_SETTINGS_HEADLINE");
         this.asset.TextSchoolName.visible = true;
         this.asset.OkButton.visible = false;
         Buttonizer.unbuttonizeFrames(this.asset.OkButton,this.okButtonClicked);
         var _loc2_:String = "" + this.secondsToDays(param1);
         this.asset.SchoolTitleText.textColor = 0;
         this.asset.SchoolTitleText.text = this.localeManager.getString("MSP_MY_SCHOOL_LOCKED_TEXT2",[_loc2_]);
         this.asset.SchoolTitleText.width = 450;
         this.asset.SchoolTitleText.height = 200;
      }
      
      private function secondsToDays(param1:int) : int
      {
         return int(Math.ceil(param1 / 86400));
      }
      
      public function setAlreadyHasData(param1:int, param2:int, param3:String) : void
      {
         this.removeEditInputs();
         if(this.asset.FindMoviestarsText != null)
         {
            this.asset.FindMoviestarsText.visible = false;
         }
         this.asset.FillInDetailsText.visible = false;
         this._schoolInputInstructController.switchTextDisplay(true);
         this._nameInputInstructController.switchTextDisplay(true);
         this.asset.TextSchoolName.text = this.localeManager.getString("MSP_MY_SCHOOL_SETTINGS_HEADLINE");
         this.asset.TextSchoolName.visible = true;
         this.asset.SchoolTitleText.autoSize = TextFieldAutoSize.LEFT;
         this.asset.YearTitleText.autoSize = TextFieldAutoSize.LEFT;
         this.asset.ClassTitleText.autoSize = TextFieldAutoSize.LEFT;
         this.asset.SchoolTitleText.textColor = this.hasSchoolDataFontColor;
         this.asset.YearTitleText.textColor = this.hasSchoolDataFontColor;
         this.asset.ClassTitleText.textColor = this.hasSchoolDataFontColor;
         var _loc4_:String = this.LOCALE_PREFIX_CLASS + this.convertValueToLocaleSuffix(param2);
         var _loc5_:String = this.localeManager.getString(_loc4_);
         var _loc6_:String = this.LOCALE_PREFIX_YEAR + this.convertValueToLocaleSuffix(param1);
         var _loc7_:String = this.localeManager.getString(_loc6_);
         this.asset.SchoolTitleText.text += " " + param3;
         this.asset.YearTitleText.text += " " + _loc7_;
         this.asset.ClassTitleText.text += " " + _loc5_;
         this.asset.ClassTitleText.x -= 160;
         this.asset.OkButton.ButtonText.text = MSPLocaleManagerWeb.getInstance().getString("DELETE");
         Buttonizer.unbuttonizeFrames(this.asset.OkButton,this.okButtonClicked);
         Buttonizer.buttonizeFrames(this.asset.OkButton,this.deleteButtonClicked);
         DisplayObjectUtilities.setButtonizedEnabled(this.asset.OkButton,true);
      }
      
      public function setSchoolInfo(param1:int, param2:int, param3:String, param4:String) : void
      {
         this.autoComplete.setText(param3);
         this.assignAndAdjustSchoolName(param3);
         this.asset.FirstNameValueText.text = param4;
         var _loc5_:String = this.LOCALE_PREFIX_CLASS + this.convertValueToLocaleSuffix(param2);
         var _loc6_:String = this.localeManager.getString(_loc5_);
         this.asset.ClassValueText.Textfield.text = _loc6_ || "";
         var _loc7_:String = this.LOCALE_PREFIX_YEAR + this.convertValueToLocaleSuffix(param1);
         var _loc8_:String = this.localeManager.getString(_loc7_);
         this.asset.YearValueText.Textfield.text = _loc8_;
      }
      
      private function convertValueToLocaleSuffix(param1:int) : String
      {
         if(param1 == 0)
         {
            return this.LOCALE_SUFFIX_SPECIAL_VALUE;
         }
         return param1.toString();
      }
      
      private function assignAndAdjustSchoolName(param1:String) : void
      {
         var _loc2_:TextFormat = null;
         var _loc3_:int = 0;
         if(param1 != "")
         {
            this.asset.SchoolNameValueText.text = param1;
            this.setInstructionsEnabled(false);
            this.asset.TextSchoolName.text = param1;
            _loc2_ = new TextFormat();
            _loc3_ = 25;
            if(this.asset.TextSchoolName.textWidth > this.asset.TextSchoolName.width)
            {
               while(this.asset.TextSchoolName.textWidth > this.asset.TextSchoolName.width && _loc2_.size > 15)
               {
                  _loc2_.size = --_loc3_;
                  this.asset.TextSchoolName.setTextFormat(_loc2_);
               }
            }
         }
      }
      
      public function addSkipButton(param1:MovieClip) : void
      {
         this._skipButton = param1;
      }
      
      public function destroy() : void
      {
         this.model = null;
         this.controller = null;
         if(this.asset != null)
         {
            if(this.asset.OkButton != null)
            {
               Buttonizer.unbuttonizeFrames(this.asset.OkButton,this.okButtonClicked);
            }
            if(this.asset.FirstNameValueText != null)
            {
               this.asset.FirstNameValueText.removeEventListener(Event.CHANGE,this.firstNameValueChanged);
            }
         }
         if(this.loadingBar != null)
         {
            this.loadingBar.hide();
            this.loadingBar = null;
         }
         if(this.autoComplete != null)
         {
            this.autoComplete.removeChildren();
            this.autoComplete = null;
         }
         if(this.dropDownClass != null)
         {
            this.dropDownClass.destroy();
            this.dropDownClass = null;
         }
         if(this.dropDownYear != null)
         {
            this.dropDownYear.destroy();
            this.dropDownYear = null;
         }
         if(this.asset != null)
         {
            this.asset.Container.removeChildren();
            this.asset = null;
         }
         if(this._schoolInputInstructController)
         {
            this._schoolInputInstructController.destroy();
         }
         if(this._nameInputInstructController)
         {
            this._nameInputInstructController.destroy();
         }
         this.onInitializedCallback = null;
         removeChildren();
      }
   }
}

