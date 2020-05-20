program LojaDelphi;

uses
  Vcl.Forms,
  UMainScreen in 'UMainScreen.pas' {MainScreen},
  Vcl.Themes,
  Vcl.Styles,
  UCategory in 'UCategory.pas',
  UProduct in 'UProduct.pas',
  DMCategoryDAO in 'DMCategoryDAO.pas' {CategoryDAO: TDataModule},
  DMProductDAO in 'DMProductDAO.pas' {ProductDAO: TDataModule},
  UCategoryPanel in 'UCategoryPanel.pas',
  UProductPanel in 'UProductPanel.pas',
  DMConnection in 'DMConnection.pas' {Connection: TDataModule},
  ULoginScreen in 'ULoginScreen.pas' {LoginScreen},
  URegisterScreen in 'URegisterScreen.pas' {RegisterScreen},
  UUser in 'UUser.pas',
  DMUserDAO in 'DMUserDAO.pas' {UserDAO: TDataModule},
  UUtils in 'UUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainScreen, MainScreen);
  Application.Run;
end.
