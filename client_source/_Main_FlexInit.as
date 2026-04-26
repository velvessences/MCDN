package
{
   import com.adobe.linguistics.spelling.utils.WordList;
   import com.moviestarplanet.messenger.model.InvalidInputError;
   import com.moviestarplanet.messenger.model.LatestMessage;
   import com.moviestarplanet.messenger.model.Message;
   import com.moviestarplanet.messenger.model.MessageList;
   import flash.net.getClassByAlias;
   import flash.net.registerClassAlias;
   import flash.system.*;
   import flash.utils.*;
   import mx.accessibility.AlertAccImpl;
   import mx.accessibility.ButtonAccImpl;
   import mx.accessibility.CheckBoxAccImpl;
   import mx.accessibility.ColorPickerAccImpl;
   import mx.accessibility.ComboBaseAccImpl;
   import mx.accessibility.ComboBoxAccImpl;
   import mx.accessibility.DataGridAccImpl;
   import mx.accessibility.DateChooserAccImpl;
   import mx.accessibility.DateFieldAccImpl;
   import mx.accessibility.LabelAccImpl;
   import mx.accessibility.LinkButtonAccImpl;
   import mx.accessibility.ListAccImpl;
   import mx.accessibility.ListBaseAccImpl;
   import mx.accessibility.PanelAccImpl;
   import mx.accessibility.RadioButtonAccImpl;
   import mx.accessibility.SliderAccImpl;
   import mx.accessibility.TabBarAccImpl;
   import mx.accessibility.TitleWindowAccImpl;
   import mx.accessibility.TreeAccImpl;
   import mx.accessibility.UIComponentAccProps;
   import mx.collections.ArrayCollection;
   import mx.collections.ArrayList;
   import mx.core.IFlexModuleFactory;
   import mx.core.mx_internal;
   import mx.effects.EffectManager;
   import mx.graphics.ImageSnapshot;
   import mx.managers.systemClasses.ChildManager;
   import mx.messaging.channels.AMFChannel;
   import mx.messaging.config.ConfigMap;
   import mx.messaging.config.ServerConfig;
   import mx.messaging.messages.AcknowledgeMessage;
   import mx.messaging.messages.AcknowledgeMessageExt;
   import mx.messaging.messages.AsyncMessage;
   import mx.messaging.messages.AsyncMessageExt;
   import mx.messaging.messages.CommandMessage;
   import mx.messaging.messages.CommandMessageExt;
   import mx.messaging.messages.ErrorMessage;
   import mx.messaging.messages.HTTPRequestMessage;
   import mx.messaging.messages.MessagePerformanceInfo;
   import mx.messaging.messages.RemotingMessage;
   import mx.messaging.messages.SOAPMessage;
   import mx.styles.IStyleManager2;
   import mx.styles.StyleManagerImpl;
   import mx.utils.ObjectProxy;
   
   public class _Main_FlexInit
   {
      
      private static var mx_messaging_channels_AMFChannel_ref:AMFChannel;
      
      public function _Main_FlexInit()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         var styleNames:Array;
         var i:int;
         var styleManager:IStyleManager2 = null;
         var fbs:IFlexModuleFactory = param1;
         new ChildManager(fbs);
         styleManager = new StyleManagerImpl(fbs);
         EffectManager.mx_internal::registerEffectTrigger("addedEffect","added");
         EffectManager.mx_internal::registerEffectTrigger("completeEffect","complete");
         EffectManager.mx_internal::registerEffectTrigger("creationCompleteEffect","creationComplete");
         EffectManager.mx_internal::registerEffectTrigger("focusInEffect","focusIn");
         EffectManager.mx_internal::registerEffectTrigger("focusOutEffect","focusOut");
         EffectManager.mx_internal::registerEffectTrigger("hideEffect","hide");
         EffectManager.mx_internal::registerEffectTrigger("itemsChangeEffect","itemsChange");
         EffectManager.mx_internal::registerEffectTrigger("mouseDownEffect","mouseDown");
         EffectManager.mx_internal::registerEffectTrigger("mouseUpEffect","mouseUp");
         EffectManager.mx_internal::registerEffectTrigger("moveEffect","move");
         EffectManager.mx_internal::registerEffectTrigger("removedEffect","removed");
         EffectManager.mx_internal::registerEffectTrigger("resizeEffect","resize");
         EffectManager.mx_internal::registerEffectTrigger("resizeEndEffect","resizeEnd");
         EffectManager.mx_internal::registerEffectTrigger("resizeStartEffect","resizeStart");
         EffectManager.mx_internal::registerEffectTrigger("rollOutEffect","rollOut");
         EffectManager.mx_internal::registerEffectTrigger("rollOverEffect","rollOver");
         EffectManager.mx_internal::registerEffectTrigger("showEffect","show");
         if(Capabilities.hasAccessibility)
         {
            ComboBoxAccImpl.enableAccessibility();
            RadioButtonAccImpl.enableAccessibility();
            UIComponentAccProps.enableAccessibility();
            ButtonAccImpl.enableAccessibility();
            LinkButtonAccImpl.enableAccessibility();
            TreeAccImpl.enableAccessibility();
            DateFieldAccImpl.enableAccessibility();
            TitleWindowAccImpl.enableAccessibility();
            CheckBoxAccImpl.enableAccessibility();
            ListBaseAccImpl.enableAccessibility();
            LabelAccImpl.enableAccessibility();
            SliderAccImpl.enableAccessibility();
            PanelAccImpl.enableAccessibility();
            AlertAccImpl.enableAccessibility();
            ColorPickerAccImpl.enableAccessibility();
            TabBarAccImpl.enableAccessibility();
            DateChooserAccImpl.enableAccessibility();
            DataGridAccImpl.enableAccessibility();
            ListAccImpl.enableAccessibility();
            ComboBaseAccImpl.enableAccessibility();
         }
         try
         {
            if(getClassByAlias(">com.adobe.linguistics.spelling.utils.WordList") != WordList)
            {
               registerClassAlias(">com.adobe.linguistics.spelling.utils.WordList",WordList);
            }
         }
         catch(e:Error)
         {
            registerClassAlias(">com.adobe.linguistics.spelling.utils.WordList",WordList);
         }
         try
         {
            if(getClassByAlias("com.moviestarplanet.messenger.model.InvalidInputError") != InvalidInputError)
            {
               registerClassAlias("com.moviestarplanet.messenger.model.InvalidInputError",InvalidInputError);
            }
         }
         catch(e:Error)
         {
            registerClassAlias("com.moviestarplanet.messenger.model.InvalidInputError",InvalidInputError);
         }
         try
         {
            if(getClassByAlias("com.moviestarplanet.messenger.model.LatestMessage") != LatestMessage)
            {
               registerClassAlias("com.moviestarplanet.messenger.model.LatestMessage",LatestMessage);
            }
         }
         catch(e:Error)
         {
            registerClassAlias("com.moviestarplanet.messenger.model.LatestMessage",LatestMessage);
         }
         try
         {
            if(getClassByAlias("com.moviestarplanet.messenger.model.Message") != Message)
            {
               registerClassAlias("com.moviestarplanet.messenger.model.Message",Message);
            }
         }
         catch(e:Error)
         {
            registerClassAlias("com.moviestarplanet.messenger.model.Message",Message);
         }
         try
         {
            if(getClassByAlias("com.moviestarplanet.messenger.model.MessageList") != MessageList)
            {
               registerClassAlias("com.moviestarplanet.messenger.model.MessageList",MessageList);
            }
         }
         catch(e:Error)
         {
            registerClassAlias("com.moviestarplanet.messenger.model.MessageList",MessageList);
         }
         try
         {
            if(getClassByAlias("flex.messaging.io.ArrayCollection") != ArrayCollection)
            {
               registerClassAlias("flex.messaging.io.ArrayCollection",ArrayCollection);
            }
         }
         catch(e:Error)
         {
            registerClassAlias("flex.messaging.io.ArrayCollection",ArrayCollection);
         }
         try
         {
            if(getClassByAlias("flex.messaging.io.ArrayList") != ArrayList)
            {
               registerClassAlias("flex.messaging.io.ArrayList",ArrayList);
            }
         }
         catch(e:Error)
         {
            registerClassAlias("flex.messaging.io.ArrayList",ArrayList);
         }
         try
         {
            if(getClassByAlias("flex.graphics.ImageSnapshot") != ImageSnapshot)
            {
               registerClassAlias("flex.graphics.ImageSnapshot",ImageSnapshot);
            }
         }
         catch(e:Error)
         {
            registerClassAlias("flex.graphics.ImageSnapshot",ImageSnapshot);
         }
         try
         {
            if(getClassByAlias("flex.messaging.config.ConfigMap") != ConfigMap)
            {
               registerClassAlias("flex.messaging.config.ConfigMap",ConfigMap);
            }
         }
         catch(e:Error)
         {
            registerClassAlias("flex.messaging.config.ConfigMap",ConfigMap);
         }
         try
         {
            if(getClassByAlias("flex.messaging.messages.AcknowledgeMessage") != AcknowledgeMessage)
            {
               registerClassAlias("flex.messaging.messages.AcknowledgeMessage",AcknowledgeMessage);
            }
         }
         catch(e:Error)
         {
            registerClassAlias("flex.messaging.messages.AcknowledgeMessage",AcknowledgeMessage);
         }
         try
         {
            if(getClassByAlias("DSK") != AcknowledgeMessageExt)
            {
               registerClassAlias("DSK",AcknowledgeMessageExt);
            }
         }
         catch(e:Error)
         {
            registerClassAlias("DSK",AcknowledgeMessageExt);
         }
         try
         {
            if(getClassByAlias("flex.messaging.messages.AsyncMessage") != AsyncMessage)
            {
               registerClassAlias("flex.messaging.messages.AsyncMessage",AsyncMessage);
            }
         }
         catch(e:Error)
         {
            registerClassAlias("flex.messaging.messages.AsyncMessage",AsyncMessage);
         }
         try
         {
            if(getClassByAlias("DSA") != AsyncMessageExt)
            {
               registerClassAlias("DSA",AsyncMessageExt);
            }
         }
         catch(e:Error)
         {
            registerClassAlias("DSA",AsyncMessageExt);
         }
         try
         {
            if(getClassByAlias("flex.messaging.messages.CommandMessage") != CommandMessage)
            {
               registerClassAlias("flex.messaging.messages.CommandMessage",CommandMessage);
            }
         }
         catch(e:Error)
         {
            registerClassAlias("flex.messaging.messages.CommandMessage",CommandMessage);
         }
         try
         {
            if(getClassByAlias("DSC") != CommandMessageExt)
            {
               registerClassAlias("DSC",CommandMessageExt);
            }
         }
         catch(e:Error)
         {
            registerClassAlias("DSC",CommandMessageExt);
         }
         try
         {
            if(getClassByAlias("flex.messaging.messages.ErrorMessage") != ErrorMessage)
            {
               registerClassAlias("flex.messaging.messages.ErrorMessage",ErrorMessage);
            }
         }
         catch(e:Error)
         {
            registerClassAlias("flex.messaging.messages.ErrorMessage",ErrorMessage);
         }
         try
         {
            if(getClassByAlias("flex.messaging.messages.HTTPMessage") != HTTPRequestMessage)
            {
               registerClassAlias("flex.messaging.messages.HTTPMessage",HTTPRequestMessage);
            }
         }
         catch(e:Error)
         {
            registerClassAlias("flex.messaging.messages.HTTPMessage",HTTPRequestMessage);
         }
         try
         {
            if(getClassByAlias("flex.messaging.messages.MessagePerformanceInfo") != MessagePerformanceInfo)
            {
               registerClassAlias("flex.messaging.messages.MessagePerformanceInfo",MessagePerformanceInfo);
            }
         }
         catch(e:Error)
         {
            registerClassAlias("flex.messaging.messages.MessagePerformanceInfo",MessagePerformanceInfo);
         }
         try
         {
            if(getClassByAlias("flex.messaging.messages.RemotingMessage") != RemotingMessage)
            {
               registerClassAlias("flex.messaging.messages.RemotingMessage",RemotingMessage);
            }
         }
         catch(e:Error)
         {
            registerClassAlias("flex.messaging.messages.RemotingMessage",RemotingMessage);
         }
         try
         {
            if(getClassByAlias("flex.messaging.messages.SOAPMessage") != SOAPMessage)
            {
               registerClassAlias("flex.messaging.messages.SOAPMessage",SOAPMessage);
            }
         }
         catch(e:Error)
         {
            registerClassAlias("flex.messaging.messages.SOAPMessage",SOAPMessage);
         }
         try
         {
            if(getClassByAlias("flex.messaging.io.ObjectProxy") != ObjectProxy)
            {
               registerClassAlias("flex.messaging.io.ObjectProxy",ObjectProxy);
            }
         }
         catch(e:Error)
         {
            registerClassAlias("flex.messaging.io.ObjectProxy",ObjectProxy);
         }
         styleNames = ["kerning","alternatingItemColors","leading","fontAntiAliasType","selectionColor","labelWidth","contentBackgroundAlpha","fontFamily","textSelectedColor","layoutDirection","disabledIconColor","strokeColor","dropShadowColor","shadowColor","fontWeight","interactionMode","textAlign","accentColor","fontSharpness","todayColor","shadowCapColor","footerColors","headerColors","contentBackgroundColor","textDecoration","fontStyle","chromeColor","highlightColor","focusColor","themeColor","verticalGridLineColor","fontSize","textRollOverColor","selectionDisabledColor","strokeWidth","horizontalGridLineColor","fontGridFitType","showErrorSkin","errorColor","color","backgroundDisabledColor","textIndent","locale","barColor","fontThickness","separatorWidth","direction","dropdownBorderColor","separatorColor","symbolColor","depthColors","letterSpacing","disabledColor","modalTransparencyColor","rollOverColor","modalTransparencyBlur","modalTransparencyDuration","modalTransparency","iconColor","showErrorTip"];
         i = 0;
         while(i < styleNames.length)
         {
            styleManager.registerInheritingStyle(styleNames[i]);
            i++;
         }
         ServerConfig.xml = <services>
	<service id="fluorine-flashremoting-service">
		<destination id="fluorine">
			<channels>
				<channel ref="my-amf"/>
			</channels>
		</destination>
	</service>
	<channels>
		<channel id="my-amf" type="mx.messaging.channels.AMFChannel">
			<endpoint uri="http://localhost:1600/Gateway.aspx"/>
			<properties>
			</properties>
		</channel>
	</channels>
</services>;
      }
   }
}

import mx.core.TextFieldFactory;

TextFieldFactory;

