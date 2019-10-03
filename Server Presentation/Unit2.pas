unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
 IBCustomDataSet, DB, IBTable, IBDatabase, ScktComp, StdCtrls,WinSock,
  DBCtrls, Grids, DBGrids,  ExtCtrls, Mask, Spin, IBQuery, DBTables;
type
  users=record
        NICK,IP,Port:string;
        Active:boolean;
        SocketClient:TServerClientWinSocket;
        TimerSend,TimerWait,ID:longint;
        end;
  Tinfo=array of char;
  TData=record
          Command,Color:integer;
          Password,Login,NameSend,Nick,IP:string[15];
          InfoCommand:string[255];
          ResultMSG:string[255];
          HistoryMessage:array[1..40]of string[255];
        end;
  TNew=record
        S1,s2:string[15];
       end;
  PData=^TData;
  Tmconnections=array[0..65534] of users;
  TChatServer = class(TForm)
    SctServer: TServerSocket;
    Panel1: TPanel;
    mmLog: TMemo;
    mmChat: TMemo;
    EdLocalPort: TSpinEdit;
    Label1: TLabel;
    Label3: TLabel;
    BtnOpenClose: TButton;
    Label4: TLabel;
    Connectionss: TMaskEdit;
    Label5: TLabel;
    IPServer: TEdit;
    IBDatabase1: TIBDatabase;
    IBTransaction1: TIBTransaction;
    IBDataSet1: TIBDataSet;
    RegLOG: TIBQuery;
    RegNICK: TIBQuery;
    PosName: TIBQuery;
    SelectName: TIBQuery;
    InsertIP: TIBQuery;
    TakePub: TIBQuery;
    IBMessage: TIBDataSet;
    InsertPub: TIBQuery;
    PosMembers1: TIBQuery;
    Timer1: TTimer;
    InsertPrivate: TIBQuery;
    PosMembers2: TIBQuery;
    StaticText1: TStaticText;
    function GetLocalIP:String;
    procedure BtnOpenCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SctServerGetThread(Sender: TObject;
      ClientSocket: TServerClientWinSocket;
      var SocketThread: TServerClientThread);
    procedure HandleEvent(var aData:TData;ClientSocket:TServerClientWinSocket);
    procedure Timer1Timer(Sender: TObject);
  end;
  TMyThread=class(TThread)
  protected
  end;
  TServerThread = class(TServerClientThread)
    private
      fData:TData;
    public
     procedure ClientExecute; override;
    end;
Const
 KeyExit=1;
 KeyRegNewUser=2;
 KeyLogUser=3;
 KeyAcceptUsers=4;
 KeyWrongLogin=5;
 KeySendMessage=6;
 KeyAcceptName=7;
 KeyWrongReg=8;
 KeyRegAccept=9;
 KeyWrongRegLog=10;
 KeyWrongRegNick=11;
 KeyPrivateHistory=12;
 KeyMessagePrivate=13;
 KeyMessagePublic=14;
 KeyPublicHistory=15;
var
  ChatServer: TChatServer;
  mConnections:TmConnections;
  MyThread:TMyThread;
  SocketThread:TServerThread;
  MSGResult,HistoryPub:AnsiString;
  GlobalData:TData;
  LoggedConnections:Longint;
implementation

{$R *.dfm}

Function TChatServer.GetLocalIP;
  Var WSAData:TWSAData;
   P: PHostEnt;
   Name: array[0..$FF] of Char;
  Begin
   WSAStartup($0101,WSAData);
   GetHostName(Name,$FF);
   P:=GetHostByName(Name);
   GetLocalIP:=inet_ntoa(PInAddr(P.h_addr_list^)^);
   WSACleanup;
  End;
procedure TChatServer.BtnOpenCloseClick(Sender: TObject);
Var s:string;
begin
IPServer.Text:=GetLocalIp;
 s:=IPServer.Text;
 if SctServer.Active
  then
   begin
    SctServer.Close;
    EdLocalPort.Enabled:=True;
    BtnOpenClose.Caption:='Запустить';
    mmLog.Lines.Add('Сервер остановлен');
   end
  else
   begin
    SctServer.Port:=EdLocalPort.Value;
    SctServer.Open;
    EdLocalPort.Enabled:=False;
    BtnOpenClose.Caption:='Остановить';
    mmLog.Lines.Add('('+TimeTostr(time)+') '+SctServer.Socket.LocalHost+
    ' ['+IPServer.Text+':'+Inttostr(SctServer.Socket.LocalPort)+'] Сервер запущен');
   end;
