program PKasir;

uses
  Forms,
  ULogin in 'ULogin.pas' {Frm_Login},
  UAjar in 'UAjar.pas' {Frm_Jual},
  UDM in 'UDM.pas' {DM: TDataModule},
  UTest in 'UTest.pas' {Frm_Test},
  UPustaka in 'UPustaka.pas',
  Ubayar in 'Ubayar.pas' {Frm_Bayar},
  URacik in 'URacik.pas' {Frm_Racik};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrm_Login, Frm_Login);
  Application.CreateForm(TFrm_Jual, Frm_Jual);
  Application.CreateForm(TFrm_Test, Frm_Test);
  Application.CreateForm(TFrm_Bayar, Frm_Bayar);
  Application.CreateForm(TFrm_Racik, Frm_Racik);
  Application.Run;
end.
