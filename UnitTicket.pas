unit UnitTicket;

interface

uses
   System.Classes,DBClient, Vcl.Dialogs, System.SysUtils,Data.DB,System.UITypes,xprocs,
  Vcl.DBCtrls, Vcl.StdCtrls,Vcl.ComCtrls, FireDAC.Comp.Client,system.DateUtils;

type TTicket = class
  procedure importaArquivo(aCli: TClientDataSet; arquivo: TFileName; progress: TProgressBar);
  procedure BuscaTitulos(aCli: TClientDataSet;ProgressBar: TProgressBar);
  function  LimpaValor(val: String):String;
  procedure GeraNumBordero(aMemo: TMemo);
  function  SQLBuscaTitulosMain:String;
  function  SQLBuscaTitulosSecond:String;
  procedure alimentaClientCartao(aCli: TClientDataSet;aQry: TFDQuery);
end;

implementation

{ TTicket }

uses UDmRetaguarda, uDmTciket;

procedure TTicket.alimentaClientCartao(aCli: TClientDataSet; aQry: TFDQuery);
begin
  aQry.First;
  while not(aQry.Eof) do
  begin 
    if not (aCli.Locate('COD_CHAVE',aQry.FieldByName('COD_CHAVE').AsInteger,[])) then
    begin
      aCli.Append;
      aCli.FieldByName('NUM_CGC').AsString:= aQry.FieldByName('NUM_CGC').AsString;
      aCli.FieldByName('DES_LOJA').AsString:= aQry.FieldByName('DES_LOJA').AsString;
      aCli.FieldByName('DES_PARCEIRO').AsString:= aQry.FieldByName('DES_PARCEIRO').AsString;
      aCli.FieldByName('COD_BANDEIRA').AsInteger:= aQry.FieldByName('COD_BANDEIRA').AsInteger;
      aCli.FieldByName('DES_BANDEIRA').AsString:=  aQry.FieldByName('DES_BANDEIRA').AsString;
      aCli.FieldByName('DTA_EMISSAO').AsDateTime:= aQry.FieldByName('DTA_EMISSAO').AsDateTime;
      aCli.FieldByName('DTA_ENTRADA').AsDateTime:= aQry.FieldByName('DTA_ENTRADA').AsDateTime;
      aCli.FieldByName('DTA_VENCIMENTO').AsDateTime:= aQry.FieldByName('DTA_VENCIMENTO').AsDateTime;
      aCli.FieldByName('VAL_PARCELA').AsFloat:= aQry.FieldByName('VAL_PARCELA').AsFloat;
      aCli.FieldByName('VAL_LIQUIDO').AsFloat:= aQry.FieldByName('VAL_LIQUIDO').AsFloat;
      aCli.FieldByName('COD_ADMINISTRADORA_TEF').AsString:= aQry.FieldByName('COD_ADMINISTRADORA_TEF').AsString;
      aCli.FieldByName('NUM_BIN_TEF').AsString:= aQry.FieldByName('NUM_BIN_TEF').AsString;
      aCli.FieldByName('NUM_NSU_HOST_TEF').AsString:= aQry.FieldByName('NUM_NSU_HOST_TEF').AsString;
      aCli.FieldByName('COD_TRANSACAO_TEF').AsString:= aQry.FieldByName('COD_TRANSACAO_TEF').AsString;
      aCli.FieldByName('COD_INSTITUICAO_TEF').AsString:= aQry.FieldByName('COD_INSTITUICAO_TEF').AsString;
      aCli.FieldByName('COD_BANDEIRA_TEF').AsString:= aQry.FieldByName('COD_BANDEIRA_TEF').AsString;
      aCli.FieldByName('NUM_NSU_SITEF').AsString:= aQry.FieldByName('NUM_NSU_SITEF').AsString;
      aCli.FieldByName('COD_AUTORIZACAO_TEF').AsString:= aQry.FieldByName('COD_AUTORIZACAO_TEF').AsString;
      aCli.FieldByName('COD_ESTABELECIMENTO_TEF').AsString:= aQry.FieldByName('COD_ESTABELECIMENTO_TEF').AsString;
      aCli.FieldByName('VAL_TOTAL_NF').AsFloat:= aQry.FieldByName('VAL_TOTAL_NF').AsFloat;
      aCli.FieldByName('NUM_PARCELA').AsInteger:= aQry.FieldByName('NUM_PARCELA').AsInteger;
      aCli.FieldByName('QTD_PARCELA').AsInteger:= aQry.FieldByName('QTD_PARCELA').AsInteger;
      aCli.FieldByName('COD_PARCEIRO').AsInteger:= aQry.FieldByName('COD_PARCEIRO').AsInteger;
      aCli.FieldByName('COD_CHAVE').AsInteger:= aQry.FieldByName('COD_CHAVE').AsInteger;
      aCli.FieldByName('NUM_BORDERO').AsInteger:=  0;
      aCli.FieldByName('COD_INTERNO').AsInteger:=  aCli.RecNo;
      aCli.FieldByName('FLG_ENCONTRADO').AsBoolean:=  True;
      aCli.FieldByName('FLG_QUITADO').AsString:=  aQry.FieldByName('FLG_QUITADO').AsString;
      aCli.Post;
      exit
    end;    
    aQry.Next;
  end;
