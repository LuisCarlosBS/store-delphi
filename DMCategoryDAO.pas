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
    queryAllCategories: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    function getCategorias : TList<TCategory>;
  end;

var
  CategoryDAO: TCategoryDAO;
  lista : TList<TCategory>;

implementation

uses
  DMConnection;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TCategoryDAO.DataModuleCreate(Sender: TObject);
begin
  DMConnection.TConnection.Create(self);
end;

function TCategoryDAO.getCategorias: TList<TCategory>;
var
  name : string;
  i, id: Integer;
  category : TCategory;
begin
  lista := TList<TCategory>.Create;
  queryAllCategories.Open;
  while not queryAllCategories.Eof do
  begin
    category := TCategory.Create;
    name := queryAllCategories.FieldByName('CategoryName').AsString;
    id := queryAllCategories.FieldByName('ID').AsInteger;
    category.setName(name);
    category.SetId(id);
    lista.Add(category);
    queryAllCategories.Next;
  end;

  Result := lista;
end;

end.
