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
    connection1: TFDConnection;
    queryLoadProducts: TFDQuery;
    fdgxwtcrsr1: TFDGUIxWaitCursor;
    fdphysfbdrvrlnk1: TFDPhysFBDriverLink;
  private
    { Private declarations }
  public
    function GetProducts : TList<TProduct>;
  end;

var
  ProductDAO: TProductDAO;
  products : TList<TProduct>;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TProductDAO }

function TProductDAO.GetProducts: TList<TProduct>;
var sql : string;
product : TProduct;
  i: Integer;
begin
  sql := 'SELECT * FROM Products';
  products := TList<TProduct>.Create;
  queryLoadProducts.SQL.Add(sql);
  queryLoadProducts.Open;
  while not queryLoadProducts.Eof do
  begin
    product := TProduct.Create;
    product.SetID(queryLoadProducts.FieldByName('ID').AsInteger);
    product.SetIDCategory(queryLoadProducts.FieldByName('IDCategory').AsInteger);
    product.SetProductName(UTF8ToString(queryLoadProducts.FieldByName('ProductName').AsString));
    product.SetProductDescription(UTF8ToString(queryLoadProducts.FieldByName('ProductDescription').AsString));
    product.SetUnitPrice(queryLoadProducts.FieldByName('UnitPrice').AsFloat);
    product.SetProductPicture(UTF8ToString(queryLoadProducts.FieldByName('ProductPicture').AsString));
    product.SetActive(queryLoadProducts.FieldByName('Active').AsBoolean);
    products.Add(product);
    queryLoadProducts.Next;
  end;
  Result := products;
end;

end.
