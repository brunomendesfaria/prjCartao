unit UnitTicket;

interface

uses
   System.Classes,DBClient, Vcl.Dialogs, System.SysUtils,Data.DB,System.UITypes,xprocs,
  Vcl.DBCtrls, Vcl.StdCtrls,Vcl.ComCtrls, FireDAC.Comp.Client;

type TTicket = class
  procedure importaArquivo(aCli: TClientDataSet; arquivo: TFileName; progress: TProgressBar);
  procedure BuscaTitulos(aCli: TClientDataSet;ProgressBar: TProgressBar);
  function LimpaValor(val: String):String;
  function SQLBuscaTitulos:String;

end;

implementation

{ TTicket }

uses UDmRetaguarda;

procedure TTicket.BuscaTitulos(aCli: TClientDataSet; ProgressBar: TProgressBar);
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
        if qryRetaguarda.Active then
          qryRetaguarda.Close;

        qryRetaguarda.SQL.Clear;
        qryRetaguarda.SQL.Add(SQLBuscaTitulos);
        qryRetaguarda.ParamByName('DTA_ENTRADA').AsDate:= aCli.FieldByName('DATA_TRANSACAO').AsDateTime;
        qryRetaguarda.ParamByName('VAL_PARCELA').AsFloat:= StrToFloat(aCli.FieldByName('VALOR').AsString);
        qryRetaguarda.Open;

        if not(qryRetaguarda.IsEmpty) then
        begin
          ClientDataSetCartao.Append;
          ClientDataSetCartao.FieldByName('NUM_CGC').AsString:= qryRetaguarda.FieldByName('NUM_CGC').AsString;
          ClientDataSetCartao.FieldByName('DES_LOJA').AsString:= qryRetaguarda.FieldByName('DES_LOJA').AsString;
          ClientDataSetCartao.FieldByName('DES_PARCEIRO').AsString:= qryRetaguarda.FieldByName('DES_PARCEIRO').AsString;
          ClientDataSetCartao.FieldByName('COD_BANDEIRA').AsInteger:= qryRetaguarda.FieldByName('COD_BANDEIRA').AsInteger;
          ClientDataSetCartao.FieldByName('DES_BANDEIRA').AsString:=  qryRetaguarda.FieldByName('DES_BANDEIRA').AsString;
          ClientDataSetCartao.FieldByName('DTA_EMISSAO').AsDateTime:= qryRetaguarda.FieldByName('DTA_EMISSAO').AsDateTime;
          ClientDataSetCartao.FieldByName('DTA_ENTRADA').AsDateTime:= qryRetaguarda.FieldByName('DTA_ENTRADA').AsDateTime;
          ClientDataSetCartao.FieldByName('DTA_VENCIMENTO').AsDateTime:= qryRetaguarda.FieldByName('DTA_VENCIMENTO').AsDateTime;
          ClientDataSetCartao.FieldByName('VAL_PARCELA').AsFloat:= qryRetaguarda.FieldByName('VAL_PARCELA').AsFloat;
          ClientDataSetCartao.FieldByName('VAL_LIQUIDO').AsFloat:= qryRetaguarda.FieldByName('VAL_LIQUIDO').AsFloat;
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

function TTicket.LimpaValor(val: String): String;
var
  valorLimpo: String;
begin
  valorLimpo:='';
  valorLimpo:=  val;
  valorLimpo:=  StringReplace(valorLimpo, 'R$ ', '' ,[rfReplaceAll]);
  valorLimpo:=  StringReplace(valorLimpo, '.',  ',',[rfReplaceAll]);
end;

procedure TTicket.importaArquivo(aCli: TClientDataSet; arquivo: TFileName;
  progress: TProgressBar);
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

    try
      if i > 19 then
      begin
        if Trim(gravar.Strings[3]) <> '' then
        begin
          aCli.Append;
          aCli.FieldByName('DATA_TRANSACAO').AsString:= gravar.Strings[0];
          aCli.FieldByName('PRODUTO').AsString:= gravar.Strings[3];
          aCli.FieldByName('VALOR').AsString:= gravar.Strings[6];
//          aCli.FieldByName('VALOR').AsString:= LimpaValor(gravar.Strings[6]);
//          ShowMessage('valor ' + LimpaValor(gravar.Strings[6]));
          aCli.FieldByName('FLG_ENCONTRADO').AsBoolean:= False;
          cod_interno:= cod_interno+1;
          aCli.FieldByName('COD_INTERNO').AsInteger:= cod_interno;
          aCli.Post;
        end;
      end;
    finally

     end;

  end;
