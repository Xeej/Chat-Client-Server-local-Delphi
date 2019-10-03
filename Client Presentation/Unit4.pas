unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, XPMan, CheckLst, ComCtrls, Menus,
  Unit2, Unit3, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, Buttons, ScktComp;

type

  TForm4 = class(TForm)
  private
    { Private declarations }
  public
     procedure BackGrPict(Han:HWnd;fBmp:string);
    { Public declarations }
  end;
 
var
  Form4: TForm4;
  wind: HWND;
 
implementation
{$R *.dfm}
 
procedure TForm4.BackGrPict(Han: HWnd;fBmp:string);
var H:HBITMAP;
    bm:BITMAP;
    M,DC:HDC;
    bW,bH:integer;
begin
  H:=LoadImage(GetModuleHandle(nil),PChar(fBmp),IMAGE_BITMAP,0,0,LR_LOADFROMFILE);  //грузим битмап
  if H=0 then Exit else
  begin
    DC:=GetDC(Han);  //берем контекст формы
    M:=CreateCompatibleDC(DC);  //создаем временный контекст
    SelectObject(M,H);  //применяем к нему наш битмап
    GetObject(H,sizeof(BITMAP),@bm);  //берем данные битмапа
    bW:=0;
    bH:=0;
    BitBlt(DC,bW,bH,bm.bmWidth,bm.bmHeight,M,0,0,SRCCOPY);  //рисуем битмап на контексте формы (используя ширину и высоту)
    DeleteDC(M);  //стираем временный контекст
    DeleteObject(H);
  end;
end;
begin
end.
