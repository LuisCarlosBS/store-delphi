unit UUser;

interface

type
  TUser = class
    private
      _Id : Integer;
      _Username : string;
      _Password : string;
      _DisplayName : string;
      _Email : string;
      _ProfilePicture : string;
      _Employee : Boolean;
    Fasesae: string;
      procedure SetId(id : Integer);
      procedure SetUsername(username : string);
      procedure SetPassword(password : string);
      procedure SetDisplayName(displayName : string);
      procedure SetEmail(email : string);
      procedure SetProfilePicture(profilePicture : string);
      procedure SetEmployee(isEmployee : Boolean);
    public
      property Id : Integer read _Id write SetId;
      property Username : string read _Username write SetUsername;
      property Password : string read _Password write SetPassword;
      property DisplayName : string read _DisplayName write SetDisplayName;
      property Email : string read _Email write SetEmail;
      property ProfilePicture : string read _ProfilePicture write SetProfilePicture;
      property Employee : Boolean read _Employee write SetEmployee;
  end;

implementation

{ TUser }

procedure TUser.SetDisplayName(displayName: string);
begin
  Self._DisplayName := displayName;
end;

procedure TUser.SetEmail(email: string);
begin
  Self._Email := email;
end;

procedure TUser.SetEmployee(isEmployee: Boolean);
begin
  Self._Employee := isEmployee;
end;

procedure TUser.SetId(id: Integer);
begin
  Self._Id := id;
end;

procedure TUser.SetPassword(password: string);
begin
  Self._Password := password;
end;

procedure TUser.SetProfilePicture(profilePicture: string);
begin
  Self._ProfilePicture := profilePicture;
end;

procedure TUser.SetUsername(username: string);
begin
  Self._Username := username;
end;

end.
