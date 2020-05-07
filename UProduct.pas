unit UProduct;

interface

uses UCategory;

type
  TProduct = class
    private
      ID : Integer;
      IDCategory : Integer;
      ProductName : string;
      ProductDescription : string;
      UnitPrice : Double;
      ProductPicture : string;
      Active : Boolean;
    public
      constructor Create(ID : Integer; IDCategory : Integer; productName : string;
      productDescription : string; unitPrice : Double; productPicture : string;
      active : Boolean); overload;
      constructor Create; overload;
      function GetIDCategory : Integer;
      function GetProductName : string;
      function GetProductDescription : string;
      function GetUnitPrice : Double;
      function GetProductPicture : string;
      function GetActive : Boolean;
      function GetID : Integer;
      procedure SetID(ID : Integer);
      procedure SetIDCategory(IDCategory : Integer);
      procedure SetProductName(productName : string);
      procedure SetProductDescription(productDescription : string);
      procedure SetUnitPrice(price : Double);
      procedure SetProductPicture(picturePath : string);
      procedure SetActive(active : Boolean);
  end;
implementation

{ TProduct }

constructor TProduct.Create;
begin
  inherited Create;
end;

constructor TProduct.Create(ID : Integer; IDCategory: Integer; productName,
  productDescription: string; unitPrice: Double; productPicture: string;
  active: Boolean);
begin
  Self.ID := ID;
  self.IDCategory := IDCategory;
  self.ProductName := productName;
  self.ProductDescription := productDescription;
  self.UnitPrice := unitPrice;
  self.ProductPicture := productPicture;
  self.Active := active;
end;

function TProduct.GetActive: Boolean;
begin
  Result := Self.Active;
end;

function TProduct.GetID: Integer;
begin
  Result := self.ID;
end;

function TProduct.GetIDCategory: Integer;
begin
  Result := Self.IDCategory;
end;

function TProduct.GetProductDescription: string;
begin
  Result := Self.ProductDescription;
end;

function TProduct.GetProductName: string;
begin
  Result := self.ProductName;
end;

function TProduct.GetProductPicture: string;
begin
  Result := self.ProductPicture;
end;

function TProduct.GetUnitPrice: Double;
begin
  Result := self.UnitPrice;
end;

procedure TProduct.SetActive(active: Boolean);
begin
  Self.Active := active;
end;

procedure TProduct.SetID(ID: Integer);
begin
  Self.ID := ID;
end;

procedure TProduct.SetIDCategory(IDCategory: Integer);
begin
  self.IDCategory := IDCategory;
end;

procedure TProduct.SetProductDescription(productDescription: string);
begin
  Self.ProductDescription := productDescription;
end;

procedure TProduct.SetProductName(productName: string);
begin
  self.ProductName := productName;
end;

procedure TProduct.SetProductPicture(picturePath: string);
begin
  self.ProductPicture := picturePath;
end;

procedure TProduct.SetUnitPrice(price: Double);
begin
  self.UnitPrice := price;
end;

end.
