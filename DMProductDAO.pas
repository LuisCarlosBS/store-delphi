unit DMProductDAO;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.VCLUI.Wait, FireDAC.Phys.IBBase, FireDAC.Comp.UI,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, UProduct, System.Generics.Collections;

type
  TProductDAO = class(TDataModule)
    queryLoadProducts: TFDQuery;
    query1: TFDQuery;
    queryUpdateProductPicture: TFDQuery;
    ds1: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    function GetProducts : TList<TProduct>;
    function GetPictures : TList<TProduct>;
    procedure UpdatePictures(lista : TList<TProduct>);
  end;

var
  ProductDAO: TProductDAO;
  products : TList<TProduct>;

implementation

uses
  DMConnection;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TProductDAO.DataModuleCreate(Sender: TObject);
begin
  DMConnection.TConnection.Create(self);
end;

{ TProductDAO }

function TProductDAO.GetPictures: TList<TProduct>;
var lista : TList<TProduct>;
product : TProduct;
begin
  lista := TList<TProduct>.Create;
  query1.Open;
  while not query1.Eof do
  begin
    product := TProduct.Create;
    product.SetID(query1.FieldByName('ID').AsInteger);
    product.SetProductPicture(query1.FieldByName('ProductPicture').AsString);
    lista.Add(product);
    query1.Next;
  end;
  Result := lista;
end;

function TProductDAO.GetProducts: TList<TProduct>;
var sql : string;
product : TProduct;
  i: Integer;
begin
  products := TList<TProduct>.Create;
  queryLoadProducts.SQL.Add(sql);
  queryLoadProducts.Open;
  while not queryLoadProducts.Eof do
  begin
    product := TProduct.Create;
    product.SetID(queryLoadProducts.FieldByName('ID').AsInteger);
    product.SetIDCategory(queryLoadProducts.FieldByName('IDCategory').AsInteger);
    product.SetProductName(queryLoadProducts.FieldByName('ProductName').AsString);
    product.SetProductDescription(queryLoadProducts.FieldByName('ProductDescription').AsString);
    product.SetUnitPrice(queryLoadProducts.FieldByName('UnitPrice').AsFloat);
    product.SetProductPicture(queryLoadProducts.FieldByName('ProductPicture').AsString);
    product.SetActive(queryLoadProducts.FieldByName('Active').AsBoolean);
    products.Add(product);
    queryLoadProducts.Next;
  end;
  Result := products;
end;

procedure TProductDAO.UpdatePictures(lista: TList<TProduct>);
var sql : string;
  path: TProduct;
begin
  sql := 'UPDATE Products SET ProductPicture = :pProductPicture WHERE ID = :pId';
  for path in lista do
  begin
    queryUpdateProductPicture.SQL.Clear;
    queryUpdateProductPicture.SQL.Add(sql);
    queryUpdateProductPicture.ParamByName('pProductPicture').AsString := path.GetProductPicture;
    queryUpdateProductPicture.ParamByName('pId').AsInteger := path.GetID;
    queryUpdateProductPicture.ExecSQL;   
  end;
end;

end.
