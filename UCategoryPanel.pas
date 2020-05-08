unit UCategoryPanel;

interface

uses Vcl.ExtCtrls, System.Classes, UCategory, System.Generics.Collections, Vcl.Graphics, System.UIConsts;

type
  TCategoryPanel = class(TPanel)
    private
      procedure CategoryPanelOnMouseEnter(Sender : TObject);
      procedure CategoryPanelOnMouseLeave(Sender : TObject);
      procedure ConfigPanel;
    public
      constructor Create(AOwner: TComponent); override;
  end;

implementation

{ TCategoryPanel }

procedure TCategoryPanel.CategoryPanelOnMouseEnter(Sender: TObject);
begin
  (Sender as TPanel).Color := TColor($BDBEBF);
end;

procedure TCategoryPanel.CategoryPanelOnMouseLeave(Sender: TObject);
begin
  (Sender as TPanel).Color := StringToColor('clBtnFace');
end;

procedure TCategoryPanel.ConfigPanel;
begin
  Self.Height := 40;
  Self.Width := 240;
  Self.Cursor := StringToCursor('crHandPoint');
  Self.ParentColor := false;
  Self.ParentBackground := False;
end;

constructor TCategoryPanel.Create(AOwner: TComponent);
begin
  inherited;
  Self.OnMouseEnter := CategoryPanelOnMouseEnter;
  Self.OnMouseLeave := CategoryPanelOnMouseLeave;
  ConfigPanel;
end;

end.
