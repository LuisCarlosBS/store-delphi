unit UMainScreen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.Math, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, JvExForms,
  JvCustomItemViewer, JvImagesViewer, Vcl.Imaging.jpeg, JvScrollBox,
  Vcl.ComCtrls, System.Generics.Collections, UCategory, UProduct;

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
    labelPName: TLabel;
    procedure FormCreate(Sender: TObject);
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
  i: Integer;
begin
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
var i : integer;
begin
  scrollBoxCategoryResponsive;
  PositionProductPanels(180,225);
end;

procedure TForm1.loadCategoryPanels(categories: TList<TCategory>);
var i: Integer;
panel : TPanel;
begin
  for i := 0 to (categories.Count - 1) do
    begin
      panel := TPanel.Create(self);
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
      createdCategoryPanels.Add(panel);
    end;
end;

procedure TForm1.CreateProductPanels(products: TList<TProduct>);
var
  i, panelWidth, panelHeight: Integer;
  panel : TPanel;
  imageProduct : TImage;
  labelPrice, labelProvider, labelProductName : TLabel;
begin
  panelWidth := 180;
  panelHeight := 225;
  for i := 0 to (products.Count - 1) do
  begin
    panel := TPanel.Create(Self);
    imageProduct := TImage.Create(panel);
    labelProductName := TLabel.Create(panel);
    labelPrice := TLabel.Create(panel);
    labelProvider := TLabel.Create(panel);
    panel.Height := panelHeight;
    imageProduct.Height := 140;
    labelPrice.AutoSize := true;
    labelProvider.AutoSize := true;
    labelProductName.AutoSize := true;
    panel.Width := panelWidth;
    imageProduct.Width := 170;
    labelProductName.Caption := products.Items[i].GetProductName;
    labelProvider.Caption := 'Fornecido por: -----';
    labelPrice.Caption := 'Pre�o: R$ ' + FloatToStr(products.Items[i].GetUnitPrice).Replace('.',',');
    imageProduct.Picture.LoadFromFile(products.Items[i].GetProductPicture);
    imageProduct.Left := 5;
    imageProduct.Top := 5;
    labelProductName.Top := 160;
    labelPrice.Top := 180;
    labelProvider.Top := 200;
    labelProductName.Left := 8;
    labelPrice.Left := 8;
    labelProvider.Left := 8;
    imageProduct.Stretch := true;
    imageProduct.Parent := panel;
    labelProductName.Font.Size := 10;
    labelProductName.Parent := panel;
    labelPrice.Parent := panel;
    labelProvider.Parent := panel;
    createdProductPanels.Add(panel);
  end;
  PositionProductPanels(panelWidth, panelHeight);
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
  lines := Ceil((panelWidth * createdProductPanels.Count) / scrlbxProducts.Width);
  alreadyPositioned := 0;
  restToPosition := 0;
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
  panelCard.BevelOuter := TBevelCut.bvLowered;
end;

procedure TForm1.panelCardMouseLeave(Sender: TObject);
begin
  panelCard.BevelOuter := TBevelCut.bvRaised;
end;


end.
