unit UProviderDetailsScreen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UProvider;

type
  TProviderDetailsScreen = class(TForm)
    labelProvideName: TLabel;
    labelProviderAddress: TLabel;
    labelCnpj: TLabel;
    labelDescriptionTitle: TLabel;
    labelProviderDescription: TLabel;
  private
    FProvider: TProvider;
    procedure SetProvider(const Value: TProvider);
    { Private declarations }
  public
    { Public declarations }
    property Provider: TProvider read FProvider write SetProvider;
    constructor Create(AOwner: TComponent); override;
    procedure CreateAll;
  end;

var
  ProviderDetailsScreen: TProviderDetailsScreen;

implementation

{$R *.dfm}

{ TProviderDetailsScreen }

constructor TProviderDetailsScreen.Create(AOwner: TComponent);
begin
  inherited;

end;

procedure TProviderDetailsScreen.CreateAll;
begin
  labelProvideName.Caption := Provider.ProviderName;
  labelProviderAddress.Caption := Provider.Street + ', ' + IntToStr(Provider.Number) + ' - ' + Provider.City;
  Caption := 'Loja - Detalhes ' + Provider.ProviderName;
  labelCnpj.Caption := 'CNPJ: ' + Provider.CNPJ.Insert(2, '.').Insert(6,'.').Insert(10,'/').Insert(15,'-');
  labelProviderDescription.Caption := Provider.ProviderDescription;
end;

procedure TProviderDetailsScreen.SetProvider(const Value: TProvider);
begin
  FProvider := Value;
end;

end.
