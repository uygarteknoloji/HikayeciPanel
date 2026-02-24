unit YeniSifreOlustur;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniLabel, uniGUIBaseClasses, uniPanel, uniEdit,
  uniButton, Data.DB, MemDS, DBAccess, Uni;

type
  TYeniSifreOlusturForm = class(TUniForm)
    UniPanel1: TUniPanel;
    UniLabel1: TUniLabel;
    txtSifre1: TUniEdit;
    txtSifre2: TUniEdit;
    btnGiris: TUniButton;
    btnVazgec: TUniButton;
    qKullanici: TUniQuery;
    procedure UniFormCreate(Sender: TObject);
    procedure btnGirisClick(Sender: TObject);
  private
    { Private declarations }
    KUL_ID: integer;
  public
    { Public declarations }
  end;

function YeniSifreOlusturForm: TYeniSifreOlusturForm;

implementation

{$R *.dfm}

uses
  ServerModule, MainModule, uniGUIApplication, Utils;

function YeniSifreOlusturForm: TYeniSifreOlusturForm;
begin
  Result := TYeniSifreOlusturForm(UniMainModule.GetFormInstance(TYeniSifreOlusturForm));
end;

procedure TYeniSifreOlusturForm.btnGirisClick(Sender: TObject);
begin
  try
    if Trim(txtSifre1.Text)='' then
    begin
      UniMainModule.Notification('', 'Þifrenizi giriniz', 1);
      UniMainModule.Focus(txtSifre1);
      exit;
    end;
    if Trim(txtSifre2.Text)='' then
    begin
      UniMainModule.Notification('', 'Þifrenizi tekrar giriniz', 1);
      UniMainModule.Focus(txtSifre2);
      exit;
    end;
    if Trim(txtSifre1.Text)<>Trim(txtSifre2.Text) then
    begin
      UniMainModule.Notification('', 'Þifre ve þifre tekrarý ayný deðil !!!', 1);
      UniMainModule.Focus(txtSifre1);
      exit;
    end;
    qKullanici.Edit;
    qKullanici.FieldByName('KUL_AKTIVASYON_KODU').Clear;
    qKullanici.FieldByName('KUL_SIFRE').AsString := LowerCase(MD5(txtSifre1.Text));
    qKullanici.Post;
    UniMainModule.Notification('', 'Þifre deðiþiklik iþlemi baþarý ile tamamlandý. Yeni þifreniz ile giriþ yapabilirsiniz', 3);
    ModalResult := mrOk;
  except on e:exception do
    UniMainModule.Notification('Hata', HataMesaj(e.Message), 2);
  end;
end;

procedure TYeniSifreOlusturForm.UniFormCreate(Sender: TObject);
begin
  KUL_ID := UniMainModule.Tmp_ID;
  UniMainModule.Tmp_ID := -1;
  try
    if qKullanici.Active then
      qKullanici.Close;
    qKullanici.SQL.Clear;
    qKullanici.SQL.Add('Select * From KULLANICILAR Where KUL_ID=:KUL_ID');
    qKullanici.ParamByName('KUL_ID').AsInteger := KUL_ID;
    qKullanici.Open;
    UniLabel1.Caption := 'Merhaba Sayýn, ' + qKullanici.FieldByName('KUL_ADI_SOYADI').AsString;
  except on e:exception do
    UniMainModule.Notification('Hata', HataMesaj(e.Message), 2);
  end;

end;

end.
