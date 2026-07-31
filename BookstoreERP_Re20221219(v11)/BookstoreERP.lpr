program BookstoreERP;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, datetimectrls, unitDashboard, unitlogin, unitorder, unitprocurement,
  unitsession, unitProductSerch, unitProductRevise
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TFormDashboard, FormDashboard);
  Application.CreateForm(TformLogin, formLogin);
  Application.CreateForm(TformOrder, formOrder);
  Application.CreateForm(TformProcurement, formProcurement);
  Application.CreateForm(TFormProductSearch, FormProductSearch);
  Application.CreateForm(TFormProductRevise, FormProductRevise);
  Application.Run;
end.

