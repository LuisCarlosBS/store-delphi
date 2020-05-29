unit UProductPanel;

interface

uses Vcl.StdCtrls, Vcl.ExtCtrls, System.Classes, System.SysUtils, Vcl.Controls, Vcl.Graphics, UProduct, UProvider,
      System.Generics.Collections;

type
  TProductPanel = class(TPanel)
    private
      ProductImage : TImage;
      LabelProductName : TLabel;
      LabelProductPrice : TLabel;
      LabelProductProvider : TLabel;
      _IdCategory : integer;
      FProduct: TProduct;
    FProviders: TList<TProvider>;
      procedure ConfigPanel(parent : TWinControl);
      procedure ConfigProductImage;
      procedure ConfigProductName;
      procedure ConfigProductPrice;
      procedure ConfigProductProvider;
      procedure ProductPanelMouseEnter(Sender : TObject);
      procedure ProductPanelMouseLeave(Sender : TObject);
      procedure ProductPanelOnClick(Sender : TObject);
      procedure SetIdCategory(idCategory : Integer);
      procedure SetProduct(const Value: TProduct);
      procedure SetProviders(const Value: TList<TProvider>);
    public
      constructor Create(AOwner: TComponent); override;
      procedure CreateAll(Parent: TWinControl);
      function GetProductName : string;
      function GetProductPrice : Double;
      property IdCategory : Integer read _IdCategory write SetIdCategory;
      property Product: TProduct read FProduct write SetProduct;
      property Providers: TList<TProvider> read FProviders write SetProviders;
  end;

implementation

uses
  UProductScreen, DMStockDAO;

{ TProductPanel }

procedure TProductPanel.ConfigPanel(parent : TWinControl);
begin
  Height := 225;
  Width := 180;
  Self.Parent := parent;
  Self.ParentBackground := false;
  Self.ParentColor := false;
  Self.Cursor := StringToCursor('crHandPoint');
  Self.OnMouseEnter := ProductPanelMouseEnter;
  Self.OnMouseLeave := ProductPanelMouseLeave;
  Self.OnClick := ProductPanelOnClick;
end;

procedure TProductPanel.ConfigProductImage;
begin
  Self.ProductImage.Width := 170;
  Self.ProductImage.Height := 140;
  Self.ProductImage.Left := 5;
  Self.ProductImage.Top := 5;
  Self.ProductImage.Stretch := true;
  Self.ProductImage.Parent := self;
  Self.ProductImage.OnMouseEnter := ProductPanelMouseEnter;
  Self.ProductImage.OnMouseLeave := ProductPanelMouseLeave;
  Self.ProductImage.OnClick := ProductPanelOnClick;
end;

procedure TProductPanel.ConfigProductName;
begin
  Self.LabelProductName.AutoSize := True;
  Self.LabelProductName.Left := 8;
  Self.LabelProductName.Top := 160;
  Self.LabelProductName.Font.Size := 10;
  Self.LabelProductName.Parent := self;
  Self.LabelProductName.OnMouseEnter := ProductPanelMouseEnter;
  Self.LabelProductName.OnMouseLeave := ProductPanelMouseLeave;
  Self.LabelProductName.OnClick := ProductPanelOnClick;
end;

procedure TProductPanel.ConfigProductPrice;
begin
  Self.LabelProductPrice.AutoSize := True;
  Self.LabelProductPrice.Left := 8;
  Self.LabelProductPrice.Top := 180;
  Self.LabelProductPrice.Parent := self;
  Self.LabelProductPrice.OnMouseEnter := ProductPanelMouseEnter;
  Self.LabelProductPrice.OnMouseLeave := ProductPanelMouseLeave;
  Self.LabelProductPrice.OnClick := ProductPanelOnClick;
end;

procedure TProductPanel.ConfigProductProvider;
begin
  Self.LabelProductProvider.AutoSize := True;
  Self.LabelProductProvider.Left := 8;
  Self.LabelProductProvider.Top := 200;
  Self.LabelProductProvider.Parent := self;
  Self.LabelProductProvider.OnMouseEnter := ProductPanelMouseEnter;
  Self.LabelProductProvider.OnMouseLeave := ProductPanelMouseLeave;
  Self.LabelProductProvider.OnClick := ProductPanelOnClick;
