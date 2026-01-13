// *****************************************************************************
// Unit UPustaka
// Adalah kumpulan procedure, function umum yang dapat digunakan untuk program
// lain.
//
// *****************************************************************************

unit UPustaka;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,ZAbstractRODataset,
  ZDataset, ZAbstractConnection, ZConnection;
 // Procedure-procedure yang Dapat di aksess dari unit lain yang menggunakannya
  function Rata_Kanan(P : Integer; angka : double): string;
  Procedure Buka_Query(Que : TZQuery; Perintah : String );
implementation

// *****************************************************************************
// Sementara panjang masih statis 20 space, ushakan menjadi parameter
//
// *****************************************************************************
function Rata_Kanan(P : Integer; angka : double): string;
begin
 DecimalSeparator := ',';              // siapa tahu setting dirubah user
 ThousandSeparator := '.';             // seperator harus diset spt ini
 result := format('%*s ',[P,formatFloat('#,##0.',angka)]);
end;

Procedure Buka_Query(Que : TZQuery; Perintah : String );
Begin
 Que.DisableControls;
 Try
   Que.Close;
   que.SQL.Clear;
   Que.SQL.Add(Perintah);
   Que.Open;
//   ShowMessage('Test Pustaka ');
 Finally
   Que.EnableControls;
 end;
end;

end.

