unit UAjar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, Menus, ExtCtrls;

type
  TFrm_Jual = class(TForm)
    Btn_Exit: TButton;
    Btn_Proses: TButton;
    Grid_Obat: TDBGrid;
    Grid_Jual: TDBGrid;
    Edt_Obat: TEdit;
    Edt_Barcode: TEdit;
    Lbl_BarCode: TLabel;
    Lbl_Nama: TLabel;
    Btn_History: TButton;
    Btn_Racik: TButton;
    Btn_Hapus: TButton;
    Btn_Batal: TButton;
    Btn_Refresh: TButton;
    Btn_Test: TButton;
    Button1: TButton;
    Menu: TMainMenu;
    File1: TMenuItem;
    ransaksi1: TMenuItem;
    Laporan1: TMenuItem;
    Konfigurasi1: TMenuItem;
    Jual1: TMenuItem;
    Masuk1: TMenuItem;
    Kirim1: TMenuItem;
    Retur1: TMenuItem;
    utupJual1: TMenuItem;
    utupbulan1: TMenuItem;
    Exit1: TMenuItem;
    Juallini1: TMenuItem;
    JualPeriode1: TMenuItem;
    BatalJual1: TMenuItem;
    Muasi1: TMenuItem;
    Retur2: TMenuItem;
    Bundelransaksii1: TMenuItem;
    BackUpDatabase1: TMenuItem;
    SettiingDatabase1: TMenuItem;
    Edt_GTotal: TEdit;
    procedure Btn_ExitClick(Sender: TObject);
    procedure BtnExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edt_ObatChange(Sender: TObject);
    procedure Grid_ObatDblClick(Sender: TObject);
    procedure Grid_ObatKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Btn_RacikClick(Sender: TObject);
    procedure Btn_HistoryClick(Sender: TObject);
    procedure Btn_TestClick(Sender: TObject);
    procedure Btn_ProsesClick(Sender: TObject);
    procedure Grid_JualKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_Jual: TFrm_Jual;

implementation

uses UDM, UTest,UPustaka,Ubayar,URacik, ULogin;

{$R *.dfm}

procedure TFrm_Jual.Btn_ExitClick(Sender: TObject);
begin
  DM.Koneksi.Connected  := false;
  application.Terminate;
end;

procedure TFrm_Jual.BtnExitClick(Sender: TObject);
begin
  DM.koneksi.Connected := false;
  Application.Terminate;
end;

procedure TFrm_Jual.FormShow(Sender: TObject);
begin
//  Edt_Obat.SetFocus;
  FRM_Login.show;
end;

// *****************************************************************************
// Jika ada perubahan di Edt_Obat maka Grid Obat akan menampilkan sesuai dengan
// Yang dipilih
// *****************************************************************************
procedure TFrm_Jual.Edt_ObatChange(Sender: TObject);
begin
 DM.CDS_Obat.Active := false;
 DM.Que_Obat.SQL.Text  := format('(select ID_Obat, Nama_obat, '+
 'harga, lokasi from Tab_Obat_mst'+
 ' where Nama_obat LIKE ''%s'')',[edt_Obat.Text+'%'] );
 DM.Que_Obat.Open;
 DM.CDS_Obat.Active := true;

end;

procedure TFrm_Jual.Grid_ObatDblClick(Sender: TObject);
begin
  with DM do
  begin
   VT.Active := True;
   VT.Append;
   VT.FieldByName('ID_OBAT').Asinteger := CDS_Obat.fieldbyName('ID_Obat').asinteger;
   VT.FieldByName('Nama_Obat').AsString := CDS_Obat.fieldbyName('Nama_obat').AsString;
   VT.FieldByName('Harga').AsString := CDS_Obat.fieldbyName('harga').AsString;
   VT.FieldByName('JUMLAH').AsString := '1';     // default = 1;
   Grid_Jual.EditorMode := true;               // Warna jadi biru
   Grid_JUal.Fields[3].FocusControl;            // Ke kolom Jumlah
  end;

end;

procedure TFrm_Jual.Grid_ObatKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_RETURN then
    Grid_ObatDblClick(Grid_Obat);
  if (Key = VK_UP) and (DM.VT.RecNo = 1) then begin
    edt_Obat.SelectAll;
    edt_Obat.SetFocus;
  end;
end;

procedure TFrm_Jual.Btn_RacikClick(Sender: TObject);
begin
  Frm_Racik.show();
end;

procedure TFrm_Jual.Btn_HistoryClick(Sender: TObject);
begin
  ShowMessage('Tampilkan window racik');
end;

procedure TFrm_Jual.Btn_TestClick(Sender: TObject);
var coba_Str : string;
begin
  coba_Str := Rata_Kanan(15,10000.5);
  ShowMessage('Batas Kiri'+Coba_Str+'Batas Kanan');
end;

procedure TFrm_Jual.Btn_ProsesClick(Sender: TObject);
begin
  Frm_Bayar.show();
end;

Procedure HitungSubTotal();
var HRG,JML,Diskon,DiskonRp,embalase,SubTotal,dis : real;
begin
  with DM do Begin
    DM.VT.Refresh;
    dm.VT.Edit;
    Hrg := strToFloat(VT.fieldByName('Harga').AsString);  // ini aman karena sudah di filter
    if not VT.fieldByName('Jumlah').IsNull then
       JML := VT.fieldByName('Jumlah').AsFloat else JML := 0;

