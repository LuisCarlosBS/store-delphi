unit ULoginScreen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.Buttons, Vcl.StdCtrls, UMainScreen;

type
  TLoginScreen = class(TForm)
    imageAvatar: TImage;
    labeledEditEmail: TLabeledEdit;
    buttonRegister: TButton;
    labeledEditPassword: TLabeledEdit;
    btnShowPassword: TSpeedButton;
    labelRecoverPassword: TLabel;
    buttonLogin: TButton;
    labelEmailStatus: TLabel;
    labelLoginStatus: TLabel;
    procedure btnShowPasswordClick(Sender: TObject);
    procedure buttonLoginClick(Sender: TObject);
    procedure buttonRegisterClick(Sender: TObject);
    procedure labeledEditEmailChange(Sender: TObject);
    procedure labeledEditPasswordChange(Sender: TObject);
  private
    { Private declarations }
    function IsEmailValid(email : string) : Boolean;
    function IsEmailExists(email : string) : Boolean;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;

  end;

var
  LoginScreen: TLoginScreen;
  MainScreen : TMainScreen;

implementation

uses
  URegisterScreen, UUser, DMUserDAO, UUtils;

{$R *.dfm}

procedure TLoginScreen.btnShowPasswordClick(Sender: TObject);
var passwordChar : Char;
begin
  passwordChar := labeledEditPassword.PasswordChar;
  if passwordChar = #0 then labeledEditPassword.PasswordChar := '*';
  if passwordChar = '*' then labeledEditPassword.PasswordChar := #0;
end;

procedure TLoginScreen.buttonLoginClick(Sender: TObject);
var dao : TUserDAO;
user, loggedUser : TUser;
begin
  dao := TUserDAO.Create(self);
  user := TUser.Create;
  try
    user.Email := labeledEditEmail.Text;
    user.Password := labeledEditPassword.Text;
    if not dao.ValidateLoginByEmail(user) then
    begin
      labelLoginStatus.Caption := 'A senha não condiz com o email digitado';
      labelLoginStatus.Font.Color := StringToColor('clRed');
      exit;
    end;
    loggedUser := dao.FindByEmail(user);
    MainScreen.ConfigUser(loggedUser);
    Close;
  finally
    dao.Free;
    user.Free;
  end;
end;

procedure TLoginScreen.buttonRegisterClick(Sender: TObject);
var registerScreen : TRegisterScreen;
begin
  registerScreen := TRegisterScreen.Create(Self);
  try
    registerScreen.ShowModal;
  finally
    registerScreen.Free;
  end;
end;

constructor TLoginScreen.Create(AOwner: TComponent);
begin
  inherited;
  MainScreen := (AOwner as TMainScreen);
end;

function TLoginScreen.IsEmailExists(email: string): Boolean;
var
dao : TUserDAO;
begin
  dao := TUserDAO.Create(Self);
  try
    Result := dao.IsEmailExists(email);
  finally
    dao.Free;
  end;
end;

function TLoginScreen.IsEmailValid(email: string): Boolean;
var
utils : TUtils;
begin
 utils := TUtils.Create;
 try
  Result := utils.ValidateEmail(email);
 finally
  utils.Free;
 end;
end;

procedure TLoginScreen.labeledEditEmailChange(Sender: TObject);
var email : string;
begin
  email := labeledEditEmail.Text;
  if not IsEmailValid(email) then
  begin
    labeledEditPassword.Visible := false;
    labelRecoverPassword.Visible := false;
    btnShowPassword.Visible := false;
    buttonLogin.Visible := false;
    labelEmailStatus.Caption := 'Email inválido.';
    labelEmailStatus.Font.Color := StringToColor('clRed');
    exit;
  end;

  if not IsEmailExists(email) then
  begin
    labeledEditPassword.Visible := false;
    labelRecoverPassword.Visible := false;
    btnShowPassword.Visible := false;
    buttonLogin.Visible := false;
    labelEmailStatus.Caption := 'Email não cadastrado.';
    labelEmailStatus.Font.Color := StringToColor('clRed');
    exit;
  end;
  labelEmailStatus.Caption := '';
  labeledEditPassword.Visible := true;
  labelRecoverPassword.Visible := true;
  btnShowPassword.Visible := true;
  buttonLogin.Visible := true;
end;

procedure TLoginScreen.labeledEditPasswordChange(Sender: TObject);
begin
  if labelLoginStatus.Caption = '' then exit;
  labelLoginStatus.Caption := '';
end;

end.
