object DMTicket: TDMTicket
  OldCreateOrder = False
  Height = 547
  Width = 525
  object FDQryTicket: TFDQuery
    Left = 72
    Top = 80
  end
  object DSTicket: TDataSource
    DataSet = FDQryTicket
    Left = 112
    Top = 288
  end
end
