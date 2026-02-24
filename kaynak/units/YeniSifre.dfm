object YeniSifreForm: TYeniSifreForm
  Left = 0
  Top = 0
  ClientHeight = 266
  ClientWidth = 560
  Caption = 'Yeni '#350'ifre '#304'ste'#287'i'
  Color = 2565927
  BorderStyle = bsDialog
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  ScreenMask.Target = Owner
  TextHeight = 15
  object UniPanel1: TUniPanel
    Left = 8
    Top = 8
    Width = 545
    Height = 249
    Hint = ''
    TabOrder = 0
    BorderStyle = ubsFrameLowered
    Caption = ''
    Color = 2565927
    object txtEMail: TUniEdit
      Left = 36
      Top = 14
      Width = 470
      Height = 23
      Hint = ''
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Text = ''
      ParentFont = False
      Font.Height = -13
      TabOrder = 1
      ClientEvents.ExtEvents.Strings = (
        
          'afterrender=function afterrender(sender, eOpts)'#13#10'{'#13#10'  var el = s' +
          'ender.inputEl.dom;'#13#10'  Inputmask({alias: "email"}).mask(el);'#13#10'}')
      ClearButton = True
      FieldLabel = 'EMail Adresi'
      FieldLabelWidth = 140
      FieldLabelSeparator = ' '
      FieldLabelFont.Color = 11195647
    end
    object txtAdi: TUniEdit
      Left = 36
      Top = 47
      Width = 298
      Height = 23
      Hint = ''
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Text = ''
      ParentFont = False
      Font.Height = -13
      TabOrder = 2
      ClearButton = True
      FieldLabel = 'Ad'#305' Soyad'#305
      FieldLabelWidth = 140
      FieldLabelSeparator = ' '
      FieldLabelFont.Color = 11195647
    end
    object txtSoyadi: TUniEdit
      Left = 344
      Top = 47
      Width = 162
      Height = 23
      Hint = ''
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Text = ''
      ParentFont = False
      Font.Height = -13
      TabOrder = 3
      ClearButton = True
      FieldLabelSeparator = ' '
      FieldLabelFont.Color = clRed
    end
    object txtTelefon: TUniEdit
      Left = 36
      Top = 80
      Width = 298
      Height = 23
      Hint = ''
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Text = ''
      ParentFont = False
      Font.Height = -13
      TabOrder = 4
      ClientEvents.ExtEvents.Strings = (
        
          'afterrender=function afterrender(sender, eOpts)'#13#10'{'#13#10'  var el = s' +
          'ender.inputEl.dom;'#13#10'  Inputmask("\\+\\9\\0(999)999 99 99").mask(' +
          'el);'#13#10'}')
      ClearButton = True
      FieldLabel = 'Telefon'
      FieldLabelWidth = 140
      FieldLabelSeparator = ' '
      FieldLabelFont.Color = 11195647
    end
    object btnOk: TUniBitBtn
      Left = 36
      Top = 168
      Width = 237
      Height = 57
      Hint = ''
      Caption = 'Yeni '#350'ifremi Olu'#351'tur'
      ParentFont = False
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      TabOrder = 6
      ClientEvents.UniEvents.Strings = (
        
          'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'  config.cls=' +
          #39'bntLogin'#39';'#13#10'}')
      ScreenMask.Enabled = True
      ScreenMask.Target = Owner
      OnClick = btnOkClick
    end
    object btnCancel: TUniBitBtn
      Left = 279
      Top = 168
      Width = 237
      Height = 57
      Hint = ''
      Caption = 'Vazge'#231
      ModalResult = 2
      ParentFont = False
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      TabOrder = 7
      ClientEvents.UniEvents.Strings = (
        
          'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'  config.cls=' +
          #39'bntLogin'#39';'#13#10'}')
    end
    object txtCevap: TUniEdit
      Left = 36
      Top = 113
      Width = 470
      Height = 23
      Hint = ''
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Visible = False
      Text = ''
      ParentFont = False
      Font.Height = -13
      TabOrder = 5
      ClearButton = True
      FieldLabel = 'G'#252'venlik Sorusu Cevab'#305
      FieldLabelWidth = 140
      FieldLabelSeparator = ' '
      FieldLabelFont.Color = 11195647
    end
  end
  object qKullanici: TUniQuery
    KeyFields = 'KUL_ID'
    Connection = UniServerModule.ServisDB
    Options.DefaultValues = True
    SpecificOptions.Strings = (
      'InterBase.FetchAll=True'
      'InterBase.KeyGenerator=GEN_KULLANICILAR_ID')
    Left = 512
    Top = 80
  end
end
