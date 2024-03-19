unit UnitGetNet;

interface

uses
   System.Classes,DBClient, Vcl.Dialogs, System.SysUtils,Data.DB,System.UITypes,xprocs,
  Vcl.DBCtrls, Vcl.StdCtrls,Vcl.ComCtrls;

type TGetNet = class
  procedure importaArquivo(aCli: TClientDataSet; arquivo: TFileName; progress: TProgressBar);
  procedure importaArquivoVenda(aCli: TClientDataSet; arquivo: TFileName; progress: TProgressBar);
  function formatValor(val: String):String;
  function verificaCaracter(Origem,Caractere: String):boolean;
  procedure BuscaTitulos(aCli: TClientDataSet;ProgressBar: TProgressBar);
  procedure BuscaTitulosConcVenda(aCli: TClientDataSet;ProgressBar: TProgressBar);
  procedure GeraNumBordero(aMemo: TMemo);
  procedure GeraNumBorderoUnico(aMemo: TMemo);

  function CurrencyStringToFloat(Value: String): Double;
end;

implementation

{ TGetNet }

uses UDmRetaguarda, System.Variants, UnitProgressoImportacao, Data.DBXCommon,
  UDmConexao;


procedure TGetNet.BuscaTitulos(aCli: TClientDataSet;ProgressBar: TProgressBar);
var autorizacao: Integer;
begin
  try
    DmRetaguarda.ClientDataSetCartao.DisableControls;
    aCli.DisableControls;
    ProgressBar.Min:=0;
    aCli.First;
    with DmRetaguarda do
    begin
      ClientDataSetCartao.Open;
      ClientDataSetCartao.EmptyDataSet;
      ProgressBar.Max:= aCli.RecordCount;
      while not aCli.Eof do
      begin
        qryRetaguarda.Close;
        qryRetaguarda.ParamByName('NUM_CGC').AsString:= '03008421000157';
        qryRetaguarda.ParamByName('DTA_EMISSAO').AsDate:= aCli.FieldByName('DATA_VENDA').AsDateTime;
        qryRetaguarda.ParamByName('COD_AUTORIZACAO_TEF').AsString := iif(limpaLetras(aCli.FieldByName('AUTORIZACAO').AsString)='',0 ,limpaLetras(aCli.FieldByName('AUTORIZACAO').AsString));
        qryRetaguarda.ParamByName('VAL_PARCELA').AsFloat:= aCli.FieldByName('VALOR_BRUTO').AsFloat;
        qryRetaguarda.ParamByName('NUM_PARCELA').AsFloat:= aCli.FieldByName('PARCELA').AsFloat;
        qryRetaguarda.Open;

        if not(qryRetaguarda.IsEmpty) then
        begin
          ClientDataSetCartao.Append;
          ClientDataSetCartao.FieldByName('FLG_UPDATE').AsBoolean:= False;
          ClientDataSetCartao.FieldByName('NUM_CGC').AsString:= qryRetaguarda.FieldByName('NUM_CGC').AsString;
          ClientDataSetCartao.FieldByName('DES_LOJA').AsString:= qryRetaguarda.FieldByName('DES_LOJA').AsString;
          ClientDataSetCartao.FieldByName('DES_PARCEIRO').AsString:= qryRetaguarda.FieldByName('DES_PARCEIRO').AsString;
          ClientDataSetCartao.FieldByName('COD_BANDEIRA').AsInteger:= qryRetaguarda.FieldByName('COD_BANDEIRA').AsInteger;
          ClientDataSetCartao.FieldByName('DES_BANDEIRA').AsString:=  qryRetaguarda.FieldByName('DES_BANDEIRA').AsString;
          ClientDataSetCartao.FieldByName('DTA_EMISSAO').AsDateTime:= qryRetaguarda.FieldByName('DTA_EMISSAO').AsDateTime;
          ClientDataSetCartao.FieldByName('DTA_ENTRADA').AsDateTime:= qryRetaguarda.FieldByName('DTA_ENTRADA').AsDateTime;

          ClientDataSetCartao.FieldByName('DTA_VENCIMENTO').AsDateTime:= qryRetaguarda.FieldByName('DTA_VENCIMENTO').AsDateTime;
          if acli.FieldByName('VENCIMENTO').AsDateTime <>  qryRetaguarda.FieldByName('DTA_VENCIMENTO').AsDateTime then
          begin
            ClientDataSetCartao.FieldByName('DTA_VENCIMENTO').AsDateTime:= acli.FieldByName('VENCIMENTO').AsDateTime;
            ClientDataSetCartao.FieldByName('FLG_UPDATE').AsBoolean:= True;
            ClientDataSetCartao.FieldByName('FLG_DATA_VENC').AsBoolean:= True;
          end;

          ClientDataSetCartao.FieldByName('VAL_LIQUIDO').AsFloat:= qryRetaguarda.FieldByName('VAL_LIQUIDO').AsFloat;
          if qryRetaguardaVAL_LIQUIDO.AsFloat <> aCli.FieldByName('LIQUIDO').AsFloat then
          begin
            ClientDataSetCartao.FieldByName('VAL_LIQUIDO').AsFloat:= aCli.FieldByName('LIQUIDO').AsFloat;
            ClientDataSetCartao.FieldByName('FLG_VAL_LIQUIDO').AsBoolean:= True;
            ClientDataSetCartao.FieldByName('FLG_UPDATE').AsBoolean:= True;
          end;

          ClientDataSetCartao.FieldByName('VAL_PARCELA').AsFloat:= qryRetaguarda.FieldByName('VAL_PARCELA').AsFloat;
          ClientDataSetCartao.FieldByName('COD_ADMINISTRADORA_TEF').AsString:= qryRetaguarda.FieldByName('COD_ADMINISTRADORA_TEF').AsString;
          ClientDataSetCartao.FieldByName('NUM_BIN_TEF').AsString:= qryRetaguarda.FieldByName('NUM_BIN_TEF').AsString;
          ClientDataSetCartao.FieldByName('NUM_NSU_HOST_TEF').AsString:= qryRetaguarda.FieldByName('NUM_NSU_HOST_TEF').AsString;
          ClientDataSetCartao.FieldByName('COD_TRANSACAO_TEF').AsString:= qryRetaguarda.FieldByName('COD_TRANSACAO_TEF').AsString;
          ClientDataSetCartao.FieldByName('COD_INSTITUICAO_TEF').AsString:= qryRetaguarda.FieldByName('COD_INSTITUICAO_TEF').AsString;
          ClientDataSetCartao.FieldByName('COD_BANDEIRA_TEF').AsString:= qryRetaguarda.FieldByName('COD_BANDEIRA_TEF').AsString;
          ClientDataSetCartao.FieldByName('NUM_NSU_SITEF').AsString:= qryRetaguarda.FieldByName('NUM_NSU_SITEF').AsString;
          ClientDataSetCartao.FieldByName('COD_AUTORIZACAO_TEF').AsString:= qryRetaguarda.FieldByName('COD_AUTORIZACAO_TEF').AsString;
          ClientDataSetCartao.FieldByName('COD_ESTABELECIMENTO_TEF').AsString:= qryRetaguarda.FieldByName('COD_ESTABELECIMENTO_TEF').AsString;
          ClientDataSetCartao.FieldByName('VAL_TOTAL_NF').AsFloat:= qryRetaguarda.FieldByName('VAL_TOTAL_NF').AsFloat;
          ClientDataSetCartao.FieldByName('NUM_PARCELA').AsInteger:= qryRetaguarda.FieldByName('NUM_PARCELA').AsInteger;
          ClientDataSetCartao.FieldByName('QTD_PARCELA').AsInteger:= qryRetaguarda.FieldByName('QTD_PARCELA').AsInteger;
          ClientDataSetCartao.FieldByName('COD_PARCEIRO').AsInteger:= qryRetaguarda.FieldByName('COD_PARCEIRO').AsInteger;
          ClientDataSetCartao.FieldByName('COD_CHAVE').AsInteger:= qryRetaguarda.FieldByName('COD_CHAVE').AsInteger;
          ClientDataSetCartao.FieldByName('NUM_BORDERO').AsInteger:=  0;
          ClientDataSetCartao.FieldByName('COD_INTERNO').AsInteger:=  aCli.RecNo;
          ClientDataSetCartao.FieldByName('FLG_ENCONTRADO').AsBoolean:=  True;
          ClientDataSetCartao.FieldByName('FLG_QUITADO').AsString:=  qryRetaguarda.FieldByName('FLG_QUITADO').AsString;
          ClientDataSetCartao.Post;
        end;

        if qryRetaguarda.IsEmpty then
        begin
          qryRetaguarda2.Close;
          qryRetaguarda2.ParamByName('NUM_CGC').AsString:= '03008421000157';
          qryRetaguarda2.ParamByName('DTA_EMISSAO').AsDate:= aCli.FieldByName('DATA_VENDA').AsDateTime;
          qryRetaguarda2.ParamByName('VAL_PARCELA').AsFloat :=   aCli.FieldByName('VALOR_BRUTO').AsFloat;
          qryRetaguarda2.ParamByName('NUM_PARCELA').AsFloat:= aCli.FieldByName('PARCELA').AsFloat;
          qryRetaguarda2.Open;

          if not qryRetaguarda2.IsEmpty then
          begin

            if qryRetaguarda2.RecordCount > 1 then
            begin

              if (qryRetaguarda2.Locate('COD_PARCEIRO;COD_BANDEIRA;',
                VarArrayOf([ClientDataSetCartao.FieldByName('COD_PARCEIRO').AsInteger,
               ClientDataSetCartao.FieldByName('COD_BANDEIRA').AsInteger]),[])) then
               begin
                ClientDataSetCartao.Append;
                ClientDataSetCartao.FieldByName('FLG_UPDATE').AsBoolean:= False;
                ClientDataSetCartao.FieldByName('NUM_CGC').AsString:= qryRetaguarda2.FieldByName('NUM_CGC').AsString;
                ClientDataSetCartao.FieldByName('DES_LOJA').AsString:= qryRetaguarda2.FieldByName('DES_LOJA').AsString;
                ClientDataSetCartao.FieldByName('DES_PARCEIRO').AsString:= qryRetaguarda2.FieldByName('DES_PARCEIRO').AsString;
                ClientDataSetCartao.FieldByName('COD_BANDEIRA').AsInteger:= qryRetaguarda2.FieldByName('COD_BANDEIRA').AsInteger;
                ClientDataSetCartao.FieldByName('DES_BANDEIRA').AsString:=  qryRetaguarda2.FieldByName('DES_BANDEIRA').AsString;
                ClientDataSetCartao.FieldByName('DTA_EMISSAO').AsDateTime:= qryRetaguarda2.FieldByName('DTA_EMISSAO').AsDateTime;
                ClientDataSetCartao.FieldByName('DTA_ENTRADA').AsDateTime:= qryRetaguarda2.FieldByName('DTA_ENTRADA').AsDateTime;


                ClientDataSetCartao.FieldByName('DTA_VENCIMENTO').AsDateTime:= qryRetaguarda2.FieldByName('DTA_VENCIMENTO').AsDateTime;
                if acli.FieldByName('VENCIMENTO').AsDateTime <>  qryRetaguarda2.FieldByName('DTA_VENCIMENTO').AsDateTime then
                begin
                  ClientDataSetCartao.FieldByName('DTA_VENCIMENTO').AsDateTime:= acli.FieldByName('VENCIMENTO').AsDateTime;
                  ClientDataSetCartao.FieldByName('FLG_UPDATE').AsBoolean:= True;
                end;


                ClientDataSetCartao.FieldByName('VAL_LIQUIDO').AsFloat:= qryRetaguarda2.FieldByName('VAL_LIQUIDO').AsFloat;
                if qryRetaguarda2.FieldByName('VAL_LIQUIDO').AsFloat <> aCli.FieldByName('valliquido').AsFloat then
                begin
                  ClientDataSetCartao.FieldByName('VAL_LIQUIDO').AsFloat:= aCli.FieldByName('LIQUIDO').AsFloat;
                  ClientDataSetCartao.FieldByName('FLG_UPDATE').AsBoolean:= True;
                end;

                ClientDataSetCartao.FieldByName('VAL_PARCELA').AsFloat:= qryRetaguarda2.FieldByName('VAL_PARCELA').AsFloat;
                ClientDataSetCartao.FieldByName('COD_ADMINISTRADORA_TEF').AsString:= qryRetaguarda2.FieldByName('COD_ADMINISTRADORA_TEF').AsString;
                ClientDataSetCartao.FieldByName('NUM_BIN_TEF').AsString:= qryRetaguarda2.FieldByName('NUM_BIN_TEF').AsString;
                ClientDataSetCartao.FieldByName('NUM_NSU_HOST_TEF').AsString:= qryRetaguarda2.FieldByName('NUM_NSU_HOST_TEF').AsString;
                ClientDataSetCartao.FieldByName('COD_TRANSACAO_TEF').AsString:= qryRetaguarda2.FieldByName('COD_TRANSACAO_TEF').AsString;
                ClientDataSetCartao.FieldByName('COD_INSTITUICAO_TEF').AsString:= qryRetaguarda2.FieldByName('COD_INSTITUICAO_TEF').AsString;
                ClientDataSetCartao.FieldByName('COD_BANDEIRA_TEF').AsString:= qryRetaguarda2.FieldByName('COD_BANDEIRA_TEF').AsString;
                ClientDataSetCartao.FieldByName('NUM_NSU_SITEF').AsString:= qryRetaguarda2.FieldByName('NUM_NSU_SITEF').AsString;
                ClientDataSetCartao.FieldByName('COD_AUTORIZACAO_TEF').AsString:= qryRetaguarda2.FieldByName('COD_AUTORIZACAO_TEF').AsString;
                ClientDataSetCartao.FieldByName('COD_ESTABELECIMENTO_TEF').AsString:= qryRetaguarda2.FieldByName('COD_ESTABELECIMENTO_TEF').AsString;
                ClientDataSetCartao.FieldByName('VAL_TOTAL_NF').AsFloat:= qryRetaguarda2.FieldByName('VAL_TOTAL_NF').AsFloat;
                ClientDataSetCartao.FieldByName('NUM_PARCELA').AsInteger:= qryRetaguarda2.FieldByName('NUM_PARCELA').AsInteger;
                ClientDataSetCartao.FieldByName('QTD_PARCELA').AsInteger:= qryRetaguarda2.FieldByName('QTD_PARCELA').AsInteger;
                ClientDataSetCartao.FieldByName('COD_PARCEIRO').AsInteger:= qryRetaguarda2.FieldByName('COD_PARCEIRO').AsInteger;
                ClientDataSetCartao.FieldByName('COD_CHAVE').AsInteger:= qryRetaguarda2.FieldByName('COD_CHAVE').AsInteger;
                ClientDataSetCartao.FieldByName('NUM_BORDERO').AsInteger:=  0;
                ClientDataSetCartao.FieldByName('COD_INTERNO').AsInteger:=  aCli.RecNo;
                ClientDataSetCartao.FieldByName('FLG_ENCONTRADO').AsBoolean:=  True;
                ClientDataSetCartao.FieldByName('FLG_QUITADO').AsString:=  qryRetaguarda2.FieldByName('FLG_QUITADO').AsString;
                ClientDataSetCartao.Post;
                {ClientDataSetCartao.Append;
                ClientDataSetCartao.FieldByName('NUM_CGC').AsString:= '0';
                ClientDataSetCartao.FieldByName('DES_LOJA').AsString:= '0';
                ClientDataSetCartao.FieldByName('DES_PARCEIRO').AsString:= 'Selecionar Registro tem mais de 1 !';
                ClientDataSetCartao.FieldByName('COD_BANDEIRA').AsInteger:= 0;
                ClientDataSetCartao.FieldByName('DES_BANDEIRA').AsString:=  '0';
                ClientDataSetCartao.FieldByName('DTA_EMISSAO').AsDateTime:= Now;
                ClientDataSetCartao.FieldByName('DTA_ENTRADA').AsDateTime:= Now;
                ClientDataSetCartao.FieldByName('DTA_VENCIMENTO').AsDateTime:= Now;
                ClientDataSetCartao.FieldByName('VAL_PARCELA').AsFloat:= 0;
                ClientDataSetCartao.FieldByName('VAL_LIQUIDO').AsFloat:= 0;
                ClientDataSetCartao.FieldByName('COD_ADMINISTRADORA_TEF').AsString:= '0';
                ClientDataSetCartao.FieldByName('NUM_BIN_TEF').AsString:= '0';
                ClientDataSetCartao.FieldByName('NUM_NSU_HOST_TEF').AsString:= '0';
                ClientDataSetCartao.FieldByName('COD_TRANSACAO_TEF').AsString:='0';
                ClientDataSetCartao.FieldByName('COD_INSTITUICAO_TEF').AsString:= '0';
                ClientDataSetCartao.FieldByName('COD_BANDEIRA_TEF').AsString:= '0';
                ClientDataSetCartao.FieldByName('NUM_NSU_SITEF').AsString:= '0';
                ClientDataSetCartao.FieldByName('COD_AUTORIZACAO_TEF').AsString:= '0';
                ClientDataSetCartao.FieldByName('COD_ESTABELECIMENTO_TEF').AsString:= '0';
                ClientDataSetCartao.FieldByName('VAL_TOTAL_NF').AsFloat:= 0;
                ClientDataSetCartao.FieldByName('NUM_PARCELA').AsInteger:= 0;
                ClientDataSetCartao.FieldByName('QTD_PARCELA').AsInteger:= 0;
                ClientDataSetCartao.FieldByName('COD_PARCEIRO').AsInteger:= 0;
                ClientDataSetCartao.FieldByName('COD_CHAVE').AsInteger:= 0;
                ClientDataSetCartao.FieldByName('NUM_BORDERO').AsInteger:=  0;
                ClientDataSetCartao.FieldByName('COD_INTERNO').AsInteger:=  aCli.RecNo;
                ClientDataSetCartao.FieldByName('FLG_ENCONTRADO').AsBoolean:=  False; }
               end;

            end;
            if qryRetaguarda2.RecordCount = 1 then
            begin
              ClientDataSetCartao.Append;
              ClientDataSetCartao.FieldByName('FLG_UPDATE').AsBoolean:= False;
              ClientDataSetCartao.FieldByName('NUM_CGC').AsString:= qryRetaguarda2.FieldByName('NUM_CGC').AsString;
              ClientDataSetCartao.FieldByName('DES_LOJA').AsString:= qryRetaguarda2.FieldByName('DES_LOJA').AsString;
              ClientDataSetCartao.FieldByName('DES_PARCEIRO').AsString:= qryRetaguarda2.FieldByName('DES_PARCEIRO').AsString;
              ClientDataSetCartao.FieldByName('COD_BANDEIRA').AsInteger:= qryRetaguarda2.FieldByName('COD_BANDEIRA').AsInteger;
              ClientDataSetCartao.FieldByName('DES_BANDEIRA').AsString:=  qryRetaguarda2.FieldByName('DES_BANDEIRA').AsString;
              ClientDataSetCartao.FieldByName('DTA_EMISSAO').AsDateTime:= qryRetaguarda2.FieldByName('DTA_EMISSAO').AsDateTime;
              ClientDataSetCartao.FieldByName('DTA_ENTRADA').AsDateTime:= qryRetaguarda2.FieldByName('DTA_ENTRADA').AsDateTime;


              ClientDataSetCartao.FieldByName('DTA_VENCIMENTO').AsDateTime:= qryRetaguarda2.FieldByName('DTA_VENCIMENTO').AsDateTime;
              if acli.FieldByName('VENCIMENTO').AsDateTime <>  qryRetaguarda2.FieldByName('DTA_VENCIMENTO').AsDateTime then
              begin
                ClientDataSetCartao.FieldByName('DTA_VENCIMENTO').AsDateTime:= acli.FieldByName('VENCIMENTO').AsDateTime;
                ClientDataSetCartao.FieldByName('FLG_UPDATE').AsBoolean:= True;
              end;

              ClientDataSetCartao.FieldByName('VAL_LIQUIDO').AsFloat:= qryRetaguarda2.FieldByName('VAL_LIQUIDO').AsFloat;
              if qryRetaguarda2.FieldByName('VAL_LIQUIDO').AsFloat <> aCli.FieldByName('valliquido').AsFloat then
              begin
                ClientDataSetCartao.FieldByName('VAL_LIQUIDO').AsFloat:= aCli.FieldByName('LIQUIDO').AsFloat;
                ClientDataSetCartao.FieldByName('FLG_UPDATE').AsBoolean:= True;
              end;

              ClientDataSetCartao.FieldByName('VAL_PARCELA').AsFloat:= qryRetaguarda2.FieldByName('VAL_PARCELA').AsFloat;
              ClientDataSetCartao.FieldByName('COD_ADMINISTRADORA_TEF').AsString:= qryRetaguarda2.FieldByName('COD_ADMINISTRADORA_TEF').AsString;
              ClientDataSetCartao.FieldByName('NUM_BIN_TEF').AsString:= qryRetaguarda2.FieldByName('NUM_BIN_TEF').AsString;
              ClientDataSetCartao.FieldByName('NUM_NSU_HOST_TEF').AsString:= qryRetaguarda2.FieldByName('NUM_NSU_HOST_TEF').AsString;
              ClientDataSetCartao.FieldByName('COD_TRANSACAO_TEF').AsString:= qryRetaguarda2.FieldByName('COD_TRANSACAO_TEF').AsString;
              ClientDataSetCartao.FieldByName('COD_INSTITUICAO_TEF').AsString:= qryRetaguarda2.FieldByName('COD_INSTITUICAO_TEF').AsString;
              ClientDataSetCartao.FieldByName('COD_BANDEIRA_TEF').AsString:= qryRetaguarda2.FieldByName('COD_BANDEIRA_TEF').AsString;
              ClientDataSetCartao.FieldByName('NUM_NSU_SITEF').AsString:= qryRetaguarda2.FieldByName('NUM_NSU_SITEF').AsString;
              ClientDataSetCartao.FieldByName('COD_AUTORIZACAO_TEF').AsString:= qryRetaguarda2.FieldByName('COD_AUTORIZACAO_TEF').AsString;
              ClientDataSetCartao.FieldByName('COD_ESTABELECIMENTO_TEF').AsString:= qryRetaguarda2.FieldByName('COD_ESTABELECIMENTO_TEF').AsString;
              ClientDataSetCartao.FieldByName('VAL_TOTAL_NF').AsFloat:= qryRetaguarda2.FieldByName('VAL_TOTAL_NF').AsFloat;
              ClientDataSetCartao.FieldByName('NUM_PARCELA').AsInteger:= qryRetaguarda2.FieldByName('NUM_PARCELA').AsInteger;
              ClientDataSetCartao.FieldByName('QTD_PARCELA').AsInteger:= qryRetaguarda2.FieldByName('QTD_PARCELA').AsInteger;
              ClientDataSetCartao.FieldByName('COD_PARCEIRO').AsInteger:= qryRetaguarda2.FieldByName('COD_PARCEIRO').AsInteger;
              ClientDataSetCartao.FieldByName('COD_CHAVE').AsInteger:= qryRetaguarda2.FieldByName('COD_CHAVE').AsInteger;
              ClientDataSetCartao.FieldByName('NUM_BORDERO').AsInteger:=  0;
              ClientDataSetCartao.FieldByName('COD_INTERNO').AsInteger:=  aCli.RecNo;
              ClientDataSetCartao.FieldByName('FLG_ENCONTRADO').AsBoolean:=  True;
              ClientDataSetCartao.FieldByName('FLG_QUITADO').AsString:=  qryRetaguarda2.FieldByName('FLG_QUITADO').AsString;
              ClientDataSetCartao.Post;
            end;
          end
          else
          begin
            ClientDataSetCartao.Append;
            ClientDataSetCartao.FieldByName('NUM_CGC').AsString:= '0';
            ClientDataSetCartao.FieldByName('DES_LOJA').AsString:= '0';
            ClientDataSetCartao.FieldByName('DES_PARCEIRO').AsString:= 'Nenhum registro encontrado';
            ClientDataSetCartao.FieldByName('COD_BANDEIRA').AsInteger:= 0;
            ClientDataSetCartao.FieldByName('DES_BANDEIRA').AsString:=  '0';
            ClientDataSetCartao.FieldByName('DTA_EMISSAO').AsDateTime:= Now;
            ClientDataSetCartao.FieldByName('DTA_ENTRADA').AsDateTime:= Now;
            ClientDataSetCartao.FieldByName('DTA_VENCIMENTO').AsDateTime:= Now;
            ClientDataSetCartao.FieldByName('VAL_PARCELA').AsFloat:= 0;
            ClientDataSetCartao.FieldByName('VAL_LIQUIDO').AsFloat:= 0;
            ClientDataSetCartao.FieldByName('COD_ADMINISTRADORA_TEF').AsString:= '0';
            ClientDataSetCartao.FieldByName('NUM_BIN_TEF').AsString:= '0';
            ClientDataSetCartao.FieldByName('NUM_NSU_HOST_TEF').AsString:= '0';
            ClientDataSetCartao.FieldByName('COD_TRANSACAO_TEF').AsString:='0';
            ClientDataSetCartao.FieldByName('COD_INSTITUICAO_TEF').AsString:= '0';
            ClientDataSetCartao.FieldByName('COD_BANDEIRA_TEF').AsString:= '0';
            ClientDataSetCartao.FieldByName('NUM_NSU_SITEF').AsString:= '0';
            ClientDataSetCartao.FieldByName('COD_AUTORIZACAO_TEF').AsString:= '0';
            ClientDataSetCartao.FieldByName('COD_ESTABELECIMENTO_TEF').AsString:= '0';
            ClientDataSetCartao.FieldByName('VAL_TOTAL_NF').AsFloat:= 0;
            ClientDataSetCartao.FieldByName('NUM_PARCELA').AsInteger:= 0;
            ClientDataSetCartao.FieldByName('QTD_PARCELA').AsInteger:= 0;
            ClientDataSetCartao.FieldByName('COD_PARCEIRO').AsInteger:= 0;
            ClientDataSetCartao.FieldByName('COD_CHAVE').AsInteger:= 0;
            ClientDataSetCartao.FieldByName('NUM_BORDERO').AsInteger:=  0;
            ClientDataSetCartao.FieldByName('COD_INTERNO').AsInteger:=  aCli.RecNo;
            ClientDataSetCartao.FieldByName('FLG_ENCONTRADO').AsBoolean:=  False;
            ClientDataSetCartao.FieldByName('FLG_ENCONTRADO').AsBoolean:=  False;
            ClientDataSetCartao.FieldByName('FLG_QUITADO').AsString:=  '-';
            ClientDataSetCartao.Post;
          end;
        end;

        ProgressBar.Position:= aCli.RecNo;
        aCli.Next;
      end;
    end;

    DmRetaguarda.ClientDataSetCartao.Filtered:=False;
    DmRetaguarda.ClientDataSetCartao.Filter:=
      'FLG_ENCONTRADO = True';
    DmRetaguarda.ClientDataSetCartao.Filtered:=True;

    DmRetaguarda.ClientDataSetCartao.First;
    while not DmRetaguarda.ClientDataSetCartao.Eof do
    begin
      aCli.First;
      while not aCli.Eof do
      begin
        if aCli.RecNo = DmRetaguarda.ClientDataSetCartaoCOD_INTERNO.AsInteger then
        begin
          aCli.Edit;
          aCli.FieldByName('FLG_ENCONTRADO').AsBoolean:= True;
          aCli.Post;
        end;
        aCli.Next;
      end;
      DmRetaguarda.ClientDataSetCartao.Next;
    end;
  finally
    DmRetaguarda.ClientDataSetCartao.Filtered:=False;
    aCli.Filtered:=False;
    DmRetaguarda.ClientDataSetCartao.EnableControls;
    aCli.EnableControls;
  end;
