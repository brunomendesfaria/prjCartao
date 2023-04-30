unit UnitSodexoAlimentaPass;

interface

uses
System.Classes,DBClient, Vcl.Dialogs, System.SysUtils, FireDAC.Comp.Client;

type TSodexoAlimentaPass = class
  procedure importaArquivo(aCli: TClientDataSet; arquivo: TFileName);
  procedure buscaTiulo(aFDQuery: TFDQuery;aSelect: String);
  function limpaCaracter(aTexto: String): String;
end;


implementation

uses
  Data.SqlExpr,XPROCS,Data.DBXCommon;


procedure TSodexoAlimentaPass.buscaTiulo(aFDQuery: TFDQuery;aSelect: String);
begin
 try

 finally

 end;

end;

procedure TSodexoAlimentaPass.importaArquivo(aCli: TClientDataSet; arquivo: TFileName);
var  gravar, ler: TStrings;
            i: integer;
begin
  gravar:= TStringList.Create;
  ler:=    TStringList.Create;

  ler.LoadFromFile(arquivo);

  gravar.Delimiter:=';';
  gravar.StrictDelimiter:= True;

  for I := 0 to Pred(ler.Count) do
  begin


    if i > 13 then
    begin
      gravar.DelimitedText:= ler.Strings[i];

      if gravar.Strings[0] = '03.008.421/0001-57' then
      begin

        aCli.Edit;
        aCli.FieldByName('CNPJ').AsString:= limpaCaracter(gravar.Strings[0]);
        aCli.FieldByName('RAZAO_SOCIAL').AsString:= gravar.Strings[1];
        aCli.FieldByName('DATA_TRANSACAO').AsString:= gravar.Strings[2];
        aCli.FieldByName('DATA_PROCESSAMENTO').AsString:= gravar.Strings[3];
        aCli.FieldByName('REDE_CAPTURA').AsString:= gravar.Strings[4];
        aCli.FieldByName('DESCRICAO').AsString:= gravar.Strings[5];
        aCli.FieldByName('NUM_CARTAO').AsString:= gravar.Strings[6];
        aCli.FieldByName('NUM_AUTORIZACAO').AsString:= gravar.Strings[7];
        aCli.FieldByName('VALOR_BRUTO').AsString:= gravar.Strings[8];
        aCli.Append;
      end;
    end;
  end;



end;

function TSodexoAlimentaPass.limpaCaracter(aTexto: String): String;
var
  xTexto: String;
begin
  xTexto:= aTexto;
  xTexto:= StrReplace(aTexto,'.','');
  xTexto:=  StrReplace(xTexto,'/','');
  xTexto:=  StrReplace(xTexto,'-','');
  Result:= xTexto;
end;


end.
