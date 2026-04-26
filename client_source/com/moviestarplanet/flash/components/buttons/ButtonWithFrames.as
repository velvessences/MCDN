package com.moviestarplanet.flash.components.buttons
{
   import com.moviestarplanet.font.IFontManager;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.managers.SoundManager;
   import com.moviestarplanet.utils.translation.TranslationUtilities;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class ButtonWithFrames
   {
      
      [Inject]
      public var fontManager:IFontManager;
      
      protected var movieClip:MovieClip;
      
      protected var textFieldName:String;
      
      protected var text:String;
      
      protected var translate:Boolean;
      
      protected var soundClick:String;
      
      protected var soundHover:String;
      
      protected var callback:Function;
      
      public function ButtonWithFrames(param1:MovieClip, param2:Function, param3:Boolean = false, param4:String = null, param5:String = null, param6:String = null)
      {
         super();
         InjectionManager.manager().injectMe(this);
         this.movieClip = param1;
         this.movieClip.stop();
         this.textFieldName = param4;
         this.translate = param3;
         this.soundClick = param5;
         this.soundHover = param6;
         this.callback = param2;
         if(param4 != null)
         {
            this.fontManager.setupTextField(TextField(param1[param4]));
            this.text = TextField(param1[param4]).text;
            if(param3 == true)
            {
               this.text = TranslationUtilities.translate(this.text);
            }
         }
         else
         {
            this.fontManager.setupDisplayObject(param1);
         }
         this.setButtonizedEnabled(true);
         this.goToFrame("normal");
      }
      
      protected function clickHandler(param1:MouseEvent) : void
      {
         if(this.soundClick != null)
         {
            SoundManager.Instance().playSoundEffect(this.soundClick);
         }
         this.callback(param1);
      }
      
      protected function setCursorSettings(param1:Boolean) : void
      {
         if(this.movieClip == null)
         {
            return;
         }
         this.movieClip.useHandCursor = param1;
         this.movieClip.buttonMode = param1;
         this.movieClip.mouseChildren = false;
      }
      
      protected function addMouseAwareness() : void
      {
         if(this.movieClip == null)
         {
            return;
         }
         this.movieClip.addEventListener(MouseEvent.CLICK,this.clickHandler);
         this.movieClip.addEventListener(MouseEvent.MOUSE_OVER,this.hover);
         this.movieClip.addEventListener(MouseEvent.MOUSE_DOWN,this.down);
         this.movieClip.addEventListener(MouseEvent.MOUSE_UP,this.hover);
         this.movieClip.addEventListener(MouseEvent.MOUSE_OUT,this.normal);
      }
      
      private function removeMouseAwareness() : void
      {
         if(this.movieClip == null)
         {
            return;
         }
         this.movieClip.removeEventListener(MouseEvent.CLICK,this.clickHandler);
         this.movieClip.removeEventListener(MouseEvent.MOUSE_OVER,this.hover);
         this.movieClip.removeEventListener(MouseEvent.MOUSE_DOWN,this.down);
         this.movieClip.removeEventListener(MouseEvent.MOUSE_UP,this.hover);
         this.movieClip.removeEventListener(MouseEvent.MOUSE_OUT,this.normal);
      }
      
      protected function hover(param1:Event) : void
      {
         if(this.soundHover != null)
         {
            SoundManager.Instance().playSoundEffect(this.soundHover);
         }
         this.goToFrame("hover");
      }
      
      protected function down(param1:Event) : void
      {
         this.goToFrame("down");
      }
      
      protected function normal(param1:Event) : void
      {
         this.goToFrame("normal");
      }
      
      protected function goToFrame(param1:String) : void
      {
         if(this.movieClip == null)
         {
            return;
         }
         this.movieClip.gotoAndStop(param1);
         if(this.textFieldName != null)
         {
            if(TextField(this.movieClip[this.textFieldName]).text == "" || this.translate == true)
            {
               TextField(this.movieClip[this.textFieldName]).text = this.text;
            }
         }
         else if(this.translate == true)
         {
            this.fontManager.setupDisplayObject(this.movieClip);
            TranslationUtilities.translateDisplayObject(this.movieClip,true);
         }
      }
      
      public function select() : void
      {
         this.setButtonizedEnabled(false);
         this.goToFrame("down");
      }
      
      public function setButtonizedEnabled(param1:Boolean) : void
      {
         this.setCursorSettings(param1);
         if(param1 == true)
         {
            this.addMouseAwareness();
         }
         else
         {
            this.removeMouseAwareness();
         }
      }
      
      public function deselect() : void
      {
         this.setButtonizedEnabled(true);
         this.goToFrame("normal");
      }
      
      public function destroy() : void
      {
         if(this.movieClip != null)
         {
            this.movieClip.removeEventListener(MouseEvent.CLICK,this.clickHandler);
            this.movieClip.removeEventListener(MouseEvent.MOUSE_OVER,this.hover);
            this.movieClip.removeEventListener(MouseEvent.MOUSE_DOWN,this.down);
            this.movieClip.removeEventListener(MouseEvent.MOUSE_UP,this.hover);
            this.movieClip.removeEventListener(MouseEvent.MOUSE_OUT,this.normal);
         }
      }
   }
}