end;
Procedure TChatServer.HandleEvent(var aData:TData;ClientSocket:TServerClientWinSocket);
procedure Log(aData:TData;ID:longint);
Var LOGIN,s,PASS:string;
    Data:TData;
    i:longint;
begin
 LOGIN:=aData.Login;
 PASS:=aData.Password;
 ChatServer.PosName.Close;
 ChatServer.PosName.Params.ParamByName('LOGIN').Value:=LOGIN;
 ChatServer.PosName.Params.ParamByName('PASS').Value:=PASS;
 ChatServer.PosName.Open;
 if ChatServer.PosName.IsEmpty
 then
  begin
   Data.Command:=KeyWrongLogin;
   ChatServer.SctServer.Socket.Connections[ID].SendBuf(Data,Sizeof(Data));
  end
 else
  begin
   ChatServer.SelectName.Close;
   Chatserver.SelectName.ParamByName('LOGIN').Value:=Login;
   Chatserver.SelectName.Open;
   Data.Nick:=SelectName.Fields[0].AsString;
   Data.command:=KeyAcceptName;
    i:=0;
    While mConnections[i].Active do
     Inc(i);
   mConnections[i].Active:=true;
   mConnections[i].NICK:=Data.Nick;
   mConnections[i].IP:=aData.IP;
   mConnections[i].SocketClient:=ClientSocket;
    IBMessage.Active:=true;
   ChatServer.TakePub.Close;
   ChatServer.TakePub.Open;
   s:=TakePub.Fields[0].AsString;
   IBMessage.Active:=true;
   i:=1;
   While s<>'' do
    begin
     Data.HistoryMessage[i]:=Copy(s,1,255);
     Delete(s,1,255);
     Inc(i);
    end;
   i:=0;
   While i<>65534 do
    begin
    if mconnections[i].Active
     then
      Data.ResultMSG:=Data.ResultMSG+mConnections[i].NICK+';';
     Inc(i);
    end;

   ChatServer.SctServer.Socket.Connections[ID].SendBuf(Data,Sizeof(TData));
      Data.Command:=KeyAcceptUsers;
      For i:=0 to ChatServer.SctServer.Socket.ActiveConnections-1 do
       if ClientSocket<>ChatServer.SctServer.Socket.Connections[i]
        then
         ChatServer.SctServer.Socket.Connections[i].SendBuf(Data,Sizeof(TData));
  end;
end;
{+++++++++++++++++REG+++++++++++++++++++}
Procedure Reg(aData:TData;ID:integer);
 Var Login,Pass,Nick,IP:string;
     Data:TData;
 begin
       NICK:=aData.Nick;
       LOGIN:=aData.Login;
       PASS:=aData.Password;
       IP:=aData.IP;
       ChatServer.mmLog.Lines.Add(NICK+' '+LOGIN+' '+PASS+ ' '+IP);
       ChatServer.RegNICK.Close;
       ChatServer.RegNICK.Params.ParamByName('NICK').Value:=NICK;
       ChatServer.RegNICK.Open;
      if ChatServer.RegNICK.IsEmpty
       then
        begin
         ChatServer.RegLog.Close;
         ChatServer.RegLog.Params.ParamByName('LOGIN').Value:=LOGIN;
         ChatServer.RegLOG.Open;
        if ChatServer.RegLog.IsEmpty
         then
          begin
            try
             If not ChatServer.IBTransaction1.Active then ChatServer.IBTransaction1.StartTransaction;
               with ChatServer.IBDataset1 do
                begin
                 Insert;
                 FieldByName('EDNICKNAME').AsString:=NICK;
                 FieldByName('Login').AsString:=LOGIN;
                 FieldByName('PASS').AsString:=PASS;
                 FieldByName('IP').AsString:=IP;
                 //ChatServer.mmLog.Lines.Add(NICK+' '+LOGIN+' '+PASS+' '+IP);
                 Post;
                end;
               ChatServer.IBTransaction1.Commit;
               ChatServer.IBDataset1.Active:=true;
            except
             Data.Command:=KeyWrongReg;
             ChatServer.SctServer.Socket.Connections[ID].SendBuf(Data,SizeOf(TData));
            end;
            if Data.Command<>KeyWrongReg then
             begin
              Data.Command:=KeyRegAccept;
              ChatServer.SctServer.Socket.Connections[ID].SendBuf(Data,SizeOf(TData));
             end;
          end
         else
          begin
           Data.Command:=KeyWrongRegLog;
           ChatServer.SctServer.Socket.Connections[ID].SendBuf(Data,SizeOf(TData));
          end
        end
       else
        begin
         Data.Command:=KeyWrongRegNick;
         ChatServer.SctServer.Socket.Connections[ID].SendBuf(Data,SizeOf(TData))
        end;
 end;
