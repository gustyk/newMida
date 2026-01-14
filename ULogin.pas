unit ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TFrm_Login = class(TForm)
    Btn_Ok: TButton;
    Edt_User: TEdit;
    Edt_Password: TEdit;
    Cmb_Shift: TComboBox;  // edt_Shift: TEdit; - Diganti ke ComboBox
    Lbl_User: TLabel;
    Lbl_Password: TLabel;
    lbl_shift: TLabel;
    procedure Btn_OkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    function ValidasiLogin(): Boolean;
  public
    { Public declarations }
  end;

var
  Frm_Login: TFrm_Login;

implementation

uses UAjar, UDM;

{$R *.dfm}

// *****************************************************************************
// Function ValidasiLogin
// Melakukan pengecekan username dan password ke database Tab_User
// Return: True jika login berhasil, False jika gagal
// *****************************************************************************
function TFrm_Login.ValidasiLogin(): Boolean;
var
  Qry: TZQuery;
begin
  Result := False;
  
  // Validasi input kosong
  if Trim(Edt_User.Text) = '' then
  begin
    ShowMessage('Username tidak boleh kosong!');
    Edt_User.SetFocus;
    Exit;
  end;
  
  if Trim(Edt_Password.Text) = '' then
  begin
    ShowMessage('Password tidak boleh kosong!');
    Edt_Password.SetFocus;
    Exit;
  end;
  
  // Query ke database untuk cek user dan password
  Qry := TZQuery.Create(nil);
  try
    Qry.Connection := DM.Koneksi;
    Qry.SQL.Text := 'SELECT nama, password FROM Tab_User WHERE nama = :username';
    Qry.ParamByName('username').AsString := Trim(Edt_User.Text);
    
    try
      Qry.Open;
      
      // Cek apakah user ditemukan
      if Qry.IsEmpty then
      begin
        ShowMessage('Username tidak ditemukan!');
        Edt_User.SetFocus;
        Edt_User.SelectAll;
        Exit;
      end;
      
      // Cek password
      if Qry.FieldByName('password').AsString <> Trim(Edt_Password.Text) then
      begin
        ShowMessage('Password salah!');
        Edt_Password.SetFocus;
        Edt_Password.SelectAll;
        Exit;
      end;
      
      // Login berhasil
      Result := True;
      
    except
      on E: Exception do
      begin
        ShowMessage('Error saat validasi login: ' + E.Message);
        Exit;
      end;
    end;
    
  finally
    Qry.Free;
  end;
end;

// *****************************************************************************
// Procedure Btn_OkClick
// Event handler untuk tombol OK
// Melakukan validasi login sebelum masuk ke form utama
// *****************************************************************************
procedure TFrm_Login.Btn_OkClick(Sender: TObject);
begin
  // Frm_Jual.show(); // Kode lama: langsung show tanpa validasi
  
  // Validasi login terlebih dahulu
  if ValidasiLogin() then
  begin
    Frm_Login.Hide;      // Sembunyikan form login
    Frm_Jual.Show;       // Tampilkan form utama
  end;
end;

// *****************************************************************************
// Procedure FormShow
// Event handler saat form ditampilkan
// Inisialisasi ComboBox Shift dan set focus ke Edt_User
// *****************************************************************************
procedure TFrm_Login.FormShow(Sender: TObject);
begin
  // Isi ComboBox Shift dengan pilihan shift
  Cmb_Shift.Items.Clear;
  Cmb_Shift.Items.Add('Pagi');
  Cmb_Shift.Items.Add('Siang');
  Cmb_Shift.Items.Add('Malam');
  Cmb_Shift.ItemIndex := 0;  // Default: Pagi
  
  // Set focus ke field user
  Edt_User.SetFocus;
end;

end.
