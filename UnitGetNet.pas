unit UnitGetNet;

interface

uses
   System.Classes,DBClient, Vcl.Dialogs, System.SysUtils,Data.DB,System.UITypes,xprocs,
  Vcl.DBCtrls, Vcl.StdCtrls,Vcl.ComCtrls;

type TGetNet = class
  procedure importaArquivo(aCli: TClientDataSet; arquivo: TFileName; progress: TProgressBar);
  procedure formatValor(aCli: TClientDataSet);
  function verificaCaracter(Origem,Caractere: String):boolean;
  procedure BuscaTitulos(aCli: TClientDataSet;ProgressBar: TProgressBar);
  procedure GeraNumBordero(aMemo: TMemo);
end;

implementation

{ TGetNet }

uses UDmRetaguarda, System.Variants, UnitProgressoImportacao;


procedure TGetNet.BuscaTitulos(aCli: TClientDataSet;ProgressBar: TProgressBar);
var autorizacao: Integer;
begin
  try
    ProgressBar.Min:=0;
    aCli.First;
    with DmRetaguarda do
    begin
      ClientDataSetCartao.Open;
      ClientDataSetCartao.EmptyDataSet;  
      ProgressBar.Max:=aCli.RecordCount;
      while not aCli.Eof do
      begin
        qryRetaguarda.Close;
        qryRetaguarda.ParamByName('NUM_CGC').AsString:= '03008421000157';
        qryRetaguarda.ParamByName('DTA_EMISSAO').AsDate:= aCli.FieldByName('DATA_VENDA').AsDateTime;
        qryRetaguarda.ParamByName('COD_AUTORIZACAO_TEF').AsString :=           iif(limpaLetras(aCli.FieldByName('AUTORIZACAO').AsString)='',0 ,limpaLetras(aCli.FieldByName('AUTORIZACAO').AsString));
        qryRetaguarda.Open;

        if not(qryRetaguarda.IsEmpty) then
        begin
          ClientDataSetCartao.Edit;
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
          ClientDataSetCartao.Append;
        end;
        if qryRetaguarda.IsEmpty then
        begin
          ClientDataSetCartao.Edit;
          ClientDataSetCartao.FieldByName('NUM_CGC').AsString:= '0';
          ClientDataSetCartao.FieldByName('DES_LOJA').AsString:= '0';
          ClientDataSetCartao.FieldByName('DES_PARCEIRO').AsString:= '0';
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
          ClientDataSetCartao.Append;
        end;
        ProgressBar.Position:= aCli.RecNo;
        aCli.Next;
      end;
    end;
  finally
  end;
end;

procedure TGetNet.formatValor(aCli: TClientDataSet);
begin
  if not(aCli.IsEmpty) then
  begin
    aCli.First;
    while not(aCli.Eof) do
    begin
      aCli.Edit;
      aCli.FieldByName('VALOR_ORIGINAL').AsString:= StringReplace(aCli.FieldByName('VALOR_ORIGINAL').AsString, '.', ',',[]);
      aCli.FieldByName('VALOR_BRUTO').AsString:= StringReplace(aCli.FieldByName('VALOR_BRUTO').AsString, '.', ',',[]);
      aCli.FieldByName('DESCONTO').AsString:= StringReplace(aCli.FieldByName('DESCONTO').AsString, '.', ',',[]);
      aCli.FieldByName('LIQUIDO').AsString:= StringReplace(aCli.FieldByName('LIQUIDO').AsString, '.', ',',[]);
      aCli.Next;
    end;
  end;
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
        ClientDataSetCartao.First;
        ClientDataSetAdmBand.First;
        str:='';

        str:= 'Filter ClientDataSetCartao ' +#13;
        aMemo.Lines.Add(str);
        str:='';
        while not ClientDataSetAdmBand.Eof do
        begin
          qryBordero.Close;
          qryBordero.Open();

          ClientDataSetCartao.Filtered:=False;
          ClientDataSetCartao.Filter:= 'COD_PARCEIRO = ' + IntToStr(ClientDataSetAdmBandCOD_ADMINISTRADORA.AsInteger) +
             'AND COD_BANDEIRA = ' + IntToStr(ClientDataSetAdmBandCOD_BANDEIRA.AsInteger) +
             'AND DTA_ENTRADA = ' + QuotedStr(DateToStr(ClientDataSetAdmBandDATA_VENDA.AsDateTime));
          ClientDataSetCartao.Filtered:= True;


          while not ClientDataSetCartao.Eof do
          begin
            qtd:=  qtd+1;
            str:= str + ' COD_PARCEIRO = ' +  IntToStr(ClientDataSetAdmBandCOD_ADMINISTRADORA.AsInteger);
            str:= str + ' COD_BANDEIRA_TEF = ' +  IntToStr(ClientDataSetAdmBandCOD_BANDEIRA.AsInteger);
            str:= str + ' DTA_ENTRADA = ' +  QuotedStr(DateToStr(ClientDataSetAdmBandDATA_VENDA.AsDateTime));
            aMemo.Lines.Add(str);
            ClientDataSetCartao.Edit;
            ClientDataSetCartao.FieldByName('NUM_BORDERO').AsInteger:= qryBordero.FieldByName('PROXIMO_VALOR').AsInteger;
            ClientDataSetCartao.Post;
            ClientDataSetCartao.Next;
          end;
          if qtd > 0 then
          begin
           str:= str + ' NUM_BORDERO = ' +  IntToStr(qryBordero.FieldByName('PROXIMO_VALOR').AsInteger);
           str:= str + ' Qtd: = ' +  IntToStr(qtd);
           str:= str+#13;
           qryAtualizaNumBordero.ExecSQL;
           aMemo.Lines.Add(str);
           qtd:=0;
          end;
          ClientDataSetAdmBand.Next;
        end;
      end;
    finally
      ClientDataSetCartao.Filtered:=False;
    end;
  end;
end;

procedure TGetNet.importaArquivo(aCli: TClientDataSet; arquivo: TFileName; progress: TProgressBar);
var  gravar, ler: TStrings;
            i: integer;
begin
  gravar:= TStringList.Create;
  ler:=    TStringList.Create;

  ler.LoadFromFile(arquivo);

  gravar.Delimiter:=';';
  gravar.StrictDelimiter:= True;


  progress.Min:=0;    
  progress.Max:= ler.Count.Size;
  for I := 0 to Pred(ler.Count) do
  begin

    progress.Position:= i;
    if i > 1 then
    begin
      gravar.DelimitedText:= ler.Strings[i];

      if (gravar.Strings[5] <> 'Valor Liquidado (R$)')
            and (gravar.Strings[5]  <> 'Saldo at� o vencimento') then
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
           aCli.FieldByName('VALOR_ORIGINAL').AsString:= gravar.Strings[14];
           aCli.FieldByName('VALOR_BRUTO').AsString:= gravar.Strings[15];
           aCli.FieldByName('DESCONTO').AsString:= gravar.Strings[16];
           aCli.FieldByName('LIQUIDO').AsString:= gravar.Strings[17];
           aCli.Post;
         finally
         end;
      end;        
    end;
  end;
  formatValor(aCli);
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
