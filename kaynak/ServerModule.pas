unit ServerModule;

interface

uses
  System.SysUtils, Classes, uniGUIServer, uniGUIMainModule, uniGUIApplication, uIdCustomHTTPServer,
  uniGUITypes, IdContext, IdHTTPWebBrokerBridge, IdServerIOHandler, IdSSL, IdSSLOpenSSL,
  Web.HTTPApp, Data.DB, DBAccess, Uni, MemDS, UniProvider, InterBaseUniProvider, Forms,
  DateUtils, Hash;

type
  TUniServerModule = class(TUniGUIServerModule)
    Data: TUniConnection;
    ServisDB: TUniConnection;
    IBP: TInterBaseUniProvider;
    qKayitInfo: TUniQuery;
    procedure UniGUIServerModuleCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure FirstInit; override;
  public
    { Public declarations }
  end;

function UniServerModule: TUniServerModule;

implementation

{$R *.dfm}

uses
  UniGUIVars;

function UniServerModule: TUniServerModule;
begin
  Result := TUniServerModule(UniGUIServerInstance);
end;

procedure TUniServerModule.FirstInit;
begin
  InitServerModule(Self);
end;

function GetCipherList(AStrength: Integer): WideString;
const
  cCIPHER_LIST_1: WideString = 'DHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256';
  cCIPHER_LIST_2: WideString = 'DHE-RSA-AES256-SHA256:DHE-RSA-AES128-SHA256:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA256';
  cCIPHER_LIST_3: WideString = 'ECDHE-RSA-AES256-SHA:ECDHE-RSA-AES128-SHA:DHE-RSA-AES256-SHA:DHE-RSA-AES128-SHA';
  cCIPHER_LIST_4: WideString = 'AES256-GCM-SHA384:AES128-GCM-SHA256:AES256-SHA256:AES128-SHA256:AES256-SHA:AES128-SHA';
  cCIPHER_LIST_5: WideString = 'DES-CBC3-SHA';
begin
  case AStrength of
    // Advanced Plus (A+)
      1: Result := cCIPHER_LIST_1;
    // Advanced (A)
      2: Result := cCIPHER_LIST_1 + ':' + cCIPHER_LIST_2;
    // Broad Compatibility (
      3: Result := cCIPHER_LIST_1 + ':' + cCIPHER_LIST_2 + ':' + cCIPHER_LIST_3;
    // Widest Compatibility (C)
      4: Result := cCIPHER_LIST_1 + ':' + cCIPHER_LIST_2 + ':' + cCIPHER_LIST_3 + ':' + cCIPHER_LIST_4;
    // Legacy (C-)
      5: Result := cCIPHER_LIST_1 + ':' + cCIPHER_LIST_2 + ':' + cCIPHER_LIST_3 + ':' + cCIPHER_LIST_4 + ':' + cCIPHER_LIST_5;
    else
      Result := EmptyStr;
  end;
end;

procedure TUniServerModule.UniGUIServerModuleCreate(Sender: TObject);
begin
//   Mevcut MIME türü listesine yeni uzantýlarý ekle
//   .FTL (PDF.js yerelleþtirme dosyasý) tanýmý
   UniServerModule.MimeTable.AddMimeType('.ftl', 'text/plain');
//   .MJS (Modern JS Modülü) tanýmý
   UniServerModule.MimeTable.AddMimeType('.mjs', 'application/javascript');
//   Eðer .wasm hatasý alýrsanýz ve IIS kullanmýyorsanýz bunu da ekleyin:
   UniServerModule.MimeTable.AddMimeType('.wasm', 'application/wasm');

   UniServerModule.MIMETable.AddMimeType('hdr', 'image/vnd.radiance');
   UniServerModule.MIMETable.AddMimeType('glb', 'model/gltf-binary');

//  if SSL.Enabled then
//  begin
//    SSL.SSLOptions.RootCertFile :=  UniServerModule.StartPath + 'root.pem';
//    SSL.SSLOptions.CertFile :=  UniServerModule.StartPath + 'cert.pem';
//    SSL.SSLOptions.KeyFile :=  UniServerModule.StartPath + 'key.pem';
//    //SSL.SSLOptions.CipherList := GetCipherList(4);
//    //SSL.SSLOptions.CipherList := GetCipherList(5);
//  end;

  ServisDB.ProviderName := 'InterBase';
  ServisDB.Database := ExtractFilePath(Application.ExeName) + 'files\veri\ServisDB.fdb';
  ServisDB.Username := 'SYSDBA';
  ServisDB.Password := 'masterke';
  ServisDB.SpecificOptions.Values['Charset'] := 'WIN1254';
  ServisDB.SpecificOptions.Values['SQLDialect'] := '3';
end;

initialization
  RegisterServerModuleClass(TUniServerModule);
end.
