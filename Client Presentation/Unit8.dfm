object Form8: TForm8
  Left = 21
  Top = 298
  AutoScroll = False
  Caption = 'Registration'
  ClientHeight = 412
  ClientWidth = 348
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
  object Label1: TLabel
    Left = 20
    Top = 50
    Width = 58
    Height = 13
    Caption = 'Name/'#1048#1084#1103':'
  end
  object Label2: TLabel
    Left = 19
    Top = 8
    Width = 176
    Height = 13
    Caption = #1055#1088#1080#1076#1091#1084#1072#1081#1090#1077' '#1080' '#1079#1072#1087#1080#1096#1080#1090#1077' '#1089#1077#1073#1077' '#1080#1084#1103'.'
  end
  object Label3: TLabel
    Left = 16
    Top = 24
    Width = 268
    Height = 13
    Caption = ' '#1055#1086#1076' '#1085#1080#1084' '#1074#1072#1089' '#1073#1091#1076#1091#1090' '#1079#1085#1072#1090#1100' '#1076#1088#1091#1075#1080#1077' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080' '#1095#1072#1090#1072'.'
  end
  object Label4: TLabel
    Left = 20
    Top = 80
    Width = 162
    Height = 13
    Caption = #1055#1088#1080#1076#1091#1084#1072#1081#1090#1077' '#1089#1077#1073#1077' '#1080#1085#1076#1080#1092#1080#1082#1072#1090#1086#1088'.'
  end
  object Label5: TLabel
    Left = 20
    Top = 96
    Width = 174
    Height = 13
    Caption = #1054#1085' '#1087#1086#1085#1072#1076#1086#1073#1080#1090#1089#1103' '#1076#1083#1103' '#1072#1074#1090#1086#1088#1080#1079#1072#1094#1080#1080'.'
  end
  object Label6: TLabel
    Left = 22
    Top = 121
    Width = 45
    Height = 13
    Caption = 'ID/Login:'
  end
  object Label7: TLabel
    Left = 22
    Top = 144
    Width = 281
    Height = 13
    Caption = #1055#1088#1080#1076#1091#1084#1072#1081#1090#1077' '#1080' '#1079#1072#1087#1080#1096#1080#1090#1077' '#1087#1072#1088#1086#1083#1100','#1093#1088#1072#1085#1080#1090#1077' '#1077#1075#1086' '#1074' '#1089#1077#1082#1088#1077#1090#1077'.'
  end
  object Label8: TLabel
    Left = 23
    Top = 168
    Width = 92
    Height = 13
    Caption = 'Password/'#1055#1072#1088#1086#1083#1100':'
  end
  object EdNickName: TEdit
    Left = 80
    Top = 48
    Width = 193
    Height = 21
    TabOrder = 0
    Text = 'Your name'
  end
  object EdLoginName: TEdit
    Left = 70
    Top = 119
    Width = 193
    Height = 21
    TabOrder = 1
    Text = 'Your login'
  end
  object EDPassword: TEdit
    Left = 117
    Top = 166
    Width = 193
    Height = 21
    TabOrder = 2
    Text = 'Your password'
  end
  object Button1: TButton
    Left = 24
    Top = 200
    Width = 97
    Height = 41
    Caption = 'RollBack'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button3: TButton
    Left = 200
    Top = 200
    Width = 97
    Height = 41
    Caption = 'Complete'
    TabOrder = 4
    OnClick = Button3Click
  end
end
