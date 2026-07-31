unit unitProductSerch;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, MSSQLConn, DB, Forms, Controls, Graphics, Dialogs,
  DBGrids, StdCtrls;

type

  { TFormProductSearch }

  TFormProductSearch = class(TForm)
    Button1: TButton;
    Button2: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    Label1: TLabel;
    MSSQLConnection1: TMSSQLConnection;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  FormProductSearch: TFormProductSearch;

implementation

{$R *.lfm}

{ TFormProductSearch }

procedure TFormProductSearch.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  closeaction :=caFree;
     FormProductSearch :=nil;
end;

procedure TFormProductSearch.Button1Click(Sender: TObject);
begin
  if not SQLQuery1.Locate('顧客編號',Edit1.Text,[loPartialKey]) then begin
   showmessage('查無此顧客編號');
end
end;

procedure TFormProductSearch.Button2Click(Sender: TObject);
begin
  SQLQuery1.Locate('顧客名稱',Edit1.Text,[loPartialKey]);
end;

end.

