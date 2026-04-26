package com.moviestarplanet.Forms.minigame.queue
{
   import com.moviestarplanet.Forms.world.elements.MiniGameType;
   import com.moviestarplanet.bonster.valueobjects.ActorBonsterRelItem;
   import com.moviestarplanet.chat.ChatRoomController;
   import com.moviestarplanet.chat.ChatRoomType;
   import com.moviestarplanet.chatCommunicator.chatHelpers.chatpermission.ChatPermissionManager;
   import com.moviestarplanet.chatutils.ChatServerCommands;
   import com.moviestarplanet.chatutils.ComServerConnection;
   import com.moviestarplanet.earningutils.service.FameSwitch;
   import com.moviestarplanet.logging.services.loggingservice.LoggingAmfService;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.pet.valueobjects.ActorClickItemRel;
   import com.moviestarplanet.pets.MyClickItem;
   import com.moviestarplanet.pets.selectors.SelectPetBase;
   import com.moviestarplanet.pets.selectors.SelectPetChatroom;
   import com.moviestarplanet.popup.OldPopupHandler;
   import com.moviestarplanet.services.wrappers.SessionService;
   import com.moviestarplanet.utils.DateUtils;
   import com.moviestarplanet.utils.chat.ChatLogic;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import com.moviestarplanet.window.loading.LoadingBar;
   import com.moviestarplanet.windowpopup.popup.Prompt;
   import flash.events.NetStatusEvent;
   import flash.net.NetConnection;
   import flash.net.Responder;
   
   public class RoomRequester
   {
      
      private static var _serverConnectPath:String;
      
      private static var _curRoomType:String;
      
      private static var _requestMinigameCallback:Function;
      
      private static var loadingbar:LoadingBar;
      
      private static var _isGameRoom:Boolean;
      
      private static var _isPrivateGame:Boolean;
      
      private static var _existingRoomStr:String;
      
      private static var _privateServerAppServer:String;
      
      private static var _curRoomId:String;
      
      private static var _lastLocationIndex:int;
      
      private static const MAX_ROOM_APPS:int = 10;
      
      private static var clientIsClosingCon:Boolean = false;
      
      private static var connection:NetConnection = new NetConnection();
      
      private static var isConnecting:Boolean = false;
      
      private static var gameAppName:String = "";
      
      private static var _chatServerName:String = null;
      
      private static var _chatGameServerName:String = null;
      
      private static var isRequesting:Boolean = false;
      
      private static var isShowingErrorAlready:Boolean = false;
      
      public function RoomRequester()
      {
         super();
      }
      
      public static function get chatServerUri() : String
      {
         return connection.uri;
      }
      
      public static function disconnectFromChatServer() : void
      {
         clientIsClosingCon = true;
         connection.close();
         clientIsClosingCon = false;
      }
      
      public static function get roomCon() : NetConnection
      {
         return connection;
      }
      
      public static function get appServerName() : String
      {
         return gameAppName;
      }
      
      private static function useAppServOperator(param1:String) : Boolean
      {
         return isMinigameType(param1);
      }
      
      private static function connectToRoomServer(param1:String) : void
      {
         var onGameServerStatus:Function = null;
         var onChatServerRet:Function = null;
         var roomType:String = param1;
         onGameServerStatus = function(param1:NetStatusEvent):void
         {
            if(isConnecting)
            {
               isConnecting = false;
               if(param1.info.code == "NetConnection.Connect.Success")
               {
                  onConnectResp(true);
               }
               else
               {
                  onConnectResp(false);
               }
            }
            if(!clientIsClosingCon && param1.info.code != "NetConnection.Connect.Success")
            {
               toggleLoading(false,"There was a problem connecting to the chat room.",true,param1.info.code);
               OldPopupHandler.getInstance().closeMainPopup();
            }
         };
         onChatServerRet = function(param1:String):void
         {
            var executeConnectionRequest:Function = null;
            var servername:String = param1;
            executeConnectionRequest = function(param1:String):void
            {
               if(param1 == "")
               {
                  toggleLoading(false,"There was a problem requesting the room.",true,"gameAppInst = \"\"");
               }
               else
               {
                  _serverConnectPath = ComServerConnection.curProtocol + servername + "/" + param1;
                  connection.connect(_serverConnectPath,ActorSession.loggedInActor.ActorId);
                  connection.addEventListener(NetStatusEvent.NET_STATUS,onGameServerStatus);
               }
            };
            if(_privateServerAppServer)
            {
               gameAppName = _privateServerAppServer;
               executeConnectionRequest(gameAppName);
            }
            else
            {
               gameAppName = ChatLogic.getAppInstNameForRoomType(roomType);
               if(_isPrivateGame)
               {
                  gameAppName += "_private";
               }
               if(useAppServOperator(roomType))
               {
                  OperatorRequester.getAppServForAppType(servername,gameAppName,executeConnectionRequest);
               }
               else
               {
                  executeConnectionRequest(gameAppName);
               }
            }
         };
         toggleLoading(true);
         if(!isConnecting)
         {
            if(ChatRoomController.chatRoomView != null)
            {
               ChatRoomController.chatRoomView.close();
            }
            disconnectFromChatServer();
            isConnecting = true;
            if(_isGameRoom)
            {
               getChatGameServerName(onChatServerRet);
            }
            else
            {
               getChatServerName(onChatServerRet);
            }
         }
      }
      
      private static function getChatServerName(param1:Function) : void
      {
         var callback:Function = param1;
         if(_chatServerName == null)
         {
            SessionService.GetAppSetting("chatFMSServer",function(param1:String):void
            {
               _chatServerName = param1;
               callback(_chatServerName);
            });
         }
         else
         {
            callback(_chatServerName);
         }
      }
      
      private static function getChatGameServerName(param1:Function) : void
      {
         var callback:Function = param1;
         if(_chatGameServerName == null)
         {
            SessionService.GetAppSetting("chatGameFMSServer",function(param1:String):void
            {
               _chatGameServerName = param1;
               callback(_chatGameServerName);
            });
         }
         else
         {
            callback(_chatGameServerName);
         }
      }
      
      private static function onConnectResp(param1:Boolean) : void
      {
         var _loc2_:String = null;
         if(param1)
         {
            startRoomRequest();
         }
         else
         {
            _loc2_ = "Could not connect to game server.";
            toggleLoading(false,_loc2_);
         }
      }
      
      private static function toggleLoading(param1:Boolean, param2:String = "", param3:Boolean = false, param4:String = "No Error Code") : void
      {
         var onClose:Function = null;
         var on:Boolean = param1;
         var msg:String = param2;
         var sendError:Boolean = param3;
         var errorCode:String = param4;
         onClose = function(param1:Object):void
         {
            isShowingErrorAlready = false;
         };
         if(loadingbar == null)
         {
            loadingbar = new LoadingBar("Loading...");
         }
         if(on)
         {
            loadingbar.show();
            isRequesting = true;
         }
         else
         {
            loadingbar.hide();
            isRequesting = false;
         }
         if(msg != "" && !isShowingErrorAlready)
         {
            isConnecting = false;
            disconnectFromChatServer();
            isShowingErrorAlready = true;
            Prompt.show(msg,"",4,null,onClose);
            if(sendError)
            {
               LoggingAmfService.log("CHAT CONNECT ERROR",msg + " (" + errorCode + ")");
            }
         }
      }
      
      private static function isOfReqLevel(param1:String) : Boolean
      {
         var _loc2_:int = 0;
         if(param1 == MiniGameType.CATWALK_MINIGAME.minigameRoomStr)
         {
            _loc2_ = FameSwitch.IsFameOverhaulSwitchOn ? 6 : 3;
            if(ActorSession.loggedInActor.Level < _loc2_)
            {
               Prompt.show(MSPLocaleManagerWeb.getInstance().getString("CHATROOM_LEVEL",[_loc2_,ActorSession.loggedInActor.Level]),MSPLocaleManagerWeb.getInstance().getString("HIGHER_LEVEL_REQ"));
               return false;
            }
         }
         return true;
      }
      
      private static function isPermitted() : Boolean
      {
         if(!ChatPermissionManager.instance.isPermitted)
         {
            Prompt.show(MSPLocaleManagerWeb.getInstance().getString("CHAT_NOT_ALLOWED_DESC",[DateUtils.msToHrsMinsSecsString(ChatPermissionManager.instance.getSecondsRemaining() * 1000)]));
            return false;
         }
         return true;
      }
      
      private static function popupBoonie() : void
      {
         var petselected:Function = null;
         var bonsterSelected:Function = null;
         petselected = function(param1:ActorClickItemRel):void
         {
            if(param1 != null)
            {
               MyClickItem.string = param1.ActorClickItemRelId.toString();
               connectToRoomServer(_curRoomType);
            }
         };
         bonsterSelected = function(param1:ActorBonsterRelItem):void
         {
            if(param1 != null)
            {
               MyClickItem.string = "BONSTER" + param1.ActorBonsterRelId;
               connectToRoomServer(_curRoomType);
            }
         };
         var selectPet:SelectPetBase = new SelectPetChatroom();
         selectPet.allowNone = false;
         selectPet.onDoneFunc = petselected;
         selectPet.onBonsterDoneFunc = bonsterSelected;
         selectPet.open();
      }
      
      private static function isBoonieRoom(param1:String) : Boolean
      {
         if(ChatRoomType.getChatType(param1) == ChatRoomType.PARK)
         {
            return true;
         }
         return false;
      }
      
      public static function requestGameRoom(param1:String, param2:Function, param3:Boolean = false) : void
      {
         requestRoom(param1,param2,param3,"","",false,true);
      }
      
      public static function requestRoom(param1:String, param2:Function, param3:Boolean = false, param4:String = "", param5:String = "", param6:Boolean = false, param7:Boolean = false) : void
      {
         if(checkCanJoin(param1))
         {
            _curRoomType = param1;
            _isPrivateGame = param3;
            _existingRoomStr = param4;
            _requestMinigameCallback = param2;
            _privateServerAppServer = param5;
            _isGameRoom = param7;
            if(isBoonieRoom(param1) && !param6)
            {
               popupBoonie();
            }
            else
            {
               connectToRoomServer(_curRoomType);
            }
         }
      }
      
      private static function checkCanJoin(param1:String = "none") : Boolean
      {
         if(isRequesting)
         {
            return false;
         }
         if(!isOfReqLevel(param1))
         {
            return false;
         }
         if(!isPermitted())
         {
            return false;
         }
         return true;
      }
      
      public static function joinRoom(param1:Function, param2:String, param3:String) : void
      {
         if(checkCanJoin())
         {
            _curRoomType = "none";
            _isPrivateGame = false;
            _existingRoomStr = param2;
            _requestMinigameCallback = param1;
            _privateServerAppServer = param3;
            if(isBoonieRoom(param2))
            {
               popupBoonie();
            }
            else
            {
               connectToRoomServer(_curRoomType);
            }
         }
      }
      
      private static function onRoomRequestResponse(param1:Object) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         _lastLocationIndex = param1.loc;
         if(param1.roomId == "INVALID" || param1.roomId == "INVALIDHASH")
         {
            _loc2_ = MSPLocaleManagerWeb.getInstance().getString("INVALID_ROOM");
            toggleLoading(false,_loc2_);
         }
         else if(param1.roomId == "FULL")
         {
            _loc3_ = MSPLocaleManagerWeb.getInstance().getString("TOO_MANY_PLAYERS");
            toggleLoading(false,_loc3_);
         }
         else if(_lastLocationIndex == -1)
         {
            _loc4_ = MSPLocaleManagerWeb.getInstance().getString("ROOM_FULL");
            toggleLoading(false,_loc4_);
         }
         else
         {
            toggleLoading(false);
            _curRoomId = param1.roomId;
            if(_requestMinigameCallback != null)
            {
               _requestMinigameCallback(_curRoomId);
            }
         }
      }
      
      private static function onRoomRequestError(param1:Object) : void
      {
         toggleLoading(false);
         LoggingAmfService.Error("room request resulted in error: " + param1.toString() + " gameApp:" + gameAppName + " roomId: " + _curRoomId + " actorID: " + ActorSession.getActorId());
      }
      
      private static function startRoomRequest() : void
      {
         var _loc1_:Responder = new Responder(onRoomRequestResponse,onRoomRequestError);
         if(_isPrivateGame)
         {
            roomCon.call(ChatServerCommands.JOIN_PRIVATE_ROOM,_loc1_,_curRoomType,ActorSession.getActorId(),_existingRoomStr,ActorSession.loggedInActor.Name,ActorSession.loggedInActor.getAmsSecurityHash());
         }
         else if(_existingRoomStr != "")
         {
            roomCon.call(ChatServerCommands.CREATE_PRIVATE_ROOM,_loc1_,ActorSession.getActorId(),_existingRoomStr,ActorSession.loggedInActor.Name,ActorSession.loggedInActor.getAmsSecurityHash());
         }
         else
         {
            roomCon.call(ChatServerCommands.JOIN_PUBLIC_ROOM,_loc1_,_curRoomType,ActorSession.getActorId(),ActorSession.loggedInActor.Name,ActorSession.loggedInActor.getAmsSecurityHash());
         }
      }
      
      public static function get roomId() : String
      {
         return _curRoomId;
      }
      
      public static function get lastLocationIndex() : int
      {
         return _lastLocationIndex;
      }
      
      public static function isMinigameType(param1:String) : Boolean
      {
         return MiniGameType.getMinigameByRoomStr(param1) != null;
      }
   }
}