end;

procedure TGetNet.BuscaTitulosConcVenda(aCli: TClientDataSet;ProgressBar: TProgressBar);
var autorizacao: Integer;
begin
  try
    DmRetaguarda.ClientDataSetCartao.DisableControls;
    aCli.DisableControls;
    ProgressBar.Min:=0;
    aCli.First;
    with DmRetaguarda do
    begin
      ClientDataSetCartao.Open;
      ClientDataSetCartao.EmptyDataSet;
      ProgressBar.Max:= aCli.RecordCount;
      while not aCli.Eof do
      begin
        FDQryConcVenda.Close;
        FDQryConcVenda.ParamByName('NUM_CGC').AsString:= '03008421000157';
        FDQryConcVenda.ParamByName('DTA_EMISSAO').AsDate:= aCli.FieldByName('DATA_VENDA').AsDateTime;
        FDQryConcVenda.ParamByName('COD_AUTORIZACAO_TEF').AsString := iif(limpaLetras(aCli.FieldByName('AUTORIZACAO').AsString)='',0 ,limpaLetras(aCli.FieldByName('AUTORIZACAO').AsString));
        FDQryConcVenda.ParamByName('VAL_PARCELA').AsFloat:= aCli.FieldByName('VALOR_BRUTO').AsFloat;
        FDQryConcVenda.ParamByName('NUM_PARCELA').AsFloat:= aCli.FieldByName('PARCELA').AsFloat;
        FDQryConcVenda.Open;

        if not(FDQryConcVenda.IsEmpty) then
        begin
          ClientDataSetCartao.Append;
          ClientDataSetCartao.FieldByName('FLG_UPDATE').AsBoolean:= False;
          ClientDataSetCartao.FieldByName('NUM_CGC').AsString:= FDQryConcVenda.FieldByName('NUM_CGC').AsString;
          ClientDataSetCartao.FieldByName('DES_LOJA').AsString:= FDQryConcVenda.FieldByName('DES_LOJA').AsString;
          ClientDataSetCartao.FieldByName('DES_PARCEIRO').AsString:= FDQryConcVenda.FieldByName('DES_PARCEIRO').AsString;
          ClientDataSetCartao.FieldByName('COD_BANDEIRA').AsInteger:= FDQryConcVenda.FieldByName('COD_BANDEIRA').AsInteger;
          ClientDataSetCartao.FieldByName('DES_BANDEIRA').AsString:=  FDQryConcVenda.FieldByName('DES_BANDEIRA').AsString;
          ClientDataSetCartao.FieldByName('DTA_EMISSAO').AsDateTime:= FDQryConcVenda.FieldByName('DTA_EMISSAO').AsDateTime;
          ClientDataSetCartao.FieldByName('DTA_ENTRADA').AsDateTime:= FDQryConcVenda.FieldByName('DTA_ENTRADA').AsDateTime;

          ClientDataSetCartao.FieldByName('DTA_VENCIMENTO').AsDateTime:= FDQryConcVenda.FieldByName('DTA_VENCIMENTO').AsDateTime;
          if acli.FieldByName('VENCIMENTO').AsDateTime <>  FDQryConcVenda.FieldByName('DTA_VENCIMENTO').AsDateTime then
          begin
            ClientDataSetCartao.FieldByName('DTA_VENCIMENTO').AsDateTime:= acli.FieldByName('VENCIMENTO').AsDateTime;
            ClientDataSetCartao.FieldByName('FLG_UPDATE').AsBoolean:= True;
            ClientDataSetCartao.FieldByName('FLG_DATA_VENC').AsBoolean:= True;
          end;

          ClientDataSetCartao.FieldByName('VAL_LIQUIDO').AsFloat:= qryRetaguarda.FieldByName('VAL_LIQUIDO').AsFloat;
          if qryRetaguardaVAL_LIQUIDO.AsFloat <> aCli.FieldByName('LIQUIDO').AsFloat then
          begin
            ClientDataSetCartao.FieldByName('VAL_LIQUIDO').AsFloat:= aCli.FieldByName('LIQUIDO').AsFloat;
            ClientDataSetCartao.FieldByName('FLG_VAL_LIQUIDO').AsBoolean:= True;
            ClientDataSetCartao.FieldByName('FLG_UPDATE').AsBoolean:= True;
          end;

          ClientDataSetCartao.FieldByName('VAL_PARCELA').AsFloat:= FDQryConcVenda.FieldByName('VAL_PARCELA').AsFloat;
          ClientDataSetCartao.FieldByName('COD_ADMINISTRADORA_TEF').AsString:= FDQryConcVenda.FieldByName('COD_ADMINISTRADORA_TEF').AsString;
          ClientDataSetCartao.FieldByName('NUM_BIN_TEF').AsString:= FDQryConcVenda.FieldByName('NUM_BIN_TEF').AsString;
          ClientDataSetCartao.FieldByName('NUM_NSU_HOST_TEF').AsString:= FDQryConcVenda.FieldByName('NUM_NSU_HOST_TEF').AsString;
          ClientDataSetCartao.FieldByName('COD_TRANSACAO_TEF').AsString:= FDQryConcVenda.FieldByName('COD_TRANSACAO_TEF').AsString;
          ClientDataSetCartao.FieldByName('COD_INSTITUICAO_TEF').AsString:= FDQryConcVenda.FieldByName('COD_INSTITUICAO_TEF').AsString;
          ClientDataSetCartao.FieldByName('COD_BANDEIRA_TEF').AsString:= FDQryConcVenda.FieldByName('COD_BANDEIRA_TEF').AsString;
          ClientDataSetCartao.FieldByName('NUM_NSU_SITEF').AsString:= FDQryConcVenda.FieldByName('NUM_NSU_SITEF').AsString;
          ClientDataSetCartao.FieldByName('COD_AUTORIZACAO_TEF').AsString:= FDQryConcVenda.FieldByName('COD_AUTORIZACAO_TEF').AsString;
          ClientDataSetCartao.FieldByName('COD_ESTABELECIMENTO_TEF').AsString:= FDQryConcVenda.FieldByName('COD_ESTABELECIMENTO_TEF').AsString;
          ClientDataSetCartao.FieldByName('VAL_TOTAL_NF').AsFloat:= FDQryConcVenda.FieldByName('VAL_TOTAL_NF').AsFloat;
          ClientDataSetCartao.FieldByName('NUM_PARCELA').AsInteger:= FDQryConcVenda.FieldByName('NUM_PARCELA').AsInteger;
          ClientDataSetCartao.FieldByName('QTD_PARCELA').AsInteger:= FDQryConcVenda.FieldByName('QTD_PARCELA').AsInteger;
          ClientDataSetCartao.FieldByName('COD_PARCEIRO').AsInteger:= FDQryConcVenda.FieldByName('COD_PARCEIRO').AsInteger;
          ClientDataSetCartao.FieldByName('COD_CHAVE').AsInteger:= FDQryConcVenda.FieldByName('COD_CHAVE').AsInteger;
          ClientDataSetCartao.FieldByName('NUM_BORDERO').AsInteger:=  0;
          ClientDataSetCartao.FieldByName('COD_INTERNO').AsInteger:=  aCli.RecNo;
          ClientDataSetCartao.FieldByName('FLG_ENCONTRADO').AsBoolean:=  True;
          ClientDataSetCartao.FieldByName('FLG_QUITADO').AsString:=  FDQryConcVenda.FieldByName('FLG_QUITADO').AsString;
          ClientDataSetCartao.Post;
        end;

        if FDQryConcVenda.IsEmpty then
        begin
          FDQryConcVenda2.Close;
          FDQryConcVenda2.ParamByName('NUM_CGC').AsString:= '03008421000157';
          FDQryConcVenda2.ParamByName('DTA_EMISSAO').AsDate:= aCli.FieldByName('DATA_VENDA').AsDateTime;
          FDQryConcVenda2.ParamByName('VAL_PARCELA').AsFloat :=   aCli.FieldByName('VALOR_BRUTO').AsFloat;
          FDQryConcVenda2.ParamByName('NUM_PARCELA').AsFloat:= aCli.FieldByName('PARCELA').AsFloat;
          FDQryConcVenda2.Open;

          if not FDQryConcVenda2.IsEmpty then
          begin

            if FDQryConcVenda2.RecordCount > 1 then
            begin

              if (FDQryConcVenda2.Locate('COD_PARCEIRO;COD_BANDEIRA;',
                VarArrayOf([ClientDataSetCartao.FieldByName('COD_PARCEIRO').AsInteger,
               ClientDataSetCartao.FieldByName('COD_BANDEIRA').AsInteger]),[])) then
               begin
                ClientDataSetCartao.Append;
                ClientDataSetCartao.FieldByName('FLG_UPDATE').AsBoolean:= False;
                ClientDataSetCartao.FieldByName('NUM_CGC').AsString:= FDQryConcVenda2.FieldByName('NUM_CGC').AsString;
                ClientDataSetCartao.FieldByName('DES_LOJA').AsString:= FDQryConcVenda2.FieldByName('DES_LOJA').AsString;
                ClientDataSetCartao.FieldByName('DES_PARCEIRO').AsString:= FDQryConcVenda2.FieldByName('DES_PARCEIRO').AsString;
                ClientDataSetCartao.FieldByName('COD_BANDEIRA').AsInteger:= FDQryConcVenda2.FieldByName('COD_BANDEIRA').AsInteger;
                ClientDataSetCartao.FieldByName('DES_BANDEIRA').AsString:=  FDQryConcVenda2.FieldByName('DES_BANDEIRA').AsString;
                ClientDataSetCartao.FieldByName('DTA_EMISSAO').AsDateTime:= FDQryConcVenda2.FieldByName('DTA_EMISSAO').AsDateTime;
                ClientDataSetCartao.FieldByName('DTA_ENTRADA').AsDateTime:= FDQryConcVenda2.FieldByName('DTA_ENTRADA').AsDateTime;


                ClientDataSetCartao.FieldByName('DTA_VENCIMENTO').AsDateTime:= FDQryConcVenda2.FieldByName('DTA_VENCIMENTO').AsDateTime;
                if acli.FieldByName('VENCIMENTO').AsDateTime <>  FDQryConcVenda2.FieldByName('DTA_VENCIMENTO').AsDateTime then
                begin
                  ClientDataSetCartao.FieldByName('DTA_VENCIMENTO').AsDateTime:= acli.FieldByName('VENCIMENTO').AsDateTime;
                  ClientDataSetCartao.FieldByName('FLG_UPDATE').AsBoolean:= True;
                end;


                ClientDataSetCartao.FieldByName('VAL_LIQUIDO').AsFloat:= FDQryConcVenda2.FieldByName('VAL_LIQUIDO').AsFloat;
                if qryRetaguarda2.FieldByName('VAL_LIQUIDO').AsFloat <> aCli.FieldByName('valliquido').AsFloat then
                begin
                  ClientDataSetCartao.FieldByName('VAL_LIQUIDO').AsFloat:= aCli.FieldByName('LIQUIDO').AsFloat;
                  ClientDataSetCartao.FieldByName('FLG_UPDATE').AsBoolean:= True;
                end;

                ClientDataSetCartao.FieldByName('VAL_PARCELA').AsFloat:= FDQryConcVenda2.FieldByName('VAL_PARCELA').AsFloat;
                ClientDataSetCartao.FieldByName('COD_ADMINISTRADORA_TEF').AsString:= FDQryConcVenda2.FieldByName('COD_ADMINISTRADORA_TEF').AsString;
                ClientDataSetCartao.FieldByName('NUM_BIN_TEF').AsString:= FDQryConcVenda2.FieldByName('NUM_BIN_TEF').AsString;
                ClientDataSetCartao.FieldByName('NUM_NSU_HOST_TEF').AsString:= FDQryConcVenda2.FieldByName('NUM_NSU_HOST_TEF').AsString;
                ClientDataSetCartao.FieldByName('COD_TRANSACAO_TEF').AsString:= FDQryConcVenda2.FieldByName('COD_TRANSACAO_TEF').AsString;
                ClientDataSetCartao.FieldByName('COD_INSTITUICAO_TEF').AsString:= FDQryConcVenda2.FieldByName('COD_INSTITUICAO_TEF').AsString;
                ClientDataSetCartao.FieldByName('COD_BANDEIRA_TEF').AsString:= FDQryConcVenda2.FieldByName('COD_BANDEIRA_TEF').AsString;
                ClientDataSetCartao.FieldByName('NUM_NSU_SITEF').AsString:= FDQryConcVenda2.FieldByName('NUM_NSU_SITEF').AsString;
                ClientDataSetCartao.FieldByName('COD_AUTORIZACAO_TEF').AsString:= FDQryConcVenda2.FieldByName('COD_AUTORIZACAO_TEF').AsString;
                ClientDataSetCartao.FieldByName('COD_ESTABELECIMENTO_TEF').AsString:= FDQryConcVenda2.FieldByName('COD_ESTABELECIMENTO_TEF').AsString;
                ClientDataSetCartao.FieldByName('VAL_TOTAL_NF').AsFloat:= FDQryConcVenda2.FieldByName('VAL_TOTAL_NF').AsFloat;
                ClientDataSetCartao.FieldByName('NUM_PARCELA').AsInteger:= FDQryConcVenda2.FieldByName('NUM_PARCELA').AsInteger;
                ClientDataSetCartao.FieldByName('QTD_PARCELA').AsInteger:= FDQryConcVenda2.FieldByName('QTD_PARCELA').AsInteger;
                ClientDataSetCartao.FieldByName('COD_PARCEIRO').AsInteger:= FDQryConcVenda2.FieldByName('COD_PARCEIRO').AsInteger;
                ClientDataSetCartao.FieldByName('COD_CHAVE').AsInteger:= FDQryConcVenda2.FieldByName('COD_CHAVE').AsInteger;
                ClientDataSetCartao.FieldByName('NUM_BORDERO').AsInteger:=  0;
                ClientDataSetCartao.FieldByName('COD_INTERNO').AsInteger:=  aCli.RecNo;
                ClientDataSetCartao.FieldByName('FLG_ENCONTRADO').AsBoolean:=  True;
                ClientDataSetCartao.FieldByName('FLG_QUITADO').AsString:=  FDQryConcVenda2.FieldByName('FLG_QUITADO').AsString;
                ClientDataSetCartao.Post;
               end;

            end;
            if FDQryConcVenda2.RecordCount = 1 then
            begin
              ClientDataSetCartao.Append;
              ClientDataSetCartao.FieldByName('FLG_UPDATE').AsBoolean:= False;
              ClientDataSetCartao.FieldByName('NUM_CGC').AsString:= FDQryConcVenda2.FieldByName('NUM_CGC').AsString;
              ClientDataSetCartao.FieldByName('DES_LOJA').AsString:= FDQryConcVenda2.FieldByName('DES_LOJA').AsString;
              ClientDataSetCartao.FieldByName('DES_PARCEIRO').AsString:= FDQryConcVenda2.FieldByName('DES_PARCEIRO').AsString;
              ClientDataSetCartao.FieldByName('COD_BANDEIRA').AsInteger:= FDQryConcVenda2.FieldByName('COD_BANDEIRA').AsInteger;
              ClientDataSetCartao.FieldByName('DES_BANDEIRA').AsString:=  FDQryConcVenda2.FieldByName('DES_BANDEIRA').AsString;
              ClientDataSetCartao.FieldByName('DTA_EMISSAO').AsDateTime:= FDQryConcVenda2.FieldByName('DTA_EMISSAO').AsDateTime;
              ClientDataSetCartao.FieldByName('DTA_ENTRADA').AsDateTime:= FDQryConcVenda2.FieldByName('DTA_ENTRADA').AsDateTime;


              ClientDataSetCartao.FieldByName('DTA_VENCIMENTO').AsDateTime:= FDQryConcVenda2.FieldByName('DTA_VENCIMENTO').AsDateTime;
              if acli.FieldByName('VENCIMENTO').AsDateTime <>  qryRetaguarda2.FieldByName('DTA_VENCIMENTO').AsDateTime then
              begin
                ClientDataSetCartao.FieldByName('DTA_VENCIMENTO').AsDateTime:= acli.FieldByName('VENCIMENTO').AsDateTime;
                ClientDataSetCartao.FieldByName('FLG_UPDATE').AsBoolean:= True;
              end;

              ClientDataSetCartao.FieldByName('VAL_LIQUIDO').AsFloat:= FDQryConcVenda2.FieldByName('VAL_LIQUIDO').AsFloat;
              if qryRetaguarda2.FieldByName('VAL_LIQUIDO').AsFloat <> aCli.FieldByName('valliquido').AsFloat then
              begin
                ClientDataSetCartao.FieldByName('VAL_LIQUIDO').AsFloat:= aCli.FieldByName('LIQUIDO').AsFloat;
                ClientDataSetCartao.FieldByName('FLG_UPDATE').AsBoolean:= True;
              end;

              ClientDataSetCartao.FieldByName('VAL_PARCELA').AsFloat:= FDQryConcVenda2.FieldByName('VAL_PARCELA').AsFloat;
              ClientDataSetCartao.FieldByName('COD_ADMINISTRADORA_TEF').AsString:= FDQryConcVenda2.FieldByName('COD_ADMINISTRADORA_TEF').AsString;
              ClientDataSetCartao.FieldByName('NUM_BIN_TEF').AsString:= FDQryConcVenda2.FieldByName('NUM_BIN_TEF').AsString;
              ClientDataSetCartao.FieldByName('NUM_NSU_HOST_TEF').AsString:= FDQryConcVenda2.FieldByName('NUM_NSU_HOST_TEF').AsString;
              ClientDataSetCartao.FieldByName('COD_TRANSACAO_TEF').AsString:= FDQryConcVenda2.FieldByName('COD_TRANSACAO_TEF').AsString;
              ClientDataSetCartao.FieldByName('COD_INSTITUICAO_TEF').AsString:= FDQryConcVenda2.FieldByName('COD_INSTITUICAO_TEF').AsString;
              ClientDataSetCartao.FieldByName('COD_BANDEIRA_TEF').AsString:= FDQryConcVenda2.FieldByName('COD_BANDEIRA_TEF').AsString;
              ClientDataSetCartao.FieldByName('NUM_NSU_SITEF').AsString:= FDQryConcVenda2.FieldByName('NUM_NSU_SITEF').AsString;
              ClientDataSetCartao.FieldByName('COD_AUTORIZACAO_TEF').AsString:= FDQryConcVenda2.FieldByName('COD_AUTORIZACAO_TEF').AsString;
              ClientDataSetCartao.FieldByName('COD_ESTABELECIMENTO_TEF').AsString:= FDQryConcVenda2.FieldByName('COD_ESTABELECIMENTO_TEF').AsString;
              ClientDataSetCartao.FieldByName('VAL_TOTAL_NF').AsFloat:= FDQryConcVenda2.FieldByName('VAL_TOTAL_NF').AsFloat;
              ClientDataSetCartao.FieldByName('NUM_PARCELA').AsInteger:= FDQryConcVenda2.FieldByName('NUM_PARCELA').AsInteger;
              ClientDataSetCartao.FieldByName('QTD_PARCELA').AsInteger:= FDQryConcVenda2.FieldByName('QTD_PARCELA').AsInteger;
              ClientDataSetCartao.FieldByName('COD_PARCEIRO').AsInteger:= FDQryConcVenda2.FieldByName('COD_PARCEIRO').AsInteger;
              ClientDataSetCartao.FieldByName('COD_CHAVE').AsInteger:= FDQryConcVenda2.FieldByName('COD_CHAVE').AsInteger;
              ClientDataSetCartao.FieldByName('NUM_BORDERO').AsInteger:=  0;
              ClientDataSetCartao.FieldByName('COD_INTERNO').AsInteger:=  aCli.RecNo;
              ClientDataSetCartao.FieldByName('FLG_ENCONTRADO').AsBoolean:=  True;
              ClientDataSetCartao.FieldByName('FLG_QUITADO').AsString:=  FDQryConcVenda2.FieldByName('FLG_QUITADO').AsString;
              ClientDataSetCartao.Post;
            end;
          end
          else
          begin
            ClientDataSetCartao.Append;
            ClientDataSetCartao.FieldByName('NUM_CGC').AsString:= '0';
            ClientDataSetCartao.FieldByName('DES_LOJA').AsString:= '0';
            ClientDataSetCartao.FieldByName('DES_PARCEIRO').AsString:= 'Nenhum registro encontrado';
            ClientDataSetCartao.FieldByName('COD_BANDEIRA').AsInteger:= 0;
            ClientDataSetCartao.FieldByName('DES_BANDEIRA').AsString:=  '0';
            ClientDataSetCartao.FieldByName('DTA_EMISSAO').AsDateTime:= Now;
            ClientDataSetCartao.FieldByName('DTA_ENTRADA').AsDateTime:= Now;
            ClientDataSetCartao.FieldByName('DTA_VENCIMENTO').AsDateTime:= Now;
            ClientDataSetCartao.FieldByName('VAL_PARCELA').AsFloat:= 0;
            ClientDataSetCartao.FieldByName('VAL_LIQUIDO').AsFloat:= 0;
            ClientDataSetCartao.FieldByName('COD_ADMINISTRADORA_TEF').AsString:= '0';
            ClientDataSetCartao.FieldByName('NUM_BIN_TEF').AsString:= '0';
            ClientDataSetCartao.FieldByName('NUM_NSU_HOST_TEF').AsString:= '0';
            ClientDataSetCartao.FieldByName('COD_TRANSACAO_TEF').AsString:='0';
            ClientDataSetCartao.FieldByName('COD_INSTITUICAO_TEF').AsString:= '0';
            ClientDataSetCartao.FieldByName('COD_BANDEIRA_TEF').AsString:= '0';
            ClientDataSetCartao.FieldByName('NUM_NSU_SITEF').AsString:= '0';
            ClientDataSetCartao.FieldByName('COD_AUTORIZACAO_TEF').AsString:= '0';
            ClientDataSetCartao.FieldByName('COD_ESTABELECIMENTO_TEF').AsString:= '0';
            ClientDataSetCartao.FieldByName('VAL_TOTAL_NF').AsFloat:= 0;
            ClientDataSetCartao.FieldByName('NUM_PARCELA').AsInteger:= 0;
            ClientDataSetCartao.FieldByName('QTD_PARCELA').AsInteger:= 0;
            ClientDataSetCartao.FieldByName('COD_PARCEIRO').AsInteger:= 0;
            ClientDataSetCartao.FieldByName('COD_CHAVE').AsInteger:= 0;
            ClientDataSetCartao.FieldByName('NUM_BORDERO').AsInteger:=  0;
            ClientDataSetCartao.FieldByName('COD_INTERNO').AsInteger:=  aCli.RecNo;
            ClientDataSetCartao.FieldByName('FLG_ENCONTRADO').AsBoolean:=  False;
            ClientDataSetCartao.FieldByName('FLG_ENCONTRADO').AsBoolean:=  False;
            ClientDataSetCartao.FieldByName('FLG_QUITADO').AsString:=  '-';
            ClientDataSetCartao.Post;
          end;
        end;

        ProgressBar.Position:= aCli.RecNo;
        aCli.Next;
      end;
    end;

    DmRetaguarda.ClientDataSetCartao.Filtered:=False;
    DmRetaguarda.ClientDataSetCartao.Filter:=
      'FLG_ENCONTRADO = True';
    DmRetaguarda.ClientDataSetCartao.Filtered:=True;

    DmRetaguarda.ClientDataSetCartao.First;
    while not DmRetaguarda.ClientDataSetCartao.Eof do
    begin
      aCli.First;
      while not aCli.Eof do
      begin
        if aCli.RecNo = DmRetaguarda.ClientDataSetCartaoCOD_INTERNO.AsInteger then
        begin
          aCli.Edit;
          aCli.FieldByName('FLG_ENCONTRADO').AsBoolean:= True;
          aCli.Post;
        end;
        aCli.Next;
      end;
      DmRetaguarda.ClientDataSetCartao.Next;
    end;
  finally
    DmRetaguarda.ClientDataSetCartao.Filtered:=False;
    aCli.Filtered:=False;
    DmRetaguarda.ClientDataSetCartao.EnableControls;
    aCli.EnableControls;
  end;
