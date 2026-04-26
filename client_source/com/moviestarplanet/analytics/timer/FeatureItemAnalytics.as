package com.moviestarplanet.analytics.timer
{
   import com.moviestarplanet.analytics.AnalyticsSendEventCommand;
   import com.moviestarplanet.constants.ConstantsPlatform;
   import com.moviestarplanet.constants.analytics.TimeSpentConstants;
   import com.moviestarplanet.gamescaleutils.ScreenSize;
   
   public class FeatureItemAnalytics
   {
      
      public var featureName:Array;
      
      private var enterTimestamp:Number = 0;
      
      private var pauseTimestamp:Number = -1;
      
      private var timeSpentOnPause:Number = -1;
      
      private var alwaysOpen:Boolean = false;
      
      private var timerCanBeStoppedByOtherFeatures:Boolean = true;
      
      public function FeatureItemAnalytics(param1:Array, param2:Boolean)
      {
         super();
         this.featureName = param1;
         this.enterTimestamp = new Date().getTime();
         this.timerCanBeStoppedByOtherFeatures = param2;
         this.setAlwaysOpen();
      }
      
      private function setAlwaysOpen() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         while(_loc1_ < this.featureName.length)
         {
            _loc2_ = 0;
            while(_loc2_ < TimeSpentConstants.ALWAYS_OPEN_FEATURES.length)
            {
               if(this.featureName[_loc1_] == TimeSpentConstants.ALWAYS_OPEN_FEATURES[_loc2_])
               {
                  this.alwaysOpen = true;
               }
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      public function pause() : void
      {
         if(this.pauseTimestamp != -1 || this.alwaysOpen)
         {
            return;
         }
         this.pauseTimestamp = new Date().getTime();
      }
      
      public function resume() : void
      {
         if(this.pauseTimestamp == -1 || this.alwaysOpen)
         {
            return;
         }
         var _loc1_:Number = Number(new Date().getTime());
         this.timeSpentOnPause += (_loc1_ - this.pauseTimestamp) * 0.001;
         this.pauseTimestamp = -1;
      }
      
      public function getTotalTime() : Number
      {
         this.resume();
         var _loc1_:Number = Number(new Date().getTime());
         return (_loc1_ - this.enterTimestamp) * 0.001 - this.timeSpentOnPause;
      }
      
      public function hasOneElementWithStrings(param1:Array) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = 0;
            while(_loc3_ < this.featureName.length)
            {
               if(param1[_loc2_] == this.featureName[_loc3_])
               {
                  return true;
               }
               _loc3_++;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function hasAllElementsWithStrings(param1:Array) : Boolean
      {
         if(param1.length != this.featureName.length)
         {
            return false;
         }
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            if(param1[_loc2_] != this.featureName[_loc2_])
            {
               return false;
            }
            _loc2_++;
         }
         return true;
      }
      
      public function getParentFeatures() : Array
      {
         var _loc2_:Array = null;
         var _loc1_:Array = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < this.featureName.length)
         {
            _loc2_ = this.featureName[_loc3_].split(".");
            _loc1_.push(_loc2_[0]);
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function isAlwaysOpen() : Boolean
      {
         return this.alwaysOpen;
      }
      
      public function canBeStoppedByOtherFeatures() : Boolean
      {
         return this.timerCanBeStoppedByOtherFeatures;
      }
      
      public function sendTimeMessage() : void
      {
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:Object = null;
         var _loc1_:Number = this.getTotalTime();
         var _loc2_:String = "TimeSpent";
         var _loc3_:String = "TimeSpent.";
         var _loc4_:String = "";
         if(ConstantsPlatform.isMobile)
         {
            if(ScreenSize.isTablet)
            {
               _loc2_ += ".Tablet";
               _loc3_ += "Tablet.";
            }
            else if(ScreenSize.isPhone)
            {
               _loc2_ += ".Phone";
               _loc3_ += "Phone.";
            }
         }
         if(_loc1_ >= 1 && _loc1_ < 5)
         {
            _loc4_ = "A_0s_5s";
         }
         else if(_loc1_ >= 5 && _loc1_ < 10)
         {
            _loc4_ = "B_5s_10s";
         }
         else if(_loc1_ >= 10 && _loc1_ < 20)
         {
            _loc4_ = "C_10s_20s";
         }
         else if(_loc1_ >= 20 && _loc1_ < 30)
         {
            _loc4_ = "D_20s_30s";
         }
         else if(_loc1_ >= 30 && _loc1_ < 40)
         {
            _loc4_ = "E_30s_40s";
         }
         else if(_loc1_ >= 40 && _loc1_ < 60)
         {
            _loc4_ = "F_40s_60s";
         }
         else if(_loc1_ >= 60 && _loc1_ < 90)
         {
            _loc4_ = "G_60s_90s";
         }
         else if(_loc1_ >= 90 && _loc1_ < 120)
         {
            _loc4_ = "H_90s_120s";
         }
         else if(_loc1_ >= 120 && _loc1_ < 240)
         {
            _loc4_ = "I_2m_4m";
         }
         else if(_loc1_ >= 240 && _loc1_ < 360)
         {
            _loc4_ = "J_4m_6m";
         }
         else if(_loc1_ >= 360 && _loc1_ < 480)
         {
            _loc4_ = "K_6m_8m";
         }
         else if(_loc1_ >= 480 && _loc1_ < 600)
         {
            _loc4_ = "L_8m_10m";
         }
         else if(_loc1_ >= 600 && _loc1_ < 1200)
         {
            _loc4_ = "M_10m_20m";
         }
         else if(_loc1_ >= 1200 && _loc1_ < 2400)
         {
            _loc4_ = "N_20m_40m";
         }
         else if(_loc1_ >= 2400 && _loc1_ < 3600)
         {
            _loc4_ = "O_40m_60m";
         }
         else if(_loc1_ >= 3600 && _loc1_ < 7200)
         {
            _loc4_ = "P_1h_2h";
         }
         else if(_loc1_ >= 7200 && _loc1_ < 10800)
         {
            _loc4_ = "Q_2h_3h";
         }
         else if(_loc1_ >= 10800 && _loc1_ < 14400)
         {
            _loc4_ = "R_3h_4h";
         }
         else if(_loc1_ >= 14400 && _loc1_ < 18000)
         {
            _loc4_ = "S_4h_5h";
         }
         else if(_loc1_ >= 18000 && _loc1_ < 21600)
         {
            _loc4_ = "T_5h_6h";
         }
         else if(_loc1_ >= 21600 && _loc1_ < 43200)
         {
            _loc4_ = "U_6h_12h";
         }
         else if(_loc1_ >= 43200 && _loc1_ < 86400)
         {
            _loc4_ = "V_12h_24h";
         }
         else
         {
            if(_loc1_ < 86400)
            {
               trace("AnalyticsTimer.leave() -- invalid time interval " + _loc1_ + " for feature: " + this.featureName[_loc5_]);
               return;
            }
            _loc4_ = "W_over_24h";
         }
         _loc5_ = 0;
         while(_loc5_ < this.featureName.length)
         {
            if(!this.featureName[_loc5_] || this.featureName[_loc5_] == "")
            {
               trace("SWRVE Error: The name of the feature is registered as null");
               return;
            }
            _loc6_ = _loc3_;
            _loc6_ = _loc6_ + (this.featureName[_loc5_] + ".");
            _loc7_ = {
               "Feature":this.featureName[_loc5_],
               "Time":""
            };
            _loc6_ += _loc4_;
            _loc7_.Time = _loc4_;
            AnalyticsSendEventCommand.execute(_loc2_,_loc7_);
            AnalyticsSendEventCommand.execute(_loc6_,null);
            _loc5_++;
         }
      }
   }
}

