unit DMConnection;

interface

uses
  Vcl.Dialogs, System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Phys.IBBase, Data.DB,
  FireDAC.Comp.Client, FireDAC.Comp.UI;

type
  TConnection = class(TDataModule)
    connection1: TFDConnection;
    fdphysfbdrvrlnk1: TFDPhysFBDriverLink;
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

var
  Connection: TConnection;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TConnection }

constructor TConnection.Create(AOwner: TComponent);
begin
  inherited;
  connection1.Params.Database := ExpandFileName(GetCurrentDir + '\..\..\Database\STOREDELPHI.fdb');
  fdphysfbdrvrlnk1.VendorLib := ExpandFileName(GetCurrentDir + '\..\..\Database\fbclient.dll');
  connection1.Connected := true;
end;

end.
