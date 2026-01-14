unit UDM;

interface

uses
  SysUtils, Classes, ZAbstractConnection, ZConnection, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, DBClient, Provider,
  MemDS, VirtualTable, ZAbstractTable;

type
  TDM = class(TDataModule)
    Que_Obat: TZQuery;
    DS_Obat: TDataSource;
    DSP_Obat: TDataSetProvider;
    CDS_OBAT: TClientDataSet;
    VT: TVirtualTable;
    DS_Jual: TDataSource;
    TabObtDet: TZTable;
    Que_stock: TZQuery;
    DS_Stock: TDataSource;
    DSP_Stock: TDataSetProvider;
    CDS_Stock: TClientDataSet;
    Koneksi: TZConnection;
    ZQuery1: TZQuery;
    procedure CDS_StockAfterPost(DataSet: TDataSet);
    procedure CDS_StockAfterDelete(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{$R *.dfm}

procedure TDM.CDS_StockAfterPost(DataSet: TDataSet);
begin
  CDS_Stock.ApplyUpdates(0); 
end;

procedure TDM.CDS_StockAfterDelete(DataSet: TDataSet);
begin
  CDS_Stock.ApplyUpdates(0); 
end;

end.
