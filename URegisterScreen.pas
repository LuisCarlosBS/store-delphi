unit URegisterScreen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtDlgs, Vcl.ExtCtrls, System.RegularExpressions;

type
  TRegisterScreen = class(TForm)
    labeledEditUsername: TLabeledEdit;
    labeledEditPassword: TLabeledEdit;
    labeledEditDisplayName: TLabeledEdit;
    labeledEditEmail: TLabeledEdit;
    labeledEditRepeatPassword: TLabeledEdit;
    imageProfilePicture: TImage;
    dlgOpenPic1: TOpenPictureDialog;
    buttonRegister: TButton;
    buttonCancel: TButton;
    label2: TLabel;
    bvl1: TBevel;
    labelEmailStatus: TLabel;
    labelUsernameStatus: TLabel;
    labelPasswordStatus: TLabel;
    procedure buttonCancelClick(Sender: TObject);
    procedure buttonRegisterClick(Sender: TObject);
    procedure imageProfilePictureClick(Sender: TObject);
    //1 Regex
    procedure labeledEditEmailChange(Sender: TObject);
    procedure labeledEditPasswordChange(Sender: TObject);
    procedure labeledEditRepeatPasswordChange(Sender: TObject);
    procedure labeledEditUsernameChange(Sender: TObject);
  private
    { Private declarations }
    function ValidatePasswords(password : string; anotherPassword : string) : Boolean;
    function IsAnyFieldEmpty : Boolean;
    function UsernameExists(username : string) : Boolean;
    function EmailExists(email : string) : Boolean;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

var
  RegisterScreen: TRegisterScreen;

implementation

uses
  UUtils, DMUserDAO, UUser;

{$R *.dfm}

procedure TRegisterScreen.buttonCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TRegisterScreen.buttonRegisterClick(Sender: TObject);
var dir, pictureName,defaultPictureName : string;
dao : TUserDAO;
user : TUser;
id : integer;
utils : TUtils;
begin
  utils := TUtils.Create;
  if IsAnyFieldEmpty then
  begin
    Application.MessageBox('Preencha todos os campos.', 'Esqueceu de algo', MB_ICONEXCLAMATION + MB_OK + MB_SYSTEMMODAL);
    Exit;
  end;
  if UsernameExists(labeledEditUsername.Text) then
  begin
    Application.MessageBox('O usuário ja está cadastrado.', 'Ops', MB_ICONEXCLAMATION + MB_OK + MB_SYSTEMMODAL);
    labeledEditUsername.SetFocus;
    Exit;
  end;
  if EmailExists(labeledEditEmail.Text) then
  begin
    Application.MessageBox('O email ja está cadastrado.', 'Ops', MB_ICONEXCLAMATION + MB_OK + MB_SYSTEMMODAL);
    labeledEditEmail.SetFocus;
    Exit;
  end;
  if not utils.ValidateEmail(labeledEditEmail.Text) then
  begin
    Application.MessageBox('O email não é válido.', 'Ops', MB_ICONEXCLAMATION + MB_OK + MB_SYSTEMMODAL);
    labeledEditEmail.SetFocus;
    Exit;
  end;
  if ValidatePasswords(labeledEditPassword.Text, labeledEditRepeatPassword.Text) then
  begin
    Application.MessageBox('As senhas precisam ser iguais.', 'Ops', MB_ICONEXCLAMATION + MB_OK + MB_SYSTEMMODAL);
    labeledEditPassword.SetFocus;
    Exit;
  end;
  try
    dao := TUserDAO.Create(Self);
    user := TUser.Create;
    defaultPictureName := 'generic_profile_picture.jpg';
    dir := ExtractFileDir(ParamStr(0)) + '\Pictures\Users\';
    user.Username := labeledEditUsername.Text;
    user.Password := labeledEditPassword.Text;
    user.DisplayName := labeledEditDisplayName.Text;
    user.Email := labeledEditEmail.Text;
    user.ProfilePicture := '';
    id := dao.InsertUser(user);
    pictureName := IntToStr(id) + ExtractFileExt(dlgOpenPic1.FileName);
    user.Free;
    user := TUser.Create;
    user.Id := id;
    if dlgOpenPic1.FileName = '' then
    begin
      pictureName := defaultPictureName;
    end
    else
    begin
      imageProfilePicture.Picture.SaveToFile(dir + pictureName);
    end;
    user.ProfilePicture := dir + pictureName;
    dao.UpdateProfilePicture(user);
    Close;
  finally
    utils.Free;
    dao.Free;
    user.Free;
  end;