end;

constructor TProductPanel.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TProductPanel.CreateAll(Parent: TWinControl);
var count : integer;
dao : TStockDAO;
begin
  dao := TStockDAO.Create(Self);
  Self.ProductImage := TImage.Create(Self);
  Self.LabelProductName := TLabel.Create(Self);
  Self.LabelProductPrice := TLabel.Create(self);
  Self.LabelProductProvider := TLabel.Create(self);
  Self._IdCategory := Product.GetIDCategory;
  Self.ProductImage.Picture.LoadFromFile(Product.GetProductPicture);
  Self.LabelProductName.Caption := Product.GetProductName;
  Self.LabelProductPrice.Caption := 'Melhor preço: R$ ' + FloatToStr(dao.GetBestPriceByProduct(Product)).Replace('.',',');
  Self.LabelProductProvider.Caption := 'Fornecido por %quantity% fornecedores'
  .Replace('%quantity%', IntToStr(Providers.Count));
  ConfigPanel(Parent);
  ConfigProductImage;
  ConfigProductName;
  ConfigProductPrice;
  ConfigProductProvider;
  dao.Free;
end;

function TProductPanel.GetProductName: string;
begin
  Result := Self.LabelProductName.Caption;
end;

function TProductPanel.GetProductPrice: Double;
begin
  Result := StrToFloat(Self.LabelProductPrice.Caption);
end;

procedure TProductPanel.ProductPanelMouseEnter(Sender: TObject);
var parent : TWinControl;
begin
  if (Sender is TPanel) then
  begin
    (Sender as TPanel).BevelOuter := TBevelCut.bvLowered;
    (Sender as TPanel).Color := TColor($BDBEBF);
  end;

  if (Sender is TImage) then
  begin
    parent := (Sender as TImage).Parent;
    (parent as TPanel).BevelOuter := TBevelCut.bvLowered;
    (parent as TPanel).Color := TColor($BDBEBF);
  end;

  if (Sender is TLabel) then
  begin
    parent := (Sender as TLabel).Parent;
    (parent as TPanel).BevelOuter := TBevelCut.bvLowered;
    (parent as TPanel).Color := TColor($BDBEBF);
  end;
end;

procedure TProductPanel.ProductPanelMouseLeave(Sender: TObject);
var parent : TWinControl;
begin
  if (Sender is TPanel) then
  begin
    (Sender as TPanel).BevelOuter := TBevelCut.bvRaised;
    (Sender as TPanel).Color := StringToColor('clBtnFace');
  end;

  if (Sender is TImage) then
  begin
    parent := (Sender as TImage).Parent;
    (parent as TPanel).BevelOuter := TBevelCut.bvRaised;
    (parent as TPanel).Color := StringToColor('clBtnFace');
  end;

  if (Sender is TLabel) then
  begin
    parent := (Sender as TLabel).Parent;
    (parent as TPanel).BevelOuter := TBevelCut.bvRaised;
    (parent as TPanel).Color := StringToColor('clBtnFace');
  end
end;

procedure TProductPanel.ProductPanelOnClick(Sender: TObject);
var screen : TProductScreen;
begin
  screen := TProductScreen.Create(Self);
  screen.Product := Self.Product;
  screen.Providers := Self.Providers;
  screen.CreateAll;
  try
      if (Sender is TPanel) then
      begin
        screen.ShowModal;
      end;

      if (Sender is TImage) then
      begin
        screen.ShowModal;
      end;

      if (Sender is TLabel) then
      begin
        screen.ShowModal;
      end
  finally
    screen.Free;
  end;
end;

procedure TProductPanel.SetIdCategory(idCategory: Integer);
begin
  Self._IdCategory := idCategory;
end;

procedure TProductPanel.SetProduct(const Value: TProduct);
begin
  FProduct := Value;
end;

procedure TProductPanel.SetProviders(const Value: TList<TProvider>);
begin
  FProviders := Value;
end;

end.
