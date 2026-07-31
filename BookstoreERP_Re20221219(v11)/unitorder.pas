unit unitorder;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, DB, Forms, Controls, Graphics, Dialogs, DBGrids,
  StdCtrls;

type

  { TformOrder }

  TformOrder = class(TForm)
    btnNew: TButton;
    btnEdit: TButton;
    btnView: TButton;
    dataSource: TDataSource;
    gridOrder: TDBGrid;
    queryOrder: TSQLQuery;
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  formOrder: TformOrder;

implementation

{$R *.lfm}

{ TformOrder }

procedure TformOrder.FormCreate(Sender: TObject);
begin

end;

end.

