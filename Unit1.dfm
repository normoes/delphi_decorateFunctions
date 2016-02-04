object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 342
  ClientWidth = 825
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 120
    Top = 24
    Width = 217
    Height = 58
    Caption = 'decorated with ShowMessage'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 120
    Top = 104
    Width = 217
    Height = 57
    Caption = 'decorated with logging outputs'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Memo1: TMemo
    Left = 400
    Top = 24
    Width = 401
    Height = 289
    Lines.Strings = (
      'Memo1')
    TabOrder = 2
  end
end
