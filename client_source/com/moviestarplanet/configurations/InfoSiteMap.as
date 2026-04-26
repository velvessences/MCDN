package com.moviestarplanet.configurations
{
   public class InfoSiteMap
   {
      
      public static const defaultInfoSiteMaps:Object = {
         "us":new InfoSiteMap("http://info.moviestarplanet.com/","about.aspx","parents.aspx","teachers.aspx","user-guide.aspx","safety.aspx","privacy-policy.aspx","terms-conditions.aspx","contact.aspx"),
         "gb":new InfoSiteMap("http://info.moviestarplanet.co.uk/","about.aspx","parents.aspx","teachers.aspx","user-guide.aspx","safety.aspx","privacy-policy.aspx","terms-conditions.aspx","contact.aspx"),
         "de":new InfoSiteMap("http://info.moviestarplanet.de/","ueber.aspx","eltern.aspx","lehrer.aspx","benutzerleitfaden.aspx","sicherheit.aspx","datenschutzrichtlinie.aspx","geschaeftsbedingungen.aspx","kontakt.aspx"),
         "fi":new InfoSiteMap("http://info.moviestarplanet.fi/","info.aspx","vanhemmat.aspx","opettajat.aspx","kaeyttaejaeopas.aspx","turvallisuus.aspx","yksityisyyden-suoja.aspx","ehdot-ja-saeaenoet.aspx","ota-yhteyttae.aspx"),
         "fr":new InfoSiteMap("http://info.moviestarplanet.fr/","a-propos-de.aspx","parents.aspx","professeurs.aspx","guide.aspx","s%C3%A9curit%C3%A9.aspx","confidentialit%C3%A9.aspx","termes-et-conditions.aspx","contact.aspx"),
         "pl":new InfoSiteMap("http://info.moviestarplanet.pl/","o-nas.aspx","rodzice.aspx","nauczyciele.aspx","przewodnik.aspx","bezpieczenstwo.aspx","prywatnosc.aspx","regulamin.aspx","kontakt.aspx"),
         "nl":new InfoSiteMap("http://info.moviestarplanet.nl/","over.aspx","ouders.aspx","leraren.aspx","gebruikershandleiding.aspx","veiligheid.aspx","privacy-beleid.aspx","voorwaarden-condities.aspx","contact.aspx"),
         "no":new InfoSiteMap("http://info.moviestarplanet.no/","om.aspx","foreldre.aspx","laerere.aspx","brukerguide.aspx","sikkerhet.aspx","personvern.aspx","betingelser.aspx","kontakt.aspx"),
         "se":new InfoSiteMap("http://info.moviestarplanet.se/","om.aspx","foeraeldrar.aspx","laerare.aspx","instruktionsguide.aspx","saekerhet.aspx","integritetspolicy.aspx","villkor.aspx","kontakt.aspx"),
         "dk":new InfoSiteMap("http://info.moviestarplanet.dk/","om.aspx","foraeldre.aspx","undervisere.aspx","brugervejledning.aspx","sikkerhed.aspx","fortrolighedspolitik.aspx","vilkaar-betingelser.aspx","kontakt.aspx"),
         "tr":new InfoSiteMap("http://info.moviestarplanet.com.tr/","hakk%C4%B1nda.aspx","ebeveynler.aspx","oe%c4%9fretmenler.aspx","k%C4%B1lavuz.aspx","guevenlik.aspx","gizlilik-politikas%c4%b1.aspx","kurallar-ve-ko%c5%9fullar.aspx","bize-ula%c5%9f%c4%b1n.aspx"),
         "au":new InfoSiteMap("http://info.moviestarplanet.com.au/","about.aspx","parents.aspx","teachers.aspx","user-guide.aspx","safety.aspx","privacy-policy.aspx","terms-conditions.aspx","contact.aspx"),
         "nz":new InfoSiteMap("http://info.moviestarplanet.co.nz/","about.aspx","parents.aspx","teachers.aspx","user-guide.aspx","safety.aspx","privacy-policy.aspx","terms-conditions.aspx","contact.aspx"),
         "ca":new InfoSiteMap("http://info.moviestarplanet.ca/","about.aspx","parents.aspx","teachers.aspx","user-guide.aspx","safety.aspx","privacy-policy.aspx","terms-conditions.aspx","contact.aspx"),
         "ie":new InfoSiteMap("http://info.moviestarplanet.ie/","about.aspx","parents.aspx","teachers.aspx","user-guide.aspx","safety.aspx","privacy-policy.aspx","terms-conditions.aspx","contact.aspx"),
         "es":new InfoSiteMap("http://info.mystarplanet.es/","sobre-mystarplanet.aspx","padres.aspx","teachers.aspx","gu%C3%ADa-de-usuario.aspx","Seguridad.aspx","privacy-policy.aspx","padres/términos-y-condiciones.aspx","Contacto.aspx")
      };
      
      public var about:String;
      
      public var parents:String;
      
      public var teachers:String;
      
      public var userGuide:String;
      
      public var safety:String;
      
      public var privacyPolicy:String;
      
      public var termsConditions:String;
      
      public var contact:String;
      
      public function InfoSiteMap(param1:String = null, param2:String = null, param3:String = null, param4:String = null, param5:String = null, param6:String = null, param7:String = null, param8:String = null, param9:String = null)
      {
         super();
         this.about = param1 + param2;
         this.parents = param1 + param3;
         this.teachers = param1 + param4;
         this.userGuide = param1 + param5;
         this.safety = param1 + param6;
         this.privacyPolicy = param1 + param7;
         this.termsConditions = param1 + param8;
         this.contact = param1 + param9;
      }
   }
}

