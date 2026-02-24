unit Kullanicilar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses, UniPageControl,
  uniGUIClasses, uniGUIFrame, Data.DB, MemDS, DBAccess, Uni, uniBasicGrid,
  uniGridExporters, uniGUIBaseClasses, uniSweetAlert, uniDBGrid, StrUtils,
  uniDateTimePicker, uniMultiItem, uniComboBox, uniEdit, uniButton, uniBitBtn,
  uniPanel;

type
  TKullanicilarForm = class(TUniFrame)
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
    txtAdiSoyadi: TUniEdit;
    txtKayitSayisi: TUniComboBox;
    txtFirma: TUniEdit;
    Grid: TUniDBGrid;
    dsKullanicilar: TDataSource;
    sil: TUniSweetAlert;
    qKullanicilar: TUniQuery;
    txtDurum: TUniComboBox;
    procedure btnBulClick(Sender: TObject);
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
  end;

implementation

{$R *.dfm}

uses ServerModule, MainModule, Utils, Kullanici;



procedure TKullanicilarForm.btnBulClick(Sender: TObject);
begin
  try
    qKullanicilar.Close;
    qKullanicilar.Conditions.Clear;
    pnlBul.Caption := '';
    Grid.WebOptions.PageSize := StrToInt(txtKayitSayisi.Text);
    if txtDurum.ItemIndex=0 then
    begin
      qKullanicilar.Conditions.Add('DURUM', 'KUL_DURUM=1', True);
      pnlBul.Caption := pnlBul.Caption + ifthen(pnlBul.Caption <> '', ', ') + 'Durum : Kullanýmda';
    end
    else
    if txtDurum.ItemIndex=1 then
    begin
      qKullanicilar.Conditions.Add('DURUM', 'KUL_DURUM=0', True);
      pnlBul.Caption := pnlBul.Caption + ifthen(pnlBul.Caption <> '', ', ') + 'Durum : Kullaným Dýþý';
    end;
    if txtAdiSoyadi.Text<>'' then
    begin
      qKullanicilar.Conditions.Add('KOD', 'UPPER(KUL_ADI_SOYADI) LIKE ''' + Buyuk(SuzgecVerisiIsle(txtAdiSoyadi.Text)) + '''', True);
      pnlBul.Caption := pnlBul.Caption + ifthen(pnlBul.Caption <> '', ', ') + 'Adý Soyadý : ' + SuzgecVerisiIsle(txtAdiSoyadi.Text);
    end;
    if txtFirma.Text<>'' then
    begin
      qKullanicilar.Conditions.Add('KOD', 'UPPER(FRM_ADI) LIKE ''' + Buyuk(SuzgecVerisiIsle(txtFirma.Text)) + '''', True);
      pnlBul.Caption := pnlBul.Caption + ifthen(pnlBul.Caption <> '', ', ') + 'Firma : ' + SuzgecVerisiIsle(txtFirma.Text);
    end;

    qKullanicilar.Conditions.Enable;
    qKullanicilar.Open;
    pnlBul.Visible := pnlBul.Caption <> '';

    UniMainModule.Focus(Grid);

  except on e:exception do
    UniMainModule.Notification('', HataMesaj(e.Message), 2);
  end;
end;

procedure TKullanicilarForm.btnDegistirClick(Sender: TObject);
var
  I: Integer;
  T: TUniTabSheet;
  F: TKullaniciForm;
begin
  try
    if qKullanicilar.IsEmpty then exit;
    if isFrameOpenedInTab('TKullaniciForm', TUniTabSheet(Self.Parent)) then exit;

    UniMainModule.Tmp_ID := qKullanicilar.FieldByName('KUL_ID').AsInteger;

    T := TUniTabSheet(Self.Parent);
    T.Caption := T.Caption + ' > Kullanýcý [' + qKullanicilar.FieldByName('KUL_ADI_SOYADI').AsString + ']';

    for I := 0 to T.ControlCount-1 do
      T.Controls[I].Visible := False;

    F := TKullaniciForm.Create(T);
    F.UniPanel1.Caption :=  'Kullanýcý [' + qKullanicilar.FieldByName('KUL_ADI_SOYADI').AsString + ']';
    F.PKullanicilarForm := Self;
    F.Align := alClient;
    F.Parent := T;
    F.Show;
  except on E: Exception do
    UniMainModule.Notification('', HataMesaj(e.Message), 2);
  end;
end;

procedure TKullanicilarForm.btnKapatClick(Sender: TObject);
begin
  UniMainModule.FrameKapat(Self);
end;

procedure TKullanicilarForm.btnSecClick(Sender: TObject);
begin
//
end;

procedure TKullanicilarForm.btnSilClick(Sender: TObject);
begin
  try
    if qKullanicilar.IsEmpty then exit;
    sil.Show();
  except on e:exception do
    UniMainModule.Notification('', HataMesaj(e.Message), 2);
  end;
end;

procedure TKullanicilarForm.btnYeniClick(Sender: TObject);
var
  I: Integer;
  T: TUniTabSheet;
  F: TKullaniciForm;
begin
  try
    if isFrameOpenedInTab('TKullaniciForm', TUniTabSheet(Self.Parent)) then exit;
    UniMainModule.Tmp_ID := 0;

    T := TUniTabSheet(Self.Parent);
    T.Caption := T.Caption + ' > Kullanýcý [Yeni]';

    for I := 0 to T.ControlCount-1 do
      T.Controls[I].Visible := False;

    F := TKullaniciForm.Create(T);
    F.UniPanel1.Caption := 'Kullanýcý [Yeni]';
    F.PKullanicilarForm := Self;
    F.Align := alClient;
    F.Parent := T;
    F.Show;
  except on E: Exception do
    UniMainModule.Notification('', HataMesaj(e.Message), 2);
  end;

end;

procedure TKullanicilarForm.GridAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if EventName='kaydet' then
    UniMainModule.ListeKaydet(18, 'Kullanýcýlar', qKullanicilar, Grid)
  else
  if EventName='sil' then
    UniMainModule.ListeVarsayilan(18);
end;

procedure TKullanicilarForm.GridColumnSort(Column: TUniDBGridColumn;
  Direction: Boolean);
begin
  UniMainModule.Sort(qKullanicilar, Column.FieldName, Direction);
end;

procedure TKullanicilarForm.GridDblClick(Sender: TObject);
begin
  if btnSec.Visible = true then
    btnSecClick(btnSec)
  else
    btnDegistirClick(btnDegistir);
end;

procedure TKullanicilarForm.GridDrawColumnCell(Sender: TObject; ACol,
  ARow: Integer; Column: TUniDBGridColumn; Attribs: TUniCellAttribs);
begin
  if Column.FieldName='KUL_DURUM' then
    if Column.Field.IsNull = false then
      if Column.Field.AsInteger = 0 then
      begin
        Attribs.Color := clRed;
        Attribs.Font.Color := clWhite;
      end;
end;

procedure TKullanicilarForm.silConfirm(Sender: TObject);
begin
  try
    qKullanicilar.Delete;
    UniMainModule.Notification('', 'Kayýt Silindi', 3);
  except on e:exception do
    UniMainModule.Notification('', HataMesaj(e.Message), 2);
  end;
end;

procedure TKullanicilarForm.UniFrameAjaxEvent(Sender: TComponent;
  EventName: string; Params: TUniStrings);
begin
  if EventName = 'esc_pressed' then btnKapatClick(Sender);
end;

procedure TKullanicilarForm.UniFrameCreate(Sender: TObject);
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

  UniMainModule.ButtonMask([btnYeni, btnDegistir, btnBul, btnSec, btnKapat]);
  UniMainModule.SetFocusBlur(TUniFrame(Self));

  try
    if qKullanicilar.Active then
      qKullanicilar.Close;

    qKullanicilar.SQL.Clear;
    qKullanicilar.SQL.Add('Select KULLANICILAR.*, FRM_ADI');
    qKullanicilar.SQL.Add('From KULLANICILAR');
    qKullanicilar.SQL.Add('Left Join FIRMALAR On FRM_ID=KUL_FRM_ID');
    qKullanicilar.SQL.Add('Order By KUL_ADI_SOYADI');
    qKullanicilar.Open;

    UniMainModule.ListeYukle(18, Grid);
    if UniMainModule.Tmp_Form_Sec = 1 then
    begin
      UniMainModule.Tmp_Form_Sec := -1;
      btnSec.Visible := true;
      Grid.OnDblClick := btnSecClick;
    end;
    if UniMainModule.Tmp_Kod<>'' then
    begin
      txtAdiSoyadi.Text := UniMainModule.Tmp_Kod;
      UniMainModule.Tmp_Kod := '';
      btnBulClick(btnBul);
    end;
    UniMainModule.Focus(txtAdiSoyadi);

  except on e: exception do
    UniMainModule.Notification('', HataMesaj(e.Message), 2);
  end;
end;

end.
