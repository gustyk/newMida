unit UTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, ZAbstractConnection, ZConnection, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TFrm_Test = class(TForm)
    DBGrid1: TDBGrid;
    Btn_Exit: TButton;
    Koneksi_test: TZConnection;
    Query_test: TZQuery;
    DS_Tes: TDataSource;
    Query_Mst: TZQuery;
    DS_Mst: TDataSource;
    DBGrid2: TDBGrid;
    procedure Btn_ExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_Test: TFrm_Test;

implementation

uses UPustaka;


{$R *.dfm}

procedure TFrm_Test.Btn_ExitClick(Sender: TObject);
begin
  Koneksi_Test.Connect;
  Frm_Test.Close;
end;

procedure TFrm_Test.FormShow(Sender: TObject);
begin
 Koneksi_test.Connect;
 Buka_Query(Query_Test,'Select * From Tab_Obat_Dtl');
 Buka_Query(Query_Mst,'Select * from Tab_Obat_Mst');
end;

end.
