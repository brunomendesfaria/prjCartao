unit UDmGetNet;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Datasnap.DBClient;

type
  TDmGetNet = class(TDataModule)
    qryCartao: TFDQuery;
    ClientDataSetGetNet: TClientDataSet;
    ClientDataSetGetNetCODIGO_CENTRALIZADOR: TStringField;
    ClientDataSetGetNetCODIGO: TStringField;
    ClientDataSetGetNetVENCIMENTO: TStringField;
    ClientDataSetGetNetVENCIMENTO_ORIGINAL: TStringField;
    ClientDataSetGetNetPRODUTO: TStringField;
    ClientDataSetGetNetLANCAMENTO: TStringField;
    ClientDataSetGetNetPLANO_VENDA: TStringField;
    ClientDataSetGetNetPARCELA: TStringField;
    ClientDataSetGetNetTOTAL_PARCELA: TStringField;
    ClientDataSetGetNetCARTAO: TStringField;
    ClientDataSetGetNetAUTORIZACAO: TStringField;
    ClientDataSetGetNetNUMERO_CV: TStringField;
    ClientDataSetGetNetTERMINAL: TStringField;
    ClientDataSetGetNetDATA_VENDA: TStringField;
    DataSourceGetNet: TDataSource;
    ClientDataSetGetNetQTDREGARQ: TAggregateField;
    ClientDataSetGetNetFLG_ENCONTRADO: TBooleanField;
    ClientDataSetGetNetvalLiquido: TFloatField;
    ClientDataSetGetNetVALTOTAL: TAggregateField;
    ClientDataSetGetNetVALOR_ORIGINAL: TFloatField;
    ClientDataSetGetNetVALOR_BRUTO: TFloatField;
    ClientDataSetGetNetDESCONTO: TFloatField;
    ClientDataSetGetNetLIQUIDO: TFloatField;
    ClientDataSetGetNetCOD_INTERNO: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmGetNet: TDmGetNet;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses UDmConexao;

{$R *.dfm}

procedure TDmGetNet.DataModuleCreate(Sender: TObject);
begin
 ClientDataSetGetNet.CreateDataSet;
end;

end.
