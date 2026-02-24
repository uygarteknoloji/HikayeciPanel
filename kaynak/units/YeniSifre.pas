unit YeniSifre;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniEdit, uniGUIBaseClasses, uniPanel, uniHTMLFrame,
  uniButton, uniBitBtn, Data.DB, MemDS, DBAccess, Uni;

type
  TYeniSifreForm = class(TUniForm)
    UniPanel1: TUniPanel;
    txtEMail: TUniEdit;
    txtAdi: TUniEdit;
    txtSoyadi: TUniEdit;
    txtTelefon: TUniEdit;
    btnOk: TUniBitBtn;
    btnCancel: TUniBitBtn;
    qKullanici: TUniQuery;
    txtCevap: TUniEdit;
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function YeniSifreForm: TYeniSifreForm;

implementation

{$R *.dfm}

uses
  ServerModule, MainModule, uniGUIApplication, Utils;

function YeniSifreForm: TYeniSifreForm;
begin
  Result := TYeniSifreForm(UniMainModule.GetFormInstance(TYeniSifreForm));
end;

function CreateSimpleGuid: string;
var
  g: TGUID;
begin
  CreateGUID(g);
  Result := GUIDToString(g);          // "{XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX}"
  Result := StringReplace(Result, '{', '', [rfReplaceAll]);
  Result := StringReplace(Result, '}', '', [rfReplaceAll]);
  Result := StringReplace(Result, '-', '', [rfReplaceAll]);
  Result := LowerCase(Result);        // küçük harf yap
end;

procedure TYeniSifreForm.btnOkClick(Sender: TObject);
var
  g: string;
begin
  if Trim(txtEMail.Text)='' then
  begin
    UniMainModule.Notification('', 'Email adresi giriniz', 1);
    UniMainModule.Focus(txtEMail);
    exit;
  end;
  if Trim(txtAdi.Text)='' then
  begin
    UniMainModule.Notification('', 'Adınızı giriniz', 1);
    UniMainModule.Focus(txtAdi);
    exit;
  end;
  if Trim(txtSoyadi.Text)='' then
  begin
    UniMainModule.Notification('', 'Soyadınızı giriniz', 1);
    UniMainModule.Focus(txtAdi);
    exit;
  end;
  if Trim(txtTelefon.Text)='' then
  begin
    UniMainModule.Notification('', 'Telefon numaranızı giriniz', 1);
    UniMainModule.Focus(txtTelefon);
    exit;
  end
  else
//  if Trim(txtCevap.Text)='' then
//  begin
//    UniMainModule.Notification('', 'Güvenlik anahtar kelimesini giriniz', 1);
//    UniMainModule.Focus(txtTelefon);
//    exit;
//  end;
  try
    try
      qKullanici.Close;
      qKullanici.SQL.Clear;
      qKullanici.SQL.Add('SELECT *');
      qKullanici.SQL.Add('FROM KULLANICILAR');
      qKullanici.SQL.Add('WHERE KUL_EMAIL=:KUL_EMAIL');
      qKullanici.ParamByName('KUL_EMAIL').AsString := txtEMail.Text;
      qKullanici.Open;
      if qKullanici.IsEmpty then
      begin
        UniMainModule.Notification('', 'Bu email hesabına ait kullanıcı bulunamadı !!!', 1);
        exit;
      end
      else
      if qKullanici.FieldByName('KUL_ADI').AsString <> txtAdi.Text then
      begin
        UniMainModule.Notification('', 'Girmiş olduğunuz "Adı" bilgisi geçersiz !!!', 1);
        exit;
      end
      else
      if qKullanici.FieldByName('KUL_SOYADI').AsString <> txtSoyadi.Text then
      begin
        UniMainModule.Notification('', 'Girmiş olduğunuz "Soyadı" bilgisi geçersiz !!!', 1);
        exit;
      end
      else
      if qKullanici.FieldByName('KUL_TELEFON').AsString <> txtTelefon.Text then
      begin
        UniMainModule.Notification('', 'Girmiş olduğunuz "Telefon" bilgisi geçersiz !!!', 1);
        exit;
      end
      else
//      if qKullanici.FieldByName('KUL_GUVENLIK_SORUSU_CEVABI').AsString <> txtCevap.Text then
//      begin
//        UniMainModule.Notification('', 'Girmiş olduğunuz "Güvenlik Sorusu Cevabı" bilgisi geçersiz !!!', 1);
//        exit;
//      end
//      else
      begin
        g := CreateSimpleGuid;
        if UniMainModule.SendMail_BrevoAPI(txtEMail.Text, 'Şifre Değişikliği Talebiniz Hakkında, Uygar Teknoloji',  'Merhaba,<br><br><br>Şifrenizi <a href="https://kyspro.tr/?a=' + g + '">buradan</a> yenileyebilirsiniz<br><br><br>Saygılarımızla<br>Uygar Teknoloji') then
        begin
          qKullanici.Edit;
          qKullanici.FieldByName('KUL_AKTIVASYON_KODU').AsString := g;
          qKullanici.Post;
          UniMainModule.Notification('', 'Şifre yenileme bağlantınız belirttiğiniz email adresinize gönderildi...', 3);
          Close;
        end;
      end;
    except
      on e: exception do
        UniMainModule.Notification('Hata', HataMesaj(e.Message), 2);
    end;
  finally
    if qKullanici.Active then
      qKullanici.Close;
  end;
end;

end.
