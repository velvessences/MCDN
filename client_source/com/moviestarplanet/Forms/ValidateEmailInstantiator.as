package com.moviestarplanet.Forms
{
   import com.moviestarplanet.pleaseremoveasap.IValidateEmail;
   
   public class ValidateEmailInstantiator implements IValidateEmail
   {
      
      public function ValidateEmailInstantiator()
      {
         super();
      }
      
      public function open() : void
      {
         ValidateEmailOpener.getInstance().open();
      }
   }
}

