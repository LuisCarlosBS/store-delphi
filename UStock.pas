unit UStock;

interface

uses UProduct, UProvider;

type
  TStock = class
    private
      FId : integer;
      FProduct : TProduct;
      FProvider : TProvider;
      FQuantity: Integer;
    FUnitPrice: Double;
    procedure SetId(const Value: integer);
    procedure SetProduct(const Value: TProduct);
    procedure SetProvider(const Value: TProvider);
    procedure SetUnitPrice(const Value: Double);
    public
      property Id: integer read FId write SetId;
      property Product: TProduct read FProduct write SetProduct;
      property Provider: TProvider read FProvider write SetProvider;
      property Quantity: Integer read FQuantity;
      property UnitPrice: Double read FUnitPrice write SetUnitPrice;
  end;

implementation

{ TStock }

procedure TStock.SetId(const Value: integer);
begin
  FId := Value;
end;

procedure TStock.SetProduct(const Value: TProduct);
begin
  FProduct := Value;
end;

procedure TStock.SetProvider(const Value: TProvider);
begin
  FProvider := Value;
end;

procedure TStock.SetUnitPrice(const Value: Double);
begin
  FUnitPrice := Value;
end;

end.
