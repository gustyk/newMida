unit Ubayar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFrm_Bayar = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    CB_CaraBayar: TComboBox;
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_Bayar: TFrm_Bayar;

implementation

{$R *.dfm}

procedure TFrm_Bayar.Button2Click(Sender: TObject);
begin
  Frm_bayar.Close;
end;

procedure TFrm_Bayar.FormCreate(Sender: TObject);
begin
  CB_CaraBayar.Items.Append('Tunai');
  CB_CaraBayar.Items.Append('Qris');
  CB_CaraBayar.Items.Append('BCA');
  CB_CaraBayar.Items.Append('BRI');
  CB_CaraBayar.Items.Append('BNI');
  CB_CaraBayar.Items.Append('Hallo DOC');
  CB_CaraBayar.Items.Append('BPJS');
end;

end.
