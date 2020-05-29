object Connection: TConnection
  OldCreateOrder = False
  Height = 233
  Width = 308
  object connection1: TFDConnection
    Params.Strings = (
      'User_Name=SYSDBA'
      'Password=masterkey'
      'CharacterSet=UTF8'
      'DriverID=FB')
    LoginPrompt = False
    Left = 168
    Top = 72
  end
  object fdphysfbdrvrlnk1: TFDPhysFBDriverLink
    Left = 80
    Top = 48
  end
end
