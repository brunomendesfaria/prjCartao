unit UDmRetaguarda;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.OracleDef,
  FireDAC.Phys, FireDAC.Phys.Oracle, Datasnap.DBClient;

type
  TDmRetaguarda = class(TDataModule)
    qryRetaguarda: TFDQuery;
    qryRetaguardaNUM_CGC: TStringField;
    qryRetaguardaDES_LOJA: TStringField;
    qryRetaguardaCOD_PARCEIRO: TBCDField;
    qryRetaguardaDES_PARCEIRO: TStringField;
    qryRetaguardaCOD_BANDEIRA: TBCDField;
    qryRetaguardaDES_BANDEIRA: TStringField;
    qryRetaguardaDTA_EMISSAO: TDateTimeField;
    qryRetaguardaDTA_ENTRADA: TDateTimeField;
    qryRetaguardaDTA_VENCIMENTO: TDateTimeField;
    qryRetaguardaVAL_PARCELA: TFloatField;
    qryRetaguardaVAL_LIQUIDO: TFloatField;
    qryRetaguardaCOD_ADMINISTRADORA_TEF: TStringField;
    qryRetaguardaNUM_BIN_TEF: TBCDField;
    qryRetaguardaNUM_NSU_HOST_TEF: TStringField;
    qryRetaguardaCOD_TRANSACAO_TEF: TBCDField;
    qryRetaguardaCOD_INSTITUICAO_TEF: TStringField;
    qryRetaguardaCOD_BANDEIRA_TEF: TBCDField;
    qryRetaguardaNUM_NSU_SITEF: TStringField;
    qryRetaguardaCOD_AUTORIZACAO_TEF: TBCDField;
    qryRetaguardaCOD_ESTABELECIMENTO_TEF: TStringField;
    qryRetaguardaVAL_TOTAL_NF: TFloatField;
    qryRetaguardaNUM_PARCELA: TBCDField;
    qryRetaguardaQTD_PARCELA: TBCDField;
    qryRetaguardaCOD_CHAVE: TBCDField;
    qryAtualizaTitulo: TFDQuery;
    qryBordero: TFDQuery;
    qryBorderoPROXIMO_VALOR: TBCDField;
    qryRetaguardaNUM_BORDERO: TBCDField;
    DataSourceCartao: TDataSource;
    ClientDataSetCartao: TClientDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    BCDField2: TBCDField;
    DateTimeField1: TDateTimeField;
    DateTimeField2: TDateTimeField;
    DateTimeField3: TDateTimeField;
    FloatField2: TFloatField;
    StringField4: TStringField;
    BCDField3: TBCDField;
    StringField5: TStringField;
    BCDField4: TBCDField;
    StringField6: TStringField;
    BCDField5: TBCDField;
    StringField7: TStringField;
    BCDField6: TBCDField;
    StringField8: TStringField;
    StringField9: TStringField;
    ClientDataSetCartaoCOD_CHAVE: TIntegerField;
    ClientDataSetCartaoNUM_BORDERO: TIntegerField;
    qryAtualizaNumBordero: TFDQuery;
    ClientDataSetAdmBand: TClientDataSet;
    ClientDataSetAdmBandCOD_ADMINISTRADORA: TIntegerField;
    ClientDataSetAdmBandCOD_BANDEIRA: TIntegerField;
    ClientDataSetAdmBandDATA_VENCIMENTO: TDateField;
    ClientDataSetCartaoQtdRegErp: TAggregateField;
    ClientDataSetCartaoval_bruto: TAggregateField;
    ClientDataSetCartaoCOD_PARCEIRO: TIntegerField;
    ClientDataSetCartaoDES_BANDEIRA: TStringField;
    ClientDataSetCartaoVAL_PARCELA: TFloatField;
    ClientDataSetCartaoVAL_TOTAL_NF: TFloatField;
    ClientDataSetCartaoNUM_PARCELA: TIntegerField;
    ClientDataSetCartaoQTD_PARCELA: TIntegerField;
    ClientDataSetAdmBandDATA_VENDA: TDateField;
    ClientDataSetCartaoCOD_INTERNO: TIntegerField;
    ClientDataSetCartaoFLG_ENCONTRADO: TBooleanField;
    qryRetaguarda2: TFDQuery;
    StringField3: TStringField;
    StringField10: TStringField;
    BCDField1: TBCDField;
    StringField11: TStringField;
    BCDField7: TBCDField;
    StringField12: TStringField;
    DateTimeField4: TDateTimeField;
    DateTimeField5: TDateTimeField;
    DateTimeField6: TDateTimeField;
    FloatField1: TFloatField;
    FloatField3: TFloatField;
    StringField13: TStringField;
    BCDField8: TBCDField;
    StringField14: TStringField;
    BCDField9: TBCDField;
    StringField15: TStringField;
    BCDField10: TBCDField;
    StringField16: TStringField;
    BCDField11: TBCDField;
    StringField17: TStringField;
    FloatField4: TFloatField;
    BCDField12: TBCDField;
    BCDField13: TBCDField;
    BCDField14: TBCDField;
    BCDField15: TBCDField;
    qryRetaguardaFLG_QUITADO: TStringField;
    ClientDataSetCartaoFLG_QUITADO: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure alimentaClientDataSetAdmBand;
    function limpaLetras(aStr:String):String;
  end;

