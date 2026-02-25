unit UFirma;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses, UFirmalar,
  uniGUIClasses, uniGUIFrame, Data.DB, MemDS, DBAccess, Uni, uniGUIBaseClasses,
  uniSweetAlert, uniMultiItem, uniComboBox, uniDBComboBox, uniDBLookupComboBox,
  uniCheckBox, uniDBCheckBox, uniMemo, uniDBMemo, uniEdit, uniDBEdit,
  uniScrollBox, uniButton, uniBitBtn, uniPanel;

type
  TUFirmaForm = class(TUniFrame)
    UniToolBar1: TUniPanel;
    btnKaydet: TUniBitBtn;
    UniPanel1: TUniPanel;
    btnYeni: TUniBitBtn;
    btnKapat: TUniBitBtn;
    btnVazgec: TUniBitBtn;
    btnSil: TUniBitBtn;
    btnYardim: TUniBitBtn;
    UniScrollBox1: TUniScrollBox;
    txtFirmaAdi: TUniDBEdit;
    txtAciklama: TUniDBMemo;
    txtTelefon: TUniDBEdit;
    txtDurum: TUniDBCheckBox;
    txtUnvan: TUniDBEdit;
    txtIl: TUniDBLookupComboBox;
    txtIlce: TUniDBLookupComboBox;
    txtMahalle: TUniDBLookupComboBox;
    txtYetkili: TUniDBEdit;
    txtVD: TUniDBEdit;
    txtVNo: TUniDBEdit;
    txtBinaAdi: TUniDBEdit;
    txtCadde: TUniDBEdit;
    txtBinaNo: TUniDBEdit;
    txtAdres: TUniDBMemo;
    txtPostaKodu: TUniDBEdit;
    txtDaireNo: TUniDBEdit;
    txtWeb: TUniDBEdit;
    sil: TUniSweetAlert;
    iptal: TUniSweetAlert;
    qFirma: TUniQuery;
    dsFirma: TDataSource;
    qIller: TUniQuery;
    dsIller: TDataSource;
    dsIlceler: TDataSource;
    qIlceler: TUniQuery;
    qMahalleler: TUniQuery;
    dsMahalleler: TDataSource;
    procedure UniFrameCreate(Sender: TObject);
    procedure silConfirm(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure btnVazgecClick(Sender: TObject);
    procedure btnYeniClick(Sender: TObject);
    procedure dsFirmaStateChange(Sender: TObject);
    procedure iptalConfirm(Sender: TObject);
    procedure UniFrameAjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
    procedure txtIlEnter(Sender: TObject);
    procedure txtIlceEnter(Sender: TObject);
    procedure txtMahalleEnter(Sender: TObject);
    procedure txtIlChange(Sender: TObject);
    procedure txtIlceChange(Sender: TObject);
    procedure txtMahalleChange(Sender: TObject);
  private
    FRM_ID: integer;
    procedure DugmeleriAyarla;
    { Private declarations }
  public
    { Public declarations }
    PUFirmalarForm: TUFirmalarForm;
  end;

implementation

{$R *.dfm}


uses MainModule, ServerModule, Utils;


procedure TUFirmaForm.btnKapatClick(Sender: TObject);
begin
  try
    if qFirma.State in dsEditModes then
      iptal.Show
    else
    begin
      if PUFirmalarForm<>nil then
      begin
        UniMainModule.DataSetRefresh(PUFirmalarForm.qFirmalar, 'FRM_ID', qFirma.FieldByName('FRM_ID').AsInteger);
        UniMainModule.Focus(PUFirmalarForm.txtFirma);
      end;
      UniMainModule.FrameKapat(Self);
    end;
  except on E: Exception do
    UniMainModule.Notification('', HataMesaj(e.Message), 2);
  end;
end;

procedure TUFirmaForm.btnKaydetClick(Sender: TObject);
begin
  try
    if qFirma.State in dsEditModes then
    begin
      if Trim(qFirma.FieldByName('FRM_ADI').AsString)='' then
      begin
        UniMainModule.Notification('', 'Firma adýný giriniz', 1);
        UniMainModule.Focus(txtFirmaAdi);
        exit;
      end;
      qFirma.Post;
      qFirma.ParamByName('FRM_ID').AsInteger := qFirma.FieldByName('FRM_ID').AsInteger;
      UniMainModule.Notification('', 'Ýþlem Tamamlandý', 3);
      UniMainModule.Focus(txtFirmaAdi);
    end;
  except on E: Exception do
    UniMainModule.Notification('', HataMesaj(e.Message), 2);
  end;
end;

procedure TUFirmaForm.btnSilClick(Sender: TObject);
begin
  try
    sil.Show;
  except on E: Exception do
    UniMainModule.Notification('', HataMesaj(e.Message), 2);
  end;
end;

procedure TUFirmaForm.btnVazgecClick(Sender: TObject);
begin
  try
    if qFirma.State in dsEditModes then
    begin
      qFirma.Cancel;
      if not qFirma.FieldByName('FRM_ID').IsNull then
      begin
        qFirma.ParamByName('FRM_ID').AsInteger := qFirma.FieldByName('FRM_ID').AsInteger;
        UniMainModule.Focus(txtFirmaAdi);
      end
      else
      begin
        if PUFirmalarForm<>nil then
        begin
          UniMainModule.DataSetRefresh(PUFirmalarForm.qFirmalar, 'FRM_ID', qFirma.FieldByName('FRM_ID').AsInteger);
          UniMainModule.Focus(PUFirmalarForm.txtFirma);
        end;
        UniMainModule.FrameKapat(Self);
      end;
    end;
  except on E: Exception do
    UniMainModule.Notification('', HataMesaj(e.Message), 2);
  end;
end;

procedure TUFirmaForm.btnYeniClick(Sender: TObject);
begin
  try
    if qFirma.State=dsBrowse then
    begin
      qFirma.Append;
      UniMainModule.Focus(txtFirmaAdi);
    end;
  except on E: Exception do
    UniMainModule.Notification('', HataMesaj(e.Message), 2);
  end;
end;

procedure TUFirmaForm.dsFirmaStateChange(Sender: TObject);
begin
  DugmeleriAyarla;
end;

procedure TUFirmaForm.silConfirm(Sender: TObject);
begin
  try
    qFirma.Delete;
    if PUFirmalarForm<>nil then
    begin
      UniMainModule.DataSetRefresh(PUFirmalarForm.qFirmalar, 'FRM_ID', qFirma.FieldByName('FRM_ID').AsInteger);
      UniMainModule.Focus(PUFirmalarForm.txtFirma);
    end;
    UniMainModule.Notification('', 'Kayýt Silindi', 3);
    UniMainModule.FrameKapat(Self);
  except on e:exception do
    UniMainModule.Notification('', HataMesaj(e.Message), 2);
  end;
end;

procedure TUFirmaForm.txtIlceChange(Sender: TObject);
begin
  if Trim(txtIlce.Text) = '' then
    if dsFirma.State in [dsEdit, dsInsert] then
    begin
      qFirma.FieldByName('FRM_ILC_ID').Clear;
      qFirma.FieldByName('FRM_MAH_ID').Clear;
    end;
end;

procedure TUFirmaForm.txtIlceEnter(Sender: TObject);
begin
  qIlceler.DisableControls;
  try
    if txtIl.Text='' then
      qIlceler.Close
    else
    begin
      qIlceler.Close;
      qIlceler.Open;
    end;
    UniSession.Synchronize;
  finally
    qIlceler.EnableControls;
  end;
end;

procedure TUFirmaForm.txtIlChange(Sender: TObject);
begin
  if Trim(txtIl.Text) = '' then
    if dsFirma.State in [dsEdit, dsInsert] then
    begin
      qFirma.FieldByName('FRM_IL_ID').Clear;
      qFirma.FieldByName('FRM_ILC_ID').Clear;
      qFirma.FieldByName('FRM_MAH_ID').Clear;
    end;
end;

procedure TUFirmaForm.txtIlEnter(Sender: TObject);
begin
  qIller.DisableControls;
  try
    qIller.Close;
    qIller.Open;
    UniSession.Synchronize;
  finally
    qIller.EnableControls;
  end;
end;

procedure TUFirmaForm.txtMahalleChange(Sender: TObject);
begin
  if Trim(txtMahalle.Text) = '' then
    if dsFirma.State in [dsEdit, dsInsert] then
    begin
      qFirma.FieldByName('FRM_MAH_ID').Clear;
    end;
end;

procedure TUFirmaForm.txtMahalleEnter(Sender: TObject);
begin
  qMahalleler.DisableControls;
  try
    if txtIlce.Text='' then
      qMahalleler.Close
    else
    begin
      qMahalleler.Close;
      qMahalleler.Open;
    end;
    UniSession.Synchronize;
  finally
    qMahalleler.EnableControls;
  end;
end;

procedure TUFirmaForm.UniFrameAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if EventName = 'esc_pressed' then btnKapatClick(Sender);
end;

procedure TUFirmaForm.UniFrameCreate(Sender: TObject);
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

  FRM_ID := UniMainModule.Tmp_ID;
  UniMainModule.Tmp_ID := -1;

  try
    if qFirma.Active then
      qFirma.Close;
    if qIller.Active then
      qIller.Close;
    if qIlceler.Active then
      qIlceler.Close;
    if qMahalleler.Active then
      qMahalleler.Close;

    qIller.Open;
    qIlceler.Open;
    qMahalleler.Open;

    qFirma.ParamByName('FRM_ID').AsInteger := FRM_ID;
    qFirma.Open;

    if FRM_ID=0 then
      qFirma.Append;

    txtIlEnter(txtIl);

    UniMainModule.Focus(txtFirmaAdi);

  except on e: exception do
    UniMainModule.Notification('', HataMesaj(e.Message), 2);
  end;
end;

procedure TUFirmaForm.DugmeleriAyarla;
begin
  try
    btnKaydet.Visible     := qFirma.State in dsEditModes;
    btnVazgec.Visible     := btnKaydet.Visible;
    btnYeni.Visible       := not btnKaydet.Visible;
    btnSil.Visible        := not btnKaydet.Visible;
  except on E: Exception do
    UniMainModule.Notification('', HataMesaj(e.Message), 2);
  end;
end;

procedure TUFirmaForm.iptalConfirm(Sender: TObject);
begin
  try
    qFirma.Cancel;
    if PUFirmalarForm<>nil then
    begin
      UniMainModule.DataSetRefresh(PUFirmalarForm.qFirmalar, 'FRM_ID', qFirma.FieldByName('FRM_ID').AsInteger);
      UniMainModule.Focus(PUFirmalarForm.txtFirma);
    end;
    UniMainModule.FrameKapat(Self)
  except on E: Exception do
    UniMainModule.Notification('', HataMesaj(e.Message), 2);
  end;
end;

end.
