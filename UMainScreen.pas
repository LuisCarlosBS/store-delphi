unit UMainScreen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, JvExForms,
  JvCustomItemViewer, JvImagesViewer, Vcl.Imaging.jpeg, JvScrollBox,
  Vcl.ComCtrls, System.Generics.Collections, UCategory;

type
  TForm1 = class(TForm)
    panelseparator: TPanel;
    labelCategory: TLabel;
    labelProducts: TLabel;
    panelCard: TPanel;
    imageProfilePicture: TImage;
    tEdit1: TEdit;
    label2: TLabel;
    imageProduct: TImage;
    labelPrice: TLabel;
    labelProvider: TLabel;
    labelLogin: TLabel;
    labelConnectionStatus: TLabel;
    scrlbxCategories: TScrollBox;
    scrlbxProducts: TScrollBox;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure panelCardMouseEnter(Sender: TObject);
    procedure panelCardMouseLeave(Sender: TObject);
    procedure panelCategoryClick(Sender : TObject);

  private
    procedure loadCategoryPanels(categories : TList<TCategory>);
    procedure scrollBoxCategoryResponsive;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  createdPanels : TList<TPanel>;



implementation

uses
 DMCategoryDAO;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var categoryDAO : TCategoryDAO;
  categories : TList<TCategory>;
begin
  categoryDAO := TCategoryDAO.Create(self);
  createdPanels := TList<TPanel>.Create;
  categories := categoryDAO.getCategorias;
  loadCategoryPanels(categories);
  categoryDAO.Free;
end;

procedure TForm1.FormResize(Sender: TObject);
var i : integer;
begin
  scrollBoxCategoryResponsive;
end;

procedure TForm1.loadCategoryPanels(categories: TList<TCategory>);
var i: Integer;
panel : TPanel;
begin
  for i := 0 to (categories.Count - 1) do
    begin
      panel := TPanel.Create(nil);
      panel.OnClick := panelCategoryClick;
      panel.Name := 'panel' + categories.Items[i].getName;
      panel.Height := 40;
      panel.Width := 240;
      panel.Cursor := StringToCursor('crHandPoint');
      panel.Top := (50 * i) + 5;
      if i = 0 then panel.Top := 5;
      panel.Left := 5;
      panel.Caption := categories.Items[i].getName;
      panel.Visible := true;
      panel.Parent := scrlbxCategories;
      createdPanels.Add(panel);
    end;
end;

procedure TForm1.panelCategoryClick(Sender : TObject);
var i: Integer;
panelSelected : TPanel;
begin
  if (Sender as TPanel).BevelOuter = TBevelCut.bvRaised then
  begin
    for i := 0 to (createdPanels.Count - 1) do
    begin
      createdPanels[i].BevelOuter := TBevelCut.bvRaised;
    end;
    panelSelected := (Sender as TPanel);
    (Sender as TPanel).BevelOuter := TBevelCut.bvLowered;
  end
  else
  begin
    panelSelected := nil;
    (Sender as TPanel).BevelOuter := TBevelCut.bvRaised;
  end;
end;

procedure TForm1.scrollBoxCategoryResponsive;
var i : integer;
begin
if scrlbxCategories.VertScrollBar.IsScrollBarVisible then
  begin
  for i := 0 to (createdPanels.Count - 1) do
    begin
      createdPanels[i].Width := 220;
    end;
end
else
begin
  for i := 0 to (createdPanels.Count - 1) do
    begin
      createdPanels[i].Width := 240;
    end;
end;
end;

procedure TForm1.panelCardMouseEnter(Sender: TObject);
begin
  panelCard.BevelOuter := TBevelCut.bvLowered;
end;

procedure TForm1.panelCardMouseLeave(Sender: TObject);
begin
  panelCard.BevelOuter := TBevelCut.bvRaised;
end;


end.
