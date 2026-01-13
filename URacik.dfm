object Frm_Racik: TFrm_Racik
  Left = 447
  Top = 278
  Width = 383
  Height = 287
  Caption = 'Frm_Racik'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LblDosis: TLabel
    Left = 32
    Top = 32
    Width = 154
    Height = 16
    Caption = 'Dosis yang diinginkan'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Lbl_DosisObat: TLabel
    Left = 64
    Top = 72
    Width = 116
    Height = 16
    Caption = 'Dosis pada obat'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Lbl_Bungkus: TLabel
    Left = 16
    Top = 104
    Width = 164
    Height = 16
    Caption = 'Jumlah Bungkus/kapsul'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Lbl_Jumlah: TLabel
    Left = 88
    Top = 144
    Width = 87
    Height = 16
    Caption = 'Jumlah Obat'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Btn_Ok: TButton
    Left = 40
    Top = 200
    Width = 75
    Height = 25
    Caption = 'OK(F2)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = Btn_OkClick
  end
  object Btn_Batal: TButton
    Left = 240
    Top = 200
    Width = 97
    Height = 25
    Caption = 'Batal( ESc )'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = Btn_BatalClick
  end
  object Edt_Dosis: TEdit
    Left = 200
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 2
    OnExit = Edt_DosisExit
  end
  object Edt_DosisObat: TEdit
    Left = 200
    Top = 64
    Width = 121
    Height = 21
    TabOrder = 3
    OnExit = Edt_DosisObatExit
  end
  object edt_Bungkus: TEdit
    Left = 200
    Top = 104
    Width = 121
    Height = 21
    TabOrder = 4
    OnExit = edt_BungkusExit
  end
  object Edt_JmlObat: TEdit
    Left = 200
    Top = 136
    Width = 121
    Height = 21
    TabOrder = 5
  end
end
