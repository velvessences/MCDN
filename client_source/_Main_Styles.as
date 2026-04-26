package
{
   import mx.core.IFlexModuleFactory;
   import mx.core.UITextField;
   import mx.core.mx_internal;
   import mx.skins.halo.ApplicationBackground;
   import mx.skins.halo.BrokenImageBorderSkin;
   import mx.skins.halo.BusyCursor;
   import mx.skins.halo.ButtonBarButtonSkin;
   import mx.skins.halo.ButtonSkin;
   import mx.skins.halo.CheckBoxIcon;
   import mx.skins.halo.ColorPickerSkin;
   import mx.skins.halo.ComboBoxArrowSkin;
   import mx.skins.halo.DataGridColumnDropIndicator;
   import mx.skins.halo.DataGridColumnResizeSkin;
   import mx.skins.halo.DataGridHeaderBackgroundSkin;
   import mx.skins.halo.DataGridHeaderSeparator;
   import mx.skins.halo.DataGridSortArrow;
   import mx.skins.halo.DateChooserIndicator;
   import mx.skins.halo.DateChooserMonthArrowSkin;
   import mx.skins.halo.DateChooserYearArrowSkin;
   import mx.skins.halo.DefaultDragImage;
   import mx.skins.halo.HaloBorder;
   import mx.skins.halo.HaloFocusRect;
   import mx.skins.halo.LinkButtonSkin;
   import mx.skins.halo.LinkSeparator;
   import mx.skins.halo.ListDropIndicator;
   import mx.skins.halo.NumericStepperDownSkin;
   import mx.skins.halo.NumericStepperUpSkin;
   import mx.skins.halo.PanelSkin;
   import mx.skins.halo.ProgressBarSkin;
   import mx.skins.halo.ProgressIndeterminateSkin;
   import mx.skins.halo.ProgressMaskSkin;
   import mx.skins.halo.ProgressTrackSkin;
   import mx.skins.halo.RadioButtonIcon;
   import mx.skins.halo.ScrollArrowSkin;
   import mx.skins.halo.ScrollThumbSkin;
   import mx.skins.halo.ScrollTrackSkin;
   import mx.skins.halo.SliderHighlightSkin;
   import mx.skins.halo.SliderThumbSkin;
   import mx.skins.halo.SliderTrackSkin;
   import mx.skins.halo.TabSkin;
   import mx.skins.halo.TitleBackground;
   import mx.skins.halo.ToolTipBorder;
   import mx.styles.CSSCondition;
   import mx.styles.CSSSelector;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.IStyleManager2;
   import mx.utils.ObjectUtil;
   
   public class _Main_Styles
   {
      
      private static var _embed_css_Assets_swf__1314948944_mx_skins_cursor_DragMove_1135715341:Class = _class_embed_css_Assets_swf__1314948944_mx_skins_cursor_DragMove_1135715341;
      
      private static var _embed_css_Assets_swf__1314948944_CloseButtonDisabled_596621231:Class = _class_embed_css_Assets_swf__1314948944_CloseButtonDisabled_596621231;
      
      private static var _embed_css_Assets_swf__1314948944_CloseButtonOver_1833050233:Class = _class_embed_css_Assets_swf__1314948944_CloseButtonOver_1833050233;
      
      private static var _embed_css_Assets_swf__1314948944_mx_skins_cursor_DragReject_351824773:Class = _class_embed_css_Assets_swf__1314948944_mx_skins_cursor_DragReject_351824773;
      
      private static var _embed_css_Assets_swf__1314948944_CloseButtonDown_1997220199:Class = _class_embed_css_Assets_swf__1314948944_CloseButtonDown_1997220199;
      
      private static var _embed_css_Assets_swf__1314948944_cursorStretch_1144173238:Class = _class_embed_css_Assets_swf__1314948944_cursorStretch_1144173238;
      
      private static var _embed_css_Assets_swf__1314948944_TreeDisclosureOpen_1258831200:Class = _class_embed_css_Assets_swf__1314948944_TreeDisclosureOpen_1258831200;
      
      private static var _embed_css_Assets_swf__1314948944_TreeFolderOpen_819860063:Class = _class_embed_css_Assets_swf__1314948944_TreeFolderOpen_819860063;
      
      private static var _embed_css_Assets_swf__1314948944_mx_skins_cursor_DragLink_1135689766:Class = _class_embed_css_Assets_swf__1314948944_mx_skins_cursor_DragLink_1135689766;
      
      private static var _embed_css_Assets_swf__1314948944_mx_skins_cursor_DragCopy_1135427761:Class = _class_embed_css_Assets_swf__1314948944_mx_skins_cursor_DragCopy_1135427761;
      
      private static var _embed_css_Assets_swf__1314948944_CloseButtonUp_760165616:Class = _class_embed_css_Assets_swf__1314948944_CloseButtonUp_760165616;
      
      private static var _embed_css_Assets_swf__1314948944_TreeNodeIcon_1813852372:Class = _class_embed_css_Assets_swf__1314948944_TreeNodeIcon_1813852372;
      
      private static var _embed_css_Assets_swf__1314948944_TreeDisclosureClosed_843508222:Class = _class_embed_css_Assets_swf__1314948944_TreeDisclosureClosed_843508222;
      
      private static var _embed_css_Assets_swf__1314948944_TreeFolderClosed_1765506483:Class = _class_embed_css_Assets_swf__1314948944_TreeFolderClosed_1765506483;
      
      private static var _embed_css_Assets_swf__1314948944_openDateOver_1851109767:Class = _class_embed_css_Assets_swf__1314948944_openDateOver_1851109767;
      
      private static var _embed_css_Assets_swf__1314948944_mx_skins_cursor_BusyCursor_817248327:Class = _class_embed_css_Assets_swf__1314948944_mx_skins_cursor_BusyCursor_817248327;
      
      private static var _embed_css_Assets_swf__1314948944___brokenImage_328813263:Class = _class_embed_css_Assets_swf__1314948944___brokenImage_328813263;
      
      public function _Main_Styles()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         var style:CSSStyleDeclaration = null;
         var effects:Array = null;
         var mergedStyle:CSSStyleDeclaration = null;
         var fbs:IFlexModuleFactory = param1;
         var styleManager:IStyleManager2 = fbs.getImplementation("mx.styles::IStyleManager2") as IStyleManager2;
         var conditions:Array = null;
         var condition:CSSCondition = null;
         var selector:CSSSelector = null;
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("global",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("global");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.paragraphStartIndent = 0;
               this.shadowDistance = 2;
               this.breakOpportunity = "auto";
               this.kerning = false;
               this.selectionDuration = 250;
               this.leading = 2;
               this.paddingRight = 0;
               this.rollOverOpenDelay = 200;
               this.liveDragging = true;
               this.slideDuration = 300;
               this.iconPlacement = "left";
               this.textFieldClass = UITextField;
               this.layoutDirection = "ltr";
               this.borderStyle = "inset";
               this.ligatureLevel = "common";
               this.repeatDelay = 500;
               this.dropShadowColor = 0;
               this.shadowColor = 15658734;
               this.verticalAlign = "top";
               this.interactionMode = "mouse";
               this.dominantBaseline = "roman";
               this.focusAlpha = 0.4;
               this.fontSharpness = 0;
               this.justificationStyle = "pushInKinsoku";
               this.whiteSpaceCollapse = "collapse";
               this.textDecoration = "none";
               this.fontStyle = "normal";
               this.shadowDirection = "center";
               this.version = "4.0.0";
               this.horizontalScrollPolicy = "auto";
               this.digitWidth = "default";
               this.indicatorGap = 14;
               this.lineBreak = "toFit";
               this.borderCapColor = 9542041;
               this.focusColor = 40447;
               this.themeColor = 40447;
               this.fontSize = 10;
               this.textAlignLast = "start";
               this.paddingLeft = 0;
               this.selectionDisabledColor = 14540253;
               this.trackingRight = 0;
               this.smoothScrolling = true;
               this.showErrorSkin = true;
               this.useRollOver = true;
               this.unfocusedTextSelectionColor = 15263976;
               this.backgroundAlpha = 1;
               this.dropShadowEnabled = false;
               this.baselineShift = 0;
               this.textAlpha = 1;
               this.verticalGap = 6;
               this.closeDuration = 250;
               this.disabledAlpha = 0.5;
               this.fillColor = 16777215;
               this.roundedBottomCorners = true;
               this.highlightAlphas = [0.3,0];
               this.horizontalAlign = "left";
               this.verticalGridLines = true;
               this.textRotation = "auto";
               this.dropShadowVisible = false;
               this.backgroundSize = "auto";
               this.horizontalGridLines = false;
               this.tabStops = null;
               this.firstBaselineOffset = "ascent";
               this.focusRoundedCorners = "tl tr bl br";
               this.lineThrough = false;
               this.focusSkin = HaloFocusRect;
               this.focusedTextSelectionColor = 11060974;
               this.symbolColor = 0;
               this.borderAlpha = 1;
               this.filled = true;
               this.openDuration = 250;
               this.disabledColor = 11187123;
               this.alignmentBaseline = "useDominantBaseline";
               this.modalTransparencyColor = 14540253;
               this.embedFonts = false;
               this.modalTransparencyDuration = 100;
               this.modalTransparency = 0.5;
               this.backgroundImageFillMode = "scale";
               this.lineHeight = "120%";
               this.typographicCase = "default";
               this.borderColor = 12040892;
               this.fontAntiAliasType = "advanced";
               this.selectionColor = 8376063;
               this.cffHinting = "horizontalStem";
               this.contentBackgroundAlpha = 1;
               this.cornerRadius = 0;
               this.borderThickness = 1;
               this.fontFamily = "Verdana";
               this.indentation = 17;
               this.paddingBottom = 0;
               this.digitCase = "default";
               this.repeatInterval = 35;
               this.textSelectedColor = 2831164;
               this.paragraphEndIndent = 0;
               this.disabledIconColor = 10066329;
               this.fontWeight = "normal";
               this.borderVisible = true;
               this.focusBlendMode = "normal";
               this.textAlign = "left";
               this.accentColor = 39423;
               this.shadowCapColor = 14015965;
               this.contentBackgroundColor = 16777215;
               this.fontLookup = "auto";
               this.chromeColor = 13421772;
               this.columnGap = 0;
               this.focusThickness = 2;
               this.verticalGridLineColor = 14015965;
               this.blockProgression = "tb";
               this.textRollOverColor = 2831164;
               this.fillAlphas = [0.6,0.4,0.75,0.65];
               this.horizontalGridLineColor = 16250871;
               this.strokeWidth = 1;
               this.fontGridFitType = "pixel";
               this.errorColor = 16711680;
               this.paragraphSpaceAfter = 0;
               this.unfocusedSelectionColor = 15263976;
               this.justificationRule = "space";
               this.borderSides = "left top right bottom";
               this.color = 734012;
               this.buttonColor = 7305079;
               this.fillColors = [16777215,13421772,16777215,15658734];
               this.paragraphSpaceBefore = 0;
               this.locale = "en";
               this.textIndent = 0;
               this.fontThickness = 0;
               this.renderingMode = "cff";
               this.textJustify = "interWord";
               this.inactiveSelectionColor = 15263976;
               this.fullScreenHideControlsDelay = 3000;
               this.columnWidth = "auto";
               this.paddingTop = 0;
               this.direction = "ltr";
               this.fixedThumbSize = false;
               this.caretColor = 92159;
               this.letterSpacing = 0;
               this.borderWeight = 1;
               this.columnCount = "auto";
               this.bevel = true;
               this.verticalScrollPolicy = "auto";
               this.trackingLeft = 0;
               this.horizontalGap = 8;
               this.rollOverColor = 11723263;
               this.modalTransparencyBlur = 3;
               this.stroked = false;
               this.iconColor = 1118481;
               this.inactiveTextSelectionColor = 15263976;
               this.leadingModel = "auto";
               this.showErrorTip = true;
               this.autoThumbVisibility = true;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","errorTip");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration(".errorTip");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.borderColor = 13510953;
               this.paddingBottom = 4;
               this.color = 16777215;
               this.paddingRight = 4;
               this.fontSize = 9;
               this.paddingTop = 4;
               this.borderStyle = "errorTipRight";
               this.shadowColor = 0;
               this.paddingLeft = 4;
               this.fontWeight = "bold";
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","headerDragProxyStyle");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration(".headerDragProxyStyle");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.fontWeight = "bold";
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","dateFieldPopup");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration(".dateFieldPopup");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.borderThickness = 0;
               this.backgroundColor = 16777215;
               this.dropShadowVisible = true;
               this.dropShadowEnabled = true;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","swatchPanelTextField");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration(".swatchPanelTextField");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.highlightColor = 12897484;
               this.backgroundColor = 16777215;
               this.borderColor = 14015965;
               this.borderCapColor = 9542041;
               this.buttonColor = 7305079;
               this.shadowCapColor = 14015965;
               this.paddingRight = 5;
               this.borderStyle = "inset";
               this.paddingLeft = 5;
               this.shadowColor = 14015965;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","todayStyle");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration(".todayStyle");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.color = 16777215;
               this.textAlign = "center";
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","weekDayStyle");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration(".weekDayStyle");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.textAlign = "center";
               this.fontWeight = "bold";
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","windowStatus");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration(".windowStatus");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.color = 6710886;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","windowStyles");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration(".windowStyles");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.fontWeight = "bold";
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","activeButtonStyle");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration(".activeButtonStyle");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","activeTabStyle");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration(".activeTabStyle");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.fontWeight = "bold";
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","alertButtonStyle");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration(".alertButtonStyle");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.color = 734012;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","comboDropdown");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration(".comboDropdown");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.shadowDistance = 1;
               this.borderThickness = 0;
               this.backgroundColor = 16777215;
               this.leading = 0;
               this.paddingRight = 5;
               this.dropShadowEnabled = true;
               this.shadowDirection = "center";
               this.paddingLeft = 5;
               this.fontWeight = "normal";
               this.cornerRadius = 0;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","dataGridStyles");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration(".dataGridStyles");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.fontWeight = "bold";
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","headerDateText");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration(".headerDateText");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.textAlign = "center";
               this.fontWeight = "bold";
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","linkButtonStyle");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration(".linkButtonStyle");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.paddingBottom = 2;
               this.paddingRight = 2;
               this.paddingTop = 2;
               this.paddingLeft = 2;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","opaquePanel");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration(".opaquePanel");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.backgroundColor = 16777215;
               this.borderColor = 16777215;
               this.footerColors = [15198183,13092807];
               this.headerColors = [15198183,14277081];
               this.borderAlpha = 1;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","plain");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration(".plain");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.backgroundColor = 16777215;
               this.paddingBottom = 0;
               this.backgroundImage = "";
               this.horizontalAlign = "left";
               this.paddingRight = 0;
               this.paddingTop = 0;
               this.paddingLeft = 0;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","popUpMenu");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration(".popUpMenu");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.textAlign = "left";
               this.fontWeight = "normal";
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","richTextEditorTextAreaStyle");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration(".richTextEditorTextAreaStyle");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","textAreaVScrollBarStyle");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration(".textAreaVScrollBarStyle");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","textAreaHScrollBarStyle");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration(".textAreaHScrollBarStyle");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.managers.CursorManager",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.managers.CursorManager");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.busyCursor = BusyCursor;
               this.busyCursorBackground = _embed_css_Assets_swf__1314948944_mx_skins_cursor_BusyCursor_817248327;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.managers.DragManager",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.managers.DragManager");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.linkCursor = _embed_css_Assets_swf__1314948944_mx_skins_cursor_DragLink_1135689766;
               this.rejectCursor = _embed_css_Assets_swf__1314948944_mx_skins_cursor_DragReject_351824773;
               this.copyCursor = _embed_css_Assets_swf__1314948944_mx_skins_cursor_DragCopy_1135427761;
               this.moveCursor = _embed_css_Assets_swf__1314948944_mx_skins_cursor_DragMove_1135715341;
               this.defaultDragImageSkin = DefaultDragImage;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.controls.SWFLoader",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.SWFLoader");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.brokenImageBorderSkin = BrokenImageBorderSkin;
               this.brokenImageSkin = _embed_css_Assets_swf__1314948944___brokenImage_328813263;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.controls.ToolTip",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.ToolTip");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.backgroundColor = 16777164;
               this.borderColor = 9542041;
               this.paddingBottom = 2;
               this.paddingRight = 4;
               this.backgroundAlpha = 0.95;
               this.fontSize = 9;
               this.paddingTop = 2;
               this.borderSkin = ToolTipBorder;
               this.borderStyle = "toolTip";
               this.paddingLeft = 4;
               this.cornerRadius = 2;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.controls.Alert",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.Alert");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.buttonStyleName = "alertButtonStyle";
               this.backgroundColor = 8821927;
               this.borderColor = 8821927;
               this.paddingBottom = 2;
               this.color = 16777215;
               this.roundedBottomCorners = true;
               this.paddingRight = 10;
               this.backgroundAlpha = 0.9;
               this.borderAlpha = 0.9;
               this.paddingTop = 2;
               this.paddingLeft = 10;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.core.Application",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.core.Application");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.backgroundGradientAlphas = [1,1];
               this.backgroundColor = 8821927;
               this.paddingBottom = 24;
               this.horizontalAlign = "center";
               this.backgroundImage = ApplicationBackground;
               this.paddingRight = 24;
               this.backgroundSize = "100%";
               this.paddingTop = 24;
               this.paddingLeft = 24;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.controls.Button",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.Button");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.horizontalGap = 2;
               this.paddingBottom = 2;
               this.textAlign = "center";
               this.paddingRight = 10;
               this.skin = ButtonSkin;
               this.paddingTop = 2;
               this.labelVerticalOffset = 0;
               this.verticalGap = 2;
               this.paddingLeft = 10;
               this.emphasizedSkin = null;
               this.fontWeight = "bold";
               this.cornerRadius = 4;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.controls.ButtonBar",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.ButtonBar");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.verticalAlign = "middle";
               this.horizontalGap = 0;
               this.firstButtonStyleName = "";
               this.textAlign = "center";
               this.horizontalAlign = "center";
               this.lastButtonStyleName = "";
               this.verticalGap = 0;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","buttonBarFirstButtonStyle");
         conditions.push(condition);
         selector = new CSSSelector("mx.controls.buttonBarClasses.ButtonBarButton",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.buttonBarClasses.ButtonBarButton.buttonBarFirstButtonStyle");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.focusRoundedCorners = "tl bl";
               this.skin = null;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","buttonBarLastButtonStyle");
         conditions.push(condition);
         selector = new CSSSelector("mx.controls.buttonBarClasses.ButtonBarButton",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.buttonBarClasses.ButtonBarButton.buttonBarLastButtonStyle");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.focusRoundedCorners = "tr br";
               this.skin = null;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.controls.buttonBarClasses.ButtonBarButton",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.buttonBarClasses.ButtonBarButton");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.downSkin = null;
               this.upSkin = null;
               this.horizontalGap = 1;
               this.selectedDownSkin = null;
               this.overSkin = null;
               this.selectedUpSkin = null;
               this.skin = ButtonBarButtonSkin;
               this.disabledSkin = null;
               this.selectedOverSkin = null;
               this.selectedDisabledSkin = null;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.controls.CalendarLayout",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.CalendarLayout");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.horizontalGap = 7;
               this.paddingBottom = 10;
               this.color = 2831164;
               this.textAlign = "center";
               this.todayColor = 8487297;
               this.paddingRight = 6;
               this.paddingTop = 6;
               this.verticalGap = 6;
               this.paddingLeft = 6;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.controls.CheckBox",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.CheckBox");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.upSkin = null;
               this.paddingRight = 0;
               this.upIcon = null;
               this.icon = CheckBoxIcon;
               this.skin = null;
               this.paddingBottom = 2;
               this.paddingTop = 2;
               this.labelVerticalOffset = 0;
               this.fontWeight = "normal";
               this.textAlign = "left";
               this.selectedUpIcon = null;
               this.overIcon = null;
               this.selectedOverIcon = null;
               this.disabledSkin = null;
               this.selectedDisabledIcon = null;
               this.selectedOverSkin = null;
               this.selectedDisabledSkin = null;
               this.downSkin = null;
               this.downIcon = null;
               this.horizontalGap = 5;
               this.selectedDownSkin = null;
               this.overSkin = null;
               this.selectedUpSkin = null;
               this.iconColor = 2831164;
               this.disabledIcon = null;
               this.paddingLeft = 0;
               this.selectedDownIcon = null;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.controls.ColorPicker",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.ColorPicker");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.skin = ColorPickerSkin;
               this.iconColor = 0;
               this.swatchBorderSize = 0;
               this.fontSize = 11;
               this.verticalGap = 0;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.controls.ComboBase",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.ComboBase");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.borderSkin = HaloBorder;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.controls.ComboBox",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.ComboBox");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.paddingBottom = 0;
               this.editableSkin = null;
               this.leading = 0;
               this.paddingRight = 5;
               this.skin = ComboBoxArrowSkin;
               this.paddingTop = 0;
               this.arrowButtonWidth = 22;
               this.dropdownStyleName = "comboDropdown";
               this.disabledIconColor = 9542041;
               this.paddingLeft = 5;
               this.fontWeight = "bold";
               this.cornerRadius = 5;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","comboDropdown");
         conditions.push(condition);
         selector = new CSSSelector("mx.controls.List",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.List.comboDropdown");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.leading = 0;
               this.paddingRight = 5;
               this.paddingLeft = 5;
               this.fontWeight = "normal";
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.core.Container",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.core.Container");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.borderSkin = HaloBorder;
               this.borderStyle = "none";
               this.cornerRadius = 0;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.containers.ControlBar",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.containers.ControlBar");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.verticalAlign = "middle";
               this.paddingBottom = 10;
               this.paddingRight = 10;
               this.disabledOverlayAlpha = 0;
               this.paddingTop = 10;
               this.borderStyle = "controlBar";
               this.paddingLeft = 10;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.controls.DataGrid",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.DataGrid");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.headerDragProxyStyleName = "headerDragProxyStyle";
               this.alternatingItemColors = [16250871,16777215];
               this.sortArrowSkin = DataGridSortArrow;
               this.verticalGridLineColor = 13421772;
               this.headerColors = [16777215,15132390];
               this.headerStyleName = "dataGridStyles";
               this.columnDropIndicatorSkin = DataGridColumnDropIndicator;
               this.headerSeparatorSkin = DataGridHeaderSeparator;
               this.stretchCursor = _embed_css_Assets_swf__1314948944_cursorStretch_1144173238;
               this.columnResizeSkin = DataGridColumnResizeSkin;
               this.headerBackgroundSkin = DataGridHeaderBackgroundSkin;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.controls.dataGridClasses.DataGridItemRenderer",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.dataGridClasses.DataGridItemRenderer");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.paddingLeft = 5;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.controls.DateChooser",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.DateChooser");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.todayStyleName = "todayStyle";
               this.backgroundColor = 16777215;
               this.todayIndicatorSkin = DateChooserIndicator;
               this.todayColor = 8487297;
               this.headerColors = [14804459,16053751];
               this.headerStyleName = "headerDateText";
               this.prevYearSkin = DateChooserYearArrowSkin;
               this.borderSkin = HaloBorder;
               this.selectionIndicatorSkin = DateChooserIndicator;
               this.cornerRadius = 4;
               this.weekDayStyleName = "weekDayStyle";
               this.prevMonthSkin = DateChooserMonthArrowSkin;
               this.rollOverIndicatorSkin = DateChooserIndicator;
               this.nextMonthSkin = DateChooserMonthArrowSkin;
               this.nextYearSkin = DateChooserYearArrowSkin;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.controls.DateField",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.DateField");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.downSkin = _embed_css_Assets_swf__1314948944_openDateOver_1851109767;
               this.upSkin = _embed_css_Assets_swf__1314948944_openDateOver_1851109767;
               this.overSkin = _embed_css_Assets_swf__1314948944_openDateOver_1851109767;
               this.dateChooserStyleName = "dateFieldPopup";
               this.disabledSkin = _embed_css_Assets_swf__1314948944_openDateOver_1851109767;
               this.cornerRadius = 0;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.controls.HRule",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.HRule");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.strokeWidth = 2;
               this.strokeColor = 12897484;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.controls.HSlider",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.HSlider");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.borderColor = 9542041;
               this.trackHighlightSkin = SliderHighlightSkin;
               this.tickColor = 7305079;
               this.dataTipPrecision = 2;
               this.slideDuration = 300;
               this.trackColors = [15198183,15198183];
               this.thumbSkin = SliderThumbSkin;
               this.labelOffset = -10;
               this.showTrackHighlight = false;
               this.tickOffset = -6;
               this.tickThickness = 1;
               this.thumbOffset = 0;
               this.trackSkin = SliderTrackSkin;
               this.dataTipPlacement = "top";
               this.tickLength = 4;
               this.dataTipOffset = 16;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.controls.Image",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.Image");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.layoutDirection = "ltr";
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.controls.LinkButton",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.LinkButton");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.downSkin = null;
               this.upSkin = null;
               this.selectedDownSkin = null;
               this.paddingRight = 7;
               this.overSkin = null;
               this.selectedUpSkin = null;
               this.skin = LinkButtonSkin;
               this.disabledSkin = null;
               this.selectedOverSkin = null;
               this.selectedDisabledSkin = null;
               this.paddingLeft = 7;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","linkButtonStyle");
         conditions.push(condition);
         selector = new CSSSelector("mx.controls.LinkButton",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.LinkButton.linkButtonStyle");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.paddingBottom = 2;
               this.paddingRight = 2;
               this.paddingTop = 2;
               this.paddingLeft = 2;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.controls.LinkBar",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.LinkBar");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.separatorColor = 12897484;
               this.horizontalGap = 8;
               this.paddingBottom = 2;
               this.separatorWidth = 1;
               this.paddingRight = 2;
               this.separatorSkin = LinkSeparator;
               this.linkButtonStyleName = "linkButtonStyle";
               this.paddingTop = 2;
               this.verticalGap = 8;
               this.paddingLeft = 2;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.controls.listClasses.ListBase",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.listClasses.ListBase");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.backgroundColor = 16777215;
               this._creationPolicy = "auto";
               this.paddingBottom = 2;
               this.paddingRight = 0;
               this.backgroundDisabledColor = 14540253;
               this.dropIndicatorSkin = ListDropIndicator;
               this.paddingTop = 2;
               this.borderStyle = "solid";
               this.paddingLeft = 2;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.controls.NavBar",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.NavBar");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.borderSkin = HaloBorder;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.controls.NumericStepper",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.NumericStepper");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.focusRoundedCorners = "tr br";
               this.downArrowSkin = NumericStepperDownSkin;
               this.upArrowSkin = NumericStepperUpSkin;
               this.borderSkin = HaloBorder;
               this.cornerRadius = 5;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.containers.Panel",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.containers.Panel");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.backgroundColor = 16777215;
               this.borderColor = 14869218;
               this.paddingRight = 0;
               this.borderAlpha = 0.4;
               this.resizeEndEffect = "Dissolve";
               this.statusStyleName = "windowStatus";
               this.dropShadowEnabled = true;
               this.borderSkin = PanelSkin;
               this.cornerRadius = 4;
               this.borderThickness = 0;
               this.borderThicknessRight = 10;
               this.paddingBottom = 0;
               this.roundedBottomCorners = false;
               this.borderThicknessTop = 2;
               this.titleBackgroundSkin = TitleBackground;
               this.paddingTop = 0;
               this.borderStyle = "default";
               this.borderThicknessLeft = 10;
               this.paddingLeft = 0;
               this.titleStyleName = "windowStyles";
               this.resizeStartEffect = "Dissolve";
            };
         }
         effects = style.mx_internal::effects;
         if(!effects)
         {
            effects = style.mx_internal::effects = [];
         }
         effects.push("resizeEndEffect");
         effects.push("resizeStartEffect");
         effects.push("resizeEndEffect");
         effects.push("resizeStartEffect");
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.controls.ProgressBar",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.ProgressBar");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.indeterminateSkin = ProgressIndeterminateSkin;
               this.barSkin = ProgressBarSkin;
               this.leading = 0;
               this.trackSkin = ProgressTrackSkin;
               this.indeterminateMoveInterval = 28;
               this.maskSkin = ProgressMaskSkin;
               this.trackColors = [15198183,16777215];
               this.fontWeight = "bold";
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.controls.RadioButton",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.RadioButton");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.upSkin = null;
               this.paddingRight = 0;
               this.upIcon = null;
               this.icon = RadioButtonIcon;
               this.skin = null;
               this.cornerRadius = 7;
               this.paddingBottom = 2;
               this.paddingTop = 2;
               this.labelVerticalOffset = 0;
               this.fontWeight = "normal";
               this.textAlign = "left";
               this.selectedUpIcon = null;
               this.overIcon = null;
               this.selectedOverIcon = null;
               this.disabledSkin = null;
               this.selectedDisabledIcon = null;
               this.selectedOverSkin = null;
               this.selectedDisabledSkin = null;
               this.downSkin = null;
               this.downIcon = null;
               this.horizontalGap = 5;
               this.selectedDownSkin = null;
               this.overSkin = null;
               this.selectedUpSkin = null;
               this.iconColor = 2831164;
               this.disabledIcon = null;
               this.paddingLeft = 0;
               this.selectedDownIcon = null;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","richTextEditorTextAreaStyle");
         conditions.push(condition);
         selector = new CSSSelector("mx.controls.TextArea",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.TextArea.richTextEditorTextAreaStyle");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.controls.TextArea",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.TextArea");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.backgroundColor = 16777215;
               this.horizontalScrollBarStyleName = "textAreaHScrollBarStyle";
               this.verticalScrollBarStyleName = "textAreaVScrollBarStyle";
               this.backgroundDisabledColor = 14540253;
               this.borderStyle = "solid";
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.controls.scrollClasses.ScrollBar",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.scrollClasses.ScrollBar");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.thumbSkin = ScrollThumbSkin;
               this.borderColor = 12040892;
               this.paddingBottom = 0;
               this.thumbOffset = 0;
               this.paddingRight = 0;
               this.trackSkin = ScrollTrackSkin;
               this.downArrowSkin = ScrollArrowSkin;
               this.upArrowSkin = ScrollArrowSkin;
               this.paddingTop = 0;
               this.paddingLeft = 0;
               this.trackColors = [9738651,15198183];
               this.cornerRadius = 4;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.core.ScrollControlBase",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.core.ScrollControlBase");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.focusRoundedCorners = "tl tr bl br";
               this.borderSkin = HaloBorder;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.controls.sliderClasses.Slider",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.sliderClasses.Slider");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.thumbSkin = null;
               this.labelOffset = -10;
               this.showTrackHighlight = false;
               this.tickOffset = -6;
               this.tickThickness = 1;
               this.thumbOffset = 0;
               this.trackHighlightSkin = null;
               this.tickColor = 7305079;
               this.trackSkin = null;
               this.dataTipPrecision = 2;
               this.slideDuration = 300;
               this.dataTipOffset = 16;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.controls.colorPickerClasses.SwatchPanel",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.colorPickerClasses.SwatchPanel");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.previewHeight = 22;
               this.backgroundColor = 15066855;
               this.borderColor = 10856878;
               this.paddingRight = 5;
               this.swatchBorderSize = 1;
               this.columnCount = 20;
               this.swatchHighlightSize = 1;
               this.textFieldWidth = 72;
               this.verticalGap = 0;
               this.swatchGridBackgroundColor = 0;
               this.swatchBorderColor = 0;
               this.previewWidth = 45;
               this.swatchHeight = 12;
               this.highlightColor = 16777215;
               this.horizontalGap = 0;
               this.paddingBottom = 5;
               this.textFieldStyleName = "swatchPanelTextField";
               this.swatchGridBorderSize = 0;
               this.swatchWidth = 12;
               this.fontSize = 11;
               this.paddingTop = 4;
               this.swatchHighlightColor = 16777215;
               this.paddingLeft = 5;
               this.shadowColor = 5068126;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.controls.tabBarClasses.Tab",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.tabBarClasses.Tab");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.downSkin = null;
               this.upSkin = null;
               this.paddingBottom = 1;
               this.selectedDownSkin = null;
               this.overSkin = null;
               this.selectedUpSkin = null;
               this.skin = TabSkin;
               this.disabledSkin = null;
               this.selectedOverSkin = null;
               this.paddingTop = 1;
               this.selectedDisabledSkin = null;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.controls.TabBar",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.TabBar");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.verticalAlign = "top";
               this.horizontalGap = -1;
               this.textAlign = "center";
               this.horizontalAlign = "left";
               this.verticalGap = -1;
               this.selectedTabTextStyleName = "activeTabStyle";
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.containers.TabNavigator",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.containers.TabNavigator");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.backgroundColor = 16777215;
               this.borderColor = 11187123;
               this.horizontalGap = -1;
               this.horizontalAlign = "left";
               this.paddingTop = 10;
               this.tabOffset = 0;
               this.borderStyle = "solid";
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","textAreaVScrollBarStyle");
         conditions.push(condition);
         selector = new CSSSelector("mx.controls.HScrollBar",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.HScrollBar.textAreaVScrollBarStyle");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","textAreaHScrollBarStyle");
         conditions.push(condition);
         selector = new CSSSelector("mx.controls.VScrollBar",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.VScrollBar.textAreaHScrollBarStyle");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.controls.TextInput",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.TextInput");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.backgroundColor = 16777215;
               this.paddingRight = 0;
               this.backgroundDisabledColor = 14540253;
               this.paddingTop = 0;
               this.borderSkin = HaloBorder;
               this.paddingLeft = 0;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.containers.TitleWindow",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.containers.TitleWindow");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.backgroundColor = 16777215;
               this.closeButtonDisabledSkin = _embed_css_Assets_swf__1314948944_CloseButtonDisabled_596621231;
               this.paddingBottom = 4;
               this.paddingRight = 4;
               this.closeButtonUpSkin = _embed_css_Assets_swf__1314948944_CloseButtonUp_760165616;
               this.closeButtonOverSkin = _embed_css_Assets_swf__1314948944_CloseButtonOver_1833050233;
               this.paddingTop = 4;
               this.dropShadowEnabled = true;
               this.paddingLeft = 4;
               this.closeButtonDownSkin = _embed_css_Assets_swf__1314948944_CloseButtonDown_1997220199;
               this.cornerRadius = 8;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.controls.Tree",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.Tree");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.folderClosedIcon = _embed_css_Assets_swf__1314948944_TreeFolderClosed_1765506483;
               this.verticalAlign = "middle";
               this.disclosureOpenIcon = _embed_css_Assets_swf__1314948944_TreeDisclosureOpen_1258831200;
               this.paddingRight = 0;
               this.folderOpenIcon = _embed_css_Assets_swf__1314948944_TreeFolderOpen_819860063;
               this.defaultLeafIcon = _embed_css_Assets_swf__1314948944_TreeNodeIcon_1813852372;
               this.paddingLeft = 2;
               this.disclosureClosedIcon = _embed_css_Assets_swf__1314948944_TreeDisclosureClosed_843508222;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("mx.controls.VRule",conditions,selector);
         mergedStyle = styleManager.getMergedStyleDeclaration("mx.controls.VRule");
         style = new CSSStyleDeclaration(selector,styleManager,mergedStyle == null);
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.strokeWidth = 2;
               this.strokeColor = 12897484;
            };
         }
         if(mergedStyle != null && (Boolean(mergedStyle.defaultFactory == null) || Boolean(ObjectUtil.compare(new style.defaultFactory(),new mergedStyle.defaultFactory()))))
         {
            styleManager.setStyleDeclaration(style.mx_internal::selectorString,style,false);
         }
      }
   }
}

