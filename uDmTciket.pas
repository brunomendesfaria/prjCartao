unit uDmTciket;

interface

uses
  System.SysUtils, System.Classes, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Datasnap.DBClient;

type
  TDMTicket = class(TDataModule)
    DSTicket: TDataSource;
    CliTicket: TClientDataSet;
    CliTicketNUMERO: TStringField;
    CliTicketDATA_CORTE: TStringField;
    CliTicketDATA_CREDITO_DEBITO: TStringField;
    CliTicketCOD_ESTABELECIMENTO: TStringField;
    CliTicketDATA_TRANSACAO: TStringField;
    CliTicketDATA_POSTAGEM: TStringField;
    CliTicketNUMERO_DOCTO: TStringField;
    CliTicketTIPO_TRANSACAO: TStringField;
    CliTicketDESCRICAO_LANCAMENTO: TStringField;
    CliTicketNUMERO_CARTAO: TStringField;
    CliTicketVALOR: TStringField;
    CliTicketFLG_ENCONTRADO: TBooleanField;
    CliTicketCOD_INTERNO: TIntegerField;
    CliTicketValores: TClientDataSet;
    DSTicketValores: TDataSource;
    CliTicketValoresDESCRICAO_EVENTO: TStringField;
    CliTicketValoresVALOR: TFloatField;
    CliTicketValoresDATA: TDateField;
    CliTicketVAL_REP: TFloatField;
    CliTicketTaxaSint: TClientDataSet;
    StringField1: TStringField;
    FloatField1: TFloatField;
    DateField1: TDateField;
    DSTicketTaxaSint: TDataSource;
    CliTicketTaxaSintSUBTOTAL: TFloatField;
    CliTicketDataCredito: TClientDataSet;
    StringField4: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMTicket: TDMTicket;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMTicket.DataModuleCreate(Sender: TObject);
begin
  CliTicket.CreateDataSet;
  CliTicketValores.CreateDataSet;
  CliTicketTaxaSint.CreateDataSet;
end;

end.
