unit UProvider;

interface

uses System.Classes;

type
  TProvider = class
    private
      FId : Integer;
      FProviderName : string;
      FCity : string;
      FStreet : string;
      FNumber : Integer;
      FCNPJ: string;
    FProviderDescription: string;
      procedure SetId(id : integer);
      procedure SetProviderName(name : string);
      procedure SetCity(city : string);
      procedure SetStreet(street : string);
      procedure SetNumber(number : Integer);
      procedure SetCNPJ(cnpj : string);
    procedure SetProviderDescription(const Value: string);
    public
      property Id: integer read FId write SetId;
      property ProviderName: string read FProviderName write SetProviderName;
      property City: string read FCity write SetCity;
      property Street: string read FStreet write SetStreet;
      property Number: Integer read FNumber write SetNumber;
      property CNPJ: string read FCNPJ write SetCNPJ;
      property ProviderDescription: string read FProviderDescription write SetProviderDescription;
  end;

implementation

{ TProvider }

procedure TProvider.SetCity(city: string);
begin
  Self.FCity := city;
end;

procedure TProvider.SetCNPJ(cnpj: string);
begin
  Self.FCNPJ := cnpj;
end;

procedure TProvider.SetId(id: integer);
begin
  Self.FId := id;
end;

procedure TProvider.SetNumber(number: Integer);
begin
  Self.FNumber := number;
end;

procedure TProvider.SetProviderDescription(const Value: string);
begin
  FProviderDescription := Value;
end;

procedure TProvider.SetProviderName(name: string);
begin
  Self.FProviderName := name;
end;

procedure TProvider.SetStreet(street: string);
begin
  Self.FStreet := street;
end;

end.
