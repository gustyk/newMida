unit UDM;

interface

uses
  SysUtils, Classes, Dialogs, ZAbstractConnection, ZConnection, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, DBClient, Provider,
  MemDS, ZAbstractTable;
  // VirtualTable; // Comment dulu jika UNIDAC belum ter-install

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
    procedure DataModuleCreate(Sender: TObject);
    procedure CDS_StockAfterPost(DataSet: TDataSet);
    procedure CDS_StockAfterDelete(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure InisialisasiKoneksi();
  end;

var
  DM: TDM;

implementation

uses UDBSetup;

{$R *.dfm}

// *****************************************************************************
// Event DataModuleCreate
// Dipanggil saat DataModule pertama kali dibuat
// Digunakan untuk inisialisasi koneksi database
// *****************************************************************************
procedure TDM.DataModuleCreate(Sender: TObject);
begin
  InisialisasiKoneksi();
end;

// *****************************************************************************
// Procedure InisialisasiKoneksi
// Melakukan validasi dan inisialisasi koneksi ke database
// Jika database belum setup, akan menampilkan pesan error
// *****************************************************************************
procedure TDM.InisialisasiKoneksi();
begin
  // Pastikan koneksi disconnect dulu
  if Koneksi.Connected then
    Koneksi.Disconnect;
    
  try
    // Validasi database dan tabel
    ValidasiDatabase(Koneksi);
    
    // Jika lolos validasi, koneksi sudah connected di ValidasiDatabase
    if Koneksi.Connected then
    begin
      // Koneksi berhasil, tidak perlu pesan
      // ShowMessage('Koneksi database berhasil!');
    end;
  except
    on E: Exception do
    begin
      ShowMessage('Error saat inisialisasi database: ' + E.Message);
    end;
  end;
end;

procedure TDM.CDS_StockAfterPost(DataSet: TDataSet);
begin
  CDS_Stock.ApplyUpdates(0); 
end;

procedure TDM.CDS_StockAfterDelete(DataSet: TDataSet);
begin
  CDS_Stock.ApplyUpdates(0); 
end;

end.
