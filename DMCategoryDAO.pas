unit DMCategoryDAO;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Phys.FBDef, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.IBBase, UCategory, System.Generics.Collections;

type
  TCategoryDAO = class(TDataModule)
    fdphysfbdrvrlnk1: TFDPhysFBDriverLink;
    connection1: TFDConnection;
    query1: TFDQuery;
    fdgxwtcrsr1: TFDGUIxWaitCursor;
  private
    { Private declarations }
  public
    function getCategorias : TList<TCategory>;
  end;

var
  CategoryDAO: TCategoryDAO;
  lista : TList<TCategory>;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TCategoryDAO.getCategorias: TList<TCategory>;
var
  name : string;
  i: Integer;
  category : TCategory;
begin
  lista := TList<TCategory>.Create;
  query1.SQL.Add('SELECT * FROM Categories');
  query1.Open;
  query1.First;
  for i := 0 to (query1.RowsAffected - 1) do
  begin
    category := TCategory.Create;
    name := query1.Table.Rows[i].GetData('Name');
    category.setName(name);
    lista.Add(category);
  end;

  Result := lista;
end;

end.
