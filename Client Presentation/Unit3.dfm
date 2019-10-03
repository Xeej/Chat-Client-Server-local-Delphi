object Form3: TForm3
  Left = 652
  Top = 365
  Width = 139
  Height = 267
  Caption = 'Color panel'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ColorBox1: TColorBox
    Left = 2
    Top = 0
    Width = 129
    Height = 22
    Style = [cbStandardColors]
    ItemHeight = 16
    TabOrder = 0
    OnChange = ColorBox1Change
  end
end
