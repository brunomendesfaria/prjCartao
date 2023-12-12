object DMTicket: TDMTicket
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 547
  Width = 525
  object DSTicket: TDataSource
    DataSet = CliTicket
    Left = 72
    Top = 48
  end
  object CliTicket: TClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    Left = 56
    Top = 32
    object CliTicketNUMERO: TStringField
      FieldName = 'NUMERO'
      Size = 9
    end
    object CliTicketDATA_CORTE: TStringField
      FieldName = 'DATA_CORTE'
      Size = 10
    end
    object CliTicketDATA_CREDITO_DEBITO: TStringField
      FieldName = 'DATA_CREDITO_DEBITO'
      Size = 10
    end
    object CliTicketCOD_ESTABELECIMENTO: TStringField
      FieldName = 'COD_ESTABELECIMENTO'
      Size = 7
    end
    object CliTicketDATA_TRANSACAO: TStringField
      FieldName = 'DATA_TRANSACAO'
      Size = 10
    end
    object CliTicketDATA_POSTAGEM: TStringField
      FieldName = 'DATA_POSTAGEM'
      Size = 10
    end
    object CliTicketNUMERO_DOCTO: TStringField
      FieldName = 'NUMERO_DOCTO'
      Size = 6
    end
    object CliTicketTIPO_TRANSACAO: TStringField
      FieldName = 'TIPO_TRANSACAO'
      Size = 3
    end
    object CliTicketDESCRICAO_LANCAMENTO: TStringField
      FieldName = 'DESCRICAO_LANCAMENTO'
      Size = 25
    end
    object CliTicketNUMERO_CARTAO: TStringField
      FieldName = 'NUMERO_CARTAO'
      Size = 16
    end
    object CliTicketVALOR: TStringField
      FieldName = 'VALOR'
      Size = 25
    end
    object CliTicketFLG_ENCONTRADO: TBooleanField
      FieldName = 'FLG_ENCONTRADO'
    end
    object CliTicketCOD_INTERNO: TIntegerField
      FieldName = 'COD_INTERNO'
    end
    object CliTicketVAL_REP: TFloatField
      FieldName = 'VAL_REP'
      DisplayFormat = '#,##0.00'
    end
  end
  object CliTicketValores: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 72
    Top = 112
    object CliTicketValoresDESCRICAO_EVENTO: TStringField
      FieldName = 'DESCRICAO_EVENTO'
      Size = 50
    end
    object CliTicketValoresVALOR: TFloatField
      FieldName = 'VALOR'
    end
    object CliTicketValoresDATA: TDateField
      FieldName = 'DATA'
    end
  end
  object DSTicketValores: TDataSource
    DataSet = CliTicketValores
    Left = 88
    Top = 136
  end
  object CliTicketTaxaSint: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 184
    Top = 112
    object StringField1: TStringField
      FieldName = 'DESCRICAO_EVENTO'
      Size = 50
    end
    object FloatField1: TFloatField
      FieldName = 'VALOR'
    end
    object DateField1: TDateField
      FieldName = 'DATA'
    end
    object CliTicketTaxaSintSUBTOTAL: TFloatField
      FieldName = 'SUBTOTAL'
    end
  end
  object DSTicketTaxaSint: TDataSource
    DataSet = CliTicketTaxaSint
    Left = 184
    Top = 136
  end
  object CliTicketDataCredito: TClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    Left = 160
    Top = 40
    object StringField4: TStringField
      FieldName = 'DATA_CREDITO_DEBITO'
      Size = 10
    end
  end
end
