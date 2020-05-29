object StockDAO: TStockDAO
  OldCreateOrder = False
  Height = 307
  Width = 346
  object queryProvidersByProduct: TFDQuery
    Connection = Connection.connection1
    SQL.Strings = (
      'SELECT IDProvider FROM STOCK WHERE IDProduct = :pIdProduct')
    Left = 56
    Top = 144
    ParamData = <
      item
        Name = 'PIDPRODUCT'
        ParamType = ptInput
      end>
  end
  object queryBestPriceByProduct: TFDQuery
    Connection = Connection.connection1
    SQL.Strings = (
      'SELECT MIN(UnitPrice) FROM STOCK'
      'WHERE IDProduct = :pIdProduct')
    Left = 72
    Top = 224
    ParamData = <
      item
        Name = 'PIDPRODUCT'
        ParamType = ptInput
      end>
  end
  object queryUnitPriceByProviderAndProduct: TFDQuery
    Connection = Connection.connection1
    SQL.Strings = (
      'SELECT UnitPrice FROM Stock '
      'WHERE IDProduct = :pIdProduct '
      'AND '
      'IDProvider = :pIdProvider')
    Left = 88
    Top = 72
    ParamData = <
      item
        Name = 'PIDPRODUCT'
        ParamType = ptInput
      end
      item
        Name = 'PIDPROVIDER'
        ParamType = ptInput
      end>
  end
end