end;

constructor TRegisterScreen.Create(AOwner: TComponent);
begin
  inherited;
  imageProfilePicture.Picture.LoadFromFile(ExtractFileDir(ParamStr(0)) + '\Pictures\Users\generic_profile_picture.jpg');
end;

function TRegisterScreen.EmailExists(email: string): Boolean;
var dao : TUserDAO;
begin
  dao := TUserDAO.Create(Self);
  try
    Result := dao.IsEmailExists(email);
  finally
    dao.Free;
  end;
end;

procedure TRegisterScreen.imageProfilePictureClick(Sender: TObject);
begin
  if dlgOpenPic1.Execute then
  begin
    if FileExists(dlgOpenPic1.FileName) then
    begin
      imageProfilePicture.Picture.LoadFromFile(dlgOpenPic1.FileName);

    end;
  end;
end;

function TRegisterScreen.IsAnyFieldEmpty: Boolean;
begin
  Result := false;
  if (labeledEditUsername.Text = '') OR (labeledEditPassword.Text = '') OR (labeledEditDisplayName.Text = '')
  OR (labeledEditEmail.Text = '') OR (labeledEditRepeatPassword.Text = '') then Result := true;
end;

procedure TRegisterScreen.labeledEditEmailChange(Sender: TObject);
var util : TUtils;
email : string;
isValid, emailExists : Boolean;
dao : TUserDAO;
begin
 util := TUtils.Create;
 try
  email := labeledEditEmail.Text;
  isValid := util.ValidateEmail(email);
  if not isValid then
  begin
    labelEmailStatus.Caption := 'E-mail inválido';
    labelEmailStatus.Font.Color := StringToColor('clRed');
  end
  else
  begin
    dao := TUserDAO.Create(Self);
    labelEmailStatus.Caption := '';
    emailExists :=  Self.EmailExists(email);
    if emailExists then
    begin
      labelEmailStatus.Caption := 'E-mail já cadastrado';
    end
    else
    begin
      labelEmailStatus.Caption := '';
    end;
  end;
 finally
  util.Free;
  dao.Free;
 end;
end;

procedure TRegisterScreen.labeledEditPasswordChange(Sender: TObject);
var password, repeatPass : string;
begin
  if labeledEditRepeatPassword.GetTextLen = 0 then exit;
  password := labeledEditPassword.Text;
  repeatPass := labeledEditRepeatPassword.Text;
  ValidatePasswords(password, repeatPass);
end;

procedure TRegisterScreen.labeledEditRepeatPasswordChange(Sender: TObject);
var password, repeatPass : string;
begin
  if labeledEditPassword.GetTextLen = 0 then exit;
  password := labeledEditPassword.Text;
  repeatPass := labeledEditRepeatPassword.Text;
  ValidatePasswords(password, repeatPass);
end;

procedure TRegisterScreen.labeledEditUsernameChange(Sender: TObject);
var
username : string;
usernameExists : Boolean;
dao : TUserDAO;
begin
  dao := TUserDAO.Create(Self);
  try
    username := labeledEditUsername.Text;
    if labeledEditUsername.GetTextLen = 15 then
    begin
      labelUsernameStatus.Caption := 'No máximo 15 caracteres';
      labelUsernameStatus.Font.Color := StringToColor('clRed');
    end
    else
    begin
      labelUsernameStatus.Caption := '';
      usernameExists :=  Self.UsernameExists(username);
    if usernameExists then
    begin
      labelUsernameStatus.Caption := 'Usuário já cadastrado';
      labelUsernameStatus.Font.Color := StringToColor('clRed');
    end
    else
    begin
      labelUsernameStatus.Caption := '';
    end;
    end;
  finally
    dao.Free;
  end;
end;

function TRegisterScreen.UsernameExists(username: string): Boolean;
var dao : TUserDAO;
begin
  dao := TUserDAO.Create(Self);
  try
    Result := dao.FindByUsername(username);
  finally
    dao.Free;
  end;
end;

function TRegisterScreen.ValidatePasswords(password,
  anotherPassword: string) : Boolean;
begin
  if password <> anotherPassword then
  begin
    labelPasswordStatus.Caption := 'As senhas precisam ser iguais';
    labelPasswordStatus.Font.Color := StringToColor('clRed');
  end
  else
  begin
    labelPasswordStatus.Caption := '';
  end;
  Result := password <> anotherPassword;
end;

end.
