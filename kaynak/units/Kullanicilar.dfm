object KullanicilarForm: TKullanicilarForm
  Left = 0
  Top = 0
  Width = 1274
  Height = 759
  OnCreate = UniFrameCreate
  OnAjaxEvent = UniFrameAjaxEvent
  TabOrder = 0
  object UniPanel1: TUniPanel
    Left = 0
    Top = 0
    Width = 1274
    Height = 759
    Hint = ''
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alClient
    TabOrder = 0
    Caption = ''
    object UniToolBar1: TUniPanel
      Left = 1
      Top = 1
      Width = 1272
      Height = 60
      Hint = ''
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      ParentFont = False
      Font.Height = -28
      TabOrder = 1
      BorderStyle = ubsFrameLowered
      Caption = ''
      object btnYeni: TUniBitBtn
        Left = 2
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
        TabOrder = 1
        Images = UniMainModule.ikonListe
        ImageIndex = 0
        OnClick = btnYeniClick
      end
      object btnDegistir: TUniBitBtn
        Left = 58
        Top = 2
        Width = 56
        Height = 56
        Hint = 'De'#287'i'#351'tir'
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
        ImageIndex = 1
        OnClick = btnDegistirClick
      end
      object btnSil: TUniBitBtn
        Left = 114
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
        TabOrder = 3
        Images = UniMainModule.ikonListe
        ImageIndex = 2
        OnClick = btnSilClick
      end
      object btnKapat: TUniBitBtn
        Left = 1214
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
        TabOrder = 6
        Images = UniMainModule.ikonListe
        ImageIndex = 9
        OnClick = btnKapatClick
      end
      object UniPanel2: TUniPanel
        Left = 170
        Top = 2
        Width = 988
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
        TabOrder = 4
        TabStop = False
        BorderStyle = ubsNone
        Caption = 'Kullan'#305'c'#305'lar'
        Color = 15724527
      end
      object btnSec: TUniBitBtn
        Left = 1158
        Top = 2
        Width = 56
        Height = 56
        Hint = 'Se'#231
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Visible = False
        ShowHint = True
        ParentShowHint = False
        Caption = ''
        Align = alRight
        TabOrder = 5
        Images = UniMainModule.ikonListe
        ImageIndex = 8
        OnClick = btnSecClick
      end
    end
    object pnlBul: TUniPanel
      Left = 1
      Top = 121
      Width = 1272
      Height = 44
      Hint = ''
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Visible = False
      Align = alTop
      ParentFont = False
      Font.Color = clRed
      Font.Style = [fsBold]
      TabOrder = 2
      BorderStyle = ubsFrameLowered
      Caption = ''
      Color = 15724527
    end
    object UniPanel3: TUniPanel
      Left = 1
      Top = 61
      Width = 1272
      Height = 60
      Hint = ''
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      TabOrder = 3
      ClientEvents.UniEvents.Strings = (
        
          'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'  config.base' +
          'Cls='#39'customPanelBorder'#39';'#13#10'  config.cls='#39'customPanelBorder'#39';'#13#10'}')
      BorderStyle = ubsFrameLowered
      Caption = ''
      Color = 15724527
      object btnBul: TUniBitBtn
        Left = 2
        Top = 2
        Width = 56
        Height = 56
        Hint = 'Bul'
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
        ImageIndex = 5
        OnClick = btnBulClick
      end
      object txtAdiSoyadi: TUniEdit
        Left = 208
        Top = 16
        Width = 150
        Height = 24
        Hint = ''
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Text = ''
        ParentFont = False
        Font.Height = -13
        TabOrder = 2
        EmptyText = 'Ad'#305' Soyad'#305
        ClearButton = True
      end
      object txtKayitSayisi: TUniComboBox
        Left = 528
        Top = 16
        Width = 57
        Height = 24
        Hint = ''
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Text = 'txtKayitSayisi'
        Items.Strings = (
          '25'
          '50'
          '100'
          '500'
          '1000')
        ItemIndex = 0
        ParentFont = False
        Font.Height = -13
        TabOrder = 5
        IconItems = <>
      end
      object txtFirma: TUniEdit
        Left = 368
        Top = 16
        Width = 150
        Height = 24
        Hint = ''
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Text = ''
        ParentFont = False
        Font.Height = -13
        TabOrder = 3
        EmptyText = 'Firma Ad'#305
        ClearButton = True
      end
      object txtDurum: TUniComboBox
        Left = 78
        Top = 16
        Width = 120
        Height = 24
        Hint = ''
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Text = ''
        Items.Strings = (
          'Kullan'#305'mda'
          'Kullan'#305'm D'#305#351#305)
        ParentFont = False
        Font.Height = -13
        TabOrder = 4
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'  config.type' +
            'Ahead = true;'#13#10'}'#13#10)
        EmptyText = 'Durum'
        ClearButton = True
        IconItems = <>
      end
    end
    object Grid: TUniDBGrid
      Left = 1
      Top = 165
      Width = 1272
      Height = 593
      Hint = ''
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      TitleFont.Style = [fsBold]
      DataSource = dsKullanicilar
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColumnMove, dgColLines, dgRowLines, dgConfirmDelete, dgAutoRefreshRow]
      LoadMask.Enabled = False
      LoadMask.Message = 'Y'#252'kleniyor...'
      EmptyText = '< Veri Bulunamad'#305' >'
      Align = alClient
      TabOrder = 4
      Exporter.Enabled = True
      Exporter.IncludeGroups = True
      Exporter.IncludeSummary = True
      Exporter.FileName = 'Kullan'#305'c'#305'lar'
      Exporter.Title = 'Kullan'#305'c'#305'lar'
      OnAjaxEvent = GridAjaxEvent
      OnColumnSort = GridColumnSort
      OnDblClick = GridDblClick
      OnDrawColumnCell = GridDrawColumnCell
      Columns = <
        item
          FieldName = 'KUL_ID'
          Title.Caption = 'Kul.No'
          Width = 64
        end
        item
          FieldName = 'KUL_DURUM'
          Title.Caption = 'Durum'
          Width = 115
          Alignment = taLeftJustify
          Sortable = True
          CheckBoxField.BooleanFieldOnly = False
          CheckBoxField.FieldValues = '1;0'
          CheckBoxField.DisplayValues = 'Kullan'#305'mda;Kullan'#305'm D'#305#351#305
        end
        item
          FieldName = 'KUL_KAYIT_ZAMANI'
          Title.Caption = 'Kay'#305't Zaman'#305
          Width = 175
          DisplayFormat = 'dd.MM.yyyy HH:mm:ss'
        end
        item
          FieldName = 'KUL_LAST_LOGIN_TIME'
          Title.Caption = 'Son Giri'#351' Zaman'#305
          Width = 175
          DisplayFormat = 'dd.MM.yyyy HH:mm:ss'
        end
        item
          FieldName = 'KUL_EMAIL'
          Title.Caption = 'EMail'
          Width = 232
          Sortable = True
        end
        item
          FieldName = 'KUL_ROLU'
          Title.Caption = 'Rol'
          Width = 100
          Sortable = True
        end
        item
          FieldName = 'KUL_ADI_SOYADI'
          Title.Caption = 'Ad'#305' Soyad'#305
          Width = 180
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'FRM_ADI'
          Title.Caption = 'Firma Ad'#305
          Width = 204
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'KUL_TELEFON'
          Title.Caption = 'Telefon'
          Width = 160
        end
        item
          FieldName = 'KUL_UYELIK_TURU'
          Title.Caption = #220'yelik T'#252'r'#252
          Width = 111
        end
        item
          FieldName = 'KUL_UYELIK_BEDELI_ODENDI'
          Title.Caption = #220'yelik Bedeli '#214'dendi'
          Width = 183
          Alignment = taLeftJustify
          CheckBoxField.BooleanFieldOnly = False
          CheckBoxField.FieldValues = '1;0'
          CheckBoxField.DisplayValues = #214'dendi;'#214'denmedi'
        end
        item
          FieldName = 'KUL_BASTARIHI'
          Title.Caption = 'Ba'#351'lang'#305#231' Tarihi'
          Width = 139
          Sortable = True
          DisplayFormat = 'dd.MM.yyyy'
        end
        item
          FieldName = 'KUL_BITTARIHI'
          Title.Caption = 'Biti'#351' Tarihi'
          Width = 148
          Sortable = True
          DisplayFormat = 'dd.MM.yyyy'
        end
        item
          FieldName = 'KUL_AKTIVASYON_KODU'
          Title.Caption = 'Aktivasyon Kodu'
          Width = 291
          Sortable = True
        end
        item
          FieldName = 'KUL_GUVENLIK_SORUSU_CEVABI'
          Title.Caption = 'G'#252'venlik Sorusu Cevab'#305
          Width = 254
          Sortable = True
        end>
    end
  end
  object dsKullanicilar: TDataSource
    DataSet = qKullanicilar
    Left = 360
    Top = 328
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
    Left = 296
    Top = 400
  end
  object qKullanicilar: TUniQuery
    Connection = UniServerModule.ServisDB
    SQL.Strings = (
      'Select KULLANICILAR.*, FRM_ADI'
      'From KULLANICILAR'
      'Left Join FIRMALAR On FRM_ID=KUL_FRM_ID'
      'Order By KUL_ADI_SOYADI')
    SpecificOptions.Strings = (
      'InterBase.FetchAll=True')
    Left = 296
    Top = 328
  end
end
