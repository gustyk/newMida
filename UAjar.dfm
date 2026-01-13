object Frm_Jual: TFrm_Jual
  Left = 6
  Top = 89
  Width = 1185
  Height = 583
  Caption = 'Frm_Jual'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = Menu
  OldCreateOrder = False
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Lbl_BarCode: TLabel
    Left = 776
    Top = 8
    Width = 71
    Height = 20
    Caption = 'BarCode'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Lbl_Nama: TLabel
    Left = 784
    Top = 40
    Width = 47
    Height = 20
    Caption = 'Nama'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Btn_Exit: TButton
    Left = 720
    Top = 448
    Width = 75
    Height = 25
    Caption = 'Exit'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = Btn_ExitClick
  end
  object Btn_Proses: TButton
    Left = 32
    Top = 448
    Width = 89
    Height = 25
    Caption = 'F2 Proses'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = Btn_ProsesClick
  end
  object Grid_Obat: TDBGrid
    Left = 752
    Top = 96
    Width = 329
    Height = 321
    DataSource = DM.DS_Obat
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -16
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    OnDblClick = Grid_ObatDblClick
    OnKeyDown = Grid_ObatKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'Nama_obat'
        Title.Alignment = taCenter
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'harga'
        Title.Alignment = taCenter
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'lokasi'
        Visible = True
      end>
  end
  object Grid_Jual: TDBGrid
    Left = 8
    Top = 96
    Width = 737
    Height = 281
    DataSource = DM.DS_Jual
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -16
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    OnKeyDown = Grid_JualKeyDown
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'No'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Width = 25
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'Nama_Obat'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Title.Alignment = taCenter
        Width = 182
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Harga'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Width = 78
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Jumlah'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Title.Alignment = taCenter
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Diskon'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Title.Alignment = taCenter
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DiskonRp'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Title.Alignment = taCenter
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Embalase'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Title.Alignment = taCenter
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SubTotalStr'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Title.Caption = 'Sub Total'
        Visible = True
      end>
  end
  object Edt_Obat: TEdit
    Left = 864
    Top = 40
    Width = 193
    Height = 28
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnChange = Edt_ObatChange
  end
  object Edt_Barcode: TEdit
    Left = 864
    Top = 8
    Width = 185
    Height = 28
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
  end
  object Btn_History: TButton
    Left = 248
    Top = 448
    Width = 75
    Height = 25
    Caption = 'Histori'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = Btn_HistoryClick
  end
  object Btn_Racik: TButton
    Left = 136
    Top = 448
    Width = 89
    Height = 25
    Caption = 'F4 Racik'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    OnClick = Btn_RacikClick
  end
  object Btn_Hapus: TButton
    Left = 344
    Top = 448
    Width = 75
    Height = 25
    Caption = 'Hapus'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
  end
  object Btn_Batal: TButton
    Left = 440
    Top = 448
    Width = 75
    Height = 25
    Caption = 'Batal'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
  end
  object Btn_Refresh: TButton
    Left = 528
    Top = 448
    Width = 75
    Height = 25
    Caption = 'Refresh'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 10
  end
  object Btn_Test: TButton
    Left = 520
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Test Stock'
    TabOrder = 11
    OnClick = Btn_TestClick
  end
  object Button1: TButton
    Left = 616
    Top = 448
    Width = 89
    Height = 25
    Caption = 'F12 Stock'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 12
  end
  object Edt_GTotal: TEdit
    Left = 600
    Top = 384
    Width = 137
    Height = 28
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 13
  end
  object Menu: TMainMenu
    Left = 104
    Top = 56
    object File1: TMenuItem
      Caption = '     File    '
      object utupJual1: TMenuItem
        Caption = 'Tutup Jual'
      end
      object utupbulan1: TMenuItem
        Caption = 'Tutup bulan'
      end
      object Exit1: TMenuItem
        Caption = 'Exit'
      end
    end
    object ransaksi1: TMenuItem
      Caption = '     Transaksi     '
      object Jual1: TMenuItem
        Caption = '   Jual'
      end
      object Masuk1: TMenuItem
        Caption = 'Masuk'
      end
      object Kirim1: TMenuItem
        Caption = 'Kirim'
      end
      object Retur1: TMenuItem
        Caption = 'Retur'
      end
    end
    object Laporan1: TMenuItem
      Caption = '     Laporan     '
      object Juallini1: TMenuItem
        Caption = 'Jual Sekarang'
      end
      object JualPeriode1: TMenuItem
        Caption = 'Jual Periode'
      end
      object BatalJual1: TMenuItem
        Caption = 'Batal Jual'
      end
      object Muasi1: TMenuItem
        Caption = 'Muasi'
      end
      object Retur2: TMenuItem
        Caption = 'Retur'
      end
    end
    object Konfigurasi1: TMenuItem
      Caption = '     Tool     '
      object Bundelransaksii1: TMenuItem
        Caption = 'Bundel Transaksi'
      end
      object BackUpDatabase1: TMenuItem
        Caption = 'Back Up Database'
      end
      object SettiingDatabase1: TMenuItem
        Caption = 'Settiing Database'
      end
    end
  end
end
