unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, XPMan, CheckLst, ComCtrls, Menus,
  Unit2, Unit3, Buttons, ScktComp, re_bmp, Unit6;
Const
 KeyMarkInfo='!!';
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
 KeyPublicMessage=14;
 KeyPublicHistory=15;
 KeyPictureMax=10;
 KeyMaxPrivateMessage=100;
type
  PData=^TData;
  TData=record
          Command,Color:integer;
          Password,Login,NameSend,Nick,IP:string[15];
          InfoCommand:string[255];
          ResultMSG:string[255];
          HistoryMessage:array [1..40]of string[255];
        end;
  TPict=array[1..KeyPictureMax]of record
                         Cod,PictName:string;
                         Pic:TImage;
                       end;
  TPrivatMessage=array[1..KeyMaxPrivateMessage] of TForm6;

  TForm1 = class(TForm)
    ToolPanel: TPanel;
    SellBut: TButton;
    Panel1: TPanel;
    Label1: TLabel;
    EdNickName: TEdit;
    SellMemo: TRichEdit;
    mmChat: TRichEdit;
    PMenuUsers: TPopupMenu;
    PM: TMenuItem;
    MainMenu1: TMainMenu;
    Settings1: TMenuItem;
    Color1: TMenuItem;
    SctClient: TClientSocket;
    Connectionss: TTreeView;
    Panel2: TPanel;
    ColorBox1: TColorBox;
    procedure LogSecs(Sender: TObject);
    procedure SctClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure SctClientError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure SellButClick(Sender: TObject);
    procedure ConnectionssMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Color1Click(Sender: TObject);
    procedure SendNameToServ(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FillForm(Data:array of variant);
    procedure GoodLogin;
    procedure AddHistory(Rich:TRichEdit);
    procedure ClearMessage;
    procedure AddUsers;
    procedure FindPict(Var WorkString:String;Num:integer;Rich:TRichEdit);
    procedure FormCreate(Sender: TObject);
    procedure PMClick(Sender: TObject);
    function FindForm(s:string):TRichEdit;
    Procedure Setline(RichEdit: TRichEdit; LineNumber, CharNumber: Word);
    procedure CvetText(Var WorkString:String;Num:integer;Rich:TRichEdit);
    Procedure AddPrivat;
    procedure PublicMessage;
    procedure ColorBox1Change(Sender: TObject);
  private  
    { Private declarations }
  public
    PMName:string;
    GlobalData:TData;
    Pic:TPict;
    PrM,PrS:TPrivatMessage;
  end;
var
  Form1: TForm1;


implementation


uses Unit8, Unit7, Unit5, Unit4;
{$R *.dfm}

procedure TForm1.LogSecs(Sender: TObject);
begin
 try
   FillForm([KeyLogUser,0,Form7.EdPassword.Text,Form7.EdLOGIN.Text,
   '','',SctClient.Socket.LocalAddress,KeyMarkInfo+'���������� ��� �� �������'+KeyMarkInfo,'']);
   SctClient.Socket.SendBuf(GlobalData,SizeOf(GlobalData));
 except
   MessageDLG('������ �����������,������ �����������.',mtError,[mbOK],0);
 end;
end;

procedure TForm1.SendNameToServ(Sender:TObject);
begin
 with GlobalData do
 begin
   Command:=KeyRegNewUser;
   Nick:=Form8.EdNickName.Text;
   Login:=Form8.EdLoginName.Text;
   Password:=Form8.EdLoginName.Text;
 end;
 SctClient.Socket.SendBuf(GlobalData,SizeOf(GlobalData));
end;

procedure TForm1.SctClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  mmChat.Lines.Add('Server Disconected');
  SctClient.Socket.Close;
end;

procedure TForm1.SctClientError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  if ErrorEvent=eeConnect
    then begin
           MessageDLG('������ �����������',mtError,[mbOK],0);
           ErrorCode:=0;
         end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FillForm([KeyExit,0,'','','',EdNickName.Text,'',KeyMarkInfo+'������ � �������'+KeyMarkInfo,'']);
  SctClient.Socket.SendBuf(GlobalData,SizeOf(GlobalData));
  Form7.close;
  SctClient.Socket.Close;
end;

procedure TForm1.SellButClick(Sender: TObject);
Var Chek:string;
begin
 if SellMemo.Lines[0]<>''
   then begin
          Chek:=StringReplace(SellMemo.Lines.GetText,#13#10,'',[rfreplaceall]);
          Chek:=StringReplace(Chek,#$D#$A,'',[rfreplaceall]);
          FillForm([KeyPublicMessage,0,'','','',EdNickName.Text,SctClient.Socket.LocalAddress,
          KeyMarkInfo+'��������� ���������'+KeyMarkInfo,Chek+'#0','']);
          SctClient.Socket.SendBuf(GlobalData,SizeOf(GlobalData));
          SellMemo.Lines.clear;
          ClearMessage;
          mmChat.SetFocus;
        end;
end;

procedure TForm1.ConnectionssMouseUp(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
var popMenu     : TPopupMenu;
    clickedNode : TTreeNode;
begin
  if Button = mbRight
    then begin
           popMenu := nil;
           clickedNode := Connectionss.GetNodeAt(x, y);
           if clickedNode <> nil
             then begin
                    popMenu := PMenuUsers;
                    PMName:=clickedNode.Text;
                  end;
           if popMenu <> nil
             then begin
                    Inc(x, Connectionss.Left + Form1.Left);
                    Inc(y, Connectionss.Top + Form1.Top);
                    popMenu.Popup(x, y);
                  end;
         end;
end;

procedure TForm1.Color1Click(Sender: TObject);
begin
  ColorBox1.Show;
end;

Procedure TForm1.Setline(RichEdit: TRichEdit; LineNumber, CharNumber: Word);
Begin
  RichEdit.SelStart:=RichEdit.Perform(EM_LINEINDEX, LineNumber, 0)+CharNumber;
end;

procedure TForm1.FillForm(Data:array of variant);
begin
  with GlobalData do
  begin
    Command:=Data[0];
    Color:=Data[1];
    Password:=Data[2];
    Login:=Data[3];
    NameSend:=Data[4];
    Nick:=Data[5];
    IP:=Data[6];
    InfoCommand:=Data[7];
    ResultMSG:=Data[8];
  end;
end;


procedure TForm1.GoodLogin;
begin
  EdNickName.Text:=GlobalData.Nick;
  Form7.Hide;
  Form1.Show;
end;

procedure TForm1.AddHistory(Rich:TRichEdit);
Var GoodString:ansistring;
    s:string;
    i:integer;
begin
  i:=1;
  if Rich<>nil
    then begin
           Rich.Clear;
            while Globaldata.HistoryMessage[i]<>'' do
             begin
               GoodString:=GoodString+Globaldata.HistoryMessage[i];
               Globaldata.HistoryMessage[i]:='';
               inc(i);
             end;
            while GoodString<>'' do
              begin
                s:=(Copy(GoodString,1,Pos('#0',GoodString)-1));
                s:=StringReplace(s,#$D#$A,'',[rfreplaceall]);
                s:=StringReplace(s,#13#10,'',[rfreplaceall]);
                FindPict(s,Rich.Lines.Capacity,Rich);
                CvetText(s,Rich.Lines.Capacity,Rich);
                Delete(GoodString,1,pos('#0',GoodString)+1);
              end;
         end;
end;
Procedure TForm1.ClearMessage;
Var i:integer;
begin
  with Form1.GlobalData do
  begin
    Command:=0;
    Color:=0;
    Nick:='';
    NameSend:='';
    IP:='';
    Login:='';
    Password:='';
    InfoCommand:='';
    ResultMSG:='';
  end;
   for i:=1 to 40 do
    Globaldata.HistoryMessage[i]:='';
end;

procedure TForm1.AddUsers;
begin
  Connectionss.Items.Clear;
  While GlobalData.ResultMSG<>'' do
    begin
      Connectionss.Items.Add(Nil,Copy(GlobalData.ResultMSG,1,pos(';',GlobalData.ResultMSG)-1));
      Delete(GlobalData.ResultMSG,1,pos(';',GlobalData.ResultMSG));
    end;
  ClearMessage;
end;

procedure TForm1.FindPict(var WorkString:String;Num:integer;Rich:TRichEdit);

procedure Search_And_Replace(RichEdit: TRichEdit;
  SearchText, ReplaceText: string);
var
  startpos, Position, endpos: integer;
begin
  startpos := 0;
  with RichEdit do
  begin
    endpos := Length(RichEdit.Text);
    Lines.BeginUpdate;
    while FindText(SearchText, startpos, endpos, [stMatchCase])<>-1 do
    begin
      endpos   := Length(RichEdit.Text) - startpos;
      Position := FindText(SearchText, startpos, endpos, [stMatchCase]);
      Inc(startpos, Length(SearchText));
      SetFocus;
      SelStart  := Position;
      SelLength := Length(SearchText);
      richedit.clearselection;
      SelText := ReplaceText;
    end;
    Lines.EndUpdate;
  end;
end;

Var i,komp:integer;
begin
 komp:=0;
 Rich.Lines.Append(WorkString);
 for i:=1 to KeyPictureMax do
   begin
     while pos(Pic[i].Cod,WorkString)<>0 do
       begin
         Search_And_Replace(Rich,Pic[i].Cod,'');
         Setline(Rich,Num,pos(Pic[i].Cod,WorkString)-1+komp);
         Delete(WorkString,pos(Pic[i].Cod,WorkString),Length(Pic[i].Cod));
         InsertBitmapToRE(Rich.Handle,Pic[i].Pic.Picture.Bitmap.Handle);
         inc(komp);
       end;
   end;
end;

procedure TForm1.FormCreate(Sender: TObject);
Var i:integer;
begin
  i:=1;
   while i<KeyPictureMax do
    begin
     try
      Pic[i].Cod:='^^'+IntToStr(i);
      Pic[i].PictName:=IntToStr(i)+'.bmp';
      Pic[i].Pic:=TImage.Create(Form1);
      Pic[i].Pic.Picture.Create;
      Pic[i].Pic.Parent:=Form1;
      Pic[i].Pic.Picture.LoadFromFile(Pic[i].PictName);
      Pic[i].Pic.Hide;
      inc(i);
     except
      break;
     end;
    end;
    ColorBox1.Hide;
end;

procedure TForm1.PMClick(Sender: TObject);
Var i,IB:integer;
    MarkA:boolean;
    NewF:TForm6;
begin
  MarkA:=False;
  IB:=1;
  I:=1;
  FillForm([KeyPrivateHistory,0,'','',PMName,EdNickName.Text,SctClient.Socket.LocalAddress,
            KeyMarkInfo+'������� ��������� ���������'+KeyMarkInfo,'','']);
  SctClient.Socket.SendBuf(GlobalData,SizeOf(GlobalData));
  ClearMessage;
  while i<KeyMaxPrivateMessage do
   begin
     if (PrM[i]<>nil)and(PrM[i].Name=PMName)
       then begin
              iB:=I;
              MarkA:=true;
            end;
     inc(i);
   end;

   if not MarkA
     then begin
            for i:=1 to KeyMaxPrivateMessage-1 do
              begin
                if PrM[i]=nil
                  then begin
                         iB:=I;
                         break;
                       end;
               end;
             NewF:=TForm6.Create(Application);
             PrM[iB]:=NewF;
             PrM[iB].Name:=PMName;
             PrM[iB].Caption:=PMName;
          end;
   PrM[ib].Show;
end;

Function TForm1.FindForm(s: string):TRichEdit;
Var i:integer;
begin
  FindForm:=nil;
  for i:=1 to KeyMaxPrivateMessage do
    begin
      if ((PrM[i]<>nil))and(PrM[i].Name=s)
        then FindForm:=PrM[i].mmPrVive;
      break;
    end; 
end;

procedure TForm1.CvetText(var WorkString: String; Num: integer;
  Rich: TRichEdit);
Var mySearchTypes : TSearchTypes;
    MX,DOP,i:integer;
    FindString:string;
begin
   DOP:=0;
   for i:=1 to Num-1 do
    begin
      DOP:=DOP+length(Rich.Lines.Strings[i]);
    end;
   FindString:='@'+EdNickName.Text;
   mySearchTypes := mySearchTypes + [stMatchCase];
   if pos(FindString,WorkString)<>0
     then begin
            Delete(WorkString,pos(FindString,WorkString),1);
            MX:=Rich.FindText(FindString,1,DOP,mySearchTypes);
            Rich.Lines.Strings[num-1]:=WorkString;
            if MX<>-1
              then begin
                    Rich.SelStart:=MX;
                    Rich.SelLength:=Length(FindString)-1;
                    Rich.SelAttributes.Color:=clRed;
                  end;
          end;
end;

procedure TForm1.AddPrivat;
Var Ric:TRichEdit;
    i,iB:integer;
    NewF:TForm6;
    s:string;
    k:integer;
begin
   iB:=1;
   Ric:=FindForm(GlobalData.NameSend);
   if Ric=nil
     then begin
            for i:=1 to KeyMaxPrivateMessage-1 do
              begin
                if PrM[i]=nil
                  then begin
                         iB:=I;
                         break;
                       end;
               end;
             NewF:=TForm6.Create(Application);
             PrM[iB]:=NewF;
             PrM[iB].Name:=PMName;
             PrM[iB].Caption:=PMName;
             Ric:=PrM[iB].mmPrVive;
          end;
   Delete(GlobalData.ResultMSG,Pos('#0',GlobalData.ResultMSG),2);
   s:=GlobalData.ResultMSG;
   k:=Ric.Lines.Capacity;
   FindPict(s,k,Ric);
   Ric.Parent.Show;
   ClearMessage;
end;

procedure TForm1.PublicMessage;
Var k:integer;
    s:string;
begin
    K:=mmChat.Lines.Capacity;
    s:=GlobalData.ResultMSG;
    Delete(s,Pos('#0',GlobalData.ResultMSG),2);
    FindPict(s,k,mmChat);
    CvetText(s,k,mmChat);
end;

procedure TForm1.ColorBox1Change(Sender: TObject);
begin
  Form1.Color:=ColorBox1.Selected;
  ColorBox1.Hide;
end;

end.