//    If not VT.fieldByName('Diskon').IsNull then
//       Diskon := VT.fieldByName('Diskon').AsFloat else Diskon := 0;

    if not VT.fieldByName('Embalase').IsNull then
       embalase := VT.fieldByName('Embalase').AsFloat else embalase := 0;

    if not VT.fieldByName('DiskonRp').IsNull then
       DiskonRp := VT.fieldByName('DiskonRp').AsFloat else DiskonRp := 0;

//    if diskon >0 then diskonRp := VT.fieldByName('Harga').AsFloat *
//                                  VT.fieldByName('Jumlah').AsFloat * diskon /100;

    SubTotal := (hrg * jml) - DiskonRp + Embalase;
    VT.FieldByName('SubTotal').AsString := FloatToStr(SubTotal);
    Vt.FieldByName('subTotalStr').AsString := Rata_kanan(20,SubTotal);
//    Rata_kanan(20,
  end;
End;

Procedure HitungGrandTotal();
Var GrandTotal : real;
begin
  GrandTotal := 0;
  DM.VT.First;
  WHILE NOT dm.VT.Eof DO BEGIN
     GrandTotal := GrandTotal + DM.VT.fieldByName('SubTotal').AsFloat;
     dm.VT.Next;
  end;
  Frm_jual.Edt_GTotal.Text := Rata_kanan(20,GrandTotal);
end;

Procedure HitungDiskonRp();
var DiskonF,HargaF,JumlahF,DiskonRpF : real;
Begin
  DM.VT.Refresh;
  DM.VT.Edit;
  HargaF := DM.VT.fieldByName('Harga').AsFloat;
  JumlahF := DM.VT.fieldByName('Jumlah').AsFloat;
  if not DM.VT.fieldByName('Diskon').IsNull then
       DiskonF := DM.VT.fieldByName('Diskon').AsFloat else DiskonF := 0;

//  DiskonF := DM.VT.fieldByName('Diskon').AsFloat;
  DiskonRpF := hargaF * JumlahF * DiskonF/100;
  DM.VT.FieldByName('DiskonRp').AsString := FloatToStr(DiskonRpF);
end;

Procedure HitungDiskonPersen();
var DiskonF,HargaF,JumlahF,DiskonRpF : real;
begin
  DM.VT.Refresh;
  DM.VT.Edit;
  HargaF := DM.VT.fieldByName('Harga').AsFloat;
  JumlahF := DM.VT.fieldByName('Jumlah').AsFloat;
  DiskonRpF := DM.VT.fieldByName('DiskonRp').AsFloat;
  DiskonF :=  (DiskonRpF * 100 )/(hargaF * JumlahF);
  DM.VT.FieldByName('Diskon').AsString := FloatToStr(DiskonF);

end;

procedure TFrm_Jual.Grid_JualKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key = VK_RETURN then                    // Tekan Enter....????
   case (TstringGrid(Grid_Jual).Col ) of    // ya... Posisi :
    4 : Begin
        HitungSubTotal();
        HitungGrandTotal();
        TstringGrid(Grid_Jual).Col := 5;
        end;
    5 : Begin                               // Pada kolom Diskon
        HitungDiskonRp();
        HitungSubTotal();
        HitungGrandTotal();
        TstringGrid(Grid_Jual).Col := 6;
        end;
    6 : Begin                               // Pada kolom DiskonRp
        HitungDiskonPersen();
        HitungSubTotal();
        HitungGrandTotal();
        TstringGrid(Grid_Jual).Col := 7;
        end;
    7 : Begin                             // Pada kolom embalase
        HitungSubTotal();
        HitungGrandTotal();
        Edt_Obat.SetFocus;
        end;
  end else                               // Jika menekan bukan Enter, ...
  if key = VK_F4 then begin              // lalu menekan F4, dan pada kolom jumlah
    if (Grid_jual.SelectedField <> nil) and (Grid_jual.SelectedField.FieldName = 'Jumlah') then
   frm_racik.Show();                    // Tampilkan form Racik
  end;
end;

procedure TFrm_Jual.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case key of
    VK_F2 : begin
            ShowMessage('Saving');
            end;
    VK_F4 : Begin
            ShowMessage('Racik');
            end;
   end; // Case         
end;

end.

 // -------     Catatan cara ini Delphi akan berhenti pada exception ----------
 //             harus dijalankan pada file.exe --------------------------------
   if not TryStrToInt(DM.VT.FieldByName('DiskonRp').AsString,DiskonRp) then
     diskonRp := 0

    try JML := strToFloat(VT.fieldByName('Jumlah').AsString);
    except Jml := 0; end;

//    try Diskon := strToFloat(VT.fieldByName('Diskon').AsString);
    try Diskon := VT.fieldByName('Diskon').AsFloat;
    except Diskon := 0; End;

    try Diskon := strToFloat(VT.fieldByName('Diskon').AsString);
    except Diskon := 0; End;

    Try Embalase := strToFloat(VT.fieldByName('Embalase').AsString);
    except Embalase := 0; end;


