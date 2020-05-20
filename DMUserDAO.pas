unit DMUserDAO;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, UUser;

type
  TUserDAO = class(TDataModule)
    queryValidateLoginByUsername: TFDQuery;
    queryValidateLoginByEmail: TFDQuery;
    queryFindByEmail: TFDQuery;
    queryFindByUsername: TFDQuery;
    queryInsertAnUser: TFDQuery;
    queryUpdateProfilePicture: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function ValidateLoginByUsername(user: TUser): Boolean;
    function ValidateLoginByEmail(user: TUser): Boolean;
    function FindByEmail(email : string): Boolean;
    function FindByUsername(username : string): Boolean;
    function InsertUser(user : TUser) : Integer;
    procedure UpdateProfilePicture(user : TUser);
  end;

var
  UserDAO: TUserDAO;

implementation

uses
  DMConnection;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TUserDAO.DataModuleCreate(Sender: TObject);
begin
  DMConnection.TConnection.Create(self);
end;

function TUserDAO.FindByEmail(email: string): Boolean;
var
  res: Boolean;
begin
  res := False;
  with queryFindByEmail do
  begin
    ParamByName('pEmail').AsString := email;
    Open;
    if RowsAffected > 0 then res := true;
  end;
  Result := res;
end;

function TUserDAO.FindByUsername(username: string): Boolean;
var res : Boolean;
begin
  res := false;
  with queryFindByUsername do
  begin
    ParamByName('pUsername').AsString := username;
    Open;
    if RowsAffected > 0 then res := true;
  end;
  Result := res;
end;

function TUserDAO.InsertUser(user: TUser): Integer;
var id : integer;
begin
  with queryInsertAnUser do
  begin
    ParamByName('pUsername').AsString := user.Username;
    ParamByName('pPassword').AsString := user.Password;
    ParamByName('pDisplayName').AsString := user.DisplayName;
    ParamByName('pEmail').AsString := user.Email;
    ParamByName('pProfilePicture').AsString := user.ProfilePicture;
    Open;
    id := FieldByName('ID').AsInteger;
  end;
  Result := id;
end;

procedure TUserDAO.UpdateProfilePicture(user: TUser);
begin
  with queryUpdateProfilePicture do
  begin
    ParamByName('pProfilePicture').AsString := user.ProfilePicture;
    ParamByName('pId').AsInteger := user.Id;
    ExecSQL;
  end;
end;

function TUserDAO.ValidateLoginByEmail(user: TUser): Boolean;
var
  res: Boolean;
begin
  res := false;
  with queryValidateLoginByEmail do
  begin
    ParamByName('pEmail').AsString := user.Email;
    ParamByName('pPassword').AsString := user.Password;
    Open;
    if RowsAffected > 0 then res := true;
  end;
  Result := res;
end;

function TUserDAO.ValidateLoginByUsername(user: TUser): Boolean;
var
  res: Boolean;
begin
  res := false;
  with queryValidateLoginByUsername do
  begin
    ParamByName('pUsername').AsString := user.Username;
    ParamByName('pPassword').AsString := user.Password;
    Open;
    if RowsAffected > 0 then res := true;
  end;
  Result := res;
end;

end.

