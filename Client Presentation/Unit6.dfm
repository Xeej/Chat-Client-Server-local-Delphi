object Form6: TForm6
  Left = 671
  Top = 288
  Anchors = [akLeft, akTop, akRight, akBottom]
  AutoScroll = False
  Caption = 'Form6'
  ClientHeight = 504
  ClientWidth = 342
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object mmPrChat: TRichEdit
    Left = 0
    Top = 384
    Width = 257
    Height = 121
    TabOrder = 0
  end
  object mmPrVive: TRichEdit
    Left = 0
    Top = 0
    Width = 345
    Height = 369
    ReadOnly = True
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 368
    Width = 345
    Height = 17
    Color = clMaroon
    TabOrder = 2
  end
  object Button1: TButton
    Left = 256
    Top = 384
    Width = 89
    Height = 121
    Cancel = True
    Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100
    Default = True
    ParentShowHint = False
    ShowHint = False
    TabOrder = 3
    TabStop = False
    OnClick = Button1Click
  end
end
