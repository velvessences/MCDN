package com.moviestarplanet.core.controller.commands
{
   import com.moviestarplanet.analytics.timer.IWindowString;
   import com.moviestarplanet.analytics.timer.WindowStringWeb;
   import com.moviestarplanet.color.tooltipwrapper.ColorTooltipWeb;
   import com.moviestarplanet.color.tooltipwrapper.IColorTooltip;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.utils.dateformatter.IMspDateFormatter;
   import com.moviestarplanet.utils.dateformatter.MspDateFormatterWeb;
   import com.moviestarplanet.utils.loaderfacade.ILoaderFacade;
   import com.moviestarplanet.utils.loaderfacade.LoaderFacadeWeb;
   import com.moviestarplanet.utils.tooltips.interfaces.ITooltipWrapper;
   import com.moviestarplanet.utils.tooltips.interfaces.TooltipWrapperWeb;
   
   public class MapFlexInjectionsCommand
   {
      
      public function MapFlexInjectionsCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         InjectionManager.mapper().map(IMspDateFormatter).toSingleton(MspDateFormatterWeb);
         InjectionManager.mapper().map(IWindowString).toSingleton(WindowStringWeb);
         InjectionManager.mapper().map(IColorTooltip).toSingleton(ColorTooltipWeb);
         InjectionManager.mapper().map(ITooltipWrapper).toSingleton(TooltipWrapperWeb);
         InjectionManager.mapper().map(ILoaderFacade).toSingleton(LoaderFacadeWeb);
      }
   }
}

