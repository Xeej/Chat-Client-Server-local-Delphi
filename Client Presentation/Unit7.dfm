object Form7: TForm7
  Left = 251
  Top = 190
  Width = 341
  Height = 255
  Caption = 'Login Screen'
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
  object Label2: TLabel
    Left = 16
    Top = 24
    Width = 275
    Height = 13
    Caption = #1044#1086#1073#1088#1086' '#1087#1086#1086#1078#1072#1083#1086#1074#1072#1090#1100' '#1074' '#1095#1072#1090'! '#1055#1086#1083#1091#1081#1089#1090#1072' '#1072#1074#1090#1086#1088#1080#1079#1080#1088#1091#1081#1090#1077#1089#1100
  end
  object Label1: TLabel
    Left = 41
    Top = 48
    Width = 62
    Height = 13
    Caption = 'Login/'#1051#1086#1075#1080#1085
  end
  object Label3: TLabel
    Left = 15
    Top = 80
    Width = 89
    Height = 13
    Caption = 'Password/'#1055#1072#1088#1086#1083#1100
  end
  object BLOG: TButton
    Left = 40
    Top = 160
    Width = 105
    Height = 33
    Caption = 'Login'
    TabOrder = 0
    OnClick = BLOGClick
  end
  object BREG: TButton
    Left = 160
    Top = 160
    Width = 105
    Height = 33
    Caption = 'Registration'
    TabOrder = 1
    OnClick = BREGClick
  end
  object EdLOGIN: TEdit
    Left = 110
    Top = 45
    Width = 177
    Height = 21
    TabOrder = 2
    Text = 'Your login'
  end
  object EdPassword: TEdit
    Left = 110
    Top = 77
    Width = 177
    Height = 21
    TabOrder = 3
    Text = 'Your password'
  end
end
