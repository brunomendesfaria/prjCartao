object DMTicket: TDMTicket
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 547
  Width = 525
  object DSTicket: TDataSource
    DataSet = CliTicket
    Left = 120
    Top = 40
  end
  object CliTicket: TClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    Left = 56
    Top = 32
    object CliTicketFLG_ENCONTRADO: TBooleanField
      FieldName = 'FLG_ENCONTRADO'
    end
    object CliTicketPRODUTO: TStringField
      FieldName = 'PRODUTO'
      Size = 25
    end
    object CliTicketDATA_TRANSACAO: TDateField
      FieldName = 'DATA_TRANSACAO'
    end
    object CliTicketCOD_INTERNO: TIntegerField
      FieldName = 'COD_INTERNO'
    end
    object CliTicketVALOR: TStringField
      FieldName = 'VALOR'
      Size = 25
    end
  end
end
