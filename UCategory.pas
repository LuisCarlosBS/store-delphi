unit UCategory;

interface

uses System.SysUtils;

type
  TCategory = class
    private
     Id : integer;
     Name : String;
    public
    constructor Create(id : integer; name : string); overload;
    constructor Create; overload;
    function getName : String;
    function getId : Integer;
    procedure setName(name : string);
    procedure SetId(id : integer);

  end;

implementation

constructor TCategory.Create(id : integer; name: string);
begin
   self.Name := name;
   self.Id := id;
end;

constructor TCategory.Create;
begin
  inherited Create;
end;

function TCategory.getId: Integer;
begin
  Result := Self.Id;
end;

function TCategory.getName: String;
begin
  Result := self.Name;
end;

procedure TCategory.SetId(id: integer);
begin
  Self.Id := id;
end;

procedure TCategory.setName(name : string);
begin
  self.Name := name;
end;


end.
