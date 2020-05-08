object ProductDAO: TProductDAO
  OldCreateOrder = False
  Height = 459
  Width = 540
  object connection1: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\lucar\Documents\Embarcadero\Studio\Projects\Lo' +
        'ja Delphi\Database\STOREDELPHI.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'CharacterSet=UTF8'
      'DriverID=FB')
    LoginPrompt = False
    Left = 104
    Top = 112
  end
  object queryLoadProducts: TFDQuery
    Connection = connection1
    Left = 248
    Top = 128
  end
  object fdgxwtcrsr1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 96
    Top = 248
  end
  object fdphysfbdrvrlnk1: TFDPhysFBDriverLink
    VendorLib = 
      'C:\Users\lucar\Documents\Embarcadero\Studio\Projects\Loja Delphi' +
      '\Database\fbclient.dll'
    Left = 232
    Top = 272
  end
end
