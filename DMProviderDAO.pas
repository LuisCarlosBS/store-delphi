unit DMProviderDAO;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, UProvider;

type
  TProviderDAO = class(TDataModule)
    queryFindProviderById: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function FindProviderById(id : Integer) : TProvider;
  end;

var
  ProviderDAO: TProviderDAO;

implementation

uses
  DMConnection;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TProviderDAO.DataModuleCreate(Sender: TObject);
begin
  DMConnection.TConnection.Create(Self);
end;

function TProviderDAO.FindProviderById(id: Integer): TProvider;
var provider : TProvider;
begin
  provider := TProvider.Create;
  with queryFindProviderById do
  begin
    Close;
    ParamByName('pId').AsInteger := id;
    Open;
    provider.Id := FieldByName('ID').AsInteger;
    provider.ProviderDescription := FieldByName('ProviderDescription').AsString;
    provider.ProviderName := FieldByName('ProviderName').AsString;
    provider.City := FieldByName('City').AsString;
    provider.Street := FieldByName('Street').AsString;
    provider.Number := FieldByName('Number').AsInteger;
    provider.CNPJ := FieldByName('CNPJ').AsString;
    Result := provider;
  end;
end;

end.
