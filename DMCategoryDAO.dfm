object CategoryDAO: TCategoryDAO
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 463
  Width = 673
  object queryAllCategories: TFDQuery
    Connection = Connection.connection1
    SQL.Strings = (
      'SELECT * FROM Categories')
    Left = 376
    Top = 200
  end
end
