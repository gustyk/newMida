unit URacik;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFrm_Racik = class(TForm)
    LblDosis: TLabel;
    Lbl_DosisObat: TLabel;
    Lbl_Bungkus: TLabel;
    Lbl_Jumlah: TLabel;
    Btn_Ok: TButton;
    Btn_Batal: TButton;
    Edt_Dosis: TEdit;
    Edt_DosisObat: TEdit;
    edt_Bungkus: TEdit;
    Edt_JmlObat: TEdit;
    procedure Btn_OkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Hitung_Obat();
    procedure Edt_DosisExit(Sender: TObject);
    procedure Edt_DosisObatExit(Sender: TObject);
    procedure edt_BungkusExit(Sender: TObject);
    procedure Btn_BatalClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_Racik: TFrm_Racik;

implementation

uses UDM;

{$R *.dfm}

Procedure TFrm_Racik.Hitung_Obat();
var dosis,obat,bungkus,jumlah : real;
begin
 dosis := strTofloat(Edt_Dosis.Text);
 Obat := strToFloat(Edt_DosisObat.Text);
 Bungkus := strToFloat(Edt_bungkus.Text);
 if Obat > 0 then Jumlah := (Bungkus* dosis)/obat;
 edt_JmlObat.Text := FloatToStr(jumlah);
end;

procedure TFrm_Racik.Btn_OkClick(Sender: TObject);
var dosis,obat,bungkus,jumlah : real;
begin
  DM.VT.FieldByName('Jumlah').Value := Edt_JmlObat.Text;
  Frm_Racik.Close;
end;

procedure TFrm_Racik.FormShow(Sender: TObject);
begin
 Edt_Dosis.Text := '0';
 Edt_DosisObat.Text := '0';
 Edt_bungkus.Text := '0';
 edt_JmlObat.Text := '0';
 edt_Dosis.SetFocus;
end;

procedure TFrm_Racik.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key =#13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0)
  end;
end;

procedure TFrm_Racik.Edt_DosisExit(Sender: TObject);
begin
  Hitung_Obat();
end;

procedure TFrm_Racik.Edt_DosisObatExit(Sender: TObject);
begin
  Hitung_Obat();
end;

procedure TFrm_Racik.edt_BungkusExit(Sender: TObject);
begin
    Hitung_Obat();
end;

procedure TFrm_Racik.Btn_BatalClick(Sender: TObject);
begin
  Frm_Racik.Close;
end;

end.
