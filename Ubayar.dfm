object Frm_Bayar: TFrm_Bayar
  Left = 424
  Top = 153
  Width = 381
  Height = 450
  Caption = 'Frm_Bayar'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 56
    Top = 40
    Width = 57
    Height = 13
    Caption = 'No Anggota'
  end
  object Label2: TLabel
    Left = 56
    Top = 64
    Width = 28
    Height = 13
    Caption = 'Nama'
  end
  object Label3: TLabel
    Left = 64
    Top = 96
    Width = 32
    Height = 13
    Caption = 'Dokter'
  end
  object Label4: TLabel
    Left = 56
    Top = 120
    Width = 33
    Height = 13
    Caption = 'Jumlah'
  end
  object Label5: TLabel
    Left = 56
    Top = 208
    Width = 52
    Height = 13
    Caption = 'Cara Bayar'
  end
  object Label6: TLabel
    Left = 64
    Top = 144
    Width = 27
    Height = 13
    Caption = 'Bayar'
  end
  object Label7: TLabel
    Left = 64
    Top = 168
    Width = 37
    Height = 13
    Caption = 'Kembali'
  end
  object Button1: TButton
    Left = 16
    Top = 344
    Width = 75
    Height = 25
    Caption = 'Proses'
    TabOrder = 0
  end
  object Button2: TButton
    Left = 240
    Top = 344
    Width = 75
    Height = 25
    Caption = 'Batal'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Edit1: TEdit
    Left = 144
    Top = 40
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 144
    Top = 80
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'Edit2'
  end
  object Edit3: TEdit
    Left = 144
    Top = 112
    Width = 121
    Height = 21
    TabOrder = 4
    Text = 'Edit3'
  end
  object Edit5: TEdit
    Left = 144
    Top = 144
    Width = 121
    Height = 21
    TabOrder = 5
    Text = 'Edit5'
  end
  object Edit6: TEdit
    Left = 144
    Top = 168
    Width = 121
    Height = 21
    TabOrder = 6
    Text = 'Edit6'
  end
  object CB_CaraBayar: TComboBox
    Left = 144
    Top = 200
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 7
    Text = 'Tunai'
  end
end
