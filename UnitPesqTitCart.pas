unit UnitPesqTitCart;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList;

type
  TFormPesTitCart = class(TForm)
    Panel1: TPanel;
    DateTimePicker: TDateTimePicker;
    Edit1: TEdit;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    FDQuery: TFDQuery;
    DataSource: TDataSource;
    btnPesquisar: TButton;
    btnAdicionar: TButton;
    FDQueryRegistro: TFDQuery;
    ImageList1: TImageList;
    FDQueryCOD_PARCEIRO: TBCDField;
    FDQueryNUM_CGC_CPF: TStringField;
    FDQueryDES_PARCEIRO: TStringField;
    FDQueryDTA_EMISSAO: TDateTimeField;
    FDQueryCOD_BANCO: TBCDField;
    FDQueryNUM_DOCTO: TStringField;
    FDQueryDTA_VENCIMENTO: TDateTimeField;
    FDQueryVAL_PARCELA: TFloatField;
    FDQueryDTA_ENTRADA: TDateTimeField;
    FDQueryNUM_PARCELA: TBCDField;
    FDQueryQTD_PARCELA: TBCDField;
    FDQueryVAL_TOTAL_NF: TFloatField;
    FDQueryNUM_BORDERO: TBCDField;
    FDQueryNUM_PDV: TBCDField;
    FDQueryCOD_LOJA: TBCDField;
    FDQueryNUM_CUPOM_FISCAL: TBCDField;
    FDQueryCOD_CHAVE: TBCDField;
    FDQueryDES_BANDEIRA: TStringField;
    FDQueryDES_REDE_TEF: TStringField;
    FDQueryCOD_BIN: TBCDField;
    FDQueryCOD_BANDEIRA_TEF: TBCDField;
    FDQueryCOD_AUTORIZACAO_TEF: TBCDField;
    FDQueryNUM_BIN_TEF: TBCDField;
    FDQueryNUM_NSU_HOST_TEF: TStringField;
    FDQueryNUM_NSU_SITEF: TStringField;
    FDQueryCOD_INSTITUICAO_TEF: TStringField;
    FDQueryCOD_ESTABELECIMENTO_TEF: TStringField;
    FDQueryCOD_TRANSACAO_TEF: TBCDField;
    FDQueryCOD_ADMINISTRADORA_TEF: TStringField;
    FDQueryDTA_EMISSAO_PGTO: TDateTimeField;
    FDQuerySELECTED: TBooleanField;
    FDQueryVAL_LIQUIDO: TFloatField;
    procedure btnPesquisarClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPesTitCart: TFormPesTitCart;

implementation

{$R *.dfm}

uses UDmConexao;

procedure TFormPesTitCart.btnPesquisarClick(Sender: TObject);
begin
  FDQuery.Close;
  FDQuery.ParamByName('PAR_LOJA').AsInteger:=1;
  FDQuery.ParamByName('PAR_DATA').AsDate:= DateTimePicker.Date;
  FDQuery.ParamByName('PAR_VALOR').AsFloat:= StrToFloat(Edit1.Text);
  FDQuery.Open;

  if FDQuery.IsEmpty then
  begin
    MessageDlg('Nenhum registro encontrado!', mtInformation, mbOKCancel,0);
  end
  else
  begin
    btnPesquisar.Visible:=False;
    btnAdicionar.Visible:=True;
  end;
end;


procedure TFormPesTitCart.DBGrid1CellClick(Column: TColumn);
begin
  if (Column.Field = FDQuerySELECTED) then
  begin
    FDQuery.Edit;
    FDQuery.FieldByName('SELECTED').AsBoolean:= not(FDQuery.FieldByName('SELECTED').AsBoolean);
    FDQuery.Post;
  end;
end;

procedure TFormPesTitCart.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if Column.Field = FDQuerySELECTED then
  begin
    DBGrid1.Canvas.FillRect(Rect);
    ImageList1.Draw(DBGrid1.Canvas, Rect.Left + 20,
      Rect.Top + 2, 24);
    if FDQuery.FieldByName('SELECTED').AsBoolean then
      ImageList1.Draw(DBGrid1.Canvas, Rect.Left + 20,
        Rect.Top + 2, 25)
    else
      ImageList1.Draw(DBGrid1.Canvas, Rect.Left + 20,
        Rect.Top + 2, 24);
  end;
end;

procedure TFormPesTitCart.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  if FDQuery.Active then
    if FDQuery.Locate('SELECTED', TRUE,[]) then
       ModalResult:= mrOk;

end;

end.
