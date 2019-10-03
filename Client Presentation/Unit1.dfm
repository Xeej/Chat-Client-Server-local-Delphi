object Form1: TForm1
  Left = 286
  Top = 872
  Width = 835
  Height = 699
  Caption = 'Chat'
  Color = clPurple
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    827
    645)
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 48
    Top = 502
    Width = 555
    Height = 70
    Anchors = [akLeft, akRight, akBottom]
    Color = clLime
    TabOrder = 5
  end
  object ToolPanel: TPanel
    Left = 0
    Top = 0
    Width = 49
    Height = 645
    Align = alLeft
    Color = clLime
    TabOrder = 0
  end
  object SellMemo: TRichEdit
    Left = 48
    Top = 571
    Width = 459
    Height = 77
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 3
    WantReturns = False
  end
  object SellBut: TButton
    Left = 506
    Top = 571
    Width = 94
    Height = 80
    Cursor = crHandPoint
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100
    Default = True
    TabOrder = 1
    OnClick = SellButClick
  end
  object mmChat: TRichEdit
    Left = 48
    Top = -8
    Width = 553
    Height = 510
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      '')
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 4
    WantReturns = False
    WordWrap = False
  end
  object Panel1: TPanel
    Left = 598
    Top = 0
    Width = 229
    Height = 645
    Align = alRight
    Color = clLime
    TabOrder = 2
    DesignSize = (
      229
      645)
    object Label1: TLabel
      Left = 6
      Top = 40
      Width = 53
      Height = 13
      Caption = 'NickName:'
    end
    object EdNickName: TEdit
      Left = 64
      Top = 38
      Width = 129
      Height = 21
      ReadOnly = True
      TabOrder = 0
      Text = 'Nick'
    end
    object Connectionss: TTreeView
      Left = 16
      Top = 72
      Width = 201
      Height = 486
      Anchors = [akLeft, akTop, akBottom]
      Indent = 19
      PopupMenu = PMenuUsers
      ReadOnly = True
      TabOrder = 1
      OnMouseUp = ConnectionssMouseUp
    end
  end
  object ColorBox1: TColorBox
    Left = 50
    Top = 0
    Width = 129
    Height = 22
    Style = [cbStandardColors]
    ItemHeight = 16
    TabOrder = 6
    OnChange = ColorBox1Change
  end
  object PMenuUsers: TPopupMenu
    Left = 1
    Top = 31
    object PM: TMenuItem
      Caption = 'Private Message'
      OnClick = PMClick
    end
  end
  object MainMenu1: TMainMenu
    Top = 64
    object Settings1: TMenuItem
      Caption = 'Settings'
      object Color1: TMenuItem
        Caption = 'Color'
        OnClick = Color1Click
      end
    end
  end
  object SctClient: TClientSocket
    Active = False
    ClientType = ctBlocking
    Port = 0
    OnError = SctClientError
  end
end