Procedure MessagePrivate(aData:TData;ID:integer);
Var Data:TData;
    k,j:longint;
    s,Nick1,Nick2:string;
 begin
    IBMessage.Active:=true;
    ChatServer.PosMembers1.Params.ParamByName('MEMBER1').AsString:=aData.Nick;
    ChatServer.PosMembers1.Params.ParamByName('MEMBER2').AsString:=aData.NameSend;
    ChatServer.PosMembers2.Params.ParamByName('MEMBER1').AsString:=aData.Nick;
    ChatServer.PosMembers2.Params.ParamByName('MEMBER2').AsString:=aData.NameSend;
    ChatServer.PosMembers1.Open;
    ChatServer.PosMembers2.Open;
    if ChatServer.PosMembers1.IsEmpty
         then
          begin
          s:=PosMembers2.Fields[0].AsString;
          Nick1:=aData.Nick;
          Nick2:=aData.NameSend;
          end
         else
          begin
          Nick2:=aData.Nick;
          Nick1:=aData.NameSend;
          s:=PosMembers1.Fields[0].AsString;
          end;
    If not ChatServer.IBTransaction1.Active then ChatServer.IBTransaction1.StartTransaction;
    ChatServer.InsertPrivate.Params.ParamByName('MEMBER1').AsString:=Nick1;
    ChatServer.InsertPrivate.Params.ParamByName('MEMBER2').AsString:=Nick2;
    ChatServer.InsertPrivate.Params.ParamByName('MESSAGE').AsString:=s+'['+TimeTostr(time)+'] '+aData.Nick+': '+aData.ResultMSG;
    ChatServer.InsertPrivate.Open;
    ChatServer.IBTransaction1.Commit;
    IBMessage.Active:=true;
    IBDataSet1.Active:=true;
 end;
Procedure MessagePublic(aData:TData;ID:integer);
 Var s:AnsiString;
     i:longint;
     Data:TData;
 begin
    HistoryPub:=HistoryPub+'['+TimeTostr(time)+'] '+aData.Nick+': '+aData.ResultMSG;
    Data.ResultMSG:='['+TimeTostr(time)+'] '+aData.Nick+': '+aData.ResultMSG;
    Data.Command:=KeyMessagePublic;
     For i:=0 to ChatServer.SctServer.Socket.ActiveConnections-1 do
        ChatServer.SctServer.Socket.Connections[i].SendBuf(Data,SizeOf(TData));
    ChatServer.IBMessage.Active:=true;
 end;
