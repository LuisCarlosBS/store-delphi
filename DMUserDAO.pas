unit DMUserDAO;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, UUser;

type
  TUserDAO = class(TDataModule)
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
    function ValidateLoginByEmail(user: TUser): Boolean;
    function IsEmailExists(email : string): Boolean;
    function FindByUsername(username : string): Boolean;
    function InsertUser(user : TUser) : Integer;
    function FindByEmail(user : TUser) : TUser;
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

function TUserDAO.IsEmailExists(email: string): Boolean;
begin
  with queryFindByEmail do
  begin
    ParamByName('pEmail').AsString := email;
    Open;
    Result := RowsAffected > 0;
  end;
end;

function TUserDAO.FindByEmail(user: TUser): TUser;
var newUser : TUser;
begin
  newUser := TUser.Create;
  with queryFindByEmail do
  begin
    ParamByName('pEmail').AsString := user.Email;
    Open;
    while not Eof do
    begin
      newUser.Id := FieldByName('ID').AsInteger;
      newUser.DisplayName := FieldByName('DisplayName').AsString;
      newUser.Email := FieldByName('Email').AsString;
      newUser.ProfilePicture := FieldByName('ProfilePicture').AsString;
      newUser.Employee := FieldByName('Employee').AsBoolean;
      Next;
    end;
  end;
  Result := newUser;
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
begin
  with queryValidateLoginByEmail do
  begin
    ParamByName('pEmail').AsString := user.Email;
    ParamByName('pPassword').AsString := user.Password;
    Open;
      Result := RowsAffected > 0;
  end;
end;

end.

