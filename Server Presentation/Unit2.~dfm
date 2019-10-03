object ChatServer: TChatServer
  Left = 252
  Top = 166
  BorderStyle = bsSingle
  Caption = 'Server CommForm'
  ClientHeight = 445
  ClientWidth = 677
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 677
    Height = 81
    Align = alTop
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = '.'
    Color = clGradientActiveCaption
    TabOrder = 0
    object Label1: TLabel
      Left = 552
      Top = 9
      Width = 28
      Height = 13
      Caption = #1055#1086#1088#1090':'
    end
    object Label3: TLabel
      Left = 177
      Top = 56
      Width = 51
      Height = 13
      Caption = 'Public '#1095#1072#1090':'
    end
    object Label4: TLabel
      Left = 9
      Top = 6
      Width = 129
      Height = 13
      Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1085#1099#1093' '#1082#1083#1080#1077#1085#1090#1086#1074':'
    end
    object Label5: TLabel
      Left = 232
      Top = 8
      Width = 59
      Height = 13
      Caption = 'IP '#1057#1077#1088#1074#1077#1088#1072':'
    end
    object EdLocalPort: TSpinEdit
      Left = 591
      Top = 4
      Width = 73
      Height = 22
      MaxValue = 65535
      MinValue = 1
      TabOrder = 0
      Value = 1337
    end
    object BtnOpenClose: TButton
      Left = 488
      Top = 30
      Width = 177
      Height = 43
      Caption = #1047#1072#1087#1091#1089#1090#1080#1090#1100
      TabOrder = 1
      OnClick = BtnOpenCloseClick
    end
    object Connectionss: TMaskEdit
      Left = 151
      Top = 4
      Width = 73
      Height = 21
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 2
      Text = '0'
    end
    object IPServer: TEdit
      Left = 294
      Top = 5
      Width = 107
      Height = 21
      ReadOnly = True
      TabOrder = 3
      Text = '127.0.0.1'
    end
    object StaticText1: TStaticText
      Left = 8
      Top = 56
      Width = 26
      Height = 17
      Caption = #1051#1086#1075':'
      TabOrder = 4
    end
  end
  object mmLog: TMemo
    Left = 0
    Top = 81
    Width = 161
    Height = 364
    Align = alLeft
    Color = cl3DLight
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object mmChat: TMemo
    Left = 161
    Top = 81
    Width = 516
    Height = 364
    Align = alClient
    Anchors = [akTop, akRight, akBottom]
    BevelEdges = [beLeft, beTop, beBottom]
    Color = cl3DLight
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object SctServer: TServerSocket
    Active = False
    Port = 0
    ServerType = stThreadBlocking
    OnGetThread = SctServerGetThread
    Left = 344
    Top = 33
  end
  object IBDatabase1: TIBDatabase
    Connected = True
    DatabaseName = 'DBFC2.FDB'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey'
      'lc_ctype=WIN1251')
    LoginPrompt = False
    DefaultTransaction = IBTransaction1
    IdleTimer = 0
    SQLDialect = 3
    TraceFlags = []
    Left = 216
    Top = 32
  end
  object IBTransaction1: TIBTransaction
    Active = True
    DefaultDatabase = IBDatabase1
    AutoStopAction = saNone
    Left = 248
    Top = 32
  end
  object IBDataSet1: TIBDataSet
    Database = IBDatabase1
    Transaction = IBTransaction1
    ObjectView = True
    BufferChunks = 1000
    CachedUpdates = False
    InsertSQL.Strings = (
      'INSERT INTO USERS (EDNICKNAME,LOGIN,PASS,IP)'
      'VALUES (:EDNICKNAME,:LOGIN,:PASS,:IP)')
    RefreshSQL.Strings = (
      'select * from USERS')
    SelectSQL.Strings = (
      'select * from USERS')
    GeneratorField.ApplyEvent = gamOnPost
    Active = True
    Left = 280
    Top = 32
  end
  object RegLOG: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT * FROM USERS WHERE USERS.LOGIN like :LOGIN')
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'LOGIN'
        ParamType = ptUnknown
      end>
  end
  object RegNICK: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT * FROM USERS WHERE USERS.EDNICKNAME like :NICK')
    Left = 32
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'NICK'
        ParamType = ptUnknown
      end>
  end
  object PosName: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'SELECT * FROM USERS WHERE USERS.PASS like :PASS and USERS.LOGIN ' +
        'like :LOGIN')
    Left = 48
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PASS'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'LOGIN'
        ParamType = ptUnknown
      end>
  end
  object SelectName: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT EDNICKNAME FROM USERS WHERE USERS.LOGIN=:LOGIN')
    Left = 16
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'LOGIN'
        ParamType = ptUnknown
      end>
  end
  object InsertIP: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'UPDATE USERS'
      '                    SET USERS.IP=:IP'
      '                    WHERE  USERS.EDNICKNAME=:EDNICKNAME;')
    Left = 144
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'IP'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'EDNICKNAME'
        ParamType = ptUnknown
      end>
  end
  object TakePub: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT MESSAGE FROM PUBLIC WHERE ID=1')
    Left = 80
    Top = 32
  end
  object IBMessage: TIBDataSet
    Database = IBDatabase1
    Transaction = IBTransaction1
    ObjectView = True
    BufferChunks = 1000
    CachedUpdates = False
    InsertSQL.Strings = (
      'INSERT INTO PUBLIC (MEMBER1,MEMBER2)'
      'VALUES (:MEMBER1,:MEMBER2)')
    RefreshSQL.Strings = (
      'SELECT* From PUBLIC')
    SelectSQL.Strings = (
      'SELECT* From PUBLIC')
    Active = True
    Left = 312
    Top = 32
  end
  object InsertPub: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'UPDATE PUBLIC'
      '                    SET MESSAGE=:MESSAGE'
      '                    WHERE  ID=:ID;')
    Left = 64
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'MESSAGE'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ID'
        ParamType = ptUnknown
      end>
  end
  object PosMembers1: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT MESSAGE FROM PUBLIC'
      'where((MEMBER1=:MEMBER1) and (MEMBER2=:MEMBER2))')
    Left = 112
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'MEMBER1'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'MEMBER2'
        ParamType = ptUnknown
      end>
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 864
  end
  object InsertPrivate: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'UPDATE PUBLIC'
      '                    SET MESSAGE=:MESSAGE'
      
        '                    WHERE  ((MEMBER1=:MEMBER1 and MEMBER2=:MEMBE' +
        'R2) or (MEMBER1=:MEMBER2 and MEMBER2=:MEMBER1))')
    Left = 96
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'MESSAGE'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'MEMBER1'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'MEMBER2'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'MEMBER2'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'MEMBER1'
        ParamType = ptUnknown
      end>
  end
  object PosMembers2: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT MESSAGE FROM PUBLIC'
      'where ((MEMBER1=:MEMBER2) and (MEMBER2=:MEMBER1))')
    Left = 128
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'MEMBER2'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'MEMBER1'
        ParamType = ptUnknown
      end>
  end
end
