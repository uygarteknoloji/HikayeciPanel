unit KayitBilgi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniLabel, uniGUIBaseClasses, uniPanel, uniButton,
  uniBitBtn, Data.DB, MemDS, DBAccess, Uni, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TKayitBilgiForm = class(TUniForm)
    UniPanel1: TUniPanel;
    UniPanel2: TUniPanel;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    txtKaydeden: TUniLabel;
    txtKayitTarihi: TUniLabel;
    UniLabel5: TUniLabel;
    txtDegistiren: TUniLabel;
    UniLabel7: TUniLabel;
    txtDegisiklikTarihi: TUniLabel;
    procedure UniFormShow(Sender: TObject);
    procedure UniFormCreate(Sender: TObject);
    procedure UniFormAjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
    procedure UniFormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    K, D, K_ZAMAN, D_ZAMAN: string;
  end;

function KayitBilgiForm: TKayitBilgiForm;

implementation

{$R *.dfm}

uses
  ServerModule, MainModule, Utils;

function KayitBilgiForm: TKayitBilgiForm;
begin
  Result := TKayitBilgiForm(UniMainModule.GetFormInstance(TKayitBilgiForm));
end;

procedure TKayitBilgiForm.UniFormAjaxEvent(Sender: TComponent;
  EventName: string; Params: TUniStrings);
begin
  if EventName = 'outsideClick' then
    ModalResult := mrClose; // ya da Close;
end;

procedure TKayitBilgiForm.UniFormCreate(Sender: TObject);
begin
  UniSession.AddJS(
      'setTimeout(function(){' +
      '  var wins = Ext.WindowManager.getActive();' +
      '  if (wins) {' +
      '    wins.mon(Ext.getDoc(), "mousedown", function(e) {' +
      '      if (!wins.el.contains(e.getTarget())) {' +
      '        ajaxRequest(wins, "outsideClick", []);' +
      '      }' +
      '    });' +
      '  }' +
      '}, 300);'
    );
end;

procedure TKayitBilgiForm.UniFormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ModalResult := mrCancel;
end;

procedure TKayitBilgiForm.UniFormShow(Sender: TObject);
begin
  try
    txtKaydeden.Text         := '';
    txtKayitTarihi.Text      := '';
    txtDegistiren.Text       := '';
    txtDegisiklikTarihi.Text := '';
    if K<>'' then
      txtKaydeden.Text := K;
    if D<>'' then
      txtDegistiren.Text := D;
    if K_ZAMAN<>'' then
      txtKayitTarihi.Text := FormatDateTime('dd.mm.yyyy HH:mm', StrToDateTime(K_ZAMAN)) ;
    if D_ZAMAN<>'' then
      txtDegisiklikTarihi.Text := FormatDateTime('dd.mm.yyyy HH:mm', StrToDateTime(D_ZAMAN)) ;
  except on e:exception do
    UniMainModule.Notification('Hata', HataMesaj(e.Message), 2);
  end;
end;

end.
