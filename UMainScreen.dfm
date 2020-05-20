object MainScreen: TMainScreen
  Left = 0
  Top = 0
  Width = 1257
  Height = 593
  HorzScrollBar.Range = 1241
  HorzScrollBar.Smooth = True
  HorzScrollBar.Tracking = True
  HorzScrollBar.Visible = False
  VertScrollBar.Range = 554
  VertScrollBar.Smooth = True
  VertScrollBar.Tracking = True
  Caption = 'Loja - Tela Principal'
  Color = clWhite
  Constraints.MinHeight = 350
  Constraints.MinWidth = 890
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDblClick = FormDblClick
  OnResize = FormResize
  DesignSize = (
    1241
    554)
  PixelsPerInch = 96
  TextHeight = 13
  object labelCategory: TLabel
    Left = 64
    Top = 10
    Width = 125
    Height = 33
    Caption = 'Categorias'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object labelProducts: TLabel
    Left = 290
    Top = 10
    Width = 106
    Height = 33
    Caption = 'Produtos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object imageProfilePicture: TImage
    Left = 1182
    Top = 6
    Width = 48
    Height = 48
    Anchors = [akTop, akRight]
    Stretch = True
  end
  object labelPesquisar: TLabel
    Left = 621
    Top = 23
    Width = 50
    Height = 13
    Anchors = [akTop]
    Caption = 'Pesquisar:'
  end
  object labelLogin: TLabel
    Left = 1072
    Top = 15
    Width = 104
    Height = 16
    Cursor = crHandPoint
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    Caption = 'Entrar / Cadastrar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlight
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnClick = labelLoginClick
  end
  object labelConnectionStatus: TLabel
    Left = 1097
    Top = 35
    Width = 79
    Height = 16
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    Caption = 'Desconectado'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object panelseparator: TPanel
    Left = 263
    Top = -1
    Width = 10
    Height = 555
    Anchors = [akLeft, akTop, akBottom]
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
  end
  object tEditSearch: TEdit
    Left = 736
    Top = 20
    Width = 210
    Height = 21
    Anchors = [akTop]
    AutoSize = False
    Color = clBtnHighlight
    TabOrder = 1
    OnChange = tEditSearchChange
  end
  object scrlbxCategories: TScrollBox
    Left = 4
    Top = 60
    Width = 253
    Height = 486
    VertScrollBar.Smooth = True
    VertScrollBar.Tracking = True
    Anchors = [akLeft, akTop, akBottom]
    Color = clBtnFace
    ParentColor = False
    TabOrder = 2
  end
  object scrlbxProducts: TScrollBox
    Left = 279
    Top = 60
    Width = 954
    Height = 486
    HorzScrollBar.Tracking = True
    VertScrollBar.Tracking = True
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = clBtnFace
    Padding.Left = 5
    Padding.Top = 5
    Padding.Right = 5
    Padding.Bottom = 5
    ParentColor = False
    TabOrder = 3
    object panelCard: TPanel
      Left = 5
      Top = 5
      Width = 180
      Height = 225
      Align = alCustom
      BevelWidth = 2
      ParentBackground = False
      TabOrder = 0
      Visible = False
      OnMouseEnter = panelCardMouseEnter
      OnMouseLeave = panelCardMouseLeave
      object imageProduct: TImage
        Left = 8
        Top = 8
        Width = 161
        Height = 138
        OnMouseEnter = panelCardMouseEnter
        OnMouseLeave = panelCardMouseLeave
      end
      object labelPrice: TLabel
        Left = 8
        Top = 180
        Width = 70
        Height = 13
        Caption = 'Pre'#231'o: R$ --,--'
      end
      object labelProvider: TLabel
        Left = 8
        Top = 200
        Width = 89
        Height = 13
        Caption = 'Fornecido por: ----'
      end
      object labelPName: TLabel
        Left = 8
        Top = 160
        Width = 16
        Height = 13
        Caption = '----'
      end
    end
  end
end
