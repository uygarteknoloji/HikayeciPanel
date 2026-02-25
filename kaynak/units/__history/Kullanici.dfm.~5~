object KullaniciForm: TKullaniciForm
  Left = 0
  Top = 0
  Width = 979
  Height = 599
  OnCreate = UniFrameCreate
  OnAjaxEvent = UniFrameAjaxEvent
  TabOrder = 0
  object UniToolBar1: TUniPanel
    Left = 0
    Top = 0
    Width = 979
    Height = 60
    Hint = ''
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alTop
    TabOrder = 0
    BorderStyle = ubsFrameLowered
    Caption = ''
    object btnKaydet: TUniBitBtn
      Left = 2
      Top = 2
      Width = 56
      Height = 56
      Hint = 'Kaydet'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      ShowHint = True
      ParentShowHint = False
      Caption = ''
      Align = alLeft
      TabOrder = 1
      Images = UniMainModule.ikonListe
      ImageIndex = 11
      OnClick = btnKaydetClick
    end
    object UniPanel1: TUniPanel
      Left = 226
      Top = 2
      Width = 639
      Height = 56
      Hint = ''
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alClient
      ParentFont = False
      Font.Height = -24
      Font.Name = 'Calibri'
      TabOrder = 5
      TabStop = False
      BorderStyle = ubsNone
      Caption = 'Kullan'#305'c'#305
      Color = 15724527
    end
    object btnYeni: TUniBitBtn
      Left = 114
      Top = 2
      Width = 56
      Height = 56
      Hint = 'Yeni'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      ShowHint = True
      ParentShowHint = False
      Caption = ''
      Align = alLeft
      TabOrder = 3
      Images = UniMainModule.ikonListe
      ImageIndex = 0
      OnClick = btnYeniClick
    end
    object btnKapat: TUniBitBtn
      Left = 921
      Top = 2
      Width = 56
      Height = 56
      Hint = 'Kapat'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      ShowHint = True
      ParentShowHint = False
      Caption = ''
      Align = alRight
      TabOrder = 7
      Images = UniMainModule.ikonListe
      ImageIndex = 9
      OnClick = btnKapatClick
    end
    object btnVazgec: TUniBitBtn
      Left = 58
      Top = 2
      Width = 56
      Height = 56
      Hint = 'Vazge'#231
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      ShowHint = True
      ParentShowHint = False
      Caption = ''
      Align = alLeft
      TabOrder = 2
      Images = UniMainModule.ikonListe
      ImageIndex = 12
      OnClick = btnVazgecClick
    end
    object btnSil: TUniBitBtn
      Left = 170
      Top = 2
      Width = 56
      Height = 56
      Hint = 'Sil'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      ShowHint = True
      ParentShowHint = False
      Caption = ''
      Align = alLeft
      TabOrder = 4
      Images = UniMainModule.ikonListe
      ImageIndex = 2
      OnClick = btnSilClick
    end
    object btnYardim: TUniBitBtn
      Left = 865
      Top = 2
      Width = 56
      Height = 56
      Hint = 'Yard'#305'm'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Visible = False
      ShowHint = True
      ParentShowHint = False
      Caption = ''
      Align = alRight
      TabOrder = 6
      Images = UniMainModule.ikonListe
      ImageIndex = 10
    end
  end
  object UniScrollBox1: TUniScrollBox
    Left = 0
    Top = 60
    Width = 979
    Height = 539
    Hint = ''
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alClient
    Color = 15724527
    TabOrder = 1
    ScrollHeight = 399
    ScrollWidth = 472
    object txtAdi: TUniDBEdit
      Left = 20
      Top = 86
      Width = 272
      Height = 23
      Hint = ''
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      DataField = 'KUL_ADI'
      DataSource = dsKullanici
      ParentFont = False
      Font.Height = -13
      TabOrder = 1
      ClearButton = True
      FieldLabel = 'Ad'#305' Soyad'#305
      FieldLabelSeparator = ' '
      FieldLabelFont.Color = clRed
    end
    object txtSoyadi: TUniDBEdit
      Left = 302
      Top = 86
      Width = 170
      Height = 23
      Hint = ''
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      DataField = 'KUL_SOYADI'
      DataSource = dsKullanici
      ParentFont = False
      Font.Height = -13
      TabOrder = 2
      ClearButton = True
      FieldLabelFont.Color = clRed
    end
    object txtFirma: TUniDBLookupComboBox
      Left = 20
      Top = 119
      Width = 450
      Height = 23
      Hint = ''
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      ListField = 'FRM_ADI'
      ListSource = dsFirmalar
      KeyField = 'FRM_ID'
      ListFieldIndex = 0
      ClearButton = True
      DataField = 'KUL_FRM_ID'
      DataSource = dsKullanici
      ParentFont = False
      Font.Height = -13
      TabOrder = 3
      Color = clWindow
      FieldLabel = 'Firma'
      FieldLabelSeparator = ' '
      Triggers = <
        item
          ButtonId = 0
          IconCls = 'x-form-trigger'
          Visible = False
        end
        item
          ButtonId = 1
          IconCls = 'x-form-search-trigger'
          HandleClicks = True
          Hint = 'F4 - Firmalar'
        end>
      Style = csDropDown
      OnEnter = txtFirmaEnter
    end
    object txtTelefon: TUniDBEdit
      Left = 20
      Top = 216
      Width = 272
      Height = 23
      Hint = ''
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      DataField = 'KUL_TELEFON'
      DataSource = dsKullanici
      ParentFont = False
      Font.Height = -13
      TabOrder = 7
      ClientEvents.ExtEvents.Strings = (
        
          'afterrender=function afterrender(sender, eOpts)'#13#10'{'#13#10'  var el = s' +
          'ender.inputEl.dom;'#13#10'  Inputmask("\\+\\9\\0(599)999 99 99").mask(' +
          'el);'#13#10'}')
      ClearButton = True
      FieldLabel = 'Telefon'
      FieldLabelSeparator = ' '
    end
    object txtAciklama: TUniDBMemo
      Left = 18
      Top = 305
      Width = 450
      Height = 94
      Hint = ''
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      DataField = 'KUL_ACIKLAMA'
      DataSource = dsKullanici
      ParentFont = False
      Font.Height = -13
      TabOrder = 12
      ClearButton = True
      FieldLabel = 'A'#231#305'klama'
      FieldLabelSeparator = ' '
    end
    object txtDurum: TUniDBCheckBox
      Left = 130
      Top = 41
      Width = 97
      Height = 17
      Hint = ''
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      DataField = 'KUL_DURUM'
      DataSource = dsKullanici
      ValueChecked = '1'
      ValueUnchecked = '0'
      Caption = 'Kullan'#305'mda'
      ParentFont = False
      Font.Height = -13
      TabOrder = 0
      ParentColor = False
      Color = clBtnFace
    end
    object txtEMail: TUniDBEdit
      Left = 20
      Top = 150
      Width = 450
      Height = 23
      Hint = ''
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      DataField = 'KUL_EMAIL'
      DataSource = dsKullanici
      ParentFont = False
      Font.Height = -13
      TabOrder = 4
      ClientEvents.ExtEvents.Strings = (
        
          'afterrender=function afterrender(sender, eOpts)'#13#10'{'#13#10'  var el = s' +
          'ender.inputEl.dom;'#13#10'  Inputmask({alias: "email"}).mask(el);'#13#10'}')
      ClearButton = True
      FieldLabel = 'EMail'
      FieldLabelSeparator = ' '
    end
    object txtBaslangic: TUniDBDateTimePicker
      Left = 18
      Top = 247
      Width = 272
      Height = 23
      Hint = ''
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      DataField = 'KUL_BASTARIHI'
      DataSource = dsKullanici
      DateTime = 45934.000000000000000000
      DateFormat = 'dd.MM.yyyy'
      TimeFormat = 'HH:mm:ss'
      TabOrder = 8
      ParentFont = False
      Font.Height = -13
      DisabledDates = <>
      FieldLabel = 'Ba'#351'./Bit.Tarihi'
      FieldLabelSeparator = ' '
    end
    object txtBitis: TUniDBDateTimePicker
      Left = 298
      Top = 247
      Width = 172
      Height = 23
      Hint = ''
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      DataField = 'KUL_BITTARIHI'
      DataSource = dsKullanici
      DateTime = 45934.000000000000000000
      DateFormat = 'dd.MM.yyyy'
      TimeFormat = 'HH:mm:ss'
      TabOrder = 9
      ParentFont = False
      Font.Height = -13
      DisabledDates = <>
    end
    object txtUyelikBedeli: TUniDBCheckBox
      Left = 300
      Top = 279
      Width = 97
      Height = 17
      Hint = ''
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      DataField = 'KUL_DURUM'
      DataSource = dsKullanici
      ValueChecked = '1'
      ValueUnchecked = '0'
      Caption = #214'dendi'
      ParentFont = False
      Font.Height = -13
      TabOrder = 11
      ParentColor = False
      Color = clBtnFace
    end
    object txtUyelikTuru: TUniDBComboBox
      Left = 18
      Top = 275
      Width = 272
      Height = 23
      Hint = ''
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      DataField = 'KUL_UYELIK_TURU'
      DataSource = dsKullanici
      Style = csDropDownList
      Items.Strings = (
        'Ayl'#305'k'
        'Y'#305'll'#305'k'
        'Kendi Alan'#305'm')
      ParentFont = False
      Font.Height = -13
      TabOrder = 10
      FieldLabel = #220'yelik T'#252'r'#252
      FieldLabelSeparator = ' '
      IconItems = <>
    end
    object txtRol: TUniDBComboBox
      Left = 20
      Top = 183
      Width = 272
      Height = 23
      Hint = ''
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      DataField = 'KUL_ROLU'
      DataSource = dsKullanici
      Style = csDropDownList
      Items.Strings = (
        'Kullan'#305'c'#305
        'Yazar'
        'Sistem Y'#246'neticisi')
      ParentFont = False
      Font.Height = -13
      TabOrder = 5
      FieldLabel = 'Rol'
      FieldLabelSeparator = ' '
      IconItems = <>
    end
    object txtDYSRolu: TUniDBComboBox
      Left = 300
      Top = 183
      Width = 170
      Height = 23
      Hint = ''
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Visible = False
      DataField = 'KUL_DYS_ROLU'
      DataSource = dsKullanici
      Style = csDropDownList
      Items.Strings = (
        'G'#246'zlemci'
        'Yazar'
        'DYS Y'#246'neticisi')
      ParentFont = False
      Font.Height = -13
      TabOrder = 6
      FieldLabelSeparator = ' '
      IconItems = <>
    end
  end
  object qKullanici: TUniQuery
    KeyFields = 'KUL_ID'
    Connection = UniServerModule.ServisDB
    SQL.Strings = (
      'Select *'
      'From KULLANICILAR'
      'Where KUL_ID=:KUL_ID')
    Options.DefaultValues = True
    SpecificOptions.Strings = (
      'InterBase.KeyGenerator=GEN_KULLANICILAR_ID'
      'InterBase.FetchAll=True')
    Left = 216
    Top = 392
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'KUL_ID'
        Value = nil
      end>
  end
  object dsKullanici: TDataSource
    DataSet = qKullanici
    OnStateChange = dsKullaniciStateChange
    Left = 264
    Top = 392
  end
  object sil: TUniSweetAlert
    Background = '#fff'
    Title = ' '
    Text = 'Silmek istedi'#287'inize emin misiniz?'
    ConfirmButtonText = 'Evet'
    CancelButtonText = 'Hay'#305'r'
    ConfirmButtonColor = clGreen
    CancelButtonColor = clRed
    AlertType = atQuestion
    Width = 500
    Padding = 20
    ShowCancelButton = True
    ShowLoaderOnConfirm = True
    OnConfirm = silConfirm
    Left = 104
    Top = 392
  end
  object iptal: TUniSweetAlert
    Background = '#fff'
    Title = ' '
    Text = 'Kay'#305't i'#351'lemini iptal etmek istedi'#287'inize emin misiniz?'
    ConfirmButtonText = 'Evet'
    CancelButtonText = 'Hay'#305'r'
    ConfirmButtonColor = clGreen
    CancelButtonColor = clRed
    AlertType = atQuestion
    Width = 500
    Padding = 20
    ShowCancelButton = True
    ShowLoaderOnConfirm = True
    OnConfirm = iptalConfirm
    Left = 152
    Top = 392
  end
  object qFirmalar: TUniQuery
    KeyFields = 'FRM_ID'
    Connection = UniServerModule.ServisDB
    SQL.Strings = (
      'Select FRM_ID, FRM_ADI'
      'From FIRMALAR'
      'Where FRM_DURUM=1'
      'Order By FRM_ADI')
    SpecificOptions.Strings = (
      'InterBase.FetchAll=True')
    Left = 344
    Top = 392
  end
  object dsFirmalar: TDataSource
    DataSet = qFirmalar
    Left = 392
    Top = 392
  end
end
