unit UMainScreen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.Math, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, JvExForms,
  JvCustomItemViewer, JvImagesViewer, Vcl.Imaging.jpeg, JvScrollBox,
  Vcl.ComCtrls, System.Generics.Collections, UCategory, UProduct, UCategoryPanel, UProductPanel,
  JvExExtCtrls, JvExtComponent, JvItemsPanel, DMProductDAO, Vcl.DBCGrids,
  Vcl.Mask, Vcl.DBCtrls;

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
    procedure tEditSearchChange(Sender: TObject);


  private
    procedure loadCategoryPanels(categories : TList<TCategory>);
    procedure scrollBoxCategoryResponsive;
    procedure CreateProductPanels(productsList : TList<TProduct>);
    procedure PositionProductPanels(panelWidth : integer; panelHeight : integer; listToPosition : TList<TProductPanel>);
    procedure FilterProducts;
    procedure ValidatePicturesPath(pathList : TList<TProduct>; dao : TProductDAO);
  public
    { Public declarations }
  end;

var
  Form1 : TForm1;
  createdCategoryPanels : TList<TCategoryPanel>;
  createdProductPanels : TList<TProductPanel>;
  backupProductPanels : TList<TProductPanel>;

  products    : TList<TProduct>;

implementation

uses
 DMCategoryDAO;

{$R *.dfm}

procedure TForm1.FilterProducts;
var  filteredProducts : TList<TProduct>;
elem : TProduct;
  panel: TProductPanel;
  text,name : string;
begin
  if tEditSearch.GetTextLen = 0 then
  begin
    CreateProductPanels(products);
    exit;
  end;
  try
    filteredProducts := TList<TProduct>.Create;
    for elem in products do
    begin
      text := tEditSearch.Text;
      name := elem.GetProductName;
      if Trim(name.ToUpper).Contains(Trim(text.ToUpper)) then
      begin
        filteredProducts.Add(elem);
      end;
    end;
    CreateProductPanels(filteredProducts);
  finally
    filteredProducts.Clear;
    filteredProducts.Free;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var categoryDAO : TCategoryDAO;
    productDAO  : TProductDAO;
    categories  : TList<TCategory>;

begin
  try
    categoryDAO := TCategoryDAO.Create(self);
    productDAO := TProductDAO.Create(self);
    products := TList<TProduct>.Create;
    createdProductPanels := TList<TProductPanel>.Create;
    createdCategoryPanels := TList<TCategoryPanel>.Create;
    ValidatePicturesPath(productDAO.GetPictures, productDAO);
    scrlbxProducts.Color := TColor($E3E4E6);
    scrlbxCategories.Color := TColor($E3E4E6);
    categories := categoryDAO.getCategorias;
    loadCategoryPanels(categories);
    products := productDAO.GetProducts;
    CreateProductPanels(products);
  finally
    categoryDAO.Free;
    productDAO.Free;
  end;

end;

procedure TForm1.FormResize(Sender: TObject);
begin
  scrollBoxCategoryResponsive;
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
  PositionProductPanels(180,225,createdProductPanels);
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

procedure TForm1.CreateProductPanels(productsList: TList<TProduct>);
var
  i: Integer;
  panel,count: TProductPanel;
  productName, picturePath : string;
  price : Double;
begin
  if createdProductPanels.Count > 0 then
  begin
    for count in createdProductPanels do
    begin
      count.Free;  
    end;
    createdProductPanels.Clear;
  end;

  for i := 0 to Pred(productsList.Count) do
  begin
    panel := TProductPanel.Create(Self);
    productName := productsList[i].GetProductName;
    picturePath := productsList[i].GetProductPicture;
    price := productsList[i].GetUnitPrice;
    panel.CreateAll(scrlbxProducts,picturePath,productName,price);
    createdProductPanels.Add(panel);
  end;
  PositionProductPanels(panel.Width, panel.Height, createdProductPanels);
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

procedure TForm1.PositionProductPanels(panelWidth : integer; panelHeight : integer;
 listToPosition : TList<TProductPanel>);
var i,j, lines, restToPosition, alreadyPositioned: Integer;
begin
  if scrlbxProducts.Width = 0 then exit;
  lines := Ceil((panelWidth * listToPosition.Count) / scrlbxProducts.Width);
  alreadyPositioned := 0;
  for i := 0 to Pred(lines) do
  begin
    restToPosition := listToPosition.Count - alreadyPositioned;
    for j := 0 to Pred(restToPosition)  do
    begin
      if (((panelWidth * j) + panelWidth + 40) > scrlbxProducts.Width) then
      begin
      break;
      end;
      listToPosition.Items[alreadyPositioned].Top := ((panelHeight + 5) * i) + 5;
      listToPosition.Items[alreadyPositioned].Left := ((panelWidth + 5) * j) + 5;
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

procedure TForm1.tEditSearchChange(Sender: TObject);
begin
  FilterProducts;
end;


procedure TForm1.ValidatePicturesPath(pathList: TList<TProduct>; dao : TProductDAO);
var
  appPath, newPath: string;
  doesNotExists : TList<TProduct>;
  element: TProduct;
begin
  doesNotExists := TList<TProduct>.Create;
  for element in pathList do
  begin
    if not FileExists(element.GetProductPicture) then
    begin  
      doesNotExists.Add(element);
    end;
  end;
  if doesNotExists.Count = 0 then exit;
  appPath := ExtractFilePath(ParamStr(0));
  newPath := appPath + 'Pictures\';
  for element in doesNotExists do
  begin
    element.SetProductPicture(newPath + ExtractFileName(element.GetProductPicture));
  end;
  dao.UpdatePictures(doesNotExists);
end;

end.
