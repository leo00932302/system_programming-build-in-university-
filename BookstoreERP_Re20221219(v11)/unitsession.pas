unit unitsession;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

procedure SetUserGroup(group : string);
function GetUserGroup() : string;

implementation

var userGroup : string;

procedure SetUserGroup(group : string);
begin
  userGroup := group;
end;

function GetUserGroup() : string;
begin
  GetUserGroup := userGroup;

end;

end.

