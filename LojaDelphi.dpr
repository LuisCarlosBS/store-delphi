program LojaDelphi;

uses
  Vcl.Forms,
  UMainScreen in 'UMainScreen.pas' {Form1},
  Vcl.Themes,
  Vcl.Styles,
  UCategory in 'UCategory.pas',
  UProduct in 'UProduct.pas',
  DMCategoryDAO in 'DMCategoryDAO.pas' {CategoryDAO: TDataModule},
  DMProductDAO in 'DMProductDAO.pas' {ProductDAO: TDataModule},
  UCategoryPanel in 'UCategoryPanel.pas',
  UProductPanel in 'UProductPanel.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
