package com.moviestarplanet.chatutils
{
   import com.moviestarplanet.IDestroyable;
   import com.moviestarplanet.bonster.PetType;
   import com.moviestarplanet.chatCommunicator.chatHelpers.model.valueobjects.ActorCommunicationVO;
   import com.moviestarplanet.chatCommunicator.chatHelpers.model.valueobjects.SharedActorBase;
   import com.moviestarplanet.chatutils.chatroom.ChatroomConstants;
   import com.moviestarplanet.configurations.AppSettings;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.configurations.SiteConfig;
   import com.moviestarplanet.constants.ConstantsPlatform;
   import com.moviestarplanet.mobile.msg.ObjectEvent;
   import com.moviestarplanet.msg.NumberEvent;
   import com.moviestarplanet.userbehavior.UserBehaviorResult;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.NetStatusEvent;
   import flash.events.SyncEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.net.NetConnection;
   import flash.net.Responder;
   import flash.net.SharedObject;
   import flash.utils.Timer;
   
   public class ChatServerConnection extends EventDispatcher implements IDestroyable
   {
      
      private static var _nc:NetConnection;
      
      protected static var _sharedObject:SharedObject;
      
      public static const NEW_MESSAGE:String = "ChatServerConnection.NEW_MESSAGE";
      
      public static const ACTOR_JOINED:String = "ChatServerConnection.ACTOR_JOINED";
      
      public static const ACTOR_LEFT:String = "ChatServerConnection.ACTOR_LEFT";
      
      public static const ACTOR_CHANGED:String = "ChatServerConnection.ACTOR_CHANGED";
      
      private var _actorTable:Array = [];
      
      private var _roomName:String;
      
      private var _roomId:String;
      
      private var _position:Point = new Point(1000,400);
      
      private var _animation:String = "stand";
      
      private var _textMessage:UserBehaviorResult;
      
      private var _faceExpression:String = "neutral";
      
      private var _petId:int = 0;
      
      private var _petType:int = 0;
      
      private var _statusUpdateTmr:Timer;
      
      private var _actorId:Number;
      
      private var _actorName:String;
      
      private var _locale:String;
      
      public function ChatServerConnection(param1:int, param2:String)
      {
         super();
         this._actorId = param1;
         this._locale = param2;
         this._statusUpdateTmr = new Timer(1000,1);
         this._statusUpdateTmr.addEventListener(TimerEvent.TIMER,this.doUpdateStatus);
      }
      
      public function set petId(param1:int) : void
      {
         this._petId = param1;
      }
      
      public function set petType(param1:int) : void
      {
         this._petType = param1;
      }
      
      public function connect(param1:String, param2:String, param3:Function) : void
      {
         var onChatServerName:Function;
         var onFailChatServerName:Function;
         var onGameServerStatus:Function = null;
         var roomName:String = param1;
         var roomId:String = param2;
         var callback:Function = param3;
         if(_nc == null || !_nc.connected)
         {
            onGameServerStatus = function(param1:NetStatusEvent):void
            {
               _nc.removeEventListener(NetStatusEvent.NET_STATUS,onGameServerStatus);
               if(param1.info.code == "NetConnection.Connect.Success")
               {
                  if(callback != null)
                  {
                     callback(true);
                  }
               }
               else if(callback != null)
               {
                  callback(false);
               }
            };
            onChatServerName = function(param1:String):void
            {
               var _loc2_:String = ComServerConnection.curProtocol + param1 + "/" + getAppInstNameForRoomType(_roomName);
               if(!_nc)
               {
                  _nc = new NetConnection();
                  _nc.client = this;
               }
               _nc.addEventListener(NetStatusEvent.NET_STATUS,onGameServerStatus);
               _nc.connect(_loc2_,_actorId);
            };
            onFailChatServerName = function():void
            {
               callback(false);
            };
            this._roomName = roomName;
            this._roomId = roomId;
            this.getChatServerName(onChatServerName,onFailChatServerName);
            return;
         }
         trace("ChatServerConnection::connect Already connected, call disconnect first");
         callback(false);
      }
      
      public function disconnect() : void
      {
         if(_sharedObject)
         {
            _sharedObject.removeEventListener(SyncEvent.SYNC,this.onSharedObjectFirstSync);
            _sharedObject.removeEventListener(SyncEvent.SYNC,this.onSharedObjectSync);
            _sharedObject.close();
         }
         if(_nc)
         {
            _nc.close();
         }
      }
      
      private function joinInternal(param1:Function, param2:Function, param3:Function, param4:String, ... rest) : void
      {
         var onNetworkError:Function;
         var onServerResponse:Function;
         var responder:Responder = null;
         var serverResponseCallback:Function = param1;
         var connectionErrorCallback:Function = param2;
         var roomFullCallback:Function = param3;
         var command:String = param4;
         var args:Array = rest;
         if(Boolean(_nc) && Boolean(_nc.connected))
         {
            onNetworkError = function(param1:Object):void
            {
               connectionErrorCallback();
            };
            onServerResponse = function(param1:Object):void
            {
               if(param1.loc == -1)
               {
                  roomFullCallback();
                  return;
               }
               _roomId = param1.roomId;
               _sharedObject = SharedObject.getRemote(_roomId,_nc.uri,true);
               _sharedObject.addEventListener(SyncEvent.SYNC,onSharedObjectFirstSync);
               _sharedObject.connect(_nc);
               if(serverResponseCallback != null)
               {
                  serverResponseCallback(param1);
               }
            };
            responder = new Responder(onServerResponse,onNetworkError);
            if(args.length == 1)
            {
               _nc.call(command,responder,args[0]);
            }
            else if(args.length == 2)
            {
               _nc.call(command,responder,args[0],args[1]);
            }
         }
         else
         {
            connectionErrorCallback();
         }
      }
      
      public function join(param1:Function, param2:Function, param3:Function) : void
      {
         this.joinInternal(param1,param2,param3,ChatServerCommands.JOIN_PUBLIC_ROOM,this._roomName);
      }
      
      public function joinSpecific(param1:Function, param2:Function, param3:Function) : void
      {
         this.joinInternal(param1,param2,param3,ChatServerCommands.CREATE_PRIVATE_ROOM,0,this._roomId);
      }
      
      public function getRoomNames(param1:Function, param2:Function) : void
      {
         var onNamesRetrievedResponse:Function;
         var onNetworkError:Function;
         var responder:Responder = null;
         var onRoomNames:Function = param1;
         var onConFail:Function = param2;
         if(_nc.connected)
         {
            onNamesRetrievedResponse = function(param1:Object):void
            {
               onRoomNames(param1);
            };
            onNetworkError = function(param1:Object):void
            {
               if(onConFail != null)
               {
                  onConFail("Network error " + param1);
               }
            };
            responder = new Responder(onNamesRetrievedResponse,onNetworkError);
            _nc.call(ChatServerCommands.GET_ROOM_NAME_LIST,responder);
         }
         else if(onConFail != null)
         {
            onConFail("Not connected");
         }
      }
      
      public function sendName(param1:String) : void
      {
         this._actorName = param1;
         this.updateStatus();
      }
      
      public function sendPosition(param1:Number, param2:Number) : void
      {
         this._position = new Point(param1,param2);
         this.updateStatus();
      }
      
      public function sendFaceExpression(param1:String) : void
      {
         this._faceExpression = param1;
         this.updateStatus();
      }
      
      public function sendPetId(param1:int) : void
      {
         this._petId = param1;
         this.updateStatus();
      }
      
      public function sendPetType(param1:int) : void
      {
         this._petType = param1;
         this.updateStatus();
      }
      
      public function sendAnimation(param1:String) : void
      {
         this._animation = param1;
         this.updateStatus();
      }
      
      public function sendMessage(param1:UserBehaviorResult) : void
      {
         this._textMessage = param1;
         this.updateStatus();
      }
      
      private function updateStatus() : void
      {
         this._statusUpdateTmr.reset();
         this._statusUpdateTmr.start();
      }
      
      private function doUpdateStatus(param1:Event) : void
      {
         var _loc2_:ActorCommunicationVO = new ActorCommunicationVO();
         _loc2_.actorId = this._actorId;
         _loc2_.actorName = this._actorName;
         _loc2_.posX = this._position.x;
         _loc2_.posY = this._position.y;
         _loc2_.animation = this._animation;
         _loc2_.faceExpresion = this._faceExpression;
         if(this._petType == PetType.BONSTER)
         {
            _loc2_.clickItemIdString = "BONSTER" + this._petId;
         }
         else
         {
            _loc2_.clickItemIdString = this._petId.toString();
         }
         if(this._textMessage)
         {
            _loc2_.message = this._textMessage.message;
            _loc2_.whitelistedMessage = this._textMessage.whitelistedMessage;
            _loc2_.blacklistedMessage = this._textMessage.blacklistedMessage;
            this._textMessage = null;
         }
         this.writeToSo(_loc2_);
      }
      
      private function writeToSo(param1:ActorCommunicationVO) : void
      {
         if(_sharedObject != null)
         {
            param1.soGUID = GUID.create();
            param1.client = ConstantsPlatform.APPLICATION_MOBILE;
            _sharedObject.setProperty(this._actorId.toString(),param1);
            _sharedObject.send();
         }
      }
      
      protected function getChatServerName(param1:Function, param2:Function) : void
      {
         var _loc3_:String = AppSettings.getInstance().getSetting("chatFMSServer");
         if(!_loc3_)
         {
            param2();
         }
         else
         {
            param1(_loc3_);
         }
      }
      
      private function onConnectionError(param1:Object) : void
      {
      }
      
      protected function onSharedObjectSync(param1:SyncEvent) : void
      {
         var _loc2_:Object = null;
         for each(_loc2_ in param1.changeList)
         {
            this.processIncommingData(_loc2_);
         }
      }
      
      protected function processIncommingData(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc3_:SharedActorBase = null;
         var _loc4_:ActorCommunicationVO = null;
         var _loc5_:SharedActorBase = null;
         var _loc6_:SharedActorBase = null;
         _loc2_ = int(parseInt(param1.name));
         if(_loc2_ != 0)
         {
            _loc3_ = this._actorTable[_loc2_];
            _loc4_ = new ActorCommunicationVO(_sharedObject.data[param1.name]);
            if(param1.code == "change" || param1.code == "success")
            {
               switch(_loc4_.actorAction)
               {
                  case ChatroomConstants.ENTER:
                     if(this._actorTable[_loc2_] == null && _loc2_ == this._actorId)
                     {
                        _loc6_ = this.addActorToTable(_loc2_);
                        dispatchEvent(new ObjectEvent(ACTOR_JOINED,_loc6_));
                     }
                     break;
                  case ChatroomConstants.EXIT:
                     if(_loc2_ != this._actorId)
                     {
                        trace("ChatServerConnection::onSharedObjectSync someone else left the room");
                        this._actorTable[_loc2_] = null;
                        dispatchEvent(new NumberEvent(ACTOR_LEFT,_loc2_));
                     }
                     if(_loc2_ == this._actorId)
                     {
                        trace("ChatServerConnection::onSharedObjectSync This might happen, if we reenter myRoom, that is enter, exit and then enter again");
                     }
                     break;
                  default:
                     _loc5_ = this._actorTable[_loc2_];
                     if(_loc5_ == null)
                     {
                        _loc5_ = this.addActorToTable(_loc2_);
                        this.setPetFromString(_loc4_.clickItemIdString,_loc5_);
                        dispatchEvent(new ObjectEvent(ACTOR_JOINED,_loc5_));
                     }
                     _loc5_.actorName = _loc4_.actorName;
                     _loc5_.x = _loc4_.posX;
                     _loc5_.y = _loc4_.posY;
                     _loc5_.animation = _loc4_.animation;
                     _loc5_.message = _loc4_.message;
                     _loc5_.whitelistedMessage = _loc4_.whitelistedMessage;
                     _loc5_.blacklistedMessage = _loc4_.blacklistedMessage;
                     _loc5_.faceAnimation = _loc4_.faceExpresion;
                     _loc5_.facingDirection = _loc4_.facing;
                     this.setPetFromString(_loc4_.clickItemIdString,_loc5_);
                     if(_loc5_.message != null && _loc5_.message != "")
                     {
                        dispatchEvent(new ObjectEvent(NEW_MESSAGE,{
                           "actorId":_loc2_,
                           "message":_loc5_.message,
                           "whitelistedMessage":_loc5_.whitelistedMessage,
                           "blacklistedMessage":_loc5_.blacklistedMessage
                        }));
                        break;
                     }
                     dispatchEvent(new ObjectEvent(ACTOR_CHANGED,{
                        "actorId":_loc2_,
                        "data":_loc5_
                     }));
               }
            }
            else if(param1.code == "delete")
            {
               if(_loc3_ != null)
               {
                  this.removeActorFromTable(_loc3_.actorId);
                  dispatchEvent(new NumberEvent(ACTOR_LEFT,_loc3_.actorId));
               }
            }
         }
      }
      
      private function setPetFromString(param1:String, param2:SharedActorBase) : void
      {
         if(param1 == "" || param1 == "0")
         {
            return;
         }
         if(param1.substring(0,"BONSTER".length) == "BONSTER")
         {
            param2.petId = parseInt(param1.substr("BONSTER".length));
            param2.petType = PetType.BONSTER;
         }
         else
         {
            param2.petId = parseInt(param1);
            param2.petType = PetType.MONSTER;
         }
      }
      
      private function addActorToTable(param1:int) : SharedActorBase
      {
         var _loc2_:SharedActorBase = new SharedActorBase();
         _loc2_.petId = this._petId;
         _loc2_.petType = this._petType;
         _loc2_.actorId = param1;
         _loc2_.actorName = this._actorName;
         this._actorTable[param1] = _loc2_;
         return _loc2_;
      }
      
      private function removeActorFromTable(param1:int) : void
      {
         this._actorTable[param1] = null;
      }
      
      private function onSharedObjectFirstSync(param1:SyncEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:ActorCommunicationVO = null;
         _sharedObject.removeEventListener(SyncEvent.SYNC,this.onSharedObjectFirstSync);
         _sharedObject.addEventListener(SyncEvent.SYNC,this.onSharedObjectSync);
         for(_loc2_ in _sharedObject.data)
         {
            this.fixCorruptMessage(_sharedObject.data[_loc2_]);
            this.processIncommingData({
               "code":"success",
               "name":_loc2_
            });
         }
         _loc3_ = new ActorCommunicationVO();
         _loc3_.actorId = this._actorId;
         _loc3_.actorName = this._actorName;
         _loc3_.petId = this._petId;
         _loc3_.petType = this._petType;
         _loc3_.actorAction = ChatroomConstants.ENTER;
         this.writeToSo(_loc3_);
      }
      
      private function fixCorruptMessage(param1:Object) : void
      {
         if(param1.hasOwnProperty("message"))
         {
            param1.message = null;
         }
         if(param1.hasOwnProperty("blacklistedMessage"))
         {
            param1.blacklistedMessage = null;
         }
         if(param1.hasOwnProperty("whitelistedMessage"))
         {
            param1.whitelistedMessage = null;
         }
      }
      
      public function logout() : void
      {
         trace("ChatServerConnection::logout");
      }
      
      public function get roomId() : String
      {
         return this._roomId;
      }
      
      public function destroy() : void
      {
         _nc = null;
         if(_sharedObject)
         {
            _sharedObject.removeEventListener(SyncEvent.SYNC,this.onSharedObjectSync);
         }
         _sharedObject = null;
         this._actorTable = null;
      }
      
      private function getAppInstNameForRoomType(param1:String) : String
      {
         var _loc2_:SiteConfig = Config.getCurrentSiteConfig();
         var _loc3_:String = "local";
         if(_loc2_ != null)
         {
            _loc3_ = Config.getCurrentSiteConfig().country;
         }
         return _loc3_ + "_" + this._locale + "_" + param1;
      }
   }
}

