unit Firmalar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Kullanici,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses, StrUtils, UniPageControl,
  uniGUIClasses, uniGUIFrame, Data.DB, MemDS, DBAccess, Uni, uniBasicGrid,
  uniGridExporters, uniGUIBaseClasses, uniSweetAlert, uniDBGrid, uniMultiItem,
  uniComboBox, uniEdit, uniButton, uniBitBtn, uniPanel;

type
  TFirmalarForm = class(TUniFrame)
    UniPanel1: TUniPanel;
    UniToolBar1: TUniPanel;
    btnYeni: TUniBitBtn;
    btnDegistir: TUniBitBtn;
    btnSil: TUniBitBtn;
    btnKapat: TUniBitBtn;
    UniPanel2: TUniPanel;
    btnSec: TUniBitBtn;
    pnlBul: TUniPanel;
    UniPanel3: TUniPanel;
    btnBul: TUniBitBtn;
    txtKategori: TUniEdit;
    txtDurum: TUniComboBox;
    txtKayitSayisi: TUniComboBox;
    Grid: TUniDBGrid;
    dsKategoriler: TDataSource;
    sil: TUniSweetAlert;
    qKategoriler: TUniQuery;
    procedure btnBulClick(Sender: TObject);
    procedure btnGridExportClick(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
    procedure btnSecClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure GridAjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
    procedure GridColumnSort(Column: TUniDBGridColumn; Direction: Boolean);
    procedure GridDblClick(Sender: TObject);
    procedure btnDegistirClick(Sender: TObject);
    procedure GridDrawColumnCell(Sender: TObject; ACol, ARow: Integer;
      Column: TUniDBGridColumn; Attribs: TUniCellAttribs);
    procedure silConfirm(Sender: TObject);
    procedure UniFrameAjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
    procedure UniFrameCreate(Sender: TObject);
    procedure btnYeniClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    PKullaniciForm: TKullaniciForm;
  end;

implementation

{$R *.dfm}

uses ServerModule, MainModule, Utils, Firma;

procedure TFirmalarForm.btnBulClick(Sender: TObject);
begin
  try
    qFirmalar.Close;
    qFirmalar.Conditions.Clear;
    pnlBul.Caption := '';
    Grid.WebOptions.PageSize := StrToInt(txtKayitSayisi.Text);
    if txtDurum.ItemIndex=0 then
    begin
      qFirmalar.Conditions.Add('DURUM', 'FRM_DURUM=1', True);
      pnlBul.Caption := pnlBul.Caption + ifthen(pnlBul.Caption <> '', ', ') + 'Durum : Kullanýmda';
    end
    else
    if txtDurum.ItemIndex=1 then
    begin
      qFirmalar.Conditions.Add('DURUM', 'FRM_DURUM=0', True);
      pnlBul.Caption := pnlBul.Caption + ifthen(pnlBul.Caption <> '', ', ') + 'Durum : Kullaným Dýþý';
    end;
    if txtFirma.Text<>'' then
    begin
      qFirmalar.Conditions.Add('KOD', 'UPPER(FRM_ADI) LIKE ''' + Buyuk(SuzgecVerisiIsle(txtFirma.Text)) + '''', True);
      pnlBul.Caption := pnlBul.Caption + ifthen(pnlBul.Caption <> '', ', ') + 'Firma : ' + SuzgecVerisiIsle(txtFirma.Text);
    end;

    qFirmalar.Conditions.Enable;
    qFirmalar.Open;
    pnlBul.Visible := pnlBul.Caption <> '';

    UniMainModule.Focus(Grid);
  except on e:exception do
    UniMainModule.Notification('', HataMesaj(e.Message), 2);
  end;
end;

procedure TFirmalarForm.btnDegistirClick(Sender: TObject);
var
  I: Integer;
  T: TUniTabSheet;
  F: TFirmaForm;
begin
  try
    if qFirmalar.IsEmpty then exit;
    if isFrameOpenedInTab('TFirmaForm', TUniTabSheet(Self.Parent)) then exit;

    UniMainModule.Tmp_ID := qFirmalar.FieldByName('FRM_ID').AsInteger;

    T := TUniTabSheet(Self.Parent);
    T.Caption := T.Caption + ' > Firma [' + qFirmalar.FieldByName('FRM_ADI').AsString + ']';

    for I := 0 to T.ControlCount-1 do
      T.Controls[I].Visible := False;

    F := TFirmaForm.Create(T);
    F.UniPanel1.Caption :=  'Firma [' + qFirmalar.FieldByName('FRM_ADI').AsString + ']';
    F.PFirmalarForm := Self;
    F.Align := alClient;
    F.Parent := T;
    F.Show;
  except on E: Exception do
    UniMainModule.Notification('', HataMesaj(e.Message), 2);
  end;
end;

procedure TFirmalarForm.btnGridExportClick(Sender: TObject);
begin
  try
    if qFirmalar.IsEmpty then exit;
    Grid.Exporter.ExportGrid;
  except on e:exception do
    UniMainModule.Notification('', HataMesaj(e.Message), 2);
  end;

end;

procedure TFirmalarForm.btnKapatClick(Sender: TObject);
begin
  if PKullaniciForm<>nil then
  begin
    PKullaniciForm.qFirmalar.Close;
    PKullaniciForm.qFirmalar.Open;
    UniMainModule.Focus(PKullaniciForm.txtFirma);
  end;
  UniMainModule.FrameKapat(Self);
end;

procedure TFirmalarForm.btnSecClick(Sender: TObject);
begin
  try
    if PKullaniciForm<>nil then
    begin
      if qFirmalar.IsEmpty then exit;
      PKullaniciForm.qFirmalar.Close;
      PKullaniciForm.qFirmalar.Open;
      if not(PKullaniciForm.qKullanici.State in dsEditModes) then
        PKullaniciForm.qKullanici.Edit;
      PKullaniciForm.qKullanici.FieldByName('KUL_FRM_ID').AsInteger := qFirmalar.FieldByName('FRM_ID').AsInteger;
      UniMainModule.Focus(PKullaniciForm.txtFirma);
    end;
    UniMainModule.FrameKapat(Self);
  except on E: Exception do
    UniMainModule.Notification('', HataMesaj(e.Message), 2);
  end;
end;

procedure TFirmalarForm.btnSilClick(Sender: TObject);
begin
  try
    if qFirmalar.IsEmpty then exit;
    sil.Show();
  except on e:exception do
    UniMainModule.Notification('', HataMesaj(e.Message), 2);
  end;

end;

procedure TFirmalarForm.btnYeniClick(Sender: TObject);
var
  I: Integer;
  T: TUniTabSheet;
  F: TFirmaForm;
begin
  try
    if isFrameOpenedInTab('TFirmaForm', TUniTabSheet(Self.Parent)) then exit;
    UniMainModule.Tmp_ID := 0;

    T := TUniTabSheet(Self.Parent);
    T.Caption := T.Caption + ' > Firma [Yeni]';

    for I := 0 to T.ControlCount-1 do
      T.Controls[I].Visible := False;

    F := TFirmaForm.Create(T);
    F.UniPanel1.Caption := 'Firma [Yeni]';
    F.PFirmalarForm := Self;
    F.Align := alClient;
    F.Parent := T;
    F.Show;
  except on E: Exception do
    UniMainModule.Notification('', HataMesaj(e.Message), 2);
  end;
end;

procedure TFirmalarForm.GridAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if EventName='kaydet' then
    UniMainModule.ListeKaydet(20, 'Firmalar', qFirmalar, Grid)
  else
  if EventName='sil' then
    UniMainModule.ListeVarsayilan(20);
end;

procedure TFirmalarForm.GridColumnSort(Column: TUniDBGridColumn;
  Direction: Boolean);
begin
  UniMainModule.Sort(qFirmalar, Column.FieldName, Direction);
end;

procedure TFirmalarForm.GridDblClick(Sender: TObject);
begin
  if btnSec.Visible = true then
    btnSecClick(btnSec)
  else
    btnDegistirClick(btnDegistir);
end;

procedure TFirmalarForm.GridDrawColumnCell(Sender: TObject; ACol,
  ARow: Integer; Column: TUniDBGridColumn; Attribs: TUniCellAttribs);
begin
  if Column.FieldName='FRM_DURUM' then
    if Column.Field.IsNull = false then
      if Column.Field.AsInteger = 0 then
      begin
        Attribs.Color := clRed;
        Attribs.Font.Color := clWhite;
      end;
end;

procedure TFirmalarForm.silConfirm(Sender: TObject);
begin
  try
    qFirmalar.Delete;
    UniMainModule.Notification('', 'Kayýt Silindi', 3);
    UniMainModule.Focus(txtFirma);
  except on e:exception do
    UniMainModule.Notification('', HataMesaj(e.Message), 2);
  end;
end;

procedure TFirmalarForm.UniFrameAjaxEvent(Sender: TComponent;
  EventName: string; Params: TUniStrings);
begin
  if EventName = 'esc_pressed' then btnKapatClick(Sender);
end;

procedure TFirmalarForm.UniFrameCreate(Sender: TObject);
begin
  Grid.ClientEvents.ExtEvents.Values['viewready'] := 'function (sender, eOpts)' +
       '{' +
       'var tm = new Ext.util.TextMetrics();' +
       'sender.view.tip = Ext.create("Ext.tip.ToolTip", {' +
       'target: sender.view.el,' +
       'delegate: sender.view.cellSelector,' +
       'trackMouse: true,' +
       'renderTo: Ext.getBody(),' +
       'listeners: {' +
       'beforeshow: function updateTipBody(tip) {' +
       'gridColums = sender.view.getGridColumns();' +
       'column = gridColums[tip.triggerElement.cellIndex];' +
       'record = sender.view.getRecord(tip.triggerElement.parentNode);' +
       'if (column.dataIndex !== "-1" && (column.getWidth() < (tm.getSize(record.data[parseInt(column.dataIndex)]).width) + 5)) {' +
       'tip.update(record.data[parseInt(column.dataIndex)]);' +
       '} else {' +
       'return false;' +
       '}' +
       '}' +
       '}' +
       '});' +
       '}';

  Grid.ClientEvents.UniEvents.Values['pagingBar.afterCreate'] := 'function (sender){' +
         'sender.dock = "top";' +
         'sender.displayMsg = "Kayýt Adedi : {2}";' +
         'sender.displayInfo = true;' +
         'sender.insert(0, [{' +
         'xtype: "label",' +
         'cls: "grdfooter",' +
         'padding: "0 0 1 5"' +
         '},' +

         '{' +
         'xtype: "button",' +
         'icon: "files/img/ok.png",' +
         'tooltip: "Liste Görünümünü Kaydet",' +
         'handler: function() {' +
         'ajaxRequest(sender, "kaydet", []);' +
         '}' +
         '},' +

         '{' +
         'xtype: "tbseparator"' +
         '},' +

         '{' +
         'xtype: "button",' +
         'icon: "files/img/delete.png",' +
         'tooltip: "Varsayýlan Görünüm",' +
         'handler: function() {' +
         'ajaxRequest(sender, "sil", []);' +
         '}' +
         '},' +

         '{' +
         'xtype: "tbseparator"' +
         '}' +

         ']);' +
         '}';

  self.ClientEvents.ExtEvents.Values['afterrender'] := 'function afterrender(sender, eOpts)' +
         '{' +
         '   sender.el.on("keydown", function(e){' +
         '   if (e.getKey() == Ext.EventObject.ESC) {' +
         '      ajaxRequest(sender, "esc_pressed", []);' +
         '   }' +
         '   });' +
         '}';

//  else
//    Grid.ClientEvents.UniEvents.Values['pagingBar.afterCreate'] := 'function (sender){ sender.dock = "top"; }';

  UniMainModule.ButtonMask([btnYeni, btnDegistir, btnGridExport, btnBul, btnSec, btnKapat]);
  UniMainModule.SetFocusBlur(TUniFrame(Self));

  try
    if qFirmalar.Active then
      qFirmalar.Close;
    qFirmalar.Open;

    UniMainModule.ListeYukle(20, Grid);
    if UniMainModule.Tmp_Form_Sec = 1 then
    begin
      UniMainModule.Tmp_Form_Sec := -1;
      btnSec.Visible := true;
      Grid.OnDblClick := btnSecClick;
    end;
    if UniMainModule.Tmp_Kod<>'' then
    begin
      txtFirma.Text := UniMainModule.Tmp_Kod;
      UniMainModule.Tmp_Kod := '';
      btnBulClick(btnBul);
    end;
    UniMainModule.Focus(txtFirma);

  except on e: exception do
    UniMainModule.Notification('', HataMesaj(e.Message), 2);
  end;
end;

end.
