package com.moviestarplanet.clientcensor.textfield
{
   import com.moviestarplanet.clientcensor.Censor;
   import com.moviestarplanet.constants.ConstantsPlatform;
   import com.moviestarplanet.emoticon.utility.NativeEmoticonSupport;
   import com.moviestarplanet.userbehavior.IRedifyableTextInputComponent;
   import com.moviestarplanet.utils.Cloner;
   import com.moviestarplanet.utils.StringUtilities;
   import com.moviestarplanet.utils.chatfilter.ITextInputComponent;
   import com.moviestarplanet.utils.textfield.TextFieldUtilities;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   
   public class TextFieldInputRestricted extends TextField implements IRedifyableTextInputComponent, ITextInputComponent
   {
      
      private var _originalTextFormat:TextFormat;
      
      private var _containsIllegalText:Boolean;
      
      public function TextFieldInputRestricted()
      {
         super();
         this._containsIllegalText = false;
         type = TextFieldType.INPUT;
         this._originalTextFormat = Cloner.clone(defaultTextFormat);
         this.initRestriction();
         if(ConstantsPlatform.isIOS)
         {
            NativeEmoticonSupport.getInstance().addSupport(this);
         }
         TextFieldUtilities.fixPolishCharIssue(this);
      }
      
      private function initRestriction() : void
      {
         restrict = Censor.getAllowedInputChars();
      }
      
      public function doRedify(param1:Array) : void
      {
         this._containsIllegalText = true;
         if(param1.length == 0)
         {
            return;
         }
         if(this._originalTextFormat.color == 16711680)
         {
            this._originalTextFormat.color = 0;
            textColor = uint(this._originalTextFormat.color);
         }
         this.htmlText = StringUtilities.getRedifiedHTMLText(this.text,param1);
      }
      
      public function removeRedified() : void
      {
         this._containsIllegalText = false;
         this._originalTextFormat.color = this._originalTextFormat.color == null ? 0 : this._originalTextFormat.color;
         textColor = uint(this._originalTextFormat.color);
      }
      
      public function enableUserInput() : void
      {
         type = TextFieldType.INPUT;
      }
      
      public function disableUserInput() : void
      {
         type = TextFieldType.DYNAMIC;
      }
      
      public function get isEnabled() : Boolean
      {
         return type == TextFieldType.INPUT;
      }
      
      override public function set defaultTextFormat(param1:TextFormat) : void
      {
         this._originalTextFormat = param1;
         super.defaultTextFormat = param1;
      }
      
      public function performTextProcessing() : void
      {
         Censor.redifyBadWords(this);
      }
      
      override public function replaceText(param1:int, param2:int, param3:String) : void
      {
         super.replaceText(param1,param2,param3);
         dispatchEvent(new Event(Event.CHANGE));
         this.performTextProcessing();
      }
      
      public function destroy() : void
      {
         NativeEmoticonSupport.getInstance().removeSupport(this);
      }
      
      public function get containsIllegalText() : Boolean
      {
         return this._containsIllegalText;
      }
   }
}

