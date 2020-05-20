object UserDAO: TUserDAO
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 308
  Width = 435
  object queryValidateLoginByUsername: TFDQuery
    Connection = Connection.connection1
    SQL.Strings = (
      'SELECT ID FROM Users WHERE Username = :pUsername '
      'AND Password = :pPassword')
    Left = 152
    Top = 40
    ParamData = <
      item
        Name = 'PUSERNAME'
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PPASSWORD'
        ParamType = ptInput
      end>
  end
  object queryValidateLoginByEmail: TFDQuery
    SQL.Strings = (
      'SELECT ID FROM Users WHERE Email = :pEmail'
      'AND Password = :pPassword')
    Left = 144
    Top = 120
    ParamData = <
      item
        Name = 'PEMAIL'
        ParamType = ptInput
      end
      item
        Name = 'PPASSWORD'
        ParamType = ptInput
      end>
  end
  object queryFindByEmail: TFDQuery
    Connection = Connection.connection1
    SQL.Strings = (
      'SELECT ID FROM Users WHERE Email = :pEmail')
    Left = 296
    Top = 32
    ParamData = <
      item
        Name = 'PEMAIL'
        ParamType = ptInput
      end>
  end
  object queryFindByUsername: TFDQuery
    Connection = Connection.connection1
    SQL.Strings = (
      'SELECT ID FROM Users WHERE Username = :pUsername')
    Left = 288
    Top = 120
    ParamData = <
      item
        Name = 'PUSERNAME'
        ParamType = ptInput
      end>
  end
  object queryInsertAnUser: TFDQuery
    Connection = Connection.connection1
    SQL.Strings = (
      'INSERT INTO Users'
      '(Username, Password, DisplayName, Email, ProfilePicture)'
      'VALUES'
      
        '(:pUsername, :pPassword, :pDisplayName, :pEmail, :pProfilePictur' +
        'e)'
      'RETURNING ID;')
    Left = 144
    Top = 192
    ParamData = <
      item
        Name = 'PUSERNAME'
        ParamType = ptInput
      end
      item
        Name = 'PPASSWORD'
        ParamType = ptInput
      end
      item
        Name = 'PDISPLAYNAME'
        ParamType = ptInput
      end
      item
        Name = 'PEMAIL'
        ParamType = ptInput
      end
      item
        Name = 'PPROFILEPICTURE'
        ParamType = ptInput
      end>
  end
  object queryUpdateProfilePicture: TFDQuery
    Connection = Connection.connection1
    SQL.Strings = (
      'UPDATE Users SET ProfilePicture = :pProfilePicture'
      'WHERE ID = :pId;')
    Left = 272
    Top = 200
    ParamData = <
      item
        Name = 'PPROFILEPICTURE'
        ParamType = ptInput
      end
      item
        Name = 'PID'
        ParamType = ptInput
      end>
  end
end
