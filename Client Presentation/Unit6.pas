unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons, ExtCtrls;

type
  TForm6 = class(TForm)
    mmPrChat: TRichEdit;
    mmPrVive: TRichEdit;
    Panel1: TPanel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation
Uses Unit1;
{$R *.dfm}

procedure TForm6.Button1Click(Sender: TObject);
Var Chek:string;
begin
 if mmPrChat.Lines[0]<>''
   then begin
          Chek:=StringReplace(TForm6(tButton(Sender).Parent).mmPrChat.Lines.GetText,#13#10,'',[rfreplaceall]);
          Chek:=StringReplace(Chek,#$D#$A,'',[rfreplaceall]);
          Form1.FillForm([KeyMessagePrivate,0,'','',TForm6(tbutton(sender).Parent).Name,Form1.EdNickName.Text,Form1.SctClient.Socket.LocalAddress,KeyMarkInfo+'ќтправл€ю приватное сообщение'+KeyMarkInfo,Chek+'#0','']);
          Form1.SctClient.Socket.SendBuf(Form1.GlobalData,SizeOf(Form1.GlobalData));
          mmPrChat.Lines.clear;
          Form1.ClearMessage;
          mmPrChat.SetFocus;
        end;

end;

procedure TForm6.FormClose(Sender: TObject; var Action: TCloseAction);
Var i:integer;
begin
  For I:=1 to KeyMaxPrivateMessage do
    begin
      if Form1.PrM[i]=sender
        then FreeAndNil(Form1.PrM[i]);
    end;
end;

end.
