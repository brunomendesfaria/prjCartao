unit UnitTicket;

interface

uses
   System.Classes,DBClient, Vcl.Dialogs, System.SysUtils,Data.DB,System.UITypes,xprocs,
  Vcl.DBCtrls, Vcl.StdCtrls,Vcl.ComCtrls, FireDAC.Comp.Client;

type TTicket = class
  procedure importaArquivo(aCli: TClientDataSet; arquivo: TFileName; progress: TProgressBar);
  procedure BuscaTitulos(aCli: TClientDataSet;ProgressBar: TProgressBar);
  function LimpaValor(val: String):String;
  procedure GeraNumBordero(aMemo: TMemo);
  function SQLBuscaTitulosMain:String;
  function SQLBuscaTitulosSecond:String;
  procedure alimentaClientCartao(aCli: TClientDataSet;aQry: TFDQuery);
end;

implementation

{ TTicket }

uses UDmRetaguarda;

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
          aCli.FieldByName('VALOR').AsString:= LimpaValor(gravar.Strings[6]);
//          aCli.FieldByName('VALOR').AsString:= LimpaValor(gravar.Strings[6]);
//          ShowMessage('valor ' + LimpaValor(gravar.Strings[6]));
          aCli.FieldByName('FLG_ENCONTRADO').AsBoolean:= False;
          cod_interno:= cod_interno+1;
          aCli.FieldByName('COD_INTERNO').AsInteger:= cod_interno;
          aCli.Post;
        end;
      end;
    Except
     on E: Exception do
     begin
        ShowMessage('Erro ao processar o arquivo CSV: ' + E.Message);
     end;

     end;

  end;
end;

function TTicket.SQLBuscaTitulosMain: String;
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
 ' TAB_FLUXO.COD_LOJA = 1'+
 ' AND TAB_BANDEIRA.DES_BANDEIRA LIKE ''%TICKET%'''+
 ' AND TAB_FLUXO.DTA_ENTRADA = :DTA_ENTRADA                                                                                     '+
 ' AND TAB_FLUXO.VAL_PARCELA = :VAL_PARCELA                                                                                     '+
 ' AND TAB_FLUXO.TIPO_PARCEIRO  = 4                                                                                             ';
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
