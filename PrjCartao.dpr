program PrjCartao;

uses
  Vcl.Forms,
  UnitPrinicipal in 'UnitPrinicipal.pas' {frmPrincipal},
  UnitGetNet in 'UnitGetNet.pas',
  XPROCS in 'XPROCS.PAS',
  UnitCielo in 'UnitCielo.pas',
  UnitSodexoAlimentaPass in 'UnitSodexoAlimentaPass.pas',
  UDmConexao in 'UDmConexao.pas' {DmConexao: TDataModule},
  UDmCartaoSodexo in 'UDmCartaoSodexo.pas' {DmCartaoSodexo: TDataModule},
  UDmRetaguarda in 'UDmRetaguarda.pas' {DmRetaguarda: TDataModule},
  UDmGetNet in 'UDmGetNet.pas' {DmGetNet: TDataModule},
  UnitProgressoImportacao in 'UnitProgressoImportacao.pas' {FrmProgressoImportacao},
  UnitPesqTitCart in 'UnitPesqTitCart.pas' {FormPesTitCart};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TDmConexao, DmConexao);
  Application.CreateForm(TFrmProgressoImportacao, FrmProgressoImportacao);
  Application.Run;
end.