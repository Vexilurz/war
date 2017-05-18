object fmMain: TfmMain
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Sender'
  ClientHeight = 145
  ClientWidth = 572
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    572
    145)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 38
    Width = 24
    Height = 13
    Caption = 'Port:'
  end
  object Label2: TLabel
    Left = 8
    Top = 11
    Width = 39
    Height = 13
    Caption = 'Dest IP:'
  end
  object Label3: TLabel
    Left = 8
    Top = 66
    Width = 25
    Height = 13
    Caption = 'Cmd:'
  end
  object Label4: TLabel
    Left = 180
    Top = 11
    Width = 49
    Height = 13
    Caption = 'String #1:'
  end
  object Label5: TLabel
    Left = 180
    Top = 38
    Width = 49
    Height = 13
    Caption = 'String #2:'
  end
  object Label6: TLabel
    Left = 8
    Top = 93
    Width = 35
    Height = 13
    Caption = 'Our IP:'
  end
  object bnSend: TButton
    Left = 53
    Top = 114
    Width = 121
    Height = 25
    Caption = 'Send'
    TabOrder = 0
    OnClick = bnSendClick
  end
  object cbCmd: TComboBox
    Left = 53
    Top = 63
    Width = 121
    Height = 21
    ItemIndex = 0
    TabOrder = 1
    Text = 'Check service'
    Items.Strings = (
      'Check service'
      'ShellExecute'
      'Create file'
      'Delete file'
      'WriteLn file'
      'Copy file'
      'FileExists'
      'MkDir')
  end
  object sePort: TSpinEdit
    Left = 53
    Top = 35
    Width = 121
    Height = 22
    MaxValue = 65535
    MinValue = 0
    TabOrder = 2
    Value = 59148
  end
  object edIP: TEdit
    Left = 53
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 3
    Text = '192.168.0.2'
  end
  object edStr1: TEdit
    Left = 240
    Top = 8
    Width = 324
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 4
    ExplicitWidth = 397
  end
  object edStr2: TEdit
    Left = 240
    Top = 35
    Width = 324
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 5
    ExplicitWidth = 397
  end
  object edOurIP: TEdit
    Left = 53
    Top = 90
    Width = 121
    Height = 21
    TabOrder = 6
    Text = '192.168.0.1'
  end
  object IdUDPServer1: TIdUDPServer
    Active = True
    Bindings = <>
    DefaultPort = 59147
    ThreadedEvent = True
    OnUDPRead = IdUDPServer1UDPRead
    Left = 200
    Top = 64
  end
end
