unit UMainScreen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.Math, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, JvExForms,
  JvCustomItemViewer, JvImagesViewer, Vcl.Imaging.jpeg, JvScrollBox,
  Vcl.ComCtrls, System.Generics.Collections, UCategory, UProduct, UCategoryPanel, UProductPanel;

type
  TForm1 = class(TForm)
    panelseparator: TPanel;
    labelCategory: TLabel;
    labelProducts: TLabel;
    panelCard: TPanel;
    imageProfilePicture: TImage;
    tEditSearch: TEdit;
    labelPesquisar: TLabel;
    imageProduct: TImage;
    labelPrice: TLabel;
    labelProvider: TLabel;
    labelLogin: TLabel;
    labelConnectionStatus: TLabel;
    scrlbxCategories: TScrollBox;
    scrlbxProducts: TScrollBox;
    labelPName: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure panelCardMouseEnter(Sender: TObject);
    procedure panelCardMouseLeave(Sender: TObject);
    procedure panelCategoryClick(Sender : TObject);


  private
    procedure loadCategoryPanels(categories : TList<TCategory>);
    procedure scrollBoxCategoryResponsive;
    procedure CreateProductPanels(products : TList<TProduct>);
    procedure PositionProductPanels(panelWidth : integer; panelHeight : integer);
  public
    { Public declarations }
  end;

var
  Form1 : TForm1;
  createdCategoryPanels : TList<TPanel>;
  createdProductPanels : TList<TPanel>;


implementation

uses
 DMCategoryDAO, DMProductDAO;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var categoryDAO : TCategoryDAO;
    productDAO  : TProductDAO;
    categories  : TList<TCategory>;
    products    : TList<TProduct>;
begin
  scrlbxProducts.Color := TColor($E3E4E6);
  scrlbxCategories.Color := TColor($E3E4E6);
  categoryDAO := TCategoryDAO.Create(self);
  productDAO := TProductDAO.Create(self);
  createdCategoryPanels := TList<TPanel>.Create;
  createdProductPanels := TList<TPanel>.Create;
  categories := categoryDAO.getCategorias;
  loadCategoryPanels(categories);
  products := productDAO.GetProducts;
  CreateProductPanels(products);
  categoryDAO.Free;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  scrollBoxCategoryResponsive;
  PositionProductPanels(180,225);
  if (Width >= 1275) then
  begin
    labelPesquisar.Anchors := [akTop, akLeft];
    tEditSearch.Anchors := [akTop, akLeft];
  end
  else
  begin
    labelPesquisar.Anchors := [akTop];
    tEditSearch.Anchors := [akTop];
  end;

end;

procedure TForm1.loadCategoryPanels(categories: TList<TCategory>);
var i: Integer;
panel : TCategoryPanel;
begin
  for i := 0 to (categories.Count - 1) do
    begin
      panel := TCategoryPanel.Create(self);
      panel.OnClick := panelCategoryClick;
      panel.Name := 'panel' + categories.Items[i].getName;
      panel.Top := (50 * i) + 5;
      if i = 0 then panel.Top := 5;
      panel.Left := 5;
      panel.Caption := categories.Items[i].getName;
      panel.Parent := scrlbxCategories;
      createdCategoryPanels.Add(panel);
    end;
end;

procedure TForm1.CreateProductPanels(products: TList<TProduct>);
var
  i: Integer;
  panel : TProductPanel;
  productName, picturePath : string;
  price : Double;
begin
  for i := 0 to (products.Count - 1) do
  begin
    panel := TProductPanel.Create(Self);
    productName := products[i].GetProductName;
    picturePath := products[i].GetProductPicture;
    price := products[i].GetUnitPrice;
    panel.CreateAll(Self,picturePath,productName,price);
    createdProductPanels.Add(panel);
  end;
  PositionProductPanels(panel.Width, panel.Height);
end;

procedure TForm1.FormDblClick(Sender: TObject);
begin
    ShowMessage(width.ToString + #13);
    ShowMessage(height.ToString);
end;

procedure TForm1.panelCategoryClick(Sender : TObject);
var i: Integer;
panelSelected : TPanel;
begin
  panelSelected := nil;
  if (Sender as TPanel).BevelOuter = TBevelCut.bvRaised then
  begin
    for i := 0 to (createdCategoryPanels.Count - 1) do
    begin
      createdCategoryPanels[i].BevelOuter := TBevelCut.bvRaised;
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

procedure TForm1.PositionProductPanels(panelWidth : integer; panelHeight : integer);
var i,j, lines, restToPosition, alreadyPositioned: Integer;
begin
  if scrlbxProducts.Width = 0 then exit;
  lines := Ceil((panelWidth * createdProductPanels.Count) / scrlbxProducts.Width);
  alreadyPositioned := 0;
  for i := 0 to (lines - 1) do
  begin
    restToPosition := createdProductPanels.Count - alreadyPositioned;
    for j := 0 to restToPosition - 1  do
    begin
      if (((panelWidth * j) + panelWidth + 40) > scrlbxProducts.Width) then
      begin
      break;
      end;
      createdProductPanels.Items[alreadyPositioned].Top := ((panelHeight + 5) * i) + 5;
      createdProductPanels.Items[alreadyPositioned].Left := ((panelWidth + 5) * j) + 5;
      createdProductPanels.Items[alreadyPositioned].Parent := scrlbxProducts;
      alreadyPositioned := alreadyPositioned + 1;
    end;
  end;

end;

procedure TForm1.scrollBoxCategoryResponsive;
var i : integer;
begin
if scrlbxCategories.VertScrollBar.IsScrollBarVisible then
  begin
  for i := 0 to (createdCategoryPanels.Count - 1) do
    begin
      createdCategoryPanels[i].Width := 220;
    end;
end
else
begin
  for i := 0 to (createdCategoryPanels.Count - 1) do
    begin
      createdCategoryPanels[i].Width := 240;
    end;
end;
end;

procedure TForm1.panelCardMouseEnter(Sender: TObject);
begin
  //panelCard.BevelOuter := TBevelCut.bvLowered;
end;

procedure TForm1.panelCardMouseLeave(Sender: TObject);
begin
  //panelCard.BevelOuter := TBevelCut.bvRaised;
end;


end.
