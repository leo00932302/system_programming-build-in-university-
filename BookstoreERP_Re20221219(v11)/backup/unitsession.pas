unit unitsession;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

procedure SetUserGroup(group : string);
function GetUserGroup() : string;

implementation

var userGroup : string;

end.

