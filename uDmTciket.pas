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
    CliTicketFLG_ENCONTRADO: TBooleanField;
    CliTicketPRODUTO: TStringField;
    CliTicketDATA_TRANSACAO: TDateField;
    CliTicketCOD_INTERNO: TIntegerField;
    CliTicketVALOR: TStringField;
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
end;

end.
