unit Unit8;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg;

type
  TForm8 = class(TForm)
    EdNickName: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    EdLoginName: TEdit;
    Label7: TLabel;
    EDPassword: TEdit;
    Label8: TLabel;
    Button1: TButton;
    Button3: TButton;
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation

uses Unit1, Unit7;

{$R *.dfm}

procedure TForm8.Button3Click(Sender: TObject);
Function Pereb(s:String):boolean;
Var i:integer;
    f:boolean;
begin
  f:=false;
  for i:=1 to length(s) do
   if (s[i]in['a'..'z'])or(s[i]in['A'..'Z'])or(s[i]in['0'..'9'])
     then begin
            f:=true;
          end
   else begin
          f:=false;
          break;
        end;  
  if f
    then Pereb:=true
  else Pereb:=false;
end;
begin
  if not((EdNickName.Text<>'Your name')and(Pereb(EdNickName.Text)))
  or not((EdLoginName.Text<>'Your login')and (Pereb(EdLoginName.Text)))
  or not((EdPassword.Text<>'Your password')and (Pereb(EdPassword.Text)))
    then MessageDLG('ќшибка регистрации',mtError,[mbOK],0)
  else begin
         Form1.FillForm([KeyRegNewUser,0,EdPassword.Text,EdLoginName.Text,''
         ,EdNickName.Text,Form1.SctClient.Socket.LocalAddress,KeyMarkInfo+'ќтправл€ю запрос на регистрацию'+KeyMarkInfo,'']);
         Form1.SctClient.Socket.SendBuf(Form1.GlobalData,SizeOf(Form1.GlobalData));
       end;
end;

procedure TForm8.Button1Click(Sender: TObject);
begin
  EdNickName.Text:='Your name';
  EdLoginName.Text:='Your login';
  EdPassword.Text:='Your password';
  Form7.Show;
  Form8.Hide;
end;


procedure TForm8.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Form7.Close;
end;

end.