end;

function TGetNet.CurrencyStringToFloat(Value: String): Double;
var valor: Float;
begin

  // Remove o s�mbolo da moeda e os separadores de milhar
  Value := StringReplace(Value, 'R$', '', [rfReplaceAll, rfIgnoreCase]);
  Value := StringReplace(Value, '.', '', [rfReplaceAll]); // remove o ponto dos milhares
  Value := StringReplace(Value, '-', '', [rfReplaceAll]); // remove o ponto dos milhares
  //Value := StringReplace(Value, ',', '.', [rfReplaceAll]); // troca a v�rgula por ponto para decimal
  valor:= StrToFloat(Value);



  // Converte a string limpa para um valor float
  Result := StrToFloat(Value);
end;


function TGetNet.formatValor(val: String):String;
var
  valorLimpo: String;
begin
  valorLimpo:='';
  valorLimpo:= val;
  valorLimpo:=  StringReplace(valorLimpo, 'R$ ', '',[rfReplaceAll]);
  valorLimpo:=  StringReplace(valorLimpo, '.', ',',[rfReplaceAll]);
  result:= valorLimpo;
end;

procedure TGetNet.GeraNumBordero(aMemo: TMemo);
var str: String;
    qtd: integer;
begin
  with DmRetaguarda do
  begin
    try
      if not DmRetaguarda.ClientDataSetCartao.IsEmpty then
      begin

        str:='';
        ClientDataSetAdmBand.First;
        while not ClientDataSetAdmBand.Eof do
        begin
          qryBordero.Close;
          qryBordero.Open;

          if ClientDataSetAdmBandCOD_ADMINISTRADORA.AsInteger  = 0  then
           ClientDataSetCartao.Next;

          ClientDataSetCartao.Filtered:=False;
          ClientDataSetCartao.Filter:=
             'COD_PARCEIRO = '     + IntToStr(ClientDataSetAdmBandCOD_ADMINISTRADORA.AsInteger) +
             'AND COD_BANDEIRA = ' + IntToStr(ClientDataSetAdmBandCOD_BANDEIRA.AsInteger) +
             'AND FLG_QUITADO = '+ QuotedStr('N');
          ClientDataSetCartao.Filtered:= True;
          ClientDataSetCartao.First;

          while not ClientDataSetCartao.Eof do
          begin

            qtd:=  ClientDataSetCartao.RecordCount;

            ClientDataSetCartao.Edit;
            ClientDataSetCartao.FieldByName('NUM_BORDERO').AsInteger:= qryBordero.FieldByName('PROXIMO_VALOR').AsInteger;
            ClientDataSetCartao.Post;

           ClientDataSetCartao.Next;
          end;

          if qtd > 0 then
          begin
           str:= str + ' NUM_BORDERO = ' +  IntToStr(qryBordero.FieldByName('PROXIMO_VALOR').AsInteger)
            + ' Qtd: = ' +  IntToStr(qtd);
           str:= str+#13;
           aMemo.Lines.Add(str);
           qtd:=0;
           str:= '';
           qryAtualizaNumBordero.ExecSQL;
          end;
          ClientDataSetCartao.Filtered:=False;
          ClientDataSetAdmBand.Next;
        end;

        //atuliza registro no banco do erp com o numero de bordero .
       ClientDataSetCartao.First;
       while not ClientDataSetCartao.Eof do
       begin
         qryAtualizaTitulo.ParamByName('NUM_BORDERO').AsInteger:= ClientDataSetCartaoNUM_BORDERO.AsInteger;
         qryAtualizaTitulo.ParamByName('COD_CHAVE').AsInteger:= ClientDataSetCartao.FieldByName('COD_CHAVE').AsInteger;
         qryAtualizaTitulo.ExecSQL;

         ClientDataSetCartao.Next;
        end;
      end;
    finally
    end;
  end;