end;

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
        try
          if qryRetaguarda.Active then
            qryRetaguarda.Close;

          qryRetaguarda.SQL.Clear;
          qryRetaguarda.SQL.Add(SQLBuscaTitulosMain);
          qryRetaguarda.ParamByName('DTA_ENTRADA').AsDate:= aCli.FieldByName('DATA_TRANSACAO').AsDateTime;
          qryRetaguarda.ParamByName('VAL_PARCELA').AsFloat:= StrToFloat(aCli.FieldByName('VALOR').AsString);
          qryRetaguarda.Open;

          if qryRetaguarda.RecordCount > 1 then
          begin 
            qryRetaguarda.First;
            qryRetaguarda.Filtered:= False;
            qryRetaguarda.Filter:=  'DES_BANDEIRA LIKE ' +'''%TICKET%''';
            qryRetaguarda.Filtered:=True;
          end;

          if qryRetaguarda.RecordCount > 0 then
          begin
            alimentaClientCartao(ClientDataSetCartao,qryRetaguarda);
          end
          else
          begin
            qryRetaguarda.Close;
            qryRetaguarda.SQL.Clear;
            qryRetaguarda.SQL.Add(SQLBuscaTitulosSecond);
            qryRetaguarda.ParamByName('DTA_ENTRADA').AsDate:= aCli.FieldByName('DATA_TRANSACAO').AsDateTime;
            qryRetaguarda.ParamByName('VAL_PARCELA').AsFloat:= StrToFloat(aCli.FieldByName('VALOR').AsString);
            qryRetaguarda.Open;
            alimentaClientCartao(ClientDataSetCartao,qryRetaguarda);
          end;
        ProgressBar.Position:= aCli.RecNo;
        Except 
         on E: Exception do 
         begin
           ShowMessage('Erro ao buscar o registro no financeiro: ' + E.Message);
         end;

        end;
        ClientDataSetCartao.Edit; 
        ClientDataSetCartaoCOD_INTERNO.AsInteger:= aCli.RecNo;
        ClientDataSetCartao.Post;
        
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
  valorLimpo:=  StringReplace(valorLimpo, 'R$', '' ,[rfReplaceAll]);
  valorLimpo:=  StringReplace(valorLimpo, '.',  '',[rfReplaceAll]);
  valorLimpo:=  StringReplace(valorLimpo, ' ',  '',[rfReplaceAll]);
  valorLimpo:=  FloatToStr(StrToFloat(valorLimpo));
  result:= Trim(valorLimpo);
end;

procedure TTicket.GeraNumBordero(aMemo: TMemo);
var str: String;
    qtd: integer;
begin


end;

procedure TTicket.importaArquivo(aCli: TClientDataSet; arquivo: TFileName;
  progress: TProgressBar);