Procedure PrivateHistory(aData:TData;ID:integer);
 Var s:string;
     Data:TData;
     i:longint;
 begin
  IBMessage.Active:=true;
    ChatServer.PosMembers1.Params.ParamByName('MEMBER1').AsString:=aData.Nick;
    ChatServer.PosMembers1.Params.ParamByName('MEMBER2').AsString:=aData.NameSend;
    ChatServer.PosMembers2.Params.ParamByName('MEMBER1').AsString:=aData.Nick;
    ChatServer.PosMembers2.Params.ParamByName('MEMBER2').AsString:=aData.NameSend;
    ChatServer.PosMembers1.Open;
    ChatServer.PosMembers2.Open;
    ChatServer.PosMembers1.Params.ParamByName('MEMBER1').AsString:=aData.Nick;
    ChatServer.PosMembers1.Params.ParamByName('MEMBER2').AsString:=aData.NameSend;
    ChatServer.PosMembers2.Params.ParamByName('MEMBER1').AsString:=aData.Nick;
    ChatServer.PosMembers2.Params.ParamByName('MEMBER2').AsString:=aData.NameSend;
    ChatServer.PosMembers1.Open;
    ChatServer.PosMembers2.Open;
    IBMessage.Active:=true;
    if (ChatServer.PosMembers1.IsEmpty) and (ChatServer.PosMembers2.IsEmpty)
      then
       begin
         If not ChatServer.IBTransaction1.Active then ChatServer.IBTransaction1.StartTransaction;
               with ChatServer.IBMessage do
                begin
                 Insert;
                 FieldByName('MEMBER1').AsString:=aData.Nick;
                 FieldByName('MEMBER2').AsString:=aData.NameSend;
                 Post;
                end;
               ChatServer.IBTransaction1.Commit;
        ChatServer.IBMessage.Active:=true;
         Data.Command:=KeyPrivateHistory;
             Data.NameSend:=aData.NameSend;
             For i:=1 to 40 do
              Data.HistoryMessage[i]:='';
             ChatServer.SctServer.Socket.Connections[ID].SendBuf(Data,SizeOf(TData));
       end
      else
       begin
        if ChatServer.PosMembers1.IsEmpty
         then
          s:=PosMembers2.Fields[0].AsString
         else
          s:=PosMembers1.Fields[0].AsString;
        For i:=1 to 40 do
         Data.HistoryMessage[i]:='';
         i:=1;
         While s<>'' do
          begin
           Data.HistoryMessage[i]:=Copy(s,1,255);
           Delete(s,1,255);
           Inc(i);
          end;
         For i:=0 to ChatServer.SctServer.Socket.ActiveConnections-1 do
          if ChatServer.SctServer.Socket.Connections[i]=ClientSocket
           then
            begin
             Data.Command:=KeyPrivateHistory;
             Data.NameSend:=aData.NameSend;
             ChatServer.SctServer.Socket.Connections[ID].SendBuf(Data,SizeOf(TData));
            end;
       end;
 end;
Var ID,i:longint;
begin
 i:=0;
While i<>65535 do
 begin
  if ChatServer.SctServer.Socket.Connections[i]=ClientSocket
   then begin ID:=i; break; end;
  Inc(i);
 end;
  Case aData.Command of
   KeyRegNewUser:begin
                  Reg(aData,ID);
                 end;
   KeyLogUser:begin
               Log(aData,ID);
              end;
   KeyMessagePublic:begin
                   MessagePublic(aData,ID);
                  end;
   KeyMessagePrivate:begin
                      MessagePrivate(aData,ID);
                     end;
   KeyPrivateHistory:begin
                      PrivateHistory(aData,ID);
                     end;
 end;
end;
procedure TServerThread.ClientExecute;
var fRSData:TWinSocketStream;
    SizeBuf,Timer,j: longint;
    MS:TMemoryStream;
    bufIn,Data:TData;
    i:int64;
begin
ChatServer.mmLog.Lines.Add('Клиет подключен');
ChatServer.Connectionss.Text:=InttoStr(ChatServer.SctServer.Socket.ActiveConnections);
  inherited FreeOnTerminate:=true;
  try
    fData:=GlobalData;
  except
    on E: Exception do
      Terminate;
  end;
  try
    fRSData:=TWinSocketStream.Create(ClientSocket, 10000);
    MS:=TMemoryStream.Create;
    try
      while (not Terminated)and(ClientSocket.Connected) do
       begin
        Application.ProcessMessages;
        if (not Terminated) and (fRSData.WaitForData(3000))
         then
          begin
            SizeBuf:=ClientSocket.ReceiveLength;
            if SizeBuf<>0
             then
              begin
                MS.Clear;
                MS.Seek(0, soFromBeginning);
                  repeat
                   i:=fRSData.Read(bufin,SizeOf(TData));
                   ChatServer.mmLog.Lines.Add(Bufin.ResultMSG);
                   MS.Write(bufin, i);
                   SizeBuf:=ClientSocket.ReceiveLength;
                  until SizeBuf=0;
                MS.Seek(0,soFromBeginning);
                MS.Read(fData,MS.Size);
             //   ChatServer.mmLog.Lines.Add('['+fData.IP+']: '+fData.InfoCommand);
                if fData.Command<>KeyExit
                 then
                   ChatServer.HandleEvent(fData,ClientSocket)
                 else
                  begin
                   Terminate;
                   ChatServer.mmLog.Lines.Add(fData.Nick+' отключен');
                   ClientSocket.Close;
                  end;
              end
             else
              begin
               Terminate;
               ChatServer.mmLog.Lines.Add(' вылетел');
              end;
        end;
      end;
    finally
      MS.Free;
      ChatServer.Connectionss.Text:=InttoStr(ChatServer.SctServer.Socket.ActiveConnections-1);
    end;
  except
    ClientSocket.Close;
    if not Terminated then
    Terminate;
  end;
  ClientSocket.Close;
  j:=0;
   While j<>65535 do
    begin
    if mConnections[j].SocketClient=ClientSocket
     then
      mConnections[j].Active:=false;
     Inc(j);
    end;
    j:=0;
   While j<>65534 do
    begin
    if mconnections[j].Active
     then
      Data.ResultMSG:=Data.ResultMsg+mConnections[j].NICK+';';
      Inc(j);
    end;
     Data.Command:=KeyAcceptUsers;
    For j:=0 to ChatServer.SctServer.Socket.ActiveConnections-1 do
     if ClientSocket<>ChatServer.SctServer.Socket.Connections[j]
      then
       ChatServer.SctServer.Socket.Connections[j].SendBuf(Data,Sizeof(TData));
