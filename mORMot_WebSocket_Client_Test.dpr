program WSSTest;

{$APPTYPE CONSOLE}

uses
  System.Classes, mormot.net.client, mormot.core.json, mormot.core.datetime, mormot.net.ws.client, mormot.net.http, mormot.net.ws.core, mormot.core.interfaces, mormot.core.unicode,
  mormot.net.ws.server, mormot.net.sock, mormot.core.base;

type
     TWSSRequests = class
       public
         procedure DealWSSRequests(Sender : TWebCrtSocketProcess; const Frame: TWebSocketFrame);
     end;

var WSSResponses  : TStringList;
    endConnection : Boolean;

procedure TWSSRequests.DealWSSRequests(Sender : TWebCrtSocketProcess; const Frame: TWebSocketFrame);

begin
  case Frame.opcode of
    focContinuation    : ;
    focText            : WSSResponses.Add(Frame.payload);
    focBinary          : ;
    focConnectionClose : endConnection := true;
    focPing            : ;
    focPong            : ;
  end;
end;


procedure DoWSS;

var ClientWS      : THttpClientWebSockets;
    WSSConnection : TWSSRequests;
    lProto        : TWebSocketProtocolChat;
    readtest,
    msg           : RawUtf8;

begin
  WSSConnection := TWSSRequests.Create;
  lProto := TWebSocketProtocolChat.Create('TestWSS','',WSSConnection.DealWSSRequests);
  ClientWS := THttpClientWebSockets.Create;
  ClientWS.OnCallbackRequestProcess := nil;

//  ClientWS.Open('ws.postman-echo.com', '443', nlTcp, 10000, true);
//  msg := ClientWS.WebSocketsUpgrade('raw', '', false, [], lProto, ''); // {   "op": "ping" }

//  ClientWS.Open('demo.piesocket.com', '443', nlTcp, 10000, true);
//  msg := ClientWS.WebSocketsUpgrade('v3/channel_1?api_key=oCdCMcMPQpbvNjUIzqtvF1d2X2okWpDQj4AwARJuAgtjhzKxVEjQU6IdCjwm&notify_self', '', false, [], lProto, '');

//  ClientWS.Open('stream.data.sandbox.alpaca.markets', '443', nlTcp, 10000, true);
//  msg := ClientWS.WebSocketsUpgrade('v2/iex', '', false, [], lProto, '');

//  ClientWS.Open('ws.blockchain.info', '443', nlTcp, 10000, true); // {   "op": "ping" }
//  msg := ClientWS.WebSocketsUpgrade('inv', '', false, [], lProto, '');

  ClientWS.Open('socketsbay.com', '443', nlTcp, 10000, true);
  msg := ClientWS.WebSocketsUpgrade('wss/v2/2/demo/', '', false, [], lProto, '');

  WSSResponses.Add('msg: ' + msg);
  readtest := '';
  While (not endConnection) and (readtest <> 'end') do
    begin
      ReadLn(readtest);
      if (readtest <> 'end') then
        ;
    end;
end;


begin
  try
    endConnection := false;
    WSSResponses := TStringList.Create;
    DoWSS;
    WSSResponses.SaveToFile('WSS_RESPONSES.TXT');
  finally
    WSSResponses.Free;
  end;
end.
