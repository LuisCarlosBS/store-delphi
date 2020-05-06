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
    constructor Create(AOwner: TComponent); override;
  end;

var
  ProductDAO: TProductDAO;
  products : TList<TProduct>;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TProductDAO }

constructor TProductDAO.Create;
begin
  products := TList<TProduct>.Create;
end;

function TProductDAO.GetProducts: TList<TProduct>;
var sql : string;
product : TProduct;
begin
  sql := 'SELECT * FROM Products';
  queryLoadProducts.SQL.Add(sql);
  queryLoadProducts.Open;

end;

end.
