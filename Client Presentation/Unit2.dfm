object Form2: TForm2
  Left = 1439
  Top = 261
  Width = 322
  Height = 243
  Caption = 'Login'
  Color = clGradientInactiveCaption
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 31
    Top = 29
    Width = 48
    Height = 13
    Caption = 'LocalHost'
  end
  object Label3: TLabel
    Left = 59
    Top = 61
    Width = 19
    Height = 13
    Caption = 'Port'
  end
  object EdServerPort: TSpinEdit
    Left = 88
    Top = 56
    Width = 121
    Height = 22
    MaxValue = 65535
    MinValue = 1
    TabOrder = 0
    Value = 1337
  end
  object Button1: TButton
    Left = 72
    Top = 88
    Width = 161
    Height = 65
    Caption = #1055#1086#1076#1082#1083#1102#1095#1080#1090#1100#1089#1103
    TabOrder = 1
    OnClick = Button1Click
  end
  object EdServerHost: TComboBox
    Left = 88
    Top = 24
    Width = 121
    Height = 21
    ItemHeight = 13
    TabOrder = 2
    Text = 'Select IP'
    OnDropDown = FormCreate
  end
end
