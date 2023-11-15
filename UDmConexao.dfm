object DmConexao: TDmConexao
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  Height = 418
  Width = 510
  object FDConnection: TFDConnection
    Params.Strings = (
      'User_Name=intersolid'
      'Password=1nt3rs0l1d'
      'Database=PIANTA'
      'DriverID=Ora')
    LoginPrompt = False
    UpdateTransaction = FDTransaction
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
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 40
    Top = 197
  end
end
