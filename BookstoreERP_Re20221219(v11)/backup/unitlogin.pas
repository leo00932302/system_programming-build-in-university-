unit unitlogin;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, unitsession;

type

  { TformLogin }

  TformLogin = class(TForm)
    btnLogin: TButton;
    GroupBox1: TGroupBox;
    sqlQuery: TSQLQuery;
    lbBookStoreName: TStaticText;
    txtUsername: TLabeledEdit;
    txtPassword: TLabeledEdit;
    procedure btnLoginClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private

  public

  end;

var
  formLogin: TformLogin;

implementation

{$R *.lfm}

{ TformLogin }

procedure TformLogin.btnLoginClick(Sender: TObject);
var user: string;
    pass: string;
begin
   user := txtUsername.Text;
   pass := txtPassword.Text;

   if user.Length <= 0 then
   begin
        Application.MessageBox(PChar('用戶名是必需的'), '錯誤');
        exit;
   end;

   if pass.Length <= 0 then
   begin
        Application.MessageBox(PChar('密碼是必需的'), '錯誤');
        exit;
   end;

   sqlQuery.SQL.Text := 'select * from 使用者資料 where 使用者編號=''' + user + '''';
   sqlQuery.Open;

   if sqlQuery.FieldByName('使用者編號').AsString <> user then
   begin
     Application.MessageBox(PChar('User not found'), '錯誤');
     exit;
   end;

   if sqlQuery.FieldByName('使用者密碼').AsString <> pass then
   begin
     Application.MessageBox(PChar('您的密碼不正確。 請再試一次！'), '錯誤');
     exit;
   end;

   Application.MessageBox(PChar('登錄成功'), '信息');

   //使用者職位
   unitsession.SetUserGroup(sqlQuery.FieldByName('使用者職位').AsString);
   formLogin.hide;

end;

procedure TformLogin.FormActivate(Sender: TObject);
begin
  txtUsername.Text := '';
  txtPassword.Text := '';
end;

end.

