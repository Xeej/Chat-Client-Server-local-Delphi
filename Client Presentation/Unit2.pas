unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, XPMan, ScktComp, Buttons;

type
  TForm2 = class(TForm)
    Label2: TLabel;
    Label3: TLabel;
    EdServerPort: TSpinEdit;
    Button1: TButton;
    EdServerHost: TComboBox;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AddIp(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses Unit1, Unit3, Unit7, Unit4, Unit6, Unit8, Unit5;

{$R *.dfm}

procedure TForm2.AddIp(Sender: TObject);
Var  b:boolean;
     i:integer;
begin
  b:=false;
  for i:=0 to EdServerHost.Items.Count do
    if EdServerHost.Items[i]=Form1.SctClient.Host
        then b:=true;
    if not b
      then EdServerHost.Items.Insert(0,Form1.SctClient.Host);
    EdServerHost.Items.SaveToFile('IP.txt');
end;

procedure TForm2.Button1Click(Sender: TObject);
Var i:integer;
  f:boolean;
begin
    f:=false;
    for i:=1 to length(EdServerHost.Text) do
      begin
        if (EdServerHost.Text[i] in ['0'..'9'])
        or (EdServerHost.Text[i]='.')
          then f:=false
        else begin
               f:=true;
               break;
             end;  
      end;
    if not f
      then Form1.SctClient.Host:=EdServerHost.Text
    else MessageDLG('Введен некорректный IP',mtError,[mbOK],0);
     f:=false;
    for i:=1 to length(EdServerPort.Text) do
      begin
        if (EdServerPort.Text[i] in ['0'..'9'])
          then f:=false
        else begin
               f:=true;
               break;
             end;
      end;
    if not f
      then Form1.SctClient.Port:=EdServerPort.Value
    else MessageDLG('Введен некорректный порт',mtError,[mbOK],0);
    if (Form1.SctClient.Port<>0)
    and (Form1.SctClient.Host<>'')
    then begin
    try
      Form1.SctClient.Open;
      Form2.AddIp(Sender);
      Form7.Show;
      Form2.Hide;
      TMyThread.Create(false);
    except
      MessageDLG('Ошибка подключения',mtError,[mbOK],0);
    end;
    end
    else MessageDLG('Введен некорректный IP или Порт',mtError,[mbOK],0);
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  try
   EdServerHost.Items.LoadFromFile('IP.txt');
  except
   MessageDLG('Ошибка открытия файла,он будет создан снова,"IP.txt"',mtError,[mbOK],0);
   TFileStream.Create('IP.txt', fmCreate);
   EdServerHost.Items.LoadFromFile('IP.txt');
  end;
end;

end.
