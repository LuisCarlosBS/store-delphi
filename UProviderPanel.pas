unit UProviderPanel;

interface

uses Vcl.ExtCtrls,Vcl.StdCtrls,Vcl.Controls, System.Classes, UCategory, System.Generics.Collections, Vcl.Graphics, System.UIConsts,
  UPRovider, UStock, System.SysUtils;

type
  TProviderPanel = class(TPanel)
  private
    FProvider: TProvider;
    LabelProviderName : TLabel;
    LabelProductPrice : TLabel;
    LabelViewDetails  : TLabel;
    FStock: TStock;
    FSelected: Boolean;
    procedure SetProvider(const Value: TProvider);
    procedure ConfigPanel(parent : TWinControl);
    procedure ConfigLabelProviderName;
    procedure ConfigLabelProductPrice;
    procedure ConfigLabelViewDetails;
    procedure SetStock(const Value: TStock);
    procedure SetSelected(Value : Boolean);
    procedure LabelViewDetailsOnClick(Sender : TObject);
  public
  property Provider: TProvider read FProvider write SetProvider;
  property Stock: TStock read FStock write SetStock;
  constructor Create(AOwner: TComponent); override;
  procedure CreateAll(Parent : TWinControl);
  function GetLabelProviderName : TLabel;
  function GetLabelProductPrice : TLabel;
  end;

implementation

uses
  UProviderDetailsScreen;

{ TProviderPanel }

constructor TProviderPanel.Create(AOwner: TComponent);
begin
  inherited;

end;

procedure TProviderPanel.CreateAll(Parent: TWinControl);
begin

  ConfigPanel(Parent);
  ConfigLabelProviderName;
  ConfigLabelViewDetails;
  ConfigLabelProductPrice;
end;

function TProviderPanel.GetLabelProductPrice: TLabel;
begin
  Result := Self.LabelProductPrice;
end;

function TProviderPanel.GetLabelProviderName: TLabel;
begin
  Result := Self.LabelProviderName;
end;


procedure TProviderPanel.LabelViewDetailsOnClick(Sender: TObject);
var screen : TProviderDetailsScreen;
begin
  screen := TProviderDetailsScreen.Create(Self);
  try
    screen.Provider := Self.Provider;
    screen.CreateAll;
    screen.ShowModal;
  finally
    screen.Free;
  end;
end;

procedure TProviderPanel.SetProvider(const Value: TProvider);
begin
  FProvider := Value;
end;

procedure TProviderPanel.SetSelected(Value: Boolean);
begin
  FSelected := Value;
end;

procedure TProviderPanel.SetStock(const Value: TStock);
begin
  FStock := Value;
end;

procedure TProviderPanel.ConfigLabelProductPrice;
begin
  Self.LabelProductPrice := TLabel.Create(Self);
  Self.LabelProductPrice.Top := 15;
  Self.LabelProductPrice.Left := 190;
  Self.LabelProductPrice.Font.Size := 15;
  Self.LabelProductPrice.Caption := 'R$ ' + FloatToStr(Stock.UnitPrice).Replace('.',',');
  Self.LabelProductPrice.Parent := Self;
end;

procedure TProviderPanel.ConfigLabelProviderName;
begin
  Self.LabelProviderName := TLabel.Create(Self);
  Self.LabelProviderName.Top := 15;
  Self.LabelProviderName.Left := 5;
  Self.LabelProviderName.Caption := Provider.ProviderName;
  Self.LabelProviderName.Parent := Self;
end;

procedure TProviderPanel.ConfigLabelViewDetails;
begin
  Self.LabelViewDetails := TLabel.Create(Self);
  Self.LabelViewDetails.Top := 35;
  Self.LabelViewDetails.Left := 5;
  Self.LabelViewDetails.Font.Style := [TFontStyle.fsItalic, TFontStyle.fsUnderline];
  Self.LabelViewDetails.Font.Color := StringToColor('clHighlight');
  Self.LabelViewDetails.Caption := 'Ver Detalhes';
  Self.LabelViewDetails.Cursor := StringToCursor('crHandPoint');
  Self.LabelViewDetails.OnClick := LabelViewDetailsOnClick;
  Self.LabelViewDetails.Parent := Self;
end;

procedure TProviderPanel.ConfigPanel(parent : TWinControl);
begin
  Height := 60;
  Width := 385;
  Self.Parent := parent;
  Self.ParentBackground := false;
  Self.ParentColor := false;
  Self.Cursor := StringToCursor('crHandPoint');
end;
end.
