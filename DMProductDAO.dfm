object ProductDAO: TProductDAO
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 459
  Width = 540
  object queryLoadProducts: TFDQuery
    Active = True
    Connection = Connection.connection1
    SQL.Strings = (
      'SELECT * FROM Products')
    Left = 248
    Top = 128
  end
  object query1: TFDQuery
    Connection = Connection.connection1
    SQL.Strings = (
      'SELECT ID,ProductPicture FROM Products')
    Left = 352
    Top = 144
  end
  object queryUpdateProductPicture: TFDQuery
    Connection = Connection.connection1
    Left = 192
    Top = 264
  end
  object ds1: TDataSource
    DataSet = queryLoadProducts
    Left = 320
    Top = 272
  end
end
