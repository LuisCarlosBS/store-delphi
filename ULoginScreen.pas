unit ULoginScreen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.Buttons, Vcl.StdCtrls;

type
  TLoginScreen = class(TForm)
    imageAvatar: TImage;
    labeledEditEmail: TLabeledEdit;
    buttonRegister: TButton;
    labeledEditPassword: TLabeledEdit;
    btnShowPassword: TSpeedButton;
    labelRecoverPassword: TLabel;
    procedure buttonRegisterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LoginScreen: TLoginScreen;

implementation

uses
  URegisterScreen;

{$R *.dfm}

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

end.