end;


procedure TChatServer.FormCreate(Sender: TObject);
Var s:Ansistring;
begin
 IPServer.Text:=GetLocalIP;
  ChatServer.TakePub.Close;
    ChatServer.TakePub.Open;
    s:=TakePub.Fields[0].AsString;
 mmChat.Lines.Clear;
    While s<>'' do
     begin
      mmChat.Lines.Add(Copy(s,1,Pos('#0',s)-1));
      Delete(s,1,Pos('#0',s)+1);
     end;
end;
procedure TChatServer.SctServerGetThread(Sender: TObject;
  ClientSocket: TServerClientWinSocket;
  var SocketThread: TServerClientThread);
begin
SocketThread:=TServerThread.Create(True, ClientSocket);
SocketThread.Priority:=tpHigher;
SocketThread.Resume;

end;

procedure TChatServer.Timer1Timer(Sender: TObject);
Var s:string;
begin
if HistoryPub<>''
 then
  begin
   ChatServer.TakePub.Close;
    ChatServer.TakePub.Open;
    s:=TakePub.Fields[0].AsString;
    s:=s+HistoryPub;
    IBMessage.Active:=true;
   ChatServer.InsertPub.Close;
   If not ChatServer.IBTransaction1.Active then ChatServer.IBTransaction1.StartTransaction;
    ChatServer.InsertPub.Params.ParamByName('MESSAGE').AsString:=s;
    ChatServer.InsertPub.Params.ParamByName('ID').Value:=1;
    ChatServer.InsertPub.Open;
    ChatServer.IBTransaction1.Commit;
      ChatServer.IBMessage.Active:=true;
     mmChat.Lines.Clear;
    While s<>'' do
     begin
      mmChat.Lines.Add(Copy(s,1,Pos('#0',s)-1));
      Delete(s,1,Pos('#0',s)+1);
     end;
  end;
 HistoryPub:='';
end;



end.
{ VSTAVKA SQL
 If not IBTransaction1.Active then IBTransaction1.StartTransaction;
 with IBDataset1 do
  begin
   Insert;
   FieldByName('EDNICKNAME').AsString:='Admin';
   FieldByName('Login').AsString:='admin';
   FieldByName('PASS').AsString:='1337';
   FieldByName('IP').AsString:='192.168.100.60';
   Post;
  end;
 IBTransaction1.Commit;
 IBDataset1.Active:=true;}
 {POISK SQL
 RegLog.Close;
 RegLog.Params.ParamByName('LOGIN').Value:='admin';
 RegLOG.Open;
if RegLog.IsEmpty
 then mmlog.Lines.Add('ne Naiden')
 else mmLog.Lines.Add('naiden');}
{ RegNICK.Close;
 RegNICK.Params.ParamByName('NICK').Value:='Admin';
 RegNICK.Open;
if RegNICK.IsEmpty
 then mmlog.Lines.Add('ne Naiden')
 else mmLog.Lines.Add('naiden'); }





