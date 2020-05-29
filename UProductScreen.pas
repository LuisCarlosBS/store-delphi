unit UProductScreen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, UProduct, UProvider,
   System.Generics.Collections, UProviderPanel;

type
  TProductScreen = class(TForm)
    labelProductName: TLabel;
    imageProductImage: TImage;
    labelDescriptionTitle: TLabel;
    labelProductDescription: TLabel;
    labelProviderQuantity: TLabel;
    scrlbxProviders: TScrollBox;
    panelProvider: TPanel;
    labelProviderName: TLabel;
    labelProviderDetails: TLabel;
    labelProductPrice: TLabel;
    buttonBuy: TButton;
  private
    { Private declarations }
    FProduct : TProduct;
    FProviders: TList<TProvider>;
    procedure SetProduct(const Value: TProduct);
    procedure SetProviders(const Value: TList<TProvider>);
    procedure CreateProvidersPanels;
    procedure PositionProvidersPanels;
    procedure ProviderPanelOnClick(Sender : TObject);
  public
    { Public declarations }
    property Product: TProduct read FProduct write SetProduct;
    property Providers: TList<TProvider> read FProviders write SetProviders;
    constructor Create(AOwner: TComponent); overload; override;
    procedure CreateAll();

  end;

var
  ProductScreen: TProductScreen;
  createdProviderPanels : TList<TProviderPanel>;

implementation

uses
  UStock, DMStockDAO;

{$R *.dfm}

{ TForm1 }

constructor TProductScreen.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TProductScreen.CreateAll;
begin
  Caption := 'Loja - ' + Product.GetProductName;
  labelProductName.Caption := product.GetProductName;
  labelProviderQuantity.Caption := 'Fornecido por ' + IntToStr(providers.Count) + ' fornecedor(es)';
  labelProductDescription.Caption := product.GetProductDescription;
  imageProductImage.Picture.LoadFromFile(product.GetProductPicture);
  createdProviderPanels := TList<TProviderPanel>.Create;
  CreateProvidersPanels;
end;

procedure TProductScreen.CreateProvidersPanels;
var stock : TStock;
stockDao : TStockDAO;
provider: TProvider;
providerPanel : TProviderPanel;
begin
  stockDao := TStockDAo.Create(Self);
  try
    for provider in Self.Providers do
    begin
      stock := TStock.Create;
      stock.UnitPrice := stockDao.GetUnitPriceByProviderAndProduct(Self.Product, provider);
      providerPanel := TProviderPanel.Create(Self);
      providerPanel.Provider := provider;
      providerPanel.Stock := stock;
      providerPanel.CreateAll(scrlbxProviders);
      providerPanel.OnClick := ProviderPanelOnClick;
      providerPanel.GetLabelProviderName.OnClick := ProviderPanelOnClick;
      providerPanel.GetLabelProductPrice.OnClick := ProviderPanelOnClick;
      createdProviderPanels.Add(providerPanel);   
    end;
    PositionProvidersPanels;
  finally
    stockDao.Free;
  end;
end;

procedure TProductScreen.PositionProvidersPanels;
var i: Integer;
panel : TProviderPanel;
begin
  for i := 0 to Pred(createdProviderPanels.Count) do
  begin
    panel := createdProviderPanels.Items[i];
    panel.Left := 5;
    panel.Top := (i * (panel.Height + 5)) + 5;
    if i = 0 then panel.Top := 5;
  end;

end;

procedure TProductScreen.ProviderPanelOnClick(Sender: TObject);
var i: Integer;
parent : TWinControl;
providerSelected : TProviderPanel;
name : string;
begin
  if Sender is TProviderPanel then
  begin
  if (Sender as TProviderPanel).BevelOuter = TBevelCut.bvLowered then
    begin
      (Sender as TProviderPanel).BevelOuter := TBevelCut.bvRaised;
      providerSelected := nil;
      exit;
    end;
    for i := 0 to Pred(createdProviderPanels.Count) do
    begin
      createdProviderPanels[i].BevelOuter := TBevelCut.bvRaised;
    end;
    providerSelected := (Sender as TProviderPanel);
    (Sender as TProviderPanel).BevelOuter := TBevelCut.bvLowered;
  end
  else
  begin
    if not (Sender is TLabel) then
    begin
      providerSelected := nil;
      (Sender as TProviderPanel).BevelOuter := TBevelCut.bvRaised;
    end;
  end;

  if (Sender is TLabel) then
  begin
    name := (Sender as TLabel).Caption;
    parent := (Sender as TLabel).Parent;
    if (parent as TProviderPanel).BevelOuter = TBevelCut.bvLowered then
    begin
      (parent as TProviderPanel).BevelOuter := TBevelCut.bvRaised;
      providerSelected := nil;
      exit;
    end;
    for i := 0 to Pred(createdProviderPanels.Count) do
    begin
      createdProviderPanels[i].BevelOuter := TBevelCut.bvRaised;
    end;
    providerSelected := (parent as TProviderPanel);
    (parent as TProviderPanel).BevelOuter := TBevelCut.bvLowered;
  end
  else
  begin
    if not (Sender is TProviderPanel) then
    begin
      providerSelected := nil;
      (parent as TProviderPanel).BevelOuter := TBevelCut.bvRaised;
    end;
  end;
end;

procedure TProductScreen.SetProduct(const Value: TProduct);
begin
  FProduct := Value;
end;

procedure TProductScreen.SetProviders(const Value: TList<TProvider>);
begin
  FProviders := Value;
end;

end.
