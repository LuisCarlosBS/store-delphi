object ProviderDetailsScreen: TProviderDetailsScreen
  Left = 0
  Top = 0
  Caption = 'Loja - Detalhes %providerName%'
  ClientHeight = 232
  ClientWidth = 361
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
  object labelProvideName: TLabel
    Left = 8
    Top = 8
    Width = 219
    Height = 33
    Caption = '%providerName%'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object labelProviderAddress: TLabel
    Left = 8
    Top = 56
    Width = 117
    Height = 16
    Caption = '%providerAddress%'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object labelCnpj: TLabel
    Left = 8
    Top = 75
    Width = 97
    Height = 16
    Caption = '%providerCnpj%'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object labelDescriptionTitle: TLabel
    Left = 8
    Top = 104
    Width = 50
    Height = 13
    Caption = 'Descri'#231#227'o:'
  end
  object labelProviderDescription: TLabel
    Left = 8
    Top = 128
    Width = 345
    Height = 89
    AutoSize = False
    Caption = '%providerDescription%'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
end