end;

procedure TGetNet.GeraNumBorderoUnico(aMemo: TMemo);
var
  vTrans: TDBXTransaction;

begin
  InicializaObjeto(vTrans);
  IniciarTransacao(DmConexao.FDConnection);
  with DmRetaguarda do
  begin
    qryBordero.Close;
    qryBordero.Open;

    ClientDataSetCartao.First;
    while not ClientDataSetCartao.Eof do
    begin
      if ClientDataSetCartaoFLG_QUITADO.AsString = 'N' then
      begin
        ClientDataSetCartao.Edit;
        ClientDataSetCartao.FieldByName('NUM_BORDERO').AsInteger:= qryBordero.FieldByName('PROXIMO_VALOR').AsInteger;
        ClientDataSetCartao.Post;

        qryAtualizaTitulo.ParamByName('NUM_BORDERO').AsInteger:= qryBordero.FieldByName('PROXIMO_VALOR').AsInteger;
        qryAtualizaTitulo.ParamByName('COD_CHAVE').AsInteger:= ClientDataSetCartao.FieldByName('COD_CHAVE').AsInteger;
        qryAtualizaTitulo.ExecSQL;
      end;
      ClientDataSetCartao.Next;
    end;

    aMemo.Clear;
    aMemo.Lines.Add('Bordero: ' + IntToStr(qryBordero.FieldByName('PROXIMO_VALOR').AsInteger));
    qryAtualizaNumBordero.ExecSQL;
    CommitTransacao(DmConexao.FDConnection);
  end;

