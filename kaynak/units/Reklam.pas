unit Reklam;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, UniPageControl,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses, Reklamlar,
  uniGUIClasses, uniGUIFrame, Data.DB, MemDS, DBAccess, Uni, uniGUIBaseClasses,
  uniSweetAlert, uniMultiItem, uniComboBox, uniDBComboBox, uniDBLookupComboBox,
  uniCheckBox, uniDBCheckBox, uniMemo, uniDBMemo, uniEdit, uniDBEdit,
  uniScrollBox, uniButton, uniBitBtn, uniPanel, uniImage, uniDBImage, Vcl.Menus,
  uniMainMenu, uniFileUpload;

type
  TReklamForm = class(TUniFrame)
    UniToolBar1: TUniPanel;
    btnKaydet: TUniBitBtn;
    UniPanel1: TUniPanel;
    btnYeni: TUniBitBtn;
    btnKapat: TUniBitBtn;
    btnVazgec: TUniBitBtn;
    btnSil: TUniBitBtn;
    btnYardim: TUniBitBtn;
    UniScrollBox1: TUniScrollBox;
    txtDurum: TUniDBCheckBox;
    sil: TUniSweetAlert;
    iptal: TUniSweetAlert;
    qReklam: TUniQuery;
    dsReklam: TDataSource;
    txtAciklama: TUniDBMemo;
    Yukle: TUniFileUpload;
    txtDosyaAdi: TUniDBEdit;
    procedure UniFrameCreate(Sender: TObject);
    procedure silConfirm(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure btnVazgecClick(Sender: TObject);
    procedure btnYeniClick(Sender: TObject);
    procedure dsReklamStateChange(Sender: TObject);
    procedure iptalConfirm(Sender: TObject);
    procedure UniFrameAjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
    procedure txtDosyaAdiTriggerEvent(Sender: TUniFormControl;
      AButtonId: Integer);
    procedure YukleCompleted(Sender: TObject; AStream: TFileStream);
  private
    R_ID: integer;
    FTempFilePath: string;
    procedure DugmeleriAyarla;
    function GenerateGuid: string;
    { Private declarations }
  public
    { Public declarations }
    PReklamlarForm: TReklamlarForm;
  end;

implementation

{$R *.dfm}


uses ServerModule, MainModule, Utils, Cihazlar, Kategoriler;


procedure TReklamForm.btnKapatClick(Sender: TObject);
begin
  try
    if qReklam.State in dsEditModes then
      iptal.Show
    else
    begin
      if PReklamlarForm<>nil then
      begin
        UniMainModule.DataSetRefresh(PReklamlarForm.qReklamlar, 'R_ID', qReklam.FieldByName('R_ID').AsInteger);
        UniMainModule.Focus(PReklamlarForm.txtDosya);
      end;
      UniMainModule.FrameKapat(Self);
    end;
  except on E: Exception do
    UniMainModule.Notification('', HataMesaj(e.Message), 2);
  end;
end;

function TReklamForm.GenerateGuid: string;
var
  s: string;
begin
  s := StringReplace(TGUID.NewGuid.ToString, '{', '', [rfReplaceAll]);
  s := StringReplace(s, '}', '', [rfReplaceAll]);
  s := StringReplace(s, '-', '', [rfReplaceAll]);
  Result := s;
end;

procedure TReklamForm.btnKaydetClick(Sender: TObject);
begin
  try
    if qReklam.State in dsEditModes then
    begin
      if Trim(qReklam.FieldByName('R_DOSYA_ADI').AsString)='' then
      begin
        UniMainModule.Notification('', 'Dosya seçimi yapýnýz', 1);
        UniMainModule.Focus(txtDosyaAdi);
        exit;
      end;
      qReklam.Post;
      qReklam.ParamByName('R_ID').AsInteger := qReklam.FieldByName('R_ID').AsInteger;
      UniMainModule.Notification('', 'Ýþlem Tamamlandý', 3);
      UniMainModule.Focus(txtDosyaAdi);
    end;
  except on E: Exception do
    UniMainModule.Notification('', HataMesaj(e.Message), 2);
  end;
end;

procedure TReklamForm.btnSilClick(Sender: TObject);
begin
  try
    sil.Show;
  except on E: Exception do
    UniMainModule.Notification('', HataMesaj(e.Message), 2);
  end;
end;

procedure TReklamForm.btnVazgecClick(Sender: TObject);
begin
  try
    if qReklam.State in dsEditModes then
    begin
      qReklam.Cancel;
      if not qReklam.FieldByName('R_ID').IsNull then
      begin
        qReklam.ParamByName('R_ID').AsInteger := qReklam.FieldByName('R_ID').AsInteger;
        UniMainModule.Focus(txtDosyaAdi);
      end
      else
      begin
        if PReklamlarForm<>nil then
        begin
          UniMainModule.DataSetRefresh(PReklamlarForm.qReklamlar, 'R_ID', qReklam.FieldByName('R_ID').AsInteger);
          UniMainModule.Focus(PReklamlarForm.txtDosya);
        end;
        UniMainModule.FrameKapat(Self);
      end;
    end;
  except on E: Exception do
    UniMainModule.Notification('', HataMesaj(e.Message), 2);
  end;
end;

procedure TReklamForm.btnYeniClick(Sender: TObject);
begin
  try
    if qReklam.State=dsBrowse then
    begin
      qReklam.Append;
      UniMainModule.Focus(txtDosyaAdi);
    end;
  except on E: Exception do
    UniMainModule.Notification('', HataMesaj(e.Message), 2);
  end;
end;

procedure TReklamForm.dsReklamStateChange(Sender: TObject);
begin
  DugmeleriAyarla;
end;

procedure TReklamForm.silConfirm(Sender: TObject);
begin
  try
    if FileExists('files\reklamlar\' + qReklam.FieldByName('R_DOSYA_ADI').AsString) then
    begin
      if DeleteFile('files\reklamlar\' + qReklam.FieldByName('R_DOSYA_ADI').AsString) then
      begin
        qReklam.Delete;
        if PReklamlarForm<>nil then
        begin
          UniMainModule.DataSetRefresh(PReklamlarForm.qReklamlar, 'R_ID', qReklam.FieldByName('R_ID').AsInteger);
          UniMainModule.Focus(PReklamlarForm.txtDosya);
        end;
        UniMainModule.Notification('', 'Dosya ve Kayýt Silindi', 3);
      end
      else
        UniMainModule.Notification('', 'Dosya ve Kayýt Silinemedi', 2);
    end
    else
    begin
      qReklam.Delete;
      if PReklamlarForm<>nil then
      begin
        UniMainModule.DataSetRefresh(PReklamlarForm.qReklamlar, 'R_ID', qReklam.FieldByName('R_ID').AsInteger);
        UniMainModule.Focus(PReklamlarForm.txtDosya);
      end;
      UniMainModule.Notification('', 'Dosya bulunamadý, kayýt silindi', 2);
    end;
    UniMainModule.Focus(txtDosyaAdi);
  except on e:exception do
    UniMainModule.Notification('', HataMesaj(e.Message), 2);
  end;
end;

procedure TReklamForm.txtDosyaAdiTriggerEvent(Sender: TUniFormControl;
  AButtonId: Integer);
begin
  Yukle.Execute;
end;

procedure TReklamForm.UniFrameAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if EventName = 'esc_pressed' then btnKapatClick(Sender);
end;

procedure TReklamForm.UniFrameCreate(Sender: TObject);
begin
  self.ClientEvents.ExtEvents.Values['afterrender'] := 'function afterrender(sender, eOpts)' +
         '{' +
         '   sender.el.on("keydown", function(e){' +
         '   if (e.getKey() == Ext.EventObject.ESC) {' +
         '      ajaxRequest(sender, "esc_pressed", []);' +
         '   }' +
         '   });' +
         '}';

  UniMainModule.ButtonMask([btnKaydet, btnVazgec, btnYeni, btnSil, btnKapat]);
  UniMainModule.SetFocusBlur(TUniFrame(Self));

  R_ID := UniMainModule.Tmp_ID;
  UniMainModule.Tmp_ID := -1;

  try
    if qReklam.Active then
      qReklam.Close;

    qReklam.ParamByName('R_ID').AsInteger := R_ID;
    qReklam.Open;

    if R_ID=0 then
    begin
      qReklam.Append;
    end;

    UniMainModule.Focus(txtDosyaAdi);

  except on e: exception do
    UniMainModule.Notification('', HataMesaj(e.Message), 2);
  end;
end;

procedure TReklamForm.YukleCompleted(Sender: TObject; AStream: TFileStream);
begin
  if qReklam.State in dsEditModes then
    qReklam.FieldByName('R_DOSYA_ADI').AsString := Yukle.FileName;
end;

procedure TReklamForm.DugmeleriAyarla;
begin
  try
    btnKaydet.Visible     := qReklam.State in dsEditModes;
    btnVazgec.Visible     := btnKaydet.Visible;
    btnYeni.Visible       := not btnKaydet.Visible;
    btnSil.Visible        := not btnKaydet.Visible;
  except on E: Exception do
    UniMainModule.Notification('', HataMesaj(e.Message), 2);
  end;
end;

procedure TReklamForm.iptalConfirm(Sender: TObject);
begin
  try
    qReklam.Cancel;
    if PReklamlarForm<>nil then
    begin
      UniMainModule.DataSetRefresh(PReklamlarForm.qReklamlar, 'R_ID', qReklam.FieldByName('R_ID').AsInteger);
      UniMainModule.Focus(PReklamlarForm.txtDosya);
    end;
    UniMainModule.FrameKapat(Self)
  except on E: Exception do
    UniMainModule.Notification('', HataMesaj(e.Message), 2);
  end;
end;

end.
