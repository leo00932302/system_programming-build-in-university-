unit unitDashboard;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, MSSQLConn, Forms, Controls, Graphics, Dialogs,
  Menus, unitLogin, unitProcurement, unitsession;

type

  { TFormDashboard }

  TFormDashboard = class(TForm)
    MainMenu1: TMainMenu;
    A0: TMenuItem;
    A01: TMenuItem;
    A02: TMenuItem;
    B0: TMenuItem;
    B01: TMenuItem;
    B02: TMenuItem;
    C0: TMenuItem;
    C01: TMenuItem;
    C02: TMenuItem;
    MenuItem1: TMenuItem;
    D01: TMenuItem;
    D02: TMenuItem;
    E0: TMenuItem;
    E01: TMenuItem;
    E02: TMenuItem;
    F0: TMenuItem;
    F1: TMenuItem;
    F2: TMenuItem;
    sqlConnector: TSQLConnector;
    sqlTransaction: TSQLTransaction;
    procedure A01Click(Sender: TObject);
    procedure A02Click(Sender: TObject);
    procedure B01Click(Sender: TObject);
    procedure B02Click(Sender: TObject);
    procedure E01Click(Sender: TObject);
    procedure E02Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private

  public

  end;

var
  FormDashboard: TFormDashboard;

implementation
 uses unitproductserch,unitProductRevise;
{$R *.lfm}

{ TFormDashboard }

procedure TFormDashboard.A02Click(Sender: TObject);
begin
  close;
end;

procedure TFormDashboard.B01Click(Sender: TObject);
begin
  if not Assigned(FormProductSearch) then
   FormProductSearch :=TFormProductSearch.Create(FormDashboard);
   FormProductSearch.show
end;

procedure TFormDashboard.B02Click(Sender: TObject);
begin
   if not Assigned(FormProductRevise) then
   FormProductRevise :=TFormProductRevise.Create(FormDashboard);
   FormProductRevise.show
end;

procedure TFormDashboard.E01Click(Sender: TObject);
begin
  formProcurement.cmd:= 'E01';
  formProcurement.show();
end;

procedure TFormDashboard.E02Click(Sender: TObject);
begin
  formProcurement.cmd:= 'E02';
  formProcurement.show();
end;

procedure TFormDashboard.FormActivate(Sender: TObject);
var group : string;
begin
  group := GetUserGroup();

  if group.length <= 0 then exit;
  // Director
  if(group = '主管') then
  begin
    E01.Visible := True;
    E02.Visible:= True;

  end
  else
  begin
    E01.Visible := False;
    E02.Visible:=true;
  end;

end;

procedure TFormDashboard.A01Click(Sender: TObject);
begin
   formLogin.show();
end;

end.

