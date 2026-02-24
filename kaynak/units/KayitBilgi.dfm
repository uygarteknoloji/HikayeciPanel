object KayitBilgiForm: TKayitBilgiForm
  Left = 0
  Top = 0
  ClientHeight = 180
  ClientWidth = 440
  Caption = 'Kay'#305't Bilgileri'
  OnShow = UniFormShow
  BorderStyle = bsDialog
  OldCreateOrder = False
  OnKeyDown = UniFormKeyDown
  KeyPreview = True
  MonitoredKeys.Keys = <>
  OnAjaxEvent = UniFormAjaxEvent
  OnCreate = UniFormCreate
  TextHeight = 15
  object UniPanel1: TUniPanel
    Left = 0
    Top = 0
    Width = 217
    Height = 180
    Hint = ''
    Align = alLeft
    TabOrder = 0
    BorderStyle = ubsFrameLowered
    Caption = ''
    Color = 15724527
    ExplicitHeight = 163
    object UniLabel1: TUniLabel
      Left = 77
      Top = 32
      Width = 60
      Height = 17
      Hint = ''
      Alignment = taCenter
      Caption = 'Kaydeden'
      ParentFont = False
      Font.Color = clRed
      Font.Height = -13
      Font.Style = [fsBold]
      TabOrder = 1
    end
    object UniLabel2: TUniLabel
      Left = 73
      Top = 96
      Width = 81
      Height = 17
      Hint = ''
      Alignment = taCenter
      Caption = 'Kay'#305't Zaman'#305
      ParentFont = False
      Font.Color = clRed
      Font.Height = -13
      Font.Style = [fsBold]
      TabOrder = 2
    end
    object txtKaydeden: TUniLabel
      Left = 9
      Top = 54
      Width = 200
      Height = 16
      Hint = ''
      Alignment = taCenter
      AutoSize = False
      Caption = 'Kaydeden'
      ParentFont = False
      Font.Color = clBlack
      Font.Height = -13
      Font.Style = [fsBold]
      TabOrder = 3
    end
    object txtKayitTarihi: TUniLabel
      Left = 9
      Top = 118
      Width = 200
      Height = 16
      Hint = ''
      Alignment = taCenter
      AutoSize = False
      Caption = 'Kay'#305't Tarihi'
      ParentFont = False
      Font.Color = clBlack
      Font.Height = -13
      Font.Style = [fsBold]
      TabOrder = 4
    end
  end
  object UniPanel2: TUniPanel
    Left = 217
    Top = 0
    Width = 223
    Height = 180
    Hint = ''
    Align = alClient
    TabOrder = 1
    BorderStyle = ubsFrameLowered
    Caption = ''
    Color = 15724527
    ExplicitWidth = 217
    ExplicitHeight = 163
    object UniLabel5: TUniLabel
      Left = 62
      Top = 32
      Width = 91
      Height = 17
      Hint = ''
      Alignment = taCenter
      Caption = 'Son De'#287'i'#351'tiren'
      ParentFont = False
      Font.Color = clRed
      Font.Height = -13
      Font.Style = [fsBold]
      TabOrder = 1
    end
    object txtDegistiren: TUniLabel
      Left = 9
      Top = 54
      Width = 200
      Height = 16
      Hint = ''
      Alignment = taCenter
      AutoSize = False
      Caption = 'De'#287'i'#351'tiren'
      ParentFont = False
      Font.Color = clBlack
      Font.Height = -13
      Font.Style = [fsBold]
      TabOrder = 2
    end
    object UniLabel7: TUniLabel
      Left = 46
      Top = 96
      Width = 138
      Height = 17
      Hint = ''
      Alignment = taCenter
      Caption = 'Son De'#287'i'#351'iklik Zaman'#305
      ParentFont = False
      Font.Color = clRed
      Font.Height = -13
      Font.Style = [fsBold]
      TabOrder = 3
    end
    object txtDegisiklikTarihi: TUniLabel
      Left = 9
      Top = 118
      Width = 200
      Height = 16
      Hint = ''
      Alignment = taCenter
      AutoSize = False
      Caption = 'De'#287'i'#351'ilik Tarihi'
      ParentFont = False
      Font.Color = clBlack
      Font.Height = -13
      Font.Style = [fsBold]
      TabOrder = 4
    end
  end
end
