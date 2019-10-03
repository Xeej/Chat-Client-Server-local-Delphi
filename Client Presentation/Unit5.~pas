     unit Unit5;

interface

uses
  Classes, SysUtils, Unit1, Unit2, Unit7, Unit8,Messages, Controls, Dialogs, ScktComp, ComCtrls;

type
  TMyThread = class(TThread)
  private
    fRSData: TWinSocketStream;
  protected
    procedure Execute; override;
  public
    procedure AcceptUpdate;
    procedure HandleEvent;
    procedure ClearMessage;
    destructor Close;virtual;
  end;
implementation

procedure TMyThread.AcceptUpdate;
Var SizeBuf,i:longint;
    MS: TMemoryStream;
    bufIn:TData;
begin
  SizeBuf:=Form1.SctClient.Socket.ReceiveLength;
  if SizeBuf<>0
    then begin
           MS:=TMemoryStream.Create;
           try
           i:=0;
           repeat
             i:=fRSData.Read(bufIn,SizeOf(Form1.GlobalData));
             MS.Write(bufIn, i);
             SizeBuf:=Form1.SctClient.Socket.ReceiveLength;
           until SizeBuf = 0;
           MS.Seek(0, soFromBeginning);
           MS.Read(Form1.GlobalData, MS.Size);
           except
             ClearMessage;
           end;
         MS.Free;
  end;
end;

procedure TMyThread.HandleEvent;
begin
  case Form1.GlobalData.Command of
  KeyAcceptUsers:begin Form1.AddUsers; end;
  KeyWrongLogin:begin MessageDLG('Неправильный логин или пароль.',mtError,[mbOK],0);end;
  KeyAcceptName:begin
                  with Form1 do
                  begin
                    GoodLogin;
                    AddHistory(Form1.mmChat);
                    AddUsers;
                  end;
                end;
  KeyRegAccept:begin
                 MessageDLG('Регистрация успешно завершена',mtInformation,[mbOK],0);
                 Form8.Hide;
                 Form7.Show;
               end;
  KeyWrongRegLog:begin MessageDLG('Данный логин уже используется',mtInformation,[mbOK],0); end;
  KeyWrongRegNick:begin MessageDLG('Данный никнейм уже используется',mtInformation,[mbOK],0); end;
  KeyPublicMessage:begin Form1.PublicMessage;end;
  KeyPrivateHistory:begin Form1.AddHistory(Form1.FindForm(Form1.GlobalData.NameSend));end;
  KeyMessagePrivate:begin Form1.AddPrivat;end;
  end;
  ClearMessage;
end;

procedure TMyThread.Execute;
begin
  fRSData:=TWinSocketStream.Create(Form1.SctClient.Socket,1000);
  while not Terminated do
   begin
     Synchronize(AcceptUpdate);
     Synchronize(HandleEvent);
   end;
   FreeAndNil(fRSData);
end;

Destructor TMyThread.Close;
begin
  Terminate;
  WaitFor;
  Free;
end;
procedure TMyThread.ClearMessage;
begin
  with Form1 do
  begin 
  GlobalData.Command:=0;
  GlobalData.Color:=0;
  GlobalData.Nick:='';
  GlobalData.NameSend:='';
  GlobalData.IP:='';
  GlobalData.Login:='';
  GlobalData.Password:='';
  GlobalData.InfoCommand:='';
  GlobalData.ResultMSG:='';
  end;
end;

end.
