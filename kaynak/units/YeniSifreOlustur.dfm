object YeniSifreOlusturForm: TYeniSifreOlusturForm
  Left = 0
  Top = 0
  ClientHeight = 197
  ClientWidth = 357
  Caption = 'Yeni '#350'ifrenizi Belirleyiniz'
  Color = 2565927
  BorderStyle = bsDialog
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  OnCreate = UniFormCreate
  TextHeight = 15
  object UniPanel1: TUniPanel
    Left = 8
    Top = 8
    Width = 337
    Height = 129
    Hint = ''
    TabOrder = 0
    BorderStyle = ubsFrameLowered
    Caption = ''
    Color = 2565927
    object UniLabel1: TUniLabel
      Left = 36
      Top = 16
      Width = 51
      Height = 13
      Hint = ''
      Caption = 'UniLabel1'
      ParentFont = False
      Font.Color = clWhite
      TabOrder = 1
    end
    object txtSifre1: TUniEdit
      Left = 36
      Top = 47
      Width = 270
      Height = 23
      Hint = ''
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      PasswordChar = '*'
      Text = ''
      ParentFont = False
      Font.Height = -13
      TabOrder = 2
      ClearButton = True
      FieldLabel = #350'ifre'
      FieldLabelSeparator = ' '
      FieldLabelFont.Color = 11195647
    end
    object txtSifre2: TUniEdit
      Left = 36
      Top = 80
      Width = 270
      Height = 23
      Hint = ''
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      PasswordChar = '*'
      Text = ''
      ParentFont = False
      Font.Height = -13
      TabOrder = 3
      ClearButton = True
      FieldLabel = #350'ifre (Tekrar)'
      FieldLabelSeparator = ' '
      FieldLabelFont.Color = 11195647
    end
  end
  object btnGiris: TUniButton
    Left = 8
    Top = 143
    Width = 161
    Height = 39
    Hint = ''
    Caption = 'Tamam'
    ParentFont = False
    Font.Color = clWhite
    Font.Height = -14
    Font.Name = 'Calibri'
    TabOrder = 1
    ClientEvents.UniEvents.Strings = (
      
        'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'  config.cls=' +
        #39'bntLogin'#39';'#13#10'}')
    ScreenMask.Enabled = True
    ScreenMask.WaitData = True
    ScreenMask.Target = Owner
    OnClick = btnGirisClick
  end
  object btnVazgec: TUniButton
    Left = 184
    Top = 143
    Width = 161
    Height = 39
    Hint = ''
    Caption = 'Vazge'#231
    ModalResult = 2
    ParentFont = False
    Font.Color = clWhite
    Font.Height = -14
    Font.Name = 'Calibri'
    TabOrder = 2
    ClientEvents.UniEvents.Strings = (
      
        'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'  config.cls=' +
        #39'bntLogin'#39';'#13#10'}')
    ScreenMask.Enabled = True
    ScreenMask.WaitData = True
    ScreenMask.Message = 'L'#252'tfen Bekleyiniz...'
    ScreenMask.Target = Owner
  end
  object qKullanici: TUniQuery
    KeyFields = 'KUL_ID'
    Connection = UniServerModule.ServisDB
    Options.DefaultValues = True
    SpecificOptions.Strings = (
      'InterBase.FetchAll=True'
      'InterBase.KeyGenerator=GEN_KULLANICILAR_ID')
    Left = 289
    Top = 16
  end
end
