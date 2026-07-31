unit unitprocurement;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, SQLDB, Forms, Controls, Graphics, Dialogs, DBGrids,
  StdCtrls, DBCtrls, Spin, ExtCtrls, EditBtn, LCLType;

type

  { TformProcurement }

  TformProcurement = class(TForm)
    btnNew: TButton;
    btnPaid: TButton;
    btnSave: TButton;
    btnPrint: TButton;
    btnDelete: TButton;
    dataSource: TDataSource;
    dtPurchase: TDateEdit;
    gridProcurement: TDBGrid;
    GroupBox1: TGroupBox;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    txtProduct: TLabeledEdit;
    lbCode: TLabel;
    txtPublisher: TLabeledEdit;
    txtUnitPrice: TLabeledEdit;
    numQuantity: TSpinEdit;
    sqlProcurement: TSQLQuery;
    txtTotal: TLabeledEdit;
    procedure btnDeleteClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnPaidClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure dsProductDataChange(Sender: TObject; Field: TField);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure gridProcurementCellClick(Column: TColumn);
    procedure GroupBox1Click(Sender: TObject);
    procedure numQuantityChange(Sender: TObject);
    procedure txtUnitPriceChange(Sender: TObject);
  private
    var isSelected : boolean;

  public
     var cmd : string;
  end;

var
  formProcurement: TformProcurement;

implementation

{$R *.lfm}

{ TformProcurement }

procedure TformProcurement.FormActivate(Sender: TObject);
begin
   if cmd = 'E01' then
   begin
     formProcurement.Text := '商品采購(E01)';
     btnNew.Enabled := true;
     btnSave.Enabled := true;
     btnDelete.Enabled := true;

     btnPaid.Enabled := False;
     btnPrint.Enabled := False;
   end
   else
   begin
   formProcurement.Text := '應對付款管理(E02)';
    btnNew.Enabled := False;
    btnSave.Enabled := False;
    btnDelete.Enabled := False;

    btnPaid.Enabled := True;
    btnPrint.Enabled := True;
   end;

   //sqlProduct.Close;
   //sqlProduct.SQL.Text := 'select 商品名稱 from 商品資料';
  // sqlProduct.Open;

   //sqlProcurement.Close;
   gridProcurement.DataSource.DataSet.Active := False;
    sqlProcurement.SQL.Text := 'select * from 採購商品資料';
    sqlProcurement.Open;
    gridProcurement.DataSource.DataSet.Active := True;

end;

procedure TformProcurement.FormCreate(Sender: TObject);
begin

end;

procedure TformProcurement.gridProcurementCellClick(Column: TColumn);
var status : string;
begin
   isSelected := false;
   btnPaid.Enabled := false;

  if gridProcurement.SelectedRows.Count = 1 then
  begin
    isSelected := true;
    lbCode.Caption := gridProcurement.Datasource.Dataset.FieldByName('採購編號').AsString;
    txtProduct.Text := gridProcurement.Datasource.Dataset.FieldByName('商品名稱').AsString;
    txtPublisher.Text := gridProcurement.Datasource.Dataset.FieldByName('出版商').AsString;
    numQuantity.Value := gridProcurement.Datasource.Dataset.FieldByName('數量').AsInteger;
    txtUnitPrice.Text := gridProcurement.Datasource.Dataset.FieldByName('單價').AsString;
    txtTotal.Text := gridProcurement.Datasource.Dataset.FieldByName('總價').AsString;
    dtPurchase.Date := gridProcurement.Datasource.Dataset.FieldByName('採購日期').AsDateTime;

    status := gridProcurement.Datasource.Dataset.FieldByName('應付賬款狀態').AsString;

    if(cmd = 'E02') then
    begin
       if(status = '未付款') then btnPaid.Enabled := true;
    end;

    if(cmd = 'E01') then
    begin
       if(status = '未付款') then btnDelete.Enabled := true;
    end;

  end;
end;

procedure TformProcurement.GroupBox1Click(Sender: TObject);
begin

end;

procedure TformProcurement.numQuantityChange(Sender: TObject);
var unitPrice : integer;
   total : integer;
begin
  unitPrice := strToInt(txtUnitPrice.Text);
  total := numQuantity.Value * unitPrice;

  txtTotal.Text := IntToStr(total);

end;

procedure TformProcurement.txtUnitPriceChange(Sender: TObject);
var unitPrice : integer;
   total : integer;
