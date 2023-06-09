unit UDmCartaoSodexo;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TDmCartaoSodexo = class(TDataModule)
    qry: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmCartaoSodexo: TDmCartaoSodexo;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses UDmConexao;

{$R *.dfm}

end.
