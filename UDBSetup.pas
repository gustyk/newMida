// *****************************************************************************
// Unit UDBSetup
// Adalah unit yang berisi procedure untuk checking dan setup database otomatis
// Dipanggil saat aplikasi pertama kali dijalankan
//
// Fungsi:
// - Cek apakah database 'apotek' sudah ada
// - Cek apakah tabel-tabel sudah ada
// - Memberi notifikasi jika database belum setup
// *****************************************************************************

unit UDBSetup;

interface

uses
  SysUtils, Classes, Dialogs, ZAbstractConnection, ZConnection,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

  // Procedure untuk cek database
  function CekDatabaseAda(Koneksi: TZConnection): Boolean;
  function CekTabelAda(Koneksi: TZConnection; NamaTabel: String): Boolean;
  procedure ValidasiDatabase(Koneksi: TZConnection);

implementation

// *****************************************************************************
// Function CekDatabaseAda
// Mengecek apakah database 'apotek' sudah ada di MySQL
// Return: True jika ada, False jika tidak ada
// *****************************************************************************
function CekDatabaseAda(Koneksi: TZConnection): Boolean;
var
  Query: TZQuery;
begin
  Result := False;
  Query := TZQuery.Create(nil);
  try
    Query.Connection := Koneksi;
    
    // Cek koneksi dulu
    if not Koneksi.Connected then
    begin
      try
        // Connect tanpa database spesifik
        Koneksi.Database := '';
        Koneksi.Connect;
      except
        on E: Exception do
        begin
          ShowMessage('Error koneksi ke MySQL Server: ' + E.Message + #13#10 +
                     'Pastikan MySQL Server sudah running!');
          Exit;
        end;
      end;
    end;

    // Query untuk cek database apotek
    Query.SQL.Text := 'SHOW DATABASES LIKE ''apotek''';
    Query.Open;
    
    if not Query.IsEmpty then
      Result := True;
      
    Query.Close;
  finally
    Query.Free;
  end;
end;

// *****************************************************************************
// Function CekTabelAda
// Mengecek apakah tabel tertentu sudah ada di database apotek
// Parameter: NamaTabel = nama tabel yang mau dicek
// Return: True jika ada, False jika tidak ada
// *****************************************************************************
function CekTabelAda(Koneksi: TZConnection; NamaTabel: String): Boolean;
var
  Query: TZQuery;
begin
  Result := False;
  Query := TZQuery.Create(nil);
  try
    Query.Connection := Koneksi;
    
    // Pastikan sudah connect ke database apotek
    if Koneksi.Database <> 'apotek' then
      Koneksi.Database := 'apotek';
      
    if not Koneksi.Connected then
      Koneksi.Connect;

    // Query untuk cek tabel
    Query.SQL.Text := Format('SHOW TABLES LIKE ''%s''', [NamaTabel]);
    Query.Open;
    
    if not Query.IsEmpty then
      Result := True;
      
    Query.Close;
  finally
    Query.Free;
  end;
end;

// *****************************************************************************
// Procedure ValidasiDatabase
// Melakukan validasi lengkap database dan tabel-tabel yang diperlukan
// Jika ada yang kurang, akan menampilkan pesan kepada user
// *****************************************************************************
procedure ValidasiDatabase(Koneksi: TZConnection);
var
  PesanError: String;
  AdaError: Boolean;
begin
  AdaError := False;
  PesanError := '';

  // Cek database apotek
  if not CekDatabaseAda(Koneksi) then
  begin
    AdaError := True;
    PesanError := PesanError + '- Database "apotek" belum dibuat' + #13#10;
  end
  else
  begin
    // Jika database ada, cek tabel-tabel penting
    Koneksi.Database := 'apotek';
    
    if not CekTabelAda(Koneksi, 'Tab_Obat_Mst') then
    begin
      AdaError := True;
      PesanError := PesanError + '- Tabel "Tab_Obat_Mst" belum dibuat' + #13#10;
    end;
    
    if not CekTabelAda(Koneksi, 'Tab_Obat_Dtl') then
    begin
      AdaError := True;
      PesanError := PesanError + '- Tabel "Tab_Obat_Dtl" belum dibuat' + #13#10;
    end;
    
    if not CekTabelAda(Koneksi, 'Tab_Transaksi_Hdr') then
    begin
      AdaError := True;
      PesanError := PesanError + '- Tabel "Tab_Transaksi_Hdr" belum dibuat' + #13#10;
    end;
    
    if not CekTabelAda(Koneksi, 'Tab_User') then
    begin
      AdaError := True;
      PesanError := PesanError + '- Tabel "Tab_User" belum dibuat' + #13#10;
    end;
  end;

  // Jika ada error, tampilkan pesan
  if AdaError then
  begin
    ShowMessage('DATABASE BELUM SETUP!' + #13#10 + #13#10 +
                'Silakan setup database terlebih dahulu:' + #13#10 +
                PesanError + #13#10 +
                'Cara setup:' + #13#10 +
                '1. Buka phpMyAdmin (http://localhost/phpmyadmin)' + #13#10 +
                '2. Jalankan SQL script di folder: database\' + #13#10 +
                '   - 01_create_database.sql' + #13#10 +
                '   - 02_create_tables.sql' + #13#10 +
                '   - 03_initial_data.sql (optional)' + #13#10 + #13#10 +
                'Lihat file: database\README.md untuk panduan lengkap');
  end
  else
  begin
    // Database OK, lanjut connect
    if not Koneksi.Connected then
    begin
      Koneksi.Database := 'apotek';
      Koneksi.Connect;
    end;
  end;
end;

end.