begin
  unitPrice := strToInt(txtUnitPrice.Text);
  total := numQuantity.Value * unitPrice;

  txtTotal.Text := IntToStr(total);
end;

procedure TformProcurement.dsProductDataChange(Sender: TObject; Field: TField);
begin

end;

procedure TformProcurement.btnPaidClick(Sender: TObject);
var status : string;
begin
  if isSelected = false then
  begin
    Application.MessageBox(PChar('請選擇記錄'), '錯誤');
    exit;
  end;

  if Application.MessageBox('您要將此訂單的狀態更新為已付款嗎?', '確認', MB_YESNO) = IDYES  then
  begin
    status := '已付款'; // Paid
    sqlProcurement.Close;
    sqlProcurement.SQL.Text := 'update 採購商品資料 set 應付賬款狀態=:status where 採購編號=:code;';
    sqlProcurement.Params.ParamByName('code').AsString := lbCode.Caption;
    sqlProcurement.Params.ParamByName('status').AsString := status;

    sqlProcurement.ExecSQL;
    sqlProcurement.SQLTransaction.Commit;

    gridProcurement.DataSource.DataSet.Active := False;
    sqlProcurement.SQL.Text := 'select * from 採購商品資料';
    sqlProcurement.Open;
    gridProcurement.DataSource.DataSet.Active := True;

     Application.MessageBox(PChar('更新成功'), '信息');
  end;

end;

procedure TformProcurement.btnNewClick(Sender: TObject);
begin
  isSelected := false;

  lbCode.Caption := '將被分配';
  txtProduct.Text := '';
  numQuantity.Value := 1;
  txtUnitPrice.Text := '0';
  txtTotal.Text := '0';
  txtPublisher.Text := '';

end;

procedure TformProcurement.btnDeleteClick(Sender: TObject);
begin
  if isSelected = false then
  begin
    Application.MessageBox(PChar('請選擇記錄'), '錯誤');
    exit;
  end;

  if Application.MessageBox('是否要刪除此記錄？', '確認', MB_YESNO) = IDYES  then
  begin

    sqlProcurement.Close;
    sqlProcurement.SQL.Text := 'delete 採購商品資料 where 採購編號=:code;';
    sqlProcurement.Params.ParamByName('code').AsString := lbCode.Caption;

    sqlProcurement.ExecSQL;
    sqlProcurement.SQLTransaction.Commit;

    gridProcurement.DataSource.DataSet.Active := False;
    sqlProcurement.SQL.Text := 'select * from 採購商品資料';
    sqlProcurement.Open;
    gridProcurement.DataSource.DataSet.Active := True;

     Application.MessageBox(PChar('刪除成功'), '信息');
  end;
end;

procedure TformProcurement.btnPrintClick(Sender: TObject);
var f: Text;
begin
  if isSelected = false then
  begin
    Application.MessageBox(PChar('請選擇記錄'), '錯誤');
    exit;
  end;

  system.Assign(f,'C:\MY FILE\BookstoreERP-19-12-2022\Order.html'); // use AssignFile if you have SysUtils in your uses clause
  {$I-} // without this, if rewrite fails then a runtime error will be generated
  Rewrite(f);
  {$I+}
  if IOResult =0 then begin // OK, we can write the file
    system.WriteLn(f, '<table> <tr> <td> <img style="max-width: 50px" src="https://cdn-icons-png.flaticon.com/512/2232/2232688.png"/></td> <td><b>白沙網路書城系統</b><br/> <b>採購訂單</b><br/></td> <td> </tr></table><br/>');
    system.WriteLn(f, '<div style="font-family: Arial; font-size: 13px;">');

    system.WriteLn(f, '<b>採購内容</b><br/>');
    system.WriteLn(f, '<ul>');
    system.WriteLn(f, '<li>採購編號: ' + lbCode.Caption + '</li>');
    system.WriteLn(f, '<li>應付賬款狀態: ' + gridProcurement.Datasource.Dataset.FieldByName('應付賬款狀態').AsString + '</li>');

    system.WriteLn(f, '</ul>');
    system.WriteLn(f, '<table style="font-family: Arial; font-size: 12px; width: 555px; border: solid 1px black;border-collapse: collapse;">');
    system.WriteLn(f, '<thead><tr><th style="border: solid 1px black;">數字</th><th style="border: solid 1px black;">商品名稱</th><th style="border: solid 1px black;">單價</th><th style="border: solid 1px black;">數量</th><th style="border: solid 1px black;">總價</th></tr></thead>');
    system.WriteLn(f, '<tbody>');
    system.WriteLn(f, '<tr>');
       system.WriteLn(f, '<td style="border: solid 1px black; text-align: center">1</td>');
       system.WriteLn(f, '<td style="border: solid 1px black;">' + gridProcurement.Datasource.Dataset.FieldByName('商品名稱').AsString +'</td>');
       system.WriteLn(f, '<td style="border: solid 1px black;">' + gridProcurement.Datasource.Dataset.FieldByName('單價').AsString +'</td>');
       system.WriteLn(f, '<td style="border: solid 1px black;">' + gridProcurement.Datasource.Dataset.FieldByName('數量').AsString +'</td>');
       system.WriteLn(f, '<td style="border: solid 1px black;">' + gridProcurement.Datasource.Dataset.FieldByName('總價').AsString +'</td>');
       system.WriteLn(f, '</tr>');

  end else begin

  end;

  system.Close(f);

  executeprocess('C:\Program Files\Google\Chrome\Application\chrome.exe',['C:\MY FILE\BookstoreERP-19-12-2022\Order.html', '--print']);


