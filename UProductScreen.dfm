object ProductScreen: TProductScreen
  Left = 0
  Top = 0
  Caption = 'Loja Delphi - %productName%'
  ClientHeight = 598
  ClientWidth = 744
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object labelProductName: TLabel
    Left = 8
    Top = 8
    Width = 212
    Height = 33
    Caption = '%productName%'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object imageProductImage: TImage
    Left = 8
    Top = 64
    Width = 300
    Height = 300
    Stretch = True
  end
  object labelDescriptionTitle: TLabel
    Left = 8
    Top = 370
    Width = 73
    Height = 19
    Caption = 'Descri'#231#227'o:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object labelProductDescription: TLabel
    Left = 8
    Top = 408
    Width = 720
    Height = 137
    AutoSize = False
    Caption = '%productDescription%'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object labelProviderQuantity: TLabel
    Left = 432
    Top = 64
    Width = 231
    Height = 16
    Caption = 'Fornecido por %quantity% fornecedores'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object scrlbxProviders: TScrollBox
    Left = 328
    Top = 83
    Width = 400
    Height = 281
    VertScrollBar.Tracking = True
    TabOrder = 0
    object panelProvider: TPanel
      Left = 5
      Top = 5
      Width = 385
      Height = 60
      TabOrder = 0
      Visible = False
      object labelProviderName: TLabel
        Left = 5
        Top = 15
        Width = 104
        Height = 16
        Caption = '%providerName%'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object labelProviderDetails: TLabel
        Left = 5
        Top = 35
        Width = 60
        Height = 13
        Caption = 'Ver detalhes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHighlight
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsItalic, fsUnderline]
        ParentFont = False
      end
      object labelProductPrice: TLabel
        Left = 190
        Top = 15
        Width = 179
        Height = 24
        Caption = 'R$ %productPrice%'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object buttonBuy: TButton
    Left = 632
    Top = 560
    Width = 100
    Height = 30
    Caption = 'Comprar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
end
