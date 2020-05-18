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
    query1: TFDQuery;
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
  i: Integer;
  category : TCategory;
begin
  lista := TList<TCategory>.Create;
  query1.SQL.Add('SELECT * FROM Categories');
  query1.Open;
  while not query1.Eof do
  begin
    category := TCategory.Create;
    name := query1.FieldByName('CategoryName').AsString;
    category.setName(name);
    lista.Add(category);
    query1.Next;
  end;

  Result := lista;
end;

end.
