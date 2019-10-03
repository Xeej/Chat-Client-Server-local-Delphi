unit Unit7;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm7 = class(TForm)
    BLOG: TButton;
    BREG: TButton;
    Label2: TLabel;
    EdLOGIN: TEdit;
    EdPassword: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    procedure BREGClick(Sender: TObject);
    procedure BLOGClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

uses Unit8, Unit1, Unit2;

{$R *.dfm}

procedure TForm7.BREGClick(Sender: TObject);
begin
  Form8.Show;
  Form7.hide;
end;

procedure TForm7.BLOGClick(Sender: TObject);
begin
  if EdLogin.Text<>'Your login'
    then begin
           if EdPassword.Text<>'Your password'
             then Form1.LogSecs(Sender)
           else ShowMessage('Введите пароль!');
         end
  else ShowMessage('Введите логин!');
end;

procedure TForm7.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Form2.Close;
 Form1.FillForm([KeyExit,0,'','','',Form1.EdNickName.Text,'',KeyMarkInfo+'Выхожу с сервера'+KeyMarkInfo,'']);
 Form1.SctClient.Socket.SendBuf(Form1.GlobalData,SizeOf(Form1.GlobalData));
end;

end.
