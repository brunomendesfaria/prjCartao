object DmConexao: TDmConexao
  OldCreateOrder = False
  Height = 309
  Width = 427
  object FDConnection: TFDConnection
    Params.Strings = (
      'User_Name=intersolid'
      'Password=1nt3rs0l1d'
      'Database=pianta'
      'DriverID=Ora')
    Connected = True
    LoginPrompt = False
    Left = 24
    Top = 16
  end
  object FDTransaction: TFDTransaction
    Connection = FDConnection
    Left = 32
    Top = 64
  end
  object FDPhysOracleDriverLink1: TFDPhysOracleDriverLink
    Left = 39
    Top = 128
  end
end
