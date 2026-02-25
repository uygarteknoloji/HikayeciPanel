program HikayeciPanel;
{$ifdef DEBUG}
  {$APPTYPE CONSOLE}
{$endif}

uses
  Utils,
  unitDebugService,
  SysUtils,
  SvcMgr,
  ServerModule in 'ServerModule.pas' {UniServerModule: TUniGUIServerModule},
  MainModule in 'MainModule.pas' {UniMainModule: TUniGUIMainModule},
  Main in 'Main.pas' {MainForm: TUniForm},
  ServiceModule in 'ServiceModule.pas' {HikayeciPanelServiceModule: TUniGUIService},
  KayitBilgi in 'units\KayitBilgi.pas' {KayitBilgiForm: TUniForm},
  Login in 'units\Login.pas' {LoginForm: TUniForm},
  Kullanici in 'units\Kullanici.pas' {KullaniciForm: TUniFrame},
  Kullanicilar in 'units\Kullanicilar.pas' {KullanicilarForm: TUniFrame},
  YeniSifre in 'units\YeniSifre.pas' {YeniSifreForm: TUniForm},
  YeniSifreOlustur in 'units\YeniSifreOlustur.pas' {YeniSifreOlusturForm: TUniForm},
  Kategoriler in 'units\Kategoriler.pas' {KategorilerForm: TUniFrame},
  Kategori in 'units\Kategori.pas' {KategoriForm: TUniFrame},
  Cihaz in 'units\Cihaz.pas' {CihazForm: TUniFrame},
  Cihazlar in 'units\Cihazlar.pas' {CihazlarForm: TUniFrame},
  UFirma in 'units\UFirma.pas' {UFirmaForm: TUniFrame},
  UFirmalar in 'units\UFirmalar.pas' {UFirmalarForm: TUniFrame};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  if (paramCount > 0) and (SameText(ParamStr(1), '-DEBUG')) then
  begin
    FreeAndNil(Application);
    Application := TDebugServiceApplication.Create(nil);
  end;
  if not Application.DelayInitialize or Application.Installing then Application.Initialize;
  Application.CreateForm(THikayeciPanelServiceModule, HikayeciPanelServiceModule);
  Application.Run;
end.