var
  DmRetaguarda: TDmRetaguarda;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses UDmConexao, System.Variants;

{$R *.dfm}

{ TDmRetaguarda }

procedure TDmRetaguarda.alimentaClientDataSetAdmBand;
begin
  if not ClientDataSetCartao.IsEmpty then
  begin
   ClientDataSetAdmBand.Close;
   ClientDataSetAdmBand.Open;
   ClientDataSetAdmBand.EmptyDataSet;
   ClientDataSetCartao.First;

    while not ClientDataSetCartao.Eof do
    begin
      if not (ClientDataSetAdmBand.Locate('COD_ADMINISTRADORA;COD_BANDEIRA;DATA_VENCIMENTO;DATA_VENDA',
       VarArrayOf([ClientDataSetCartao.FieldByName('COD_PARCEIRO').AsInteger,
         ClientDataSetCartao.FieldByName('COD_BANDEIRA').AsInteger,
         ClientDataSetCartao.FieldByName('DTA_VENCIMENTO').AsDateTime,
         ClientDataSetCartao.FieldByName('DTA_ENTRADA').AsDateTime]),[])) then
      begin
        ClientDataSetAdmBand.Append;
        ClientDataSetAdmBand.FieldByName('COD_ADMINISTRADORA').AsInteger:= ClientDataSetCartao.FieldByName('COD_PARCEIRO').AsInteger;
        ClientDataSetAdmBand.FieldByName('COD_BANDEIRA').AsInteger:=      ClientDataSetCartao.FieldByName('COD_BANDEIRA').AsInteger;
        ClientDataSetAdmBand.FieldByName('DATA_VENCIMENTO').AsDateTime:=  ClientDataSetCartao.FieldByName('DTA_VENCIMENTO').AsDateTime;
        ClientDataSetAdmBand.FieldByName('DATA_VENDA').AsDateTime:=  ClientDataSetCartao.FieldByName('DTA_ENTRADA').AsDateTime;
        ClientDataSetAdmBand.post;
      end;
      ClientDataSetCartao.Next;
    end;
  end;
  ClientDataSetAdmBand.IndexFieldNames:= 'COD_ADMINISTRADORA,COD_BANDEIRA';
  ClientDataSetAdmBand.IndexName:= '';
  ClientDataSetAdmBand.First;

end;

procedure TDmRetaguarda.DataModuleCreate(Sender: TObject);
begin
  ClientDataSetAdmBand.CreateDataSet;
  ClientDataSetCartao.CreateDataSet;
end;

procedure TDmRetaguarda.DataModuleDestroy(Sender: TObject);
begin
  ClientDataSetCartao.Close;
  ClientDataSetAdmBand.Close;
end;

function TDmRetaguarda.limpaLetras(aStr: String): String;
var i: integer;
begin
for i := Length(aStr) downto 1 do
   if not(aStr[i] in ['0'..'9']) then
      Delete(aStr,i,1);
 result:= aStr;
end;

end.
