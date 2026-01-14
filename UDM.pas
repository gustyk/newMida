unit UDM;

interface

uses
  SysUtils, Classes, Dialogs, DB, DBClient, Provider,
  ZAbstractConnection, ZConnection, ZAbstractRODataset, 
  ZAbstractDataset, ZDataset, ZAbstractTable,
  MemDS, VirtualTable;

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
  try
    // Pastikan database di-set ke 'apotek'
    if Koneksi.Database <> 'apotek' then
      Koneksi.Database := 'apotek';
    
    // Jika belum connected, connect sekarang
    if not Koneksi.Connected then
      Koneksi.Connect;
    
    // Validasi database dan tabel
    ValidasiDatabase(Koneksi);
    
    // Koneksi berhasil
    if Koneksi.Connected then
    begin
      // Koneksi database berhasil
    end;
  except
    on E: Exception do
    begin
      ShowMessage('Error saat inisialisasi database: ' + E.Message + #13#10 +
                  'Pastikan MySQL Server sudah running dan database apotek sudah dibuat.');
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
