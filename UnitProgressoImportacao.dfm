object FrmProgressoImportacao: TFrmProgressoImportacao
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Progresso da concilia'#231#227'o'
  ClientHeight = 226
  ClientWidth = 566
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 16
    Width = 99
    Height = 13
    Caption = 'Importando arquivo.'
  end
  object Label2: TLabel
    Left = 24
    Top = 64
    Width = 86
    Height = 13
    Caption = 'Buscando registro'
  end
  object Label3: TLabel
    Left = 24
    Top = 112
    Width = 82
    Height = 13
    Caption = 'Gerando Bordero'
  end
  object ProgressBar1: TProgressBar
    Left = 24
    Top = 35
    Width = 521
    Height = 17
    TabOrder = 0
  end
  object ProgressBar2: TProgressBar
    Left = 24
    Top = 83
    Width = 521
    Height = 17
    TabOrder = 1
  end
  object ProgressBar3: TProgressBar
    Left = 24
    Top = 131
    Width = 521
    Height = 17
    TabOrder = 2
  end
  object Button1: TButton
    Left = 470
    Top = 154
    Width = 75
    Height = 25
    Caption = 'Fechar'
    Enabled = False
    TabOrder = 3
    OnClick = Button1Click
  end
end
