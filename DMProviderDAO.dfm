object ProviderDAO: TProviderDAO
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 269
  Width = 326
  object queryFindProviderById: TFDQuery
    Connection = Connection.connection1
    SQL.Strings = (
      'SELECT * FROM Providers'
      'WHERE ID = :pId')
    Left = 112
    Top = 104
    ParamData = <
      item
        Name = 'PID'
        ParamType = ptInput
      end>
  end
end
