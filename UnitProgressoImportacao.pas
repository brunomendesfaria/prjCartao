unit UnitProgressoImportacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TFrmProgressoImportacao = class(TForm)
    Label1: TLabel;
    ProgressBar1: TProgressBar;
    Label2: TLabel;
    ProgressBar2: TProgressBar;
    Label3: TLabel;
    ProgressBar3: TProgressBar;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmProgressoImportacao: TFrmProgressoImportacao;

implementation

{$R *.dfm}

procedure TFrmProgressoImportacao.Button1Click(Sender: TObject);
begin
  Close;
end;

end.
