unit UProductPanel;

interface

uses Vcl.StdCtrls, Vcl.ExtCtrls, System.Classes, System.SysUtils, Vcl.Controls, Vcl.Graphics, UProduct;

type
  TProductPanel = class(TPanel)
    private
      ProductImage : TImage;
      LabelProductName : TLabel;
      LabelProductPrice : TLabel;
      LabelProductProvider : TLabel;
      _IdCategory : integer;
      procedure ConfigPanel(parent : TWinControl);
      procedure ConfigProductImage;
      procedure ConfigProductName;
      procedure ConfigProductPrice;
      procedure ConfigProductProvider;
      procedure ProductPanelMouseEnter(Sender : TObject);
      procedure ProductPanelMouseLeave(Sender : TObject);
      procedure SetIdCategory(idCategory : Integer);
    public
      constructor Create(AOwner: TComponent); override;
      procedure CreateAll(Parent: TWinControl; product : TProduct);
      function GetProductName : string;
      function GetProductPrice : Double;
      property IdCategory : Integer read _IdCategory write SetIdCategory;
  end;

implementation

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
end;

procedure TProductPanel.ConfigProductPrice;
begin
  Self.LabelProductPrice.AutoSize := True;
  Self.LabelProductPrice.Left := 8;
  Self.LabelProductPrice.Top := 180;
  Self.LabelProductPrice.Parent := self;
  Self.LabelProductPrice.OnMouseEnter := ProductPanelMouseEnter;
  Self.LabelProductPrice.OnMouseLeave := ProductPanelMouseLeave;
end;

procedure TProductPanel.ConfigProductProvider;
begin
  Self.LabelProductProvider.AutoSize := True;
  Self.LabelProductProvider.Left := 8;
  Self.LabelProductProvider.Top := 200;
  Self.LabelProductProvider.Parent := self;
  Self.LabelProductProvider.OnMouseEnter := ProductPanelMouseEnter;
  Self.LabelProductProvider.OnMouseLeave := ProductPanelMouseLeave;
end;

constructor TProductPanel.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TProductPanel.CreateAll(Parent: TWinControl; product : TProduct);
begin
  Self.ProductImage := TImage.Create(Self);
  Self.LabelProductName := TLabel.Create(Self);
  Self.LabelProductPrice := TLabel.Create(self);
  Self.LabelProductProvider := TLabel.Create(self);
  Self._IdCategory := product.GetIDCategory;
  Self.ProductImage.Picture.LoadFromFile(product.GetProductPicture);
  Self.LabelProductName.Caption := product.GetProductName;
  Self.LabelProductPrice.Caption := 'R$ ' + FloatToStr(product.GetUnitPrice).Replace('.',',');
  Self.LabelProductProvider.Caption := 'Fornecido por: ----';
  ConfigPanel(Parent);
  ConfigProductImage;
  ConfigProductName;
  ConfigProductPrice;
  ConfigProductProvider;
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

procedure TProductPanel.SetIdCategory(idCategory: Integer);
begin
  Self._IdCategory := idCategory;
end;

end.