end;

procedure TGetNet.importaArquivo(aCli: TClientDataSet; arquivo: TFileName; progress: TProgressBar);
var  gravar, ler: TStrings;
            i,cod_interno: integer;
    ValConversao: string;
begin
  gravar:= TStringList.Create;
  ler:=    TStringList.Create;

  ler.LoadFromFile(arquivo);

  gravar.Delimiter:=';';
  gravar.StrictDelimiter:= True;


  cod_interno:=0;
  progress.Min:=0;
  progress.Max:= ler.Count;
  for I := 0 to Pred(ler.Count) do
  begin

    progress.Position:= i;

    gravar.DelimitedText:= ler.Strings[i];

    if ((trim(gravar.DelimitedText))<>'') then
    begin
{        if (gravar.Strings[5] <> 'Valor Liquidado (R$)')
              and (gravar.Strings[5]  <> 'Saldo at� o vencimento')
               and (gravar.Strings[5]  <> 'Aluguel')
               and (gravar.Strings[5]  <> 'LAN�AMENTO')
               and (gravar.Strings[5]  <> 'Saldo anterior')
               and (gravar.Strings[5]  <> 'PLANO DE VENDA') then}
        if (gravar.Strings[6] <> '')  and (gravar.Strings[5]  <> 'LAN�AMENTO') then
        begin
           try
             aCli.Append;
             aCli.FieldByName('CODIGO_CENTRALIZADOR').AsString:= gravar.Strings[0];
             aCli.FieldByName('CODIGO').AsString:= gravar.Strings[1];
             aCli.FieldByName('VENCIMENTO').AsString:= gravar.Strings[2];
             aCli.FieldByName('VENCIMENTO_ORIGINAL').AsString:= gravar.Strings[3];
             aCli.FieldByName('PRODUTO').AsString:= gravar.Strings[4];
             aCli.FieldByName('LANCAMENTO').AsString:= gravar.Strings[5];
             aCli.FieldByName('PLANO_VENDA').AsString:= gravar.Strings[6];
             aCli.FieldByName('PARCELA').AsString:= gravar.Strings[7];
             aCli.FieldByName('TOTAL_PARCELA').AsString:= gravar.Strings[8];
             aCli.FieldByName('CARTAO').AsString:= gravar.Strings[9];
             aCli.FieldByName('AUTORIZACAO').AsString:=  gravar.Strings[10];
             aCli.FieldByName('NUMERO_CV').AsString:= gravar.Strings[11];
             aCli.FieldByName('TERMINAL').AsString:= gravar.Strings[12];
             aCli.FieldByName('DATA_VENDA').AsString:= gravar.Strings[13];

             aCli.FieldByName('VALOR_ORIGINAL').AsFloat:= StrToFloat(Trim(formatValor(gravar.Strings[14])));

             aCli.FieldByName('VALOR_BRUTO').AsFloat:= StrToFloat(formatValor(gravar.Strings[15]));

             aCli.FieldByName('DESCONTO').AsFloat:=StrToFloat(formatValor(gravar.Strings[16]));

             aCli.FieldByName('LIQUIDO').AsFloat:= StrToFloat(Trim(formatValor(gravar.Strings[17])));

             aCli.FieldByName('FLG_ENCONTRADO').AsBoolean:= False;
             cod_interno:= cod_interno+1;
             aCli.FieldByName('COD_INTERNO').AsInteger:= cod_interno;
             aCli.Post;
           finally
           end;
        end;
      end;
  end;

