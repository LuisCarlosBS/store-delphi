unit DMStockDAO;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, UProvider, UProduct, System.Generics.Collections;

type
  TStockDAO = class(TDataModule)
    queryProvidersByProduct: TFDQuery;
    queryBestPriceByProduct: TFDQuery;
    queryUnitPriceByProviderAndProduct: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    function GetProvidersByProduct(product : TProduct) : TList<TProvider>;
    function GetBestPriceByProduct(product : TProduct) : Double;
    function GetUnitPriceByProviderAndProduct(product : TProduct; provider : TProvider) : Double;
  end;

var
  StockDAO: TStockDAO;

implementation

uses
  DMConnection, DMProviderDAO;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TStockDAO }

constructor TStockDAO.Create(AOwner: TComponent);
begin
  inherited;
  DMConnection.TConnection.Create(Self);
end;

function TStockDAO.GetBestPriceByProduct(product: TProduct): Double;
begin
  with queryBestPriceByProduct do
  begin
    Close;
    ParamByName('pIdProduct').AsInteger := product.GetID;
    Open;
    Result := FieldByName('MIN').AsFloat;
  end;
end;

function TStockDAO.GetProvidersByProduct(product: TProduct): TList<TProvider>;
var pDao : TProviderDAO;
providerList : TList<TProvider>;
provider : TProvider;
idProvider : integer;
nome : string;
begin
  pDao := TProviderDAO.Create(Self);
  providerList := TList<TProvider>.Create;
  try
    with queryProvidersByProduct do
    begin
      if Active then Close;
      ParamByName('pIdProduct').AsInteger := product.GetID;
      Open;
      while not queryProvidersByProduct.Eof do
      begin
        idProvider := FieldByName('IDProvider').AsInteger;
        provider := pDao.FindProviderById(idProvider);
        nome := provider.ProviderName;
        providerList.Add(provider);
        queryProvidersByProduct.Next;
      end;
    end;
    Result := providerList;
  finally
    pDao.Free;
  end;
end;

function TStockDAO.GetUnitPriceByProviderAndProduct(product: TProduct;
  provider: TProvider): Double;
begin
  with queryUnitPriceByProviderAndProduct do
  begin
    if Active then Close;
    ParamByName('pIdProduct').AsInteger := product.GetID;
    ParamByName('pIdProvider').AsInteger := provider.Id;
    Open;
    Result := FieldByName('UnitPrice').AsFloat;
  end;
end;

end.