var  gravar, ler: TStrings;
            i,cod_interno: integer;
    ValConversao,ValSubTotal, ValTaxaGestaoPagamento, valTaxaTPE, valLiquido, vData: string;
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
      if i > 22 then
      begin
        if gravar.Strings[0]<>'' then
        begin
          aCli.Append;
          aCli.FieldByName('NUMERO').AsString:= gravar.Strings[0];
          aCli.FieldByName('DATA_CORTE').AsString:= gravar.Strings[4];
          aCli.FieldByName('DATA_CREDITO_DEBITO').AsString:= gravar.Strings[5];
          aCli.FieldByName('COD_ESTABELECIMENTO').AsString:= gravar.Strings[8];
          aCli.FieldByName('DATA_TRANSACAO').AsString:= gravar.Strings[14];
          aCli.FieldByName('DATA_POSTAGEM').AsString:= gravar.Strings[15];
          aCli.FieldByName('NUMERO_DOCTO').AsString:= gravar.Strings[18];
          aCli.FieldByName('TIPO_TRANSACAO').AsString:= gravar.Strings[21];
          aCli.FieldByName('DESCRICAO_LANCAMENTO').AsString:= gravar.Strings[23];
          aCli.FieldByName('NUMERO_CARTAO').AsString:= gravar.Strings[29];
          aCli.FieldByName('VALOR').AsString:= LimpaValor(gravar.Strings[30]);
          aCli.FieldByName('FLG_ENCONTRADO').AsBoolean:= False;
          cod_interno:= cod_interno+1;
          aCli.FieldByName('COD_INTERNO').AsInteger:= cod_interno;
          aCli.FieldByName('VAL_REP').AsFloat:= 0;
          aCli.Post;

          vData:= gravar.Strings[5];
        end;

        with DMTicket do
        begin
          if gravar.Strings[23] = 'SubTotal' then
          begin
            CliTicketValores.Append;
            CliTicketValoresDESCRICAO_EVENTO.AsString:= gravar.Strings[23];
            ValSubTotal:= gravar.Strings[30];
            ValSubTotal:= LimpaValor(ValSubTotal);
            CliTicketValoresVALOR.AsFloat:= StrToFloat(ValSubTotal);
            CliTicketValoresDATA.AsDateTime:= StrToDate(vData);
            CliTicketValores.Post;
          end;
          if gravar.Strings[23] = 'Taxa de Gestao de Pagamento' then
          begin
            CliTicketValores.Append;
            CliTicketValoresDESCRICAO_EVENTO.AsString:= gravar.Strings[23];
            ValSubTotal:= gravar.Strings[30];
            ValSubTotal:= LimpaValor(ValSubTotal);
            CliTicketValoresVALOR.AsFloat:= StrToFloat(ValSubTotal);
            CliTicketValoresDATA.AsDateTime:= StrToDate(vData);
            CliTicketValores.Post;
          end;
          if gravar.Strings[23] = 'Taxa TPE' then
          begin
            CliTicketValores.Append;
            CliTicketValoresDESCRICAO_EVENTO.AsString:= gravar.Strings[23];
            ValSubTotal:= gravar.Strings[30];
            ValSubTotal:= LimpaValor(ValSubTotal);
            CliTicketValoresVALOR.AsFloat:= StrToFloat(ValSubTotal);
            CliTicketValoresDATA.AsDateTime:= StrToDate(vData);
            CliTicketValores.Post;
          end;
          if gravar.Strings[23] = 'Total Líquido' then
          begin
            CliTicketValores.Append;
            CliTicketValoresDESCRICAO_EVENTO.AsString:= gravar.Strings[23];
            ValSubTotal:= gravar.Strings[30];
            ValSubTotal:= LimpaValor(ValSubTotal);
            CliTicketValoresVALOR.AsFloat:= StrToFloat(ValSubTotal);
            CliTicketValoresDATA.AsDateTime:= StrToDate(vData);
            CliTicketValores.Post;
          end;
        end;
      end;
    Except
     on E: Exception do
     begin
       ShowMessage('Erro ao processar o arquivo CSV: ' + E.Message);
     end;
    end;
  end;

  //percorre o client para recalcular a representativada do valor da parcela
  aCli.DisableControls;
  DMTicket.CliTicketValores.DisableControls;
  DMTicket.CliTicketTaxaSint.DisableControls;

  DMTicket.CliTicketValores.Filtered:=False;
  DMTicket.CliTicketValores.Filter:=
     'DESCRICAO_EVENTO LIKE ' + '''Taxa%'' OR DESCRICAO_EVENTO = ''Subtotal''';
  DMTicket.CliTicketValores.Filtered:=True;

  aCli.First;
  DMTicket.CliTicketValores.First;

  while not(DMTicket.CliTicketValores.Eof) do
  begin
    if not(DMTicket.CliTicketTaxaSint.Locate('DATA', DMTicket.CliTicketValores.FieldByName('DATA').AsDateTime,[])) then
    begin
      DMTicket.CliTicketTaxaSint.Append;
      DMTicket.CliTicketTaxaSint.FieldByName('DATA').AsDateTime:= DMTicket.CliTicketValoresDATA.AsDateTime;
      DMTicket.CliTicketTaxaSint.FieldByName('VALOR').AsFloat:= DMTicket.CliTicketValoresVALOR.AsFloat;
      DMTicket.CliTicketTaxaSint.Post;
    end;

    if DMTicket.CliTicketTaxaSint.Locate('DATA', DMTicket.CliTicketValores.FieldByName('DATA').AsDateTime,[]) then
    begin
      DMTicket.CliTicketTaxaSint.Edit;
      DMTicket.CliTicketTaxaSint.FieldByName('VALOR').AsFloat:=
         DMTicket.CliTicketTaxaSint.FieldByName('VALOR').AsFloat + DMTicket.CliTicketValoresVALOR.AsFloat;
      DMTicket.CliTicketTaxaSint.Post;
    end;
    DMTicket.CliTicketValores.Next;
  end;

  DMTicket.CliTicketValores.Filtered:=False;

  DMTicket.CliTicketTaxaSint.DisableControls;
  DMTicket.CliTicketTaxaSint.First;


  {while not(DMTicket.CliTicketTaxaSint.Eof) do
  begin
    while not aCli.Eof do
    begin
      if acli.FieldByName('DATA_CREDITO_DEBITO').AsDateTime = DMTicket.CliTicketTaxaSint.fieldByName('DATA').AsDateTime then
      begin
        aCli.Edit;
        aCli.FieldByName('VAL_REP').AsFloat:=  StrToFloat(aCli.FieldByName('VALOR').AsString) / DMTicket.CliTicketTaxaSint.FieldByName('SUBTOTAL').AsFloat;
        acli.Post;
      end;
     aCli.Next;
    end;
    aCli.First;
    DMTicket.CliTicketTaxaSint.Next;
  end;
   }
  aCli.EnableControls;
  DMTicket.CliTicketValores.EnableControls;
  DMTicket.CliTicketTaxaSint.EnableControls;

  DMTicket.CliTicket.IndexFieldNames:= 'DATA_CREDITO_DEBITO';




