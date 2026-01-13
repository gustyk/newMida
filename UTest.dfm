object Frm_Test: TFrm_Test
  Left = 316
  Top = 199
  Width = 542
  Height = 450
  Caption = 'Frm_Test'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 16
    Top = 88
    Width = 217
    Height = 305
    DataSource = DS_Tes
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object Btn_Exit: TButton
    Left = 440
    Top = 0
    Width = 75
    Height = 41
    Caption = 'Close'
    TabOrder = 1
    OnClick = Btn_ExitClick
  end
  object DBGrid2: TDBGrid
    Left = 248
    Top = 88
    Width = 217
    Height = 120
    DataSource = DS_Mst
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object Koneksi_test: TZConnection
    ControlsCodePage = cGET_ACP
    AutoEncodeStrings = False
    Connected = True
    DesignConnection = True
    HostName = 'LocalHost'
    Port = 3306
    Database = 'Apotek'
    User = 'root'
    Protocol = 'mysql-5'
    LibraryLocation = 'libmysql.dll'
    Left = 16
    Top = 8
  end
  object Query_test: TZQuery
    Connection = Koneksi_test
    Params = <>
    Left = 64
    Top = 8
  end
  object DS_Tes: TDataSource
    DataSet = Query_test
    Left = 120
    Top = 8
  end
  object Query_Mst: TZQuery
    Connection = Koneksi_test
    Params = <>
    Left = 64
    Top = 48
  end
  object DS_Mst: TDataSource
    DataSet = Query_Mst
    Left = 120
    Top = 48
  end
end
