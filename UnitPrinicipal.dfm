object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Conciliador'
  ClientHeight = 761
  ClientWidth = 1510
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 1510
    Height = 174
    Align = alTop
    TabOrder = 0
    object Label2: TLabel
      Left = 172
      Top = 89
      Width = 68
      Height = 13
      Caption = 'Qtd Reg. Arq.'
    end
    object Label3: TLabel
      Left = 316
      Top = 89
      Width = 70
      Height = 13
      Caption = 'Qtd Reg. ERP.'
    end
    object Label1: TLabel
      Left = 468
      Top = 91
      Width = 71
      Height = 13
      Caption = 'Val. Bruto Arq.'
    end
    object Label4: TLabel
      Left = 612
      Top = 91
      Width = 70
      Height = 13
      Caption = 'Val. Bruto Erp.'
    end
    object DataPagtoTicket: TLabel
      Left = 336
      Top = 16
      Width = 85
      Height = 13
      Caption = 'Data Pagto Ticket'
      Visible = False
    end
    object Button1: TButton
      Left = 8
      Top = 64
      Width = 89
      Height = 25
      Caption = 'Buscar Arquivo'
      TabOrder = 0
      OnClick = Button1Click
    end
    object ComboBoxAdm: TComboBox
      Left = 5
      Top = 13
      Width = 145
      Height = 21
      TabOrder = 1
      Text = 'Selciona Adminstradora'
      OnChange = ComboBoxAdmChange
      Items.Strings = (
        'GetNet'
        'Ticket'
        'Bin'
        'Cielo'
        'Rede'
        'Sodexo Alimenta Pas'
        'VR')
    end
    object Edit1: TEdit
      Left = 8
      Top = 40
      Width = 969
      Height = 21
      Enabled = False
      TabOrder = 2
      Text = 'Edit1'
    end
    object ButtonImportar: TButton
      Left = 5
      Top = 139
      Width = 75
      Height = 25
      Caption = 'Importar'
      Enabled = False
      TabOrder = 3
      OnClick = ButtonImportarClick
    end
    object EditCodLoja: TEdit
      Left = 110
      Top = 65
      Width = 121
      Height = 21
      TabOrder = 4
      Text = 'Num. Loja'
    end
    object DBEdit2: TDBEdit
      Left = 316
      Top = 104
      Width = 121
      Height = 21
      DataField = 'QtdRegErp'
      DataSource = DmRetaguarda.DataSourceCartao
      TabOrder = 5
    end
    object DBEdit4: TDBEdit
      Left = 614
      Top = 105
      Width = 121
      Height = 21
      DataField = 'val_bruto'
      DataSource = DmRetaguarda.DataSourceCartao
      TabOrder = 6
    end
    object DBEditQtdRegArq: TDBEdit
      Left = 172
      Top = 105
      Width = 121
      Height = 21
      DataField = 'QTDREGARQ'
      DataSource = DmGetNet.DataSourceGetNet
      TabOrder = 7
    end
    object DBEdit3: TDBEdit
      Left = 468
      Top = 105
      Width = 121
      Height = 21
      DataField = 'valTotal'
      DataSource = DmGetNet.DataSourceGetNet
      TabOrder = 8
    end
    object ButtonLimpar: TButton
      Left = 240
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Limpar tela'
      TabOrder = 9
      OnClick = ButtonLimparClick
    end
    object BtnGeraBodero: TButton
      Left = 86
      Top = 139
      Width = 75
      Height = 25
      Caption = 'Gera Bord.'
      Enabled = False
      TabOrder = 10
      OnClick = BtnGeraBoderoClick
    end
    object RadioGroup: TRadioGroup
      Left = 8
      Top = 88
      Width = 153
      Height = 45
      Caption = 'Venda / Pagamento'
      Columns = 2
      Items.Strings = (
        'Venda'
        'Pagamento')
      TabOrder = 11
    end
    object DtaPagtoTicket: TDateTimePicker
      Left = 427
      Top = 13
      Width = 186
      Height = 21
      Date = 45238.000000000000000000
      Time = 0.793764201385784000
      TabOrder = 12
      Visible = False
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 174
    Width = 1306
    Height = 587
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 1
    object PageControlCartao: TPageControl
      Left = 1
      Top = 1
      Width = 1304
      Height = 585
      ActivePage = TabSheet2
      Align = alClient
      TabOrder = 0
      OnChange = PageControlCartaoChange
      object TabSheet1: TTabSheet
        Caption = 'Administradora'
        object DBGridBin: TDBGrid
          Left = 0
          Top = 0
          Width = 1296
          Height = 557
          Align = alClient
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'CNPJ'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DES_FANTASIA'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DES_RAZAO_SOCIAL'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'REDE_CAPTURA'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DESCRICAO'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NUM_CARTAO'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NUM_AUTORIZACAO'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DATA_TRANSACAO'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DATA_PAGAMENTO'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DATA_PROCESSAMENTO'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VAL_BRUTO'
              Visible = True
            end>
        end
        object DBGridGetNet: TDBGrid
          Left = 0
          Top = 0
          Width = 1296
          Height = 557
          Align = alClient
          DataSource = DmGetNet.DataSourceGetNet
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnDrawDataCell = DBGridGetNetDrawDataCell
          Columns = <
            item
              Expanded = False
              FieldName = 'CODIGO_CENTRALIZADOR'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CODIGO'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VENCIMENTO'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VENCIMENTO_ORIGINAL'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PRODUTO'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'LANCAMENTO'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PLANO_VENDA'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PARCELA'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TOTAL_PARCELA'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CARTAO'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'AUTORIZACAO'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NUMERO_CV'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TERMINAL'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DATA_VENDA'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VALOR_ORIGINAL'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VALOR_BRUTO'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DESCONTO'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'LIQUIDO'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'FLG_ENCONTRADO'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'COD_INTERNO'
              Width = 64
              Visible = True
            end>
        end
        object DBGridCielo: TDBGrid
          Left = 0
          Top = 0
          Width = 1296
          Height = 557
          Align = alClient
          DataSource = DataSourceCielo
          TabOrder = 2
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
        end
        object DBGridAdministradora: TDBGrid
          Left = 0
          Top = 0
          Width = 1296
          Height = 557
          Align = alClient
          BorderStyle = bsNone
          DataSource = DataSourceAdministradora
          TabOrder = 3
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnDrawColumnCell = DBGridAdministradoraDrawColumnCell
          Columns = <
            item
              Expanded = False
              FieldName = 'CNPJ'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'RAZAO_SOCIAL'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DATA_TRANSACAO'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DATA_PROCESSAMENTO'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'REDE_CAPTURA'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DESCRICAO'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NUM_CARTAO'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NUM_AUTORIZACAO'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VALOR_BRUTO'
              Visible = True
            end>
        end
        object DBGridTicket: TDBGrid
          Left = 0
          Top = 0
          Width = 1296
          Height = 557
          Align = alClient
          DataSource = DMTicket.DSTicket
          TabOrder = 4
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'NUMERO'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DATA_CORTE'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DATA_CREDITO_DEBITO'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'COD_ESTABELECIMENTO'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DATA_TRANSACAO'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DATA_POSTAGEM'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NUMERO_DOCTO'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TIPO_TRANSACAO'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DESCRICAO_LANCAMENTO'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NUMERO_CARTAO'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VALOR'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'FLG_ENCONTRADO'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'COD_INTERNO'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VAL_REP'
              Visible = True
            end>
        end
        object DBGridVR: TDBGrid
          Left = 0
          Top = 0
          Width = 1296
          Height = 557
          Align = alClient
          TabOrder = 5
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Columns = <
            item
              Alignment = taRightJustify
              Expanded = False
              Title.Caption = 'TesteVR'
              Visible = True
            end
            item
              Expanded = False
              Visible = True
            end>
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Intersolid E.R.P'
        ImageIndex = 1
        object DBGrid1: TDBGrid
          Left = 0
          Top = 0
          Width = 1296
          Height = 557
          Align = alClient
          DataSource = DmRetaguarda.DataSourceCartao
          PopupMenu = PopupMenu
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnDrawColumnCell = DBGrid1DrawColumnCell
          OnMouseDown = DBGrid1MouseDown
          Columns = <
            item
              Expanded = False
              FieldName = 'NUM_CGC'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DES_PARCEIRO'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'COD_BANDEIRA'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DTA_EMISSAO'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DTA_ENTRADA'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DTA_VENCIMENTO'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VAL_LIQUIDO'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'COD_ADMINISTRADORA_TEF'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NUM_BIN_TEF'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NUM_NSU_HOST_TEF'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'COD_TRANSACAO_TEF'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'COD_INSTITUICAO_TEF'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'COD_BANDEIRA_TEF'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NUM_NSU_SITEF'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'COD_AUTORIZACAO_TEF'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'COD_ESTABELECIMENTO_TEF'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DES_LOJA'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'COD_CHAVE'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NUM_BORDERO'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'COD_PARCEIRO'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DES_BANDEIRA'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VAL_PARCELA'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VAL_TOTAL_NF'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NUM_PARCELA'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'QTD_PARCELA'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'COD_INTERNO'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'FLG_ENCONTRADO'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'FLG_QUITADO'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'FLG_UPDATE'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'FLG_DATA_VENC'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'FLG_VAL_LIQUIDO'
              Visible = True
            end>
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'Cart'#227'o / Bandeira'
        ImageIndex = 2
        object DBGrid2: TDBGrid
          Left = 0
          Top = 0
          Width = 1296
          Height = 557
          Align = alClient
          DataSource = DmRetaguarda.DataSourceCartaoBandeira
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'COD_ADMINISTRADORA'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DES_ADMINISTRADORA'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'COD_BANDEIRA'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DES_BANDEIRA'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DATA_VENCIMENTO'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DATA_VENDA'
              Width = 64
              Visible = True
            end>
        end
      end
      object TabSheetTicketValores: TTabSheet
        Caption = 'Ticket Valores por Data'
        ImageIndex = 3
        object DBGTicketValores: TDBGrid
          Left = 0
          Top = 0
          Width = 1296
          Height = 557
          Align = alClient
          DataSource = DMTicket.DSTicketValores
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'DESCRICAO_EVENTO'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VALOR'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DATA'
              Visible = True
            end>
        end
        object DBGridTciketTaxaSint: TDBGrid
          Left = 536
          Top = 3
          Width = 465
          Height = 352
          DataSource = DMTicket.DSTicketTaxaSint
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Visible = False
          Columns = <
            item
              Expanded = False
              FieldName = 'DESCRICAO_EVENTO'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VALOR'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DATA'
              Visible = True
            end>
        end
      end
    end
  end
  object Panel3: TPanel
    Left = 1306
    Top = 174
    Width = 204
    Height = 587
    Align = alRight
    TabOrder = 2
    object Memo1: TMemo
      Left = 1
      Top = 249
      Width = 202
      Height = 337
      Align = alClient
      Color = clCream
      Ctl3D = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Lines.Strings = (
        'Memo1')
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
    end
    object Panel5: TPanel
      Left = 1
      Top = 1
      Width = 202
      Height = 248
      Align = alTop
      TabOrder = 1
      object Label5: TLabel
        Left = 5
        Top = 16
        Width = 99
        Height = 13
        Caption = 'Importando arquivo.'
      end
      object Label6: TLabel
        Left = 5
        Top = 64
        Width = 86
        Height = 13
        Caption = 'Buscando registro'
      end
      object Label7: TLabel
        Left = 5
        Top = 112
        Width = 82
        Height = 13
        Caption = 'Gerando Bordero'
      end
      object ProgressBar1: TProgressBar
        Left = 5
        Top = 35
        Width = 180
        Height = 17
        TabOrder = 0
      end
      object ProgressBar2: TProgressBar
        Left = 5
        Top = 83
        Width = 180
        Height = 17
        TabOrder = 1
      end
      object ProgressBar3: TProgressBar
        Left = 5
        Top = 131
        Width = 180
        Height = 17
        TabOrder = 2
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 192
  end
  object ClientDataSetCielo: TClientDataSet
    PersistDataPacket.Data = {
      3D0400009619E0BD0100000018000000200000000000030000003D0406535441
      5455530100490000000100055749445448020002000F000F5449504F5F4C414E
      43414D454E544F01004900000001000557494454480200020019000944455343
      524943414F01004900000001000557494454480200020032000542414E434F01
      00490000000100055749445448020002003200074147454E4349410100490000
      000100055749445448020002000F0005434F4E54410100490000000100055749
      4454480200020019000747524156414D45010049000000010005574944544802
      0002000F0004434E504A01004900000001000557494454480200020019001243
      4E504A5F494E53545F4F5249475F4E4547010049000000010005574944544802
      0002001900124E4F4D455F494E53545F4F5249475F4E45470100490000000100
      0557494454480200020032000F4553544142454C4543494D454E544F01004900
      000001000557494454480200020019000E444154415F504147414D454E544F01
      00490000000100055749445448020002000A000F444154415F4C414E43414D45
      4E544F0100490000000100055749445448020002000A000842414E4445495241
      01004900000001000557494454480200020019000F464F524D415F504147414D
      454E544F0100490000000100055749445448020002000F000E4E554D45524F5F
      50415243454C410100490000000100055749445448020002000200125155414E
      5449444144455F50415243454C41010049000000010005574944544802000200
      02000D4E554D45524F5F43415254414F01004900000001000557494454480200
      020019000D434F445F5452414E534143414F0100490000000100055749445448
      020002000F000F434F445F4155544F52495A4143414F01004900000001000557
      49445448020002001900034E5355010049000000010005574944544802000200
      0F000B56414C4F525F425255544F010049000000010005574944544802000200
      0F000D56414C4F525F4C49515549444F01004900000001000557494454480200
      02000F000D56414C4F525F434F425241444F0100490000000100055749445448
      020002000F000E56414C4F525F50454E44454E54450100490000000100055749
      445448020002000F000B56414C4F525F544F54414C0100490000000100055749
      445448020002000F000F524553554D4F5F4F5045524143414F01004900000001
      00055749445448020002000F0009434F445F56454E4441010049000000010005
      5749445448020002000F000E4E554D45524F5F4D415155494E41010049000000
      0100055749445448020002000F0013504552494F444F5F434F4E534944455241
      444F0100490000000100055749445448020002000F000F4E554D45524F5F4F50
      45524143414F0100490000000100055749445448020002000F0010544158415F
      414E54454349504143414F0100490000000100055749445448020002000A0000
      00}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 40
    Top = 288
    object ClientDataSetCieloSTATUS: TStringField
      DisplayLabel = 'Status'
      FieldName = 'STATUS'
      Size = 15
    end
    object ClientDataSetCieloTIPO_LANCAMENTO: TStringField
      DisplayLabel = 'Tipo Lanc.'
      FieldName = 'TIPO_LANCAMENTO'
      Size = 25
    end
    object ClientDataSetCieloDESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRICAO'
      Size = 50
    end
    object ClientDataSetCieloBANCO: TStringField
      DisplayLabel = 'Banco'
      FieldName = 'BANCO'
      Size = 50
    end
    object ClientDataSetCieloAGENCIA: TStringField
      DisplayLabel = 'Agencia'
      FieldName = 'AGENCIA'
      Size = 15
    end
    object ClientDataSetCieloCONTA: TStringField
      DisplayLabel = 'Conta'
      FieldName = 'CONTA'
      Size = 25
    end
    object ClientDataSetCieloGRAVAME: TStringField
      DisplayLabel = 'Gravame'
      FieldName = 'GRAVAME'
      Size = 15
    end
    object ClientDataSetCieloCNPJ_INST_ORIG_NEG: TStringField
      DisplayLabel = 'Cnpj Inst. Origem Negoc.'
      FieldName = 'CNPJ_INST_ORIG_NEG'
      Size = 25
    end
    object ClientDataSetCieloNOME_INST_ORIG_NEG: TStringField
      DisplayLabel = 'Nome Inst. Origem Negoc.'
      FieldName = 'NOME_INST_ORIG_NEG'
      Size = 50
    end
    object ClientDataSetCieloESTABELECIMENTO: TStringField
      DisplayLabel = 'Estabelecimento'
      FieldName = 'ESTABELECIMENTO'
      Size = 25
    end
    object ClientDataSetCieloDATA_PAGAMENTO: TStringField
      DisplayLabel = 'Data Pag.'
      FieldName = 'DATA_PAGAMENTO'
      Size = 10
    end
    object ClientDataSetCieloDATA_LANCAMENTO: TStringField
      DisplayLabel = 'Data Lanc.'
      FieldName = 'DATA_LANCAMENTO'
      Size = 10
    end
    object ClientDataSetCieloBANDEIRA: TStringField
      DisplayLabel = 'Bandeira'
      FieldName = 'BANDEIRA'
      Size = 25
    end
    object ClientDataSetCieloFORMA_PAGAMENTO: TStringField
      DisplayLabel = 'Forma Pagto.'
      FieldName = 'FORMA_PAGAMENTO'
      Size = 15
    end
    object ClientDataSetCieloNUMERO_PARCELA: TStringField
      DisplayLabel = 'Num. Parcela'
      FieldName = 'NUMERO_PARCELA'
      Size = 2
    end
    object ClientDataSetCieloQUANTIDADE_PARCELA: TStringField
      DisplayLabel = 'Qtde. Parcela'
      FieldName = 'QUANTIDADE_PARCELA'
      Size = 2
    end
    object ClientDataSetCieloNUMERO_CARTAO: TStringField
      DisplayLabel = 'Num. Cart'#227'o'
      FieldName = 'NUMERO_CARTAO'
      Size = 25
    end
    object ClientDataSetCieloCOD_TRANSACAO: TStringField
      DisplayLabel = 'Cod. Transa'#231#227'o'
      FieldName = 'COD_TRANSACAO'
      Size = 15
    end
    object ClientDataSetCieloCOD_AUTORIZACAO: TStringField
      DisplayLabel = 'Cod. Autoriza'#231#227'o'
      FieldName = 'COD_AUTORIZACAO'
      Size = 25
    end
    object ClientDataSetCieloNSU: TStringField
      DisplayLabel = 'Nsu'
      FieldName = 'NSU'
      Size = 15
    end
    object ClientDataSetCieloVALOR_BRUTO: TStringField
      DisplayLabel = 'Valor Bruto'
      FieldName = 'VALOR_BRUTO'
      Size = 15
    end
    object ClientDataSetCieloVALOR_LIQUIDO: TStringField
      DisplayLabel = 'Valor L'#237'quido'
      FieldName = 'VALOR_LIQUIDO'
      Size = 15
    end
    object ClientDataSetCieloVALOR_COBRADO: TStringField
      DisplayLabel = 'Valor Cobrado'
      FieldName = 'VALOR_COBRADO'
      Size = 15
    end
    object ClientDataSetCieloVALOR_PENDENTE: TStringField
      DisplayLabel = 'Valor Pendente'
      FieldName = 'VALOR_PENDENTE'
      Size = 15
    end
    object ClientDataSetCieloVALOR_TOTAL: TStringField
      DisplayLabel = 'Valor Total'
      FieldName = 'VALOR_TOTAL'
      Size = 15
    end
    object ClientDataSetCieloRESUMO_OPERACAO: TStringField
      DisplayLabel = 'Resumo Opera'#231#227'o'
      FieldName = 'RESUMO_OPERACAO'
      Size = 15
    end
    object ClientDataSetCieloCOD_VENDA: TStringField
      DisplayLabel = 'Cod. Venda'
      FieldName = 'COD_VENDA'
      Size = 15
    end
    object ClientDataSetCieloNUMERO_MAQUINA: TStringField
      DisplayLabel = 'Num. M'#225'quina'
      FieldName = 'NUMERO_MAQUINA'
      Size = 15
    end
    object ClientDataSetCieloPERIODO_CONSIDERADO: TStringField
      DisplayLabel = 'Per'#237'odo Considerado'
      FieldName = 'PERIODO_CONSIDERADO'
      Size = 15
    end
    object ClientDataSetCieloNUMERO_OPERACAO: TStringField
      DisplayLabel = 'Num. Opera'#231#227'o'
      FieldName = 'NUMERO_OPERACAO'
      Size = 15
    end
    object ClientDataSetCieloTAXA_ANTECIPACAO: TStringField
      DisplayLabel = 'Taxa Antecipa'#231#227'o'
      FieldName = 'TAXA_ANTECIPACAO'
      Size = 10
    end
  end
  object DataSourceCielo: TDataSource
    DataSet = ClientDataSetCielo
    Left = 64
    Top = 304
  end
  object DataSourceAdministradora: TDataSource
    DataSet = ClientDataSetAdministradora
    Left = 213
    Top = 232
  end
  object ClientDataSetAdministradora: TClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    AfterScroll = ClientDataSetAdministradoraAfterScroll
    Left = 205
    Top = 184
    object ClientDataSetAdministradoraCNPJ: TStringField
      FieldName = 'CNPJ'
      Size = 25
    end
    object ClientDataSetAdministradoraRAZAO_SOCIAL: TStringField
      FieldName = 'RAZAO_SOCIAL'
      Size = 50
    end
    object ClientDataSetAdministradoraDATA_TRANSACAO: TSQLTimeStampField
      FieldName = 'DATA_TRANSACAO'
    end
    object ClientDataSetAdministradoraDATA_PROCESSAMENTO: TSQLTimeStampField
      FieldName = 'DATA_PROCESSAMENTO'
    end
    object ClientDataSetAdministradoraREDE_CAPTURA: TStringField
      FieldName = 'REDE_CAPTURA'
      Size = 25
    end
    object ClientDataSetAdministradoraDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 25
    end
    object ClientDataSetAdministradoraNUM_CARTAO: TStringField
      FieldName = 'NUM_CARTAO'
      Size = 25
    end
    object ClientDataSetAdministradoraNUM_AUTORIZACAO: TStringField
      FieldName = 'NUM_AUTORIZACAO'
      Size = 12
    end
    object ClientDataSetAdministradoraVALOR_BRUTO: TStringField
      FieldName = 'VALOR_BRUTO'
      Size = 15
    end
    object ClientDataSetAdministradoraQTDREGARQ: TAggregateField
      FieldName = 'QTDREGARQ'
      Active = True
      DisplayName = ''
      Expression = 'COUNT(*)'
    end
    object ClientDataSetAdministradoraVAL_TOTAL: TAggregateField
      DefaultExpression = 'SUM(VALOR_BRUTO)'
      FieldName = 'VAL_TOTAL'
      Active = True
      DisplayName = ''
    end
  end
  object PopupMenu: TPopupMenu
    Left = 477
    Top = 282
    object Pesquisar: TMenuItem
      Caption = 'Pesquisar'
      OnClick = PesquisarClick
    end
  end
end