end;

function TTicket.SQLBuscaTitulosMain: String;
begin
  Result:=
 ' SELECT '+
 ' TAB_LOJA.NUM_CGC, '+
 ' TAB_LOJA.DES_LOJA AS DES_LOJA, '+
 ' TAB_FLUXO.COD_PARCEIRO,'+
 ' TAB_FLUXO.DES_PARCEIRO, '+
 ' TAB_FLUXO.COD_BANDEIRA, '+
 ' TAB_BANDEIRA.DES_BANDEIRA, '+
 ' TAB_FLUXO.DTA_EMISSAO, '+
 ' TAB_FLUXO.DTA_ENTRADA, '+
 ' TAB_FLUXO.DTA_VENCIMENTO, '+
 ' TAB_FLUXO.VAL_PARCELA, '+
 ' (TAB_FLUXO.VAL_PARCELA + (TAB_FLUXO.VAL_JUROS + TAB_FLUXO.VAL_CREDITO)) - (TAB_FLUXO.VAL_DESCONTO '+
 '  + TAB_FLUXO.VAL_DEVOLUCAO + TAB_FLUXO.VAL_RETENCAO + TAB_FLUXO.VAL_TAXA_ADM) + TAB_FLUXO.VAL_OUTROS AS VAL_LIQUIDO, '+
 ' TAB_FLUXO.COD_ADMINISTRADORA_TEF, '+
 ' TAB_FLUXO.NUM_BIN_TEF, '+
 ' TAB_FLUXO.NUM_NSU_HOST_TEF, '+
 ' TAB_FLUXO.COD_TRANSACAO_TEF, '+
 ' TAB_FLUXO.COD_INSTITUICAO_TEF, '+
 ' TAB_FLUXO.COD_BANDEIRA_TEF, '+
 ' TAB_FLUXO.NUM_NSU_SITEF, '+
 ' TAB_FLUXO.COD_AUTORIZACAO_TEF, '+
 ' TAB_FLUXO.COD_ESTABELECIMENTO_TEF,  '+
 ' TAB_FLUXO.VAL_TOTAL_NF, '+
 ' TAB_FLUXO.NUM_PARCELA, '+
 ' TAB_FLUXO.QTD_PARCELA, '+
 ' TAB_FLUXO.COD_CHAVE, '+
 ' TAB_FLUXO.NUM_BORDERO, '+
 ' CASE '+
 '   WHEN TAB_FLUXO.DTA_QUITADA IS NOT NULL AND TAB_FLUXO.FLG_QUITADO = ''S'' THEN ''S''  '+
 ' ELSE ''N'' '+
 ' END AS FLG_QUITADO '+
 ' FROM TAB_FLUXO '+
 ' INNER JOIN TAB_BANDEIRA ON  '+
 ' TAB_FLUXO.COD_BANDEIRA = TAB_BANDEIRA.COD_BANDEIRA '+
 ' INNER JOIN TAB_LOJA ON '+
 ' TAB_FLUXO.COD_LOJA = TAB_LOJA.COD_LOJA '+
 ' WHERE '+
 ' TAB_FLUXO.COD_LOJA = 1'+
 ' AND TAB_BANDEIRA.DES_BANDEIRA LIKE ''%TICKET%'''+
 ' AND TAB_FLUXO.DTA_ENTRADA = :DTA_ENTRADA '+
 ' AND TAB_FLUXO.VAL_PARCELA = :VAL_PARCELA '+
 ' AND TAB_FLUXO.TIPO_PARCEIRO  = 4';
