object DmGetNet: TDmGetNet
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  Height = 289
  Width = 292
  object qryCartao: TFDQuery
    Connection = DmConexao.FDConnection
    Left = 16
    Top = 8
  end
  object ClientDataSetGetNet: TClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    Left = 80
    Top = 78
    object ClientDataSetGetNetCODIGO_CENTRALIZADOR: TStringField
      DisplayLabel = 'Cod. Centr.'
      FieldName = 'CODIGO_CENTRALIZADOR'
      Size = 10
    end
    object ClientDataSetGetNetCODIGO: TStringField
      DisplayLabel = 'Cod.'
      FieldName = 'CODIGO'
      Size = 10
    end
    object ClientDataSetGetNetVENCIMENTO: TStringField
      DisplayLabel = 'Vencimento'
      FieldName = 'VENCIMENTO'
      Size = 10
    end
    object ClientDataSetGetNetVENCIMENTO_ORIGINAL: TStringField
      DisplayLabel = 'Venc. Original'
      FieldName = 'VENCIMENTO_ORIGINAL'
      Size = 15
    end
    object ClientDataSetGetNetPRODUTO: TStringField
      DisplayLabel = 'Produto'
      FieldName = 'PRODUTO'
      Size = 25
    end
    object ClientDataSetGetNetLANCAMENTO: TStringField
      DisplayLabel = 'Lan'#231'amento'
      FieldName = 'LANCAMENTO'
      Size = 25
    end
    object ClientDataSetGetNetPLANO_VENDA: TStringField
      DisplayLabel = 'Plano Venda'
      FieldName = 'PLANO_VENDA'
      Size = 25
    end
    object ClientDataSetGetNetPARCELA: TStringField
      DisplayLabel = 'Parcela'
      FieldName = 'PARCELA'
      Size = 3
    end
    object ClientDataSetGetNetTOTAL_PARCELA: TStringField
      DisplayLabel = 'Tot. Parc.'
      FieldName = 'TOTAL_PARCELA'
      Size = 3
    end
    object ClientDataSetGetNetCARTAO: TStringField
      DisplayLabel = 'Cart'#227'o'
      FieldName = 'CARTAO'
      Size = 25
    end
    object ClientDataSetGetNetAUTORIZACAO: TStringField
      DisplayLabel = 'Autoriza'#231#227'o'
      FieldName = 'AUTORIZACAO'
      Size = 15
    end
    object ClientDataSetGetNetNUMERO_CV: TStringField
      DisplayLabel = 'N'#250'm. CV'
      FieldName = 'NUMERO_CV'
      Size = 15
    end
    object ClientDataSetGetNetTERMINAL: TStringField
      DisplayLabel = 'Terminal'
      FieldName = 'TERMINAL'
      Size = 15
    end
    object ClientDataSetGetNetDATA_VENDA: TStringField
      DisplayLabel = 'Data Venda'
      FieldName = 'DATA_VENDA'
      Size = 15
    end
    object ClientDataSetGetNetFLG_ENCONTRADO: TBooleanField
      FieldName = 'FLG_ENCONTRADO'
    end
    object ClientDataSetGetNetvalLiquido: TFloatField
      FieldName = 'valLiquido'
    end
    object ClientDataSetGetNetVALOR_ORIGINAL: TFloatField
      FieldName = 'VALOR_ORIGINAL'
    end
    object ClientDataSetGetNetVALOR_BRUTO: TFloatField
      FieldName = 'VALOR_BRUTO'
    end
    object ClientDataSetGetNetDESCONTO: TFloatField
      FieldName = 'DESCONTO'
    end
    object ClientDataSetGetNetLIQUIDO: TFloatField
      FieldName = 'LIQUIDO'
    end
    object ClientDataSetGetNetCOD_INTERNO: TIntegerField
      FieldName = 'COD_INTERNO'
    end
    object ClientDataSetGetNetQTDREGARQ: TAggregateField
      FieldName = 'QTDREGARQ'
      Active = True
      DisplayName = ''
      Expression = 'count(*)'
    end
    object ClientDataSetGetNetVALTOTAL: TAggregateField
      FieldName = 'VALTOTAL'
      Active = True
      DisplayName = ''
      Expression = 'SUM(VALOR_BRUTO)'
    end
  end
  object DataSourceGetNet: TDataSource
    DataSet = ClientDataSetGetNet
    Left = 85
    Top = 30
  end
end
