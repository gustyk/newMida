unit ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFrm_Login = class(TForm)
    Btn_Ok: TButton;
    Edt_User: TEdit;
    Edt_Password: TEdit;
    edt_Shift: TEdit;
    Lbl_User: TLabel;
    Lbl_Password: TLabel;
    lbl_shift: TLabel;
    procedure Btn_OkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_Login: TFrm_Login;

implementation

uses UAjar;

{$R *.dfm}

procedure TFrm_Login.Btn_OkClick(Sender: TObject);
begin
  Frm_Jual.show();
end;

procedure TFrm_Login.FormShow(Sender: TObject);
begin
  Edt_User.SetFocus;
end;

end.
