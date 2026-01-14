object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 190
  Top = 117
  Height = 292
  Width = 437
  object Que_Obat: TZQuery
    Connection = Koneksi
    SQL.Strings = (
      'Select * From Tab_Obat_Mst')
    Params = <>
    Properties.Strings = (
      '')
    Left = 96
    Top = 16
  end
  object DS_Obat: TDataSource
    DataSet = CDS_OBAT
    Left = 336
    Top = 16
  end
  object DSP_Obat: TDataSetProvider
    DataSet = Que_Obat
    Left = 168
    Top = 16
  end
  object CDS_OBAT: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DSP_Obat'
    Left = 240
    Top = 16
  end
  object VT: TVirtualTable
    Active = True
    FieldDefs = <
      item
        Name = 'No'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ID_OBAT'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Nama_Obat'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Harga'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Jumlah'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Diskon'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'DiskonRp'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Embalase'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'SubTotal'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'SubTotalStr'
        DataType = ftString
        Size = 20
      end>
    Left = 16
    Top = 192
    Data = {
      04000A0002004E6F0100140000000000070049445F4F42415401001400000000
      0009004E616D615F4F6261740100140000000000050048617267610100140000
      00000006004A756D6C6168010014000000000006004469736B6F6E0100140000
      00000008004469736B6F6E527001001400000000000800456D62616C61736501
      001400000000000800537562546F74616C01001400000000000B00537562546F
      74616C5374720100140000000000000000000000}
  end
  object DS_Jual: TDataSource
    DataSet = VT
    Left = 72
    Top = 192
  end
  object TabObtDet: TZTable
    Connection = Koneksi
    TableName = 'Tab_Obat_Dtl'
    Left = 72
    Top = 112
  end
  object Que_stock: TZQuery
    Connection = Koneksi
    SQL.Strings = (
      'select * from Tab_Obat_Dtl')
    Params = <>
    Left = 72
    Top = 64
  end
  object DS_Stock: TDataSource
    DataSet = CDS_Stock
    Left = 336
    Top = 72
  end
  object DSP_Stock: TDataSetProvider
    DataSet = Que_stock
    Left = 136
    Top = 64
  end
  object CDS_Stock: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DSP_Stock'
    AfterPost = CDS_StockAfterPost
    Left = 216
    Top = 64
  end
  object Koneksi: TZConnection
    ControlsCodePage = cGET_ACP
    AutoEncodeStrings = False
    Properties.Strings = (
      'RawStringEncoding=DB_CP')
    Connected = True
    HostName = 'localhost'
    Port = 3306
    Database = 'apotek'
    User = 'root'
    Protocol = 'mysql'
    LibraryLocation = 'libmysql.dll'
    Left = 24
    Top = 16
  end
  object ZQuery1: TZQuery
    Params = <>
    Left = 96
    Top = 80
  end
end