end;

procedure TGetNet.importaArquivoVenda(aCli: TClientDataSet; arquivo: TFileName;
  progress: TProgressBar);
var
  CSVFile: TStringList;
  RowList: TStringList;
  i: Integer;
  Row, ColumnValue: String;
  SpacePos,cod_interno: Integer;

begin
  CSVFile := TStringList.Create;
  RowList := TStringList.Create;
  try
    CSVFile.LoadFromFile(arquivo);
    RowList.Delimiter := ';'; // Defina o delimitador aqui, como v�rgula
    RowList.StrictDelimiter := True; // Trata o delimitador estritamente (n�o trata espa�os como delimitadores)

    progress.Min:=0;
    progress.Max:= CSVFile.Count;
    // Pula as primeiras 4 linhas
    for i := 12 to CSVFile.Count - 1 do
    begin
      progress.Position:= i;
      Row := CSVFile[i];
      RowList.DelimitedText := Row;

      // Agora, RowList cont�m cada valor de coluna da linha atual
      // Aqui, voc� pode processar cada valor de coluna como necess�rio
      // Exemplo: exibir o primeiro valor de coluna da linha
      if RowList.Count > 0 then
      begin
           SpacePos := Pos(' ', RowList.Strings[3]);
          aCli.Append;
           aCli.FieldByName('CODIGO_CENTRALIZADOR').AsString:= RowList.Strings[0];
             aCli.FieldByName('CODIGO').AsString:= RowList.Strings[0];
             aCli.FieldByName('VENCIMENTO').AsString:= RowList.Strings[4];
             aCli.FieldByName('VENCIMENTO_ORIGINAL').AsString:= RowList.Strings[4];
             aCli.FieldByName('PRODUTO').AsString:= RowList.Strings[1];
             aCli.FieldByName('LANCAMENTO').AsString:= RowList.Strings[11];
             aCli.FieldByName('PLANO_VENDA').AsString:= '0';
             aCli.FieldByName('PARCELA').AsString:= RowList.Strings[14];
             aCli.FieldByName('TOTAL_PARCELA').AsString:= RowList.Strings[10];
             aCli.FieldByName('CARTAO').AsString:= RowList.Strings[9];
             aCli.FieldByName('AUTORIZACAO').AsString:=  RowList.Strings[6];
             aCli.FieldByName('VALOR_BRUTO').AsFloat:= CurrencyStringToFloat(RowList.Strings[15]);
             aCli.FieldByName('DESCONTO').AsFloat:= CurrencyStringToFloat(RowList.Strings[17]);
              aCli.FieldByName('LIQUIDO').AsFloat:= CurrencyStringToFloat(RowList.Strings[19]);
             //StrToFloat(Trim(formatValor( RowList.Strings[15])));
             aCli.FieldByName('NUMERO_CV').AsString:= '0';
             aCli.FieldByName('TERMINAL').AsString:= '0';
             aCli.FieldByName('DATA_VENDA').AsString:= copy(RowList.Strings[3],1, SpacePos - 1);// Obt�m o primeiro valor de coluna
        // Fa�a algo com ColumnValue, como adicionar a um grid, listbox, etc.
              cod_interno:= cod_interno+1;
            aCli.FieldByName('cod_interno').AsInteger:= cod_interno;
        aCli.Post;
      end;
    end;
  finally
    CSVFile.Free;
    RowList.Free;
  end;

end;

function TGetNet.verificaCaracter(Origem, Caractere: String): boolean;
begin
  if (Origem.IndexOf(Caractere) >= 0)   then
  begin
    Result:=true;
  end
  else
  begin
    Result:=false;
  end;
end;

end.