end;

procedure TformProcurement.btnSaveClick(Sender: TObject);
var code : string;
    sqlCommand : string;
    index : integer;
begin

  if isSelected = true then
  begin
    sqlProcurement.SQL.Text := 'update 採購商品資料 set 商品名稱=:product, 採購日期=:date, 出版商=:publisher, 數量=:qty, 單價=:unitprice, 總價=:total where 採購編號=:code';
    sqlProcurement.Params.ParamByName('code').AsString := lbCode.Caption;
    sqlProcurement.Params.ParamByName('product').AsString := txtProduct.Text;
    sqlProcurement.Params.ParamByName('publisher').AsString := txtPublisher.Text;
    sqlProcurement.Params.ParamByName('qty').AsString := numQuantity.Text;
    sqlProcurement.Params.ParamByName('unitprice').AsString := txtUnitPrice.Text;

    sqlProcurement.Params.ParamByName('total').AsString := txtTotal.Text;
    sqlProcurement.Params.ParamByName('date').AsString := FormatDateTime('YYYY-MM-DD', dtPurchase.Date);

     sqlProcurement.Close;
    sqlProcurement.ExecSQL;
    sqlProcurement.SQLTransaction.Commit;

    gridProcurement.DataSource.DataSet.Active := False;
    sqlProcurement.SQL.Text := 'select * from 採購商品資料';
    sqlProcurement.Open;
    gridProcurement.DataSource.DataSet.Active := True;

    Application.MessageBox(PChar('更新成功'), '信息');

  end
  else
  begin
    sqlCommand := 'select 採購編號 from 採購商品資料';
    sqlProcurement.SQL.Text := sqlCommand;

    sqlProcurement.Open;
    sqlProcurement.Last;

    code := sqlProcurement.FieldByName('採購編號').AsString;

    if code.length <= 0 then
    begin
      code := 'B00001';
    end
    else
    begin
     code := copy(code, 2, 5);
     index := strtoint(code) + 1;
     code := inttostr(index);

    while(code.length < 5) do code := '0' + code;

    code := 'B' + code;

    lbCode.Caption := code;

    sqlProcurement.SQL.Text := 'insert into 採購商品資料 values(:code, :product, :date, :publisher, :qty, :unitprice, :status, :total)';
    sqlProcurement.Params.ParamByName('code').AsString := code;
    sqlProcurement.Params.ParamByName('product').AsString := txtProduct.Text;
    sqlProcurement.Params.ParamByName('publisher').AsString := txtPublisher.Text;
    sqlProcurement.Params.ParamByName('qty').AsString := numQuantity.Text;
    sqlProcurement.Params.ParamByName('unitprice').AsString := txtUnitPrice.Text;
    sqlProcurement.Params.ParamByName('status').AsString := '未付款';
    sqlProcurement.Params.ParamByName('total').AsString := txtTotal.Text;
    sqlProcurement.Params.ParamByName('date').AsString := FormatDateTime('YYYY-MM-DD', dtPurchase.Date);

     sqlProcurement.Close;
    sqlProcurement.ExecSQL;
    sqlProcurement.SQLTransaction.Commit;

    gridProcurement.DataSource.DataSet.Active := False;
    sqlProcurement.SQL.Text := 'select * from 採購商品資料';
    sqlProcurement.Open;
    gridProcurement.DataSource.DataSet.Active := True;

    Application.MessageBox(PChar('插入成功'), '信息');

    end;

  end;




end;

end.