end;

function TTicket.SQLBuscaTitulos: String;
begin
  Result:=
   ' SELECT																														                                                          '+
 ' TAB_LOJA.NUM_CGC,                                                                                                            '+
 ' TAB_LOJA.DES_LOJA AS DES_LOJA,                                                                                               '+
 ' TAB_FLUXO.COD_PARCEIRO,                                                                                                      '+
 ' TAB_FLUXO.DES_PARCEIRO,                                                                                                      '+
 ' TAB_FLUXO.COD_BANDEIRA,                                                                                                      '+
 ' TAB_BANDEIRA.DES_BANDEIRA,                                                                                                   '+
 ' TAB_FLUXO.DTA_EMISSAO,                                                                                                       '+
 ' TAB_FLUXO.DTA_ENTRADA,                                                                                                       '+
 ' TAB_FLUXO.DTA_VENCIMENTO,                                                                                                    '+
 ' TAB_FLUXO.VAL_PARCELA,                                                                                                       '+
 ' (TAB_FLUXO.VAL_PARCELA + (TAB_FLUXO.VAL_JUROS + TAB_FLUXO.VAL_CREDITO)) - (TAB_FLUXO.VAL_DESCONTO                            '+
 '  + TAB_FLUXO.VAL_DEVOLUCAO + TAB_FLUXO.VAL_RETENCAO + TAB_FLUXO.VAL_TAXA_ADM) + TAB_FLUXO.VAL_OUTROS AS VAL_LIQUIDO,         '+
 ' TAB_FLUXO.COD_ADMINISTRADORA_TEF,                                                                                            '+
 ' TAB_FLUXO.NUM_BIN_TEF,                                                                                                       '+
 ' TAB_FLUXO.NUM_NSU_HOST_TEF,                                                                                                  '+
 ' TAB_FLUXO.COD_TRANSACAO_TEF,                                                                                                 '+
 ' TAB_FLUXO.COD_INSTITUICAO_TEF,                                                                                               '+
 ' TAB_FLUXO.COD_BANDEIRA_TEF,                                                                                                  '+
 ' TAB_FLUXO.NUM_NSU_SITEF,                                                                                                     '+
 ' TAB_FLUXO.COD_AUTORIZACAO_TEF,                                                                                               '+
 ' TAB_FLUXO.COD_ESTABELECIMENTO_TEF,                                                                                           '+
 ' TAB_FLUXO.VAL_TOTAL_NF,                                                                                                      '+
 ' TAB_FLUXO.NUM_PARCELA,                                                                                                       '+
 ' TAB_FLUXO.QTD_PARCELA,                                                                                                       '+
 ' TAB_FLUXO.COD_CHAVE,                                                                                                         '+
 ' TAB_FLUXO.NUM_BORDERO,                                                                                                       '+
 ' CASE                                                                                                                         '+
 '   WHEN TAB_FLUXO.DTA_QUITADA IS NOT NULL AND TAB_FLUXO.FLG_QUITADO = ''S'' THEN ''S''                                        '+
 ' ELSE ''N''                                                                                                                   '+
 ' END AS FLG_QUITADO                                                                                                           '+
 ' FROM TAB_FLUXO                                                                                                                '+
 ' INNER JOIN TAB_BANDEIRA ON                                                                                                   '+
 ' TAB_FLUXO.COD_BANDEIRA = TAB_BANDEIRA.COD_BANDEIRA                                                                           '+
 ' INNER JOIN TAB_LOJA ON                                                                                                       '+
 ' TAB_FLUXO.COD_LOJA = TAB_LOJA.COD_LOJA                                                                                       '+
 ' WHERE                                                                                                                        '+
 ' TAB_LOJA.NUM_CGC = ''47866934000174''                                                                                        '+
 ' AND TAB_FLUXO.NUM_CGC_CPF = ''03008421000157''                                                                               '+
 ' AND TAB_FLUXO.DTA_ENTRADA = :DTA_ENTRADA                                                                                     '+
 ' AND TAB_FLUXO.VAL_PARCELA = :VAL_PARCELA                                                                                     '+
 ' AND TAB_FLUXO.TIPO_PARCEIRO  = 4                                                                                             ';
end;

end.
