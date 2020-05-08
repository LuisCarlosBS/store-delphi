object CategoryDAO: TCategoryDAO
  OldCreateOrder = False
  Height = 463
  Width = 673
  object fdphysfbdrvrlnk1: TFDPhysFBDriverLink
    VendorLib = 
      'C:\Users\lucar\Documents\Embarcadero\Studio\Projects\Loja Delphi' +
      '\Database\fbclient.dll'
    Left = 376
    Top = 288
  end
  object connection1: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\lucar\Documents\Embarcadero\Studio\Projects\Lo' +
        'ja Delphi\Database\STOREDELPHI.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'CharacterSet=UTF8'
      'DriverID=FB')
    LoginPrompt = False
    Left = 200
    Top = 216
  end
  object query1: TFDQuery
    Connection = connection1
    Left = 376
    Top = 200
  end
  object fdgxwtcrsr1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 184
    Top = 368
  end
end
