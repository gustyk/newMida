object Frm_Login: TFrm_Login
  Left = 368
  Top = 290
  Width = 354
  Height = 266
  Caption = 'Log In'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 20
  object Lbl_User: TLabel
    Left = 24
    Top = 48
    Width = 38
    Height = 20
    Caption = 'User '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Lbl_Password: TLabel
    Left = 24
    Top = 80
    Width = 69
    Height = 20
    Caption = 'Password'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lbl_shift: TLabel
    Left = 24
    Top = 112
    Width = 33
    Height = 20
    Caption = 'Shift'
  end
  object Btn_Ok: TButton
    Left = 32
    Top = 168
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 0
    OnClick = Btn_OkClick
  end
  object Edt_User: TEdit
    Left = 144
    Top = 48
    Width = 121
    Height = 28
    TabOrder = 1
  end
  object Edt_Password: TEdit
    Left = 144
    Top = 80
    Width = 121
    Height = 28
    TabOrder = 2
  end
  object edt_Shift: TEdit
    Left = 144
    Top = 112
    Width = 121
    Height = 28
    TabOrder = 3
  end
end