end;

function TTicket.SQLBuscaTitulosSecond: String;
begin
  result:=       
    ' SELECT '+
    ' TAB_LOJA.NUM_CGC, '+
    ' TAB_LOJA.DES_LOJA AS DES_LOJA,'+
    ' TAB_FLUXO.COD_PARCEIRO, '+
    ' TAB_FLUXO.DES_PARCEIRO, '+
    ' TAB_FLUXO.COD_BANDEIRA, '+
    ' TAB_BANDEIRA.DES_BANDEIRA, '+
    ' TAB_FLUXO.DTA_EMISSAO, '+
    ' TAB_FLUXO.DTA_ENTRADA, '+
    ' TAB_FLUXO.DTA_VENCIMENTO, '+
    ' TAB_FLUXO.VAL_PARCELA,'+
    ' (TAB_FLUXO.VAL_PARCELA + (TAB_FLUXO.VAL_JUROS + TAB_FLUXO.VAL_CREDITO)) - (TAB_FLUXO.VAL_DESCONTO '+
    ' + TAB_FLUXO.VAL_DEVOLUCAO + TAB_FLUXO.VAL_RETENCAO + TAB_FLUXO.VAL_TAXA_ADM) + TAB_FLUXO.VAL_OUTROS AS VAL_LIQUIDO,   '+
    ' TAB_FLUXO.COD_ADMINISTRADORA_TEF, '+
    ' TAB_FLUXO.NUM_BIN_TEF,'+
    ' TAB_FLUXO.NUM_NSU_HOST_TEF, '+
    ' TAB_FLUXO.COD_TRANSACAO_TEF, '+
    ' TAB_FLUXO.COD_INSTITUICAO_TEF, '+
    ' TAB_FLUXO.COD_BANDEIRA_TEF, '+
    ' TAB_FLUXO.NUM_NSU_SITEF, '+
    ' TAB_FLUXO.COD_AUTORIZACAO_TEF, '+
    ' TAB_FLUXO.COD_ESTABELECIMENTO_TEF, '+
    ' TAB_FLUXO.VAL_TOTAL_NF,  '+
    ' TAB_FLUXO.NUM_PARCELA,'+
    ' TAB_FLUXO.QTD_PARCELA,'+
    ' TAB_FLUXO.COD_CHAVE,  '+
    ' TAB_FLUXO.NUM_BORDERO,'+
    ' CASE  '+
    '   WHEN TAB_FLUXO.DTA_QUITADA IS NOT NULL AND TAB_FLUXO.FLG_QUITADO = ''S'' THEN ''S''   '+
    ' ELSE ''N''  '+
    ' END AS FLG_QUITADO '+
    ' FROM TAB_FLUXO   '+
    ' INNER JOIN TAB_BANDEIRA ON  '+
    ' TAB_FLUXO.COD_BANDEIRA = TAB_BANDEIRA.COD_BANDEIRA  '+
    ' INNER JOIN TAB_LOJA ON'+
    ' TAB_FLUXO.COD_LOJA = TAB_LOJA.COD_LOJA '+
    ' WHERE '+
    ' TAB_FLUXO.COD_LOJA = 1'+
    ' AND TAB_FLUXO.DTA_ENTRADA = :DTA_ENTRADA '+
    ' AND TAB_FLUXO.VAL_PARCELA = :VAL_PARCELA '+
    ' AND TAB_FLUXO.TIPO_PARCEIRO  = 4  ';
  
end;

end.
