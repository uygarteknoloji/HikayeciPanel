unit Utils;

interface

uses IdHashMessageDigest, System.SysUtils, System.Classes, Uni, uniPageControl,
     UniDateTimePicker, DateUtils, Xml.XmlDOC, Xml.XmlIntf, Vcl.ExtActns,
     System.Variants, Math, Graphics, Forms, Controls, Winsock, Windows, StrUtils, DB,
	   ShellApi, ZLib, Messages, ActiveX, MainModule, UniBitBtn, UniDBLookUpComboBox,
     ShlObj, jpeg,  IdHTTP, Registry, WinInet, Logger, FireDAC.Stan.Intf, FireDAC.Stan.Option,
     FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
     FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
     FireDAC.Comp.Client;


type
  TExecuteFileOption = (
    eoHide,
    eoWait,
    eoElevate
  );
  TExecuteFileOptions = set of TExecuteFileOption;


type
  TFileVersionInfo = record
    FileType,
    CompanyName,
    FileDescription,
    FileVersion,
    InternalName,
    LegalCopyRight,
    LegalTradeMarks,
    OriginalFileName,
    ProductName,
    ProductVersion,
    Comments,
    SpecialBuildStr,
    PrivateBuildStr,
    FileFunction : string;
    DebugBuild,
    PreRelease,
    SpecialBuild,
    PrivateBuild,
    Patched,
    InfoInferred : Boolean;
  end;

type
	TMetreAciklama = record
	  aciklama : Variant;
	  metre1 : Variant;
	  metre2 : Variant;
    ok : Boolean;
end;



var
  WindowList : Pointer;
  MessageBoxChecked : Boolean;
	dk, dk2 : string;
  BackgroundColor : TColor = $00F8F8F8;
  WindowsTempPath : string;
	mbCheckList : string = '';
	mbCheckListValues : string = '';
	mbComboBox : string = '';
	mbComboBoxBaslik : string = '';
	mbComboBoxText : string = '';
	mbComboBoxIndex : smallint = -1;
  CellBounds : TRect;
  SessionLengthControl: boolean;

  Logger: TLogger;

const
	Chars : string = 'ABCDEFHJKLMNPRSTUVYZ12345789';

	decimalKur : SmallInt = 5;
	decimalTutar : SmallInt = 2;
	decimalMiktar : SmallInt = 4;
	decimalMetre : SmallInt = 2;
	decimalFiyat : SmallInt = 8;
  MB_YESNOYESALL = $00000006;
  IDYESALL = 12;

  csfsBold      = '|Bold';
  csfsItalic    = '|Italic';
  csfsUnderline = '|Underline';
  csfsStrikeout = '|Strikeout';

  mtnKapatmaOnayi : PChar =	'Değişiklikler <font color="clred"><b>kaydedilsin mi</b>?</font>';

  FocusedCellColor : TColor = 8454143;

  CrLf             = #13 + #10;
  cDef_Font        = 'Tahoma';
  c_Firebird       = 'FIREBIRD';
  c_SqlServer      = 'SQLSERVER';
  c_PostgreSQL     = 'POSTGRESQL';
  c_Oracle         = 'ORACLE';
  c_FBExt          = '.fdb';
  c_MSExt          = '.mdf';
  c_Cep_EditMask   = '!\(000\) 000 00 00;1;_';
  c_Tel_EditMask   = '!\(999\) 000 00 00;1;_';
  c_Tel_SearchMask = '!\(999\) 999 99 99;0;_';
  c_Combo_Limit    : Integer = 3000;
  c_Zero_Color     : TColor = clAqua;

function MD5(s: string): string;
function HataMesaj(s: string): string;
function Buyuk(S: string): string;
function Kucuk(S: string): string;
function SuzgecVerisiIsle(veri: string): string;
procedure TarihSec(Secenek: SmallInt; edt1, edt2: TDate);
procedure DataSetToXml(DS: TUniQuery; XMLAdi: string);
function Yuvarla(Sayi: Extended; Kusurat: SmallInt): Extended; overload;
function ValueToSQL(Field: TField): string;
function Coalesce(V, Res: Variant): Variant;
function StrEllipsis(s: string; sLength: Integer): string;
function GetText(H: THandle): string;
function GetComputerName: string;
function MyRound(const AValue: Double; const ADigit: smallint): Double; overload;
function MyRound(const AValue: Double): Integer; overload;
function GetLocalIP: string;
function GetExeIP: string;
function GetIPFromHost(const HostName: string): string;
function GetNetworkDriveMapping(s: string): string;
function AddSlash(str: string): string;
function FileVersionInfo(sAppNamePath: TFileName): TFileVersionInfo;
function MyFirstUpperCase(S: string): string;
function GetKeybStateHelper(VirtualKey: Cardinal; Mask: Byte): Boolean;
function Double_To_Currency(D: Double): string;
function TrToUpperEn(S: string): string;
function TrToUpper(S: string): string;
function TrToLower(S: string): string;
procedure CapsLockKapat;
function MyExtractFileName(str: string): string;
function MyExtractFilePath(str: string): string;
procedure PostKeyEx32(key: Word; const shift: TShiftState; specialkey: Boolean);
function FontToStr(Font : TFont): string;
function DateTimeToText(DateTime: TDateTime): string;
function FloatToHours(sFloat: Double): string;
function MinutesToMinuteSecond(sFloat: Double): string;
function DateTimeToHourMinute(sFloat: Double): string;
function FloatToHourMinute(sFloat: Double): string;
function FloatToHourMinuteFloat(sFloat: Double): Variant;
procedure StrToFont(sFont : string; Font : TFont );
function myIndexOf(S: string; Strings: TStrings): Integer;
function GetDataKey: string;
procedure TokenizeGridString(const S: String; const Delimiter, QuoteChar: Char; Tokens: TStringList);
function GetDeskTopPath : string;
function GetWindowsTempPath: string;
function IsFileInUse(fName: string) : boolean;
function IsInt(s: string) : boolean;
function MiktarKusuratAyarla(Value: Double; OndalikHaneSayisi: SmallInt; Format: String): string;
function SetFloatStr(S : string): string;
function FindWindowByTitle(WindowTitle: string): Hwnd;
procedure LoadPictureFromBlob(Picture: TPicture; BlobField: TBlobField);
function GetURL(URL: string): string;
procedure Yaz(Rect: TRect; cCanvas: TCanvas; LM, TM: Integer; defColor: TColor; str: string);
procedure ChangeImageSize(FileName: string; w,h: Integer);
function GetImageSize(FileName: string): TPoint;
function ExecuteFile(Handle: HWND; const Filename, Paramaters: String; Options: TExecuteFileOptions): Integer;
function Pass2Pass(str: string; tip: smallint): string;
function AciklamaToMetreAciklama(Text: string): TMetreAciklama;
function IsLike(AString, Pattern: string): boolean;
function WideStringToString(const ws: WideString; codePage: Word): AnsiString;
procedure SplitString (var arrDes : TStringList; str_src : string; delimeter: string);
function IsConnected: boolean;
function GetMacAddress(const IPv4: String): String;
function GetMacAddressARP(const IPv4: String): String;
function Numarator(no:String):String;
function StripHTML(S: string): string;
procedure SplitKur(text: string; kur, deger: TField);
procedure AlanTemizle(ds: TDataSource; e: TDataChangeEvent; f: TField);
function Currency_To_Text(Currency: Double; const MonetaryUnit: string; const TranslationType: string = ''): string;
function isFrameOpenedInTab(FrameClassName: string; Tab: TUniTabSheet): boolean;
function YaziileTutar(const ATutar: Double; const ADoviz: string = 'TL'): string;
function GetHDDSerial(const DriveLetter: Char): string;
function HDDSerial: string;
function English(S: string): string;
//function DemoKontrol(Lisans: string; Tablo: String): boolean;


function VarToBool(const AValue: Variant): Boolean;
function VarToInt(const AValue: Variant): Integer;
function VarToInt64(const AValue: Variant): Int64;
function VarToFloat(const AValue: Variant): Double;
function VarToChar(const AValue: Variant): Char;
function BoolToStr(bValue: Boolean): string;
function StrToBool(sValue: string): Boolean;
function BoolToInt(bValue: Boolean): Integer;
function IntToBool(iValue: Integer): Boolean;
function IntStrToBool(iValue: string): Boolean;
function StrToFloatEx(Str: string): Double;
function IsInt64Str(const AStr: string; OnlyPztf: Boolean = False): Boolean;
function IsFloatStr(const AStr: string): Boolean;
function FloatRange(const AValue, AMin, AMax: Double): Double;
function IntegerRange(const AValue, AMin, AMax: Integer): Integer;
procedure QueryPrepare(Ds: TCustomUniDataSet);
procedure QuerySetAutoCommit(Ds: TCustomUniDataSet; ACommit: Boolean = False);
procedure StartTransactionDB(Transaction: TFDTransaction);
procedure CommitDatabase(Transaction: TFDTransaction);
procedure RollbackDatabase(Transaction: TFDTransaction);

procedure CreateLogger;
procedure WriteLog(log: string);



implementation

uses ServerModule, comobj;

procedure CreateLogger;
begin
  Logger := TLogger.Create(Application);
  Logger.FilePath := ExtractFilePath(Application.ExeName) + 'Log.txt';
  Logger.WriteLog('Logging Started');
end;

procedure WriteLog(log: string);
begin
  Logger.WriteLog(log);
end;

procedure StartTransactionDB(Transaction: TFDTransaction);
begin
  if not Transaction.Active then Transaction.StartTransaction;
end;

procedure CommitDatabase(Transaction: TFDTransaction);
begin
  if not Transaction.Active then Exit;
  Transaction.CommitRetaining
//    Transaction.Commit; (Other DB)
end;

procedure RollbackDatabase(Transaction: TFDTransaction);
begin
  if not Transaction.Active then Exit;
  Transaction.RollbackRetaining
//  Transaction.Rollback (Other DB)
end;


procedure QueryPrepare(Ds: TCustomUniDataSet);
begin
  if not Ds.Prepared then
    Ds.Prepare;
end;

procedure QuerySetAutoCommit(Ds: TCustomUniDataSet; ACommit: Boolean = False);
begin
  Ds.SpecificOptions.Values['AutoCommit']:= 'True'
end;


function VarToBool(const AValue: Variant): Boolean;
begin
  Result:= False;
  if not VarIsNull(AValue) then
    Result:= Boolean(AValue);
end;

function VarToInt(const AValue: Variant): Integer;
begin
  Result:= -1;
  if VarIsNumeric(AValue) then
    Result:= Integer(AValue);
end;

function VarToInt64(const AValue: Variant): Int64;
begin
  Result:= -1;
  if VarIsNumeric(AValue) then
    Result:= Int64(AValue);
end;

function VarToFloat(const AValue: Variant): Double;
begin
  Result:= 0;
  if VarIsFloat(AValue) then
    Result:= Double(AValue);
end;

function VarToChar(const AValue: Variant): Char;
var
  AStr: string;
begin
  Result:= ' ';
  AStr:= VarToStr(AValue);
  if Length(AStr) >= 1 then
    Result:= AStr[1];
end;

function BoolToStr(bValue: Boolean): string;
begin
  if bValue then
    Result:= 'true'
  else
    Result:= 'false';
end;

function StrToBool(sValue: string): Boolean;
begin
  Result:= (LowerCase(sValue) = 'true');
end;

function BoolToInt(bValue: Boolean): Integer;
begin
  if bValue then
    Result:= 1
  else
    Result:= 0;
end;

function IntToBool(iValue: Integer): Boolean;
begin
  Result:= (iValue = 1);
end;

function IntStrToBool(iValue: string): Boolean;
begin
  Result:= (iValue = '1');
end;

function StrToFloatEx(Str: string): Double;
var
  iPos: Integer;
begin
  iPos:= Pos('.', Str);
  if iPos > 0 then
  begin
    while True do
    begin
      iPos:= Pos('.', Str);
      if Pos('.', Str) = 0 then
        Break;
      Delete(Str, iPos, Length('.'));
      Insert(',', Str, iPos);
    end;
  end;
  Result:= StrToFloatDef(Str, 0);
end;


function IsInt64Str(const AStr: string; OnlyPztf: Boolean = False): Boolean;
var
  AVal: Int64;
begin
  Result:= TryStrToInt64(AStr, AVal);
  if (Result) and (OnlyPztf) then
  begin
    if (AVal < 0) then
      Result:= False;
  end;
end;

function IsFloatStr(const AStr: string): Boolean;
var
  AVal: Double;
begin
  Result:= TryStrToFloat(AStr, AVal);
end;

function FloatRange(const AValue, AMin, AMax: Double): Double;
begin
  if (AValue < AMin) then
    Result:= AMin
  else if (AValue > AMax) then
    Result:= AMax
  else
    Result:= AValue;
end;

function IntegerRange(const AValue, AMin, AMax: Integer): Integer;
begin
  if (AValue < AMin) then
    Result:= AMin
  else if (AValue > AMax) then
    Result:= AMax
  else
    Result:= AValue;
end;



function English(S: string): string;
var
  I: Integer;
begin
  S := StringReplace(S, ' ', '', [rfReplaceAll]);
  S := StringReplace(S, '-', '', [rfReplaceAll]);
  //S := StringReplace(S, '_', '', [rfReplaceAll]);
  S := StringReplace(S, '?', '', [rfReplaceAll]);
  S := StringReplace(S, '*', '', [rfReplaceAll]);
  S := StringReplace(S, '=', '', [rfReplaceAll]);
  S := StringReplace(S, '/', '', [rfReplaceAll]);
  S := StringReplace(S, '\', '', [rfReplaceAll]);
  S := StringReplace(S, '}', '', [rfReplaceAll]);
  S := StringReplace(S, '{', '', [rfReplaceAll]);
  S := StringReplace(S, '[', '', [rfReplaceAll]);
  S := StringReplace(S, ']', '', [rfReplaceAll]);
  S := StringReplace(S, '(', '', [rfReplaceAll]);
  S := StringReplace(S, ')', '', [rfReplaceAll]);
  S := StringReplace(S, '&', '', [rfReplaceAll]);
  S := StringReplace(S, '%', '', [rfReplaceAll]);
  S := StringReplace(S, '+', '', [rfReplaceAll]);
  S := StringReplace(S, '#', '', [rfReplaceAll]);
  S := StringReplace(S, '$', '', [rfReplaceAll]);
  S := StringReplace(S, '^', '', [rfReplaceAll]);
  S := StringReplace(S, '!', '', [rfReplaceAll]);
  S := StringReplace(S, '''', '', [rfReplaceAll]);
  S := StringReplace(S, '"', '', [rfReplaceAll]);
  S := StringReplace(S, 'é', '', [rfReplaceAll]);
  S := StringReplace(S, ',', '', [rfReplaceAll]);
  S := StringReplace(S, '.', '', [rfReplaceAll]);
  S := StringReplace(S, ':', '', [rfReplaceAll]);
  S := StringReplace(S, '`', '', [rfReplaceAll]);
  S := StringReplace(S, '~', '', [rfReplaceAll]);
  S := StringReplace(S, '<', '', [rfReplaceAll]);
  S := StringReplace(S, '>', '', [rfReplaceAll]);
  S := StringReplace(S, '|', '', [rfReplaceAll]);
  S := StringReplace(S, '€', '', [rfReplaceAll]);
  S := StringReplace(S, '₺', '', [rfReplaceAll]);
  S := StringReplace(S, '´', '', [rfReplaceAll]);
  S := StringReplace(S, '¨', '', [rfReplaceAll]);

  S := StringReplace(S, 'ğ', 'g', [rfReplaceAll]);
  S := StringReplace(S, 'Ğ', 'G', [rfReplaceAll]);
  S := StringReplace(S, 'ü', 'u', [rfReplaceAll]);
  S := StringReplace(S, 'Ü', 'U', [rfReplaceAll]);
  S := StringReplace(S, 'ş', 's', [rfReplaceAll]);
  S := StringReplace(S, 'Ş', 'S', [rfReplaceAll]);
  S := StringReplace(S, 'ı', 'i', [rfReplaceAll]);
  S := StringReplace(S, 'İ', 'I', [rfReplaceAll]);
  S := StringReplace(S, 'ö', 'o', [rfReplaceAll]);
  S := StringReplace(S, 'Ö', 'O', [rfReplaceAll]);
  S := StringReplace(S, 'ç', 'c', [rfReplaceAll]);
  S := StringReplace(S, 'Ç', 'C', [rfReplaceAll]);

  Result := S;
end;


function TEnglish(S: string): string;
var
  I: Integer;
begin
  S := StringReplace(S, '-', '', [rfReplaceAll]);
  S := StringReplace(S, '?', '', [rfReplaceAll]);
  S := StringReplace(S, '*', '', [rfReplaceAll]);
  S := StringReplace(S, '=', '', [rfReplaceAll]);
  S := StringReplace(S, '/', '', [rfReplaceAll]);
  S := StringReplace(S, '\', '', [rfReplaceAll]);
  S := StringReplace(S, '}', '', [rfReplaceAll]);
  S := StringReplace(S, '{', '', [rfReplaceAll]);
  S := StringReplace(S, '[', '', [rfReplaceAll]);
  S := StringReplace(S, ']', '', [rfReplaceAll]);
  S := StringReplace(S, '(', '', [rfReplaceAll]);
  S := StringReplace(S, ')', '', [rfReplaceAll]);
  S := StringReplace(S, '&', '', [rfReplaceAll]);
  S := StringReplace(S, '%', '', [rfReplaceAll]);
  S := StringReplace(S, '+', '', [rfReplaceAll]);
  S := StringReplace(S, '#', '', [rfReplaceAll]);
  S := StringReplace(S, '$', '', [rfReplaceAll]);
  S := StringReplace(S, '^', '', [rfReplaceAll]);
  S := StringReplace(S, '!', '', [rfReplaceAll]);
  S := StringReplace(S, '''', '', [rfReplaceAll]);
  S := StringReplace(S, '"', '', [rfReplaceAll]);
  S := StringReplace(S, 'é', '', [rfReplaceAll]);
  S := StringReplace(S, ',', '', [rfReplaceAll]);
  S := StringReplace(S, '.', '', [rfReplaceAll]);
  S := StringReplace(S, ':', '', [rfReplaceAll]);
  S := StringReplace(S, '`', '', [rfReplaceAll]);
  S := StringReplace(S, '~', '', [rfReplaceAll]);
  S := StringReplace(S, '<', '', [rfReplaceAll]);
  S := StringReplace(S, '>', '', [rfReplaceAll]);
  S := StringReplace(S, '|', '', [rfReplaceAll]);
  S := StringReplace(S, '€', '', [rfReplaceAll]);
  S := StringReplace(S, '₺', '', [rfReplaceAll]);
  S := StringReplace(S, '´', '', [rfReplaceAll]);
  S := StringReplace(S, '¨', '', [rfReplaceAll]);

  S := StringReplace(S, 'ğ', 'g', [rfReplaceAll]);
  S := StringReplace(S, 'Ğ', 'G', [rfReplaceAll]);
  S := StringReplace(S, 'ü', 'u', [rfReplaceAll]);
  S := StringReplace(S, 'Ü', 'U', [rfReplaceAll]);
  S := StringReplace(S, 'ş', 's', [rfReplaceAll]);
  S := StringReplace(S, 'Ş', 'S', [rfReplaceAll]);
  S := StringReplace(S, 'ı', 'i', [rfReplaceAll]);
  S := StringReplace(S, 'İ', 'I', [rfReplaceAll]);
  S := StringReplace(S, 'ö', 'o', [rfReplaceAll]);
  S := StringReplace(S, 'Ö', 'O', [rfReplaceAll]);
  S := StringReplace(S, 'ç', 'c', [rfReplaceAll]);
  S := StringReplace(S, 'Ç', 'C', [rfReplaceAll]);

  Result := S;
end;



function GetHDDSerial(const DriveLetter: Char): string;
var
  NotUsed:     DWORD;
  VolumeFlags: DWORD;
  VolumeInfo:  array[0..MAX_PATH] of Char;
  VolumeSerialNumber: DWORD;
begin
  GetVolumeInformation(PChar(DriveLetter + ':\'), nil, SizeOf(VolumeInfo), @VolumeSerialNumber, NotUsed, VolumeFlags, nil, 0);
  Result := Format('%8.8X',  [VolumeSerialNumber])
end;

function HDDSerial: string;
var
  VolumeSerialNumber : DWORD;
  MaximumComponentLength : DWORD;
  FileSystemFlags : DWORD;
begin
  GetVolumeInformation('C:\', nil, 0, @VolumeSerialNumber, MaximumComponentLength, FileSystemFlags, nil, 0);
  Result := IntToHex(HiWord(VolumeSerialNumber), 4) + '-' + IntToHex(LoWord(VolumeSerialNumber), 4);
end;


function TLPara: string;
begin
  Result:= 'TL';
end;

function TLKurus: string;
begin
  Result:= 'Krş';
end;

function RoundToEx(const AValue: Currency; const ADigit: Byte = 2): Double;
var
  AADigit: TRoundToRange;
begin
  if (ADigit > 4) then
    AADigit:= -4
  else
    AADigit:= ADigit * (-1);
  Result:= SimpleRoundTo(AValue, AADigit);
end;




function NumToText(Sayi: Double): string;
const
  birler: array[1..9] of string = ('Bir', 'İki', 'Üç', 'Dört', 'Beş', 'Altı', 'Yedi', 'Sekiz', 'Dokuz');
  onlar: array[1..9]  of string = ('On', 'Yirmi', 'Otuz', 'Kırk', 'Elli', 'Altmış', 'Yetmiş', 'Seksen', 'Doksan');
  katlar: array[1..6] of string = ('Yüz', 'Bin', 'Milyon', 'Milyar', 'Trilyon', 'Katrilyon');
var
  Rakam: string;
  Bolum, Sonuc, b: double;
  Kat: integer;
begin
  Sayi:= Round(Sayi);
  for Kat:= 6 downto 1 do
  begin
    bolum:= int(Sayi / Power(1000, Kat - 1));
    b:= bolum;
    if bolum <> 0 then
    begin
      if bolum > 199 then
      begin
        sonuc:= Int(bolum / 100);
        rakam:= rakam + birler[Trunc(sonuc)];
        bolum:= bolum - sonuc * 100;
        rakam:= rakam + katlar[1];
      end;
      if (bolum > 99) and (bolum <= 199) then
      begin
        rakam:= rakam + katlar[1];
        bolum:= bolum - 100;
      end;
      if (bolum > 9) and (bolum <= 99) then
      begin
        sonuc:= int(bolum / 10);
        rakam:= rakam + onlar[Trunc(sonuc)];
        bolum:= int(bolum - sonuc * 10);
      end;
      if (bolum > 0) and (bolum <= 9) then
        if (Sayi > 1999) or (Sayi < 1000) then
          rakam:= rakam + birler[trunc(bolum)];
      if Kat <> 1 then
        rakam:= rakam + katlar[Kat] + '';
      Sayi:= Sayi - (b * power(1000, Kat - 1));
    end;
  end;
  Result:= Rakam;
end;

function YaziileTutar(const ATutar: Double; const ADoviz: string = 'TL'): string;
var
  KrsName: string;
  ASayi: Double;
begin
  Result:= '';
  KrsName:= '';
  if ADoviz = TLPara then
    KrsName:= TLKurus;
  ASayi:= RoundToEx(ATutar, 2);
  Result:= NumToText(Trunc(ASayi));
  if Result <> '' then
    Result:= Result + '.-' + ADoviz;
  if Frac(ASayi) >= 0.01 then
    Result:= Result + '.' + NumToText(Frac(ASayi) * 100) + '.-' + KrsName;
end;


//function DemoKontrol(Lisans: string; Tablo: String): boolean;
//var
//  q: TUniQuery;
//begin
//  Result := false;
//  if (Lisans<>'DEMO') then exit;
//  try
//    q := TUniQuery.Create(nil);
//    try
//      q.Connection := UniMainModule.BaglantiVeri;
//      q.Close;
//      q.SQL.Clear;
//      q.SQL.Add('Select Count(*) Adet From ' + Tablo);
//      q.Open;
//      if q.FieldByName('Adet').AsInteger > 9 then
//      begin
//        Result := true;
//        //UniMainModule.Notification('Uyarı', 'DEMO lisansı, ON (adet) kayıt ile sınırlıdır', 1);
//      end;
//    finally
//      q.Close;
//      q.Free;
//    end;
//  except on E: Exception do
//    begin
//      Result := true;
//      UniMainModule.Notification('Hata', HataMesaj(e.Message), 2);
//    end;
//  end;
//end;

function isFrameOpenedInTab(FrameClassName: string; Tab: TUniTabSheet): boolean;
var
  I: integer;
begin
  Result := false;
  for I := 0 to Tab.ControlCount-1 do
  begin
    if FrameClassName = Tab.Controls[I].ClassName then
    begin
      Result := true;
      break;
    end;
  end;
end;

function SendARP(const DestIP, SrcIP: in_addr; pMacAddr: PULONG;
                 var PhyAddrLen: ULONG): DWORD; stdcall;
                 external 'IPHLPAPI.DLL' name 'SendARP';

function Currency_To_Tr(Currency: Double; MonetaryUnit: string): string;

  function MetniCevir(str: string): string;
  var
    I, L: Integer;
    ss: string;
  const
    Birler: Array [0 .. 9] of string = ('', 'Bir', 'İki', 'Üç', 'Dört', 'Beş',
      'Altı', 'Yedi', 'Sekiz', 'Dokuz');
    Onlar: Array [0 .. 9] of String = ('', 'On', 'Yirmi', 'Otuz', 'Kırk',
      'Elli', 'Altmış', 'Yetmiş', 'Seksen', 'Doksan');
    Basamak: Array [0 .. 3] of String = ('', 'Bin', 'Milyon', 'Milyar');

    function YuzlukCevir(Yuzluk, Ek: string): string;
    begin
      Result := '';
      if Trim(Yuzluk) = '' then
        Exit;

      if Yuzluk[1] > '1' then
        Result := Result + Birler[StrToInt(Yuzluk[1])] + 'Yüz'
      else if Yuzluk[1] = '1' then
        Result := Result + 'Yüz';

      if Yuzluk[2] > '0' then
        Result := Result + Onlar[StrToInt(Yuzluk[2])];

      if Yuzluk[3] > '0' then
        if (Ek <> 'Bin') or (Yuzluk <> '001') then
          Result := Result + Birler[StrToInt(Yuzluk[3])];

      if Yuzluk <> '000' then
        Result := Result + Ek;
    end;

  begin
    Result := '';
    ss := str;
    while (Length(ss) mod 3) > 0 do
      ss := '0' + ss;
    L := Length(ss) div 3;
    for I := L downto 1 do
      Result := YuzlukCevir(Copy(ss, (I - 1) * 3 + 1, 3), Basamak[L - I])
        + Result;
    if Result = '' then
      Result := 'Sıfır';
  end;

var
  TutarText, Tutar, Kurus: string;
begin
  TutarText := FormatFloat('0.00', Currency);
  Tutar := Copy(TutarText, 1, Pos(FormatSettings.DecimalSeparator, TutarText) - 1);
  Kurus := Copy(TutarText, Pos(FormatSettings.DecimalSeparator, TutarText) + 1,
    Length(TutarText));

  if MonetaryUnit = 'TL' then
    Result := MetniCevir(Tutar) + ' TL ' + MetniCevir(Kurus) + ' KR'
  else if MonetaryUnit = 'YTL' then
    Result := MetniCevir(Tutar) + ' YTL ' + MetniCevir(Kurus) + ' YKR'
  else if MonetaryUnit = 'EUR' then
    Result := MetniCevir(Tutar) + ' EURO ' + MetniCevir(Kurus) + ' CENT'
  else if MonetaryUnit = 'USD' then
    Result := MetniCevir(Tutar) + ' USD ' + MetniCevir(Kurus) + ' CENT'
  else if MonetaryUnit = 'GBP' then
    Result := MetniCevir(Tutar) + ' GBP ' + MetniCevir(Kurus) + ' PENNIE'
end;


function CevirOnlar(Onlar: string): string;
begin
  case StrToInt(Onlar) of
    1:
      Result := 'One';
    2:
      Result := 'Two';
    3:
      Result := 'Three';
    4:
      Result := 'Four';
    5:
      Result := 'Five';
    6:
      Result := 'Six';
    7:
      Result := 'Seven';
    8:
      Result := 'Eight';
    9:
      Result := 'Nine';
  else
    Result := '';
  end;
end;

function CevirYuzler(Yuzler: string): string;
begin
  if StrToInt(LeftStr(Yuzler, 1)) = 1 then
  begin
    case StrToInt(Yuzler) of
      10:
        Result := 'Ten';
      11:
        Result := 'Eleven';
      12:
        Result := 'Twelve';
      13:
        Result := 'Thirteen';
      14:
        Result := 'Fourteen';
      15:
        Result := 'Fifteen';
      16:
        Result := 'Sixteen';
      17:
        Result := 'Seventeen';
      18:
        Result := 'Eighteen';
      19:
        Result := 'Nineteen';
    end;
  end
  else
  begin
    case StrToInt(LeftStr(Yuzler, 1)) of
      2:
        Result := 'Twenty ';
      3:
        Result := 'Thirty ';
      4:
        Result := 'Forty ';
      5:
        Result := 'Fifty ';
      6:
        Result := 'Sixty ';
      7:
        Result := 'Seventy ';
      8:
        Result := 'Eighty ';
      9:
        Result := 'Ninety ';
    end;
    Result := Result + CevirOnlar(RightStr(Yuzler, 1));
  end;
end;

function CevirBinler(Binler: string): string;
var
  S: string;
begin
  Result := '';
  S := Binler;

  if StrToInt(S) = 0 then
    Exit;

  S := RightStr('000' + S, 3);

  if LeftStr(S, 1) <> '0' then
    Result := CevirOnlar(LeftStr(S, 1)) + ' Hundred ';

  if Copy(S, 2, 1) <> '0' then
    Result := Result + CevirYuzler(Copy(S, 2, Length(S)))
  else
    Result := Result + CevirOnlar(Copy(S, 3, Length(S)));

  Result := Trim(Result);
end;

function Currency_To_En(Currency: Double; MonetaryUnit: string): string;
var
  Tmp: string;
  strCurrency: string;
  NoktaYeri, i: Integer;
  Tutar, Kurus: string;
const
  Cursor: Array [1 .. 9] of string = ('', ' Thousand ', ' Million ',
    ' Billion ', ' Trillion ', '', '', '', '');
begin
  strCurrency := Trim(FormatFloat('0.00', Currency));

  NoktaYeri := Pos(FormatSettings.DecimalSeparator, strCurrency);

  If NoktaYeri > 0 Then
  begin
    Tmp := LeftStr(Copy(strCurrency, NoktaYeri + 1,
        Length(strCurrency)) + '00', 2);
    Kurus := CevirYuzler(Tmp);
    strCurrency := Trim(LeftStr(strCurrency, NoktaYeri - 1))
  end;

  i := 1;
  while strCurrency <> '' do
  begin
    Tmp := CevirBinler(RightStr(strCurrency, 3));
    if Tmp <> '' then
      Tutar := Tmp + Cursor[i] + Tutar;

    if Length(strCurrency) > 3 then
      strCurrency := LeftStr(strCurrency, Length(strCurrency) - 3)
    else
      strCurrency := '';

    i := i + 1;
  end;

  if MonetaryUnit = 'USD' then
  begin
    if (Tutar = '') then
      Tutar := 'No Dollars'
    else if (Tutar = 'One') then
      Tutar := 'One Dollar'
    else
      Tutar := Tutar + ' Dollars';
  end
  else if MonetaryUnit = 'EUR' then
  begin
    if (Tutar = '') then
      Tutar := 'No Euros'
    else if (Tutar = 'One') then
      Tutar := 'One Euro'
    else
      Tutar := Tutar + ' Euros';
  end
  else if MonetaryUnit = 'GBP' then
  begin
    if (Tutar = '') then
      Tutar := 'No Pounds'
    else if (Tutar = 'One') then
      Tutar := 'One Pound'
    else
      Tutar := Tutar + ' Pounds';
  end;

  if (MonetaryUnit = 'USD') or (MonetaryUnit = 'EUR') then
  begin
    if (Kurus = '') then
      Kurus := ' And No Cents'
    else if (Kurus = 'One') then
      Kurus := ' And One Cent'
    else
      Kurus := ' And ' + Kurus + ' Cents';
  end
  else if (MonetaryUnit = 'GBP') then
  begin
    if (Kurus = '') then
      Kurus := ' And No Pennies'
    else if (Kurus = 'One') then
      Kurus := ' And One Pennie'
    else
      Kurus := ' And ' + Kurus + ' Pennies';
  end;

  Result := Tutar + Kurus;
end;


function Currency_To_Text(Currency: Double; const MonetaryUnit: string; const TranslationType: string = ''): string;
var
  CeviriTipi: string;
  ParaBirimi: string;
begin
  CeviriTipi := Trim(UpperCase(TranslationType));
  ParaBirimi := Trim(UpperCase(MonetaryUnit));

  if CeviriTipi = '' then
    if (ParaBirimi = 'TL') or (ParaBirimi = 'YTL') then
      CeviriTipi := 'TL'
    else
      CeviriTipi := 'EN';

  if (CeviriTipi <> 'TL') and (CeviriTipi <> 'EN') then
  begin
    Result := '';
    Exit;
  end;

  if (CeviriTipi = 'TL') or (CeviriTipi = 'YTL') then
    Result := Currency_To_Tr(Currency, ParaBirimi)
  else if (CeviriTipi = 'EN') then
    Result := Currency_To_En(Currency, ParaBirimi);
end;


procedure SplitKur(text: string; kur, deger: TField);
var
  s: TStringList;
  Kur_Deger: Double;
begin
  s := TStringList.Create;
  try
    SplitString(s, text, ':');
    if TryStrToFloat(Trim(s.Strings[1]), Kur_Deger) then
    begin
      kur.AsString := (Trim(s.Strings[0]));
      deger.AsFloat := Kur_Deger;
    end
    else
    begin
      kur.Clear;
      deger.Clear;
    end;
  finally
    s.Free;
  end;
end;

procedure AlanTemizle(ds: TDataSource; e: TDataChangeEvent; f: TField);
begin
  ds.OnDataChange := nil;
  try
    f.Clear;
  finally
    ds.OnDataChange := e;
  end;
end;



function StripHTML(S: string): string;
var
  TagBegin, TagEnd, TagLength: integer;
begin
  TagBegin := Pos( '<', S);  // search position of first <

  while (TagBegin > 0) do begin  // while there is a < in S
    TagEnd := Pos('>', S);  // find the matching >
    TagLength := TagEnd - TagBegin + 1;
    Delete(S, TagBegin, TagLength); // delete the tag
    TagBegin:= Pos( '<', S);        // search for next <
  end;

  Result := S;                // give the result
end;



Function TersCevir(no:String):String;
var
    Cevrilen:String;
    i:Integer;
Begin
    i:= 0;
    Cevrilen := '';
    For i := length(no) DownTo 1 Do
    Begin
        Cevrilen := Cevrilen + no[i];
    End;
    Result := Cevrilen;
End;



Function Numarator(no:String):String;
var
    Nmr, Temp, Temp1:String;
    Temp2:Char;
    i, Tmp:Integer;
Begin
    nmr := TersCevir(no);
    i:= 0;
    while i < length(no) Do
    Begin
        i := i + 1;
        if nmr[i] = ' ' Then
        begin
            nmr[i] := ' ';
            continue;
        End
        Else
        if nmr[i] = '9' Then
        begin
            nmr[i] := '0';
            continue;
        End
        Else
        if (nmr[i] < '9') and (nmr[i] >= '0') Then
        Begin
            Temp := inttostr(StrToInt(nmr[i]) + 1);
            Tmp := i;
            Break;
        end;
        if nmr[i] = 'Z' Then
        begin
            nmr[i] := 'A';
            continue;
        End
        Else
        if (nmr[i] < 'Z') or (nmr[i] >= 'A') Then
        Begin
            Temp := inttostr(ord(nmr[i]));
            Temp := intToStr(StrToInt(Temp) + 1);
            Temp := Chr(StrToInt(Temp));
            Tmp := i;
            Break;
        end;
    End;
    i:= 0;
    while i < length(no) do
    Begin
        i := i + 1;
        if tmp = i Then
            if (temp[1] <= '9') and (temp[1] >= '0')  Then
                nmr[i] := temp[1]
            Else
            Begin
                nmr[i] := Temp[1];
            End;
        nmr[i] := nmr[i];
    End;

    result := TersCevir(nmr);
End;




function GetTempDirectory: String;
var
  tempFolder: array[0..MAX_PATH] of Char;
begin
  GetTempPath(MAX_PATH, @tempFolder);
  result := StrPas(tempFolder);
end;

function MD5(s: string): string;
var
  IdMD5: TIdHashMessageDigest5;
begin
  IdMD5 := TIdHashMessageDigest5.Create;
  try
    Result := IdMD5.HashStringAsHex(s);
  finally
    IdMD5.Free;
  end;
end;



function IsConnected: boolean;
const
  // local system uses a modem to connect to the Internet.
  INTERNET_CONNECTION_MODEM      = 1;
  // local system uses a local area network to connect to the Internet.
  INTERNET_CONNECTION_LAN        = 2;
  // local system uses a proxy server to connect to the Internet.
  INTERNET_CONNECTION_PROXY      = 4;
  // local system's modem is busy with a non-Internet connection.
  INTERNET_CONNECTION_MODEM_BUSY = 8;

var
  dwConnectionTypes : DWORD;
begin
  dwConnectionTypes := INTERNET_CONNECTION_MODEM +
                       INTERNET_CONNECTION_LAN +
                       INTERNET_CONNECTION_PROXY;
  Result := InternetGetConnectedState(@dwConnectionTypes,0);
end;





function GetMacAddressARP(const IPv4: String): String;
  const
    SrcIP: in_addr = (S_addr: 0);
  var
    DestIP: in_addr;
    MacAddr: array[0..5] of Byte;
    MacAddrLen, RC: DWORD;
    i: Integer;
begin
  Result := '';
  DestIP.S_addr := inet_addr(PAnsiChar(AnsiString(IPv4)));
  MacAddrLen := Length(MacAddr);
  RC := SendARP(DestIP,SrcIP,@MacAddr,MacAddrLen);
  case RC of
    NO_ERROR:
      begin
        if (MacAddrLen = 6) then
          for i := 0 to 5 do begin
            if (i > 0) then
              Result := Result + ':';
            Result := Result + IntToHex(MacAddr[i],2);
          end
        else
          Result := 'Error: MacAddrLen='+IntToStr(MacAddrLen);
      end;
    ERROR_GEN_FAILURE:
      Result := 'MAC-Adresse konnte nicht ermittelt werden. Fehler:' + #13#10 + 'ERROR_GEN_FAILURE';
    ERROR_INVALID_PARAMETER:
      Result := 'MAC-Adresse konnte nicht ermittelt werden. Fehler:' + #13#10 + 'ERROR_INVALID_PARAMETER';
    ERROR_INVALID_USER_BUFFER:
      Result := 'MAC-Adresse konnte nicht ermittelt werden. Fehler:' + #13#10 + 'ERROR_INVALID_USER_BUFFER';
    ERROR_BAD_NET_NAME:
      Result := 'MAC-Adresse konnte nicht ermittelt werden. Fehler:' + #13#10 + 'ERROR_BAD_NET_NAME';
    ERROR_BUFFER_OVERFLOW:
      Result := 'MAC-Adresse konnte nicht ermittelt werden. Fehler:' + #13#10 + 'ERROR_BUFFER_OVERFLOW';
    else
      Result := 'Error: RC='+IntToStr(RC);
  end;
end;

function GetMacAddress(const IPv4: String): String;
type
     TNetTransportEnum = function(pszServer : PWideChar;
                                  Level : DWORD;
                                  var pbBuffer : pointer;
                                  PrefMaxLen : LongInt;
                                  var EntriesRead : DWORD;
                                  var TotalEntries : DWORD;
                                  var ResumeHandle : DWORD) : DWORD; stdcall;

     TNetApiBufferFree = function(Buffer : pointer) : DWORD; stdcall;

     PTransportInfo = ^TTransportInfo;
     TTransportInfo = record
                       quality_of_service : DWORD;
                       number_of_vcs : DWORD;
                       transport_name : PWChar;
                       transport_address : PWChar;
                       wan_ish : boolean;
                     end;

var E,ResumeHandle,
    EntriesRead,
    TotalEntries : DWORD;
    FLibHandle : THandle;
    sMachineName,
    sMacAddr,
    Retvar : string;
    pBuffer : pointer;
    pInfo : PTransportInfo;
    FNetTransportEnum : TNetTransportEnum;
    FNetApiBufferFree : TNetApiBufferFree;
    pszServer : array[0..128] of WideChar;
    i,ii,iIdx : integer;
begin
  sMachineName := trim(IPv4);
  Retvar := '00-00-00-00-00-00';

  // Add leading \\ if missing
  if (sMachineName = '') and (length(sMachineName) = 2) then begin
    if copy(sMachineName,1,2) = '\\' then
      sMachineName := '\\' + sMachineName
  end;

  // Setup and load from DLL
  pBuffer := nil;
  ResumeHandle := 0;
  FLibHandle := LoadLibrary('NETAPI32.DLL');

  // Execute the external function
  if FLibHandle <> 0 then begin
    @FNetTransportEnum := GetProcAddress(FLibHandle,'NetWkstaTransportEnum');
    @FNetApiBufferFree := GetProcAddress(FLibHandle,'NetApiBufferFree');
    E := FNetTransportEnum(StringToWideChar(sMachineName,pszServer,129),0,
                           pBuffer,-1,EntriesRead,TotalEntries,Resumehandle);

    if E = 0 then begin
      pInfo := pBuffer;

      // Enumerate all protocols - look for TCPIP
      for i := 1 to EntriesRead do begin
        if pos('TCPIP',UpperCase(pInfo^.transport_name)) > 0 then begin
          // Got It - now format result 'xx-xx-xx-xx-xx-xx'
          iIdx := 1;
          sMacAddr := pInfo^.transport_address;

          for ii := 1 to 12 do begin
            Retvar[iIdx] := sMacAddr[ii];
            inc(iIdx);
            if iIdx in [3,6,9,12,15] then inc(iIdx);
          end;
        end;

        inc(pInfo);
      end;
      if pBuffer = nil then FNetApiBufferFree(pBuffer);
    end;

    try
      FreeLibrary(FLibHandle);
    except
      // Silent Error
    end;
  end;

  Result := Retvar;
end;

function GetTextW(const Text:String; Font:TFont) : Integer;
var
  LBmp: Graphics.TBitmap;
begin
  LBmp := Graphics.TBitmap.Create;
  try
   LBmp.Canvas.Font := Font;
   Result := LBmp.Canvas.TextWidth(Text);
  finally
   LBmp.Free;
  end;
end;

function CountOfChar(ContentString:string; CharToCount:char):integer;
begin
   Result:= Length(ContentString)-Length(StringReplace(ContentString, CharToCount,'', [rfReplaceAll, rfIgnoreCase]));
end;

procedure SplitString(var arrDes : TStringList; str_src : string; delimeter: string);
var
    current_position : integer;
    current_string : string;
begin
    arrDes.Clear;
    current_string := str_src;
    while true do
    begin
        current_position := Pos (delimeter, current_string);
        if current_position = 0 then  // last item
        begin
            arrDes.Add (current_string);
            break;
        end;
        arrDes.Add (Copy (current_string, 1, current_position - 1));
        current_string := Copy (current_string, current_position + 1,
        length (current_string)- current_position);
    end;
end;

function Pass2Pass(str: string; tip: smallint): string;
begin
	Result := str;
  if tip = 1 then
    Result := Chr(9)+Chr(13)+RightStr(trim(str), 6)
  else
  if tip = 2 then
    Result := LeftStr(trim(str), 4)+'#$+^'
end;

procedure ChangeImageSize(FileName: string; w,h: Integer);
var
	JpegImage : TJpegImage;
	Bitmap : Graphics.TBitmap;
begin
	JpegImage := TJpegImage.Create;
	Bitmap := Graphics.TBitmap.Create;
	JpegImage.LoadFromFile(FileName);
	Bitmap.Height := h;
	Bitmap.Width := w;
	Bitmap.Canvas.StretchDraw(Rect(0, 0, Bitmap.Width, Bitmap.Height), JpegImage);
	JpegImage.Assign(Bitmap);
	JpegImage.SaveToFile(FileName);
	JpegImage.Free;
	Bitmap.Free;
end;

function GetImageSize(FileName: string): TPoint;
var
	JpegImage : TJpegImage;
begin
	JpegImage := TJpegImage.Create;
	JpegImage.LoadFromFile(FileName);
  Result.X := JpegImage.Width;
  Result.Y := JpegImage.Height;
	JpegImage.Free;
end;

function Yuvarla(Sayi: Extended; Kusurat: SmallInt): Extended;
begin
  Result := StrToFloat(FormatFloat('0.' + DupeString('0', Kusurat), Sayi));
end;

function ValueToSQL(Field: TField): string;
begin
	if Field.IsNull then
    Result := 'null'
  else
  if Field is TNumericField then
    Result := StringReplace(Field.AsString, ',', '.', [])
  else
    Result := QuotedStr(Field.AsString);
end;

function MiktarKusuratAyarla(Value: Double; OndalikHaneSayisi: SmallInt; Format: String): string;
var
	I, P : Integer;
begin
	Result := FormatFloat(Format, Value);
  P := Pos(FormatSettings.DecimalSeparator, Result);
  for I := Length(Result) downto P+OndalikHaneSayisi+1 do
  	if Result[I] = '0' then
    	Result := LeftStr(Result, I-1)
    else
    	Break;

  if (Result <> '') and (Result[Length(Result)] = FormatSettings.DecimalSeparator)  then
  	Result := LeftStr(Result, Length(Result)-1);
end;

function IsInt(s: string) : boolean;
begin
  try
    StrToInt(s);
	  Result := True;
  except
	  Result := False;
  end;
end;

function IsFileInUse(fName: string) : boolean;
var
  HFileRes: HFILE;
begin
  Result := False;
  if not FileExists(fName) then begin
    Exit;
  end;

  HFileRes := CreateFile(PChar(fName)
    ,GENERIC_READ or GENERIC_WRITE
    ,0
    ,nil
    ,OPEN_EXISTING
    ,FILE_ATTRIBUTE_NORMAL
    ,0);

  Result := (HFileRes = INVALID_HANDLE_VALUE);

  if not(Result) then begin
    CloseHandle(HFileRes);
  end;
end;


function GetDeskTopPath : string;
var
  shellMalloc: IMalloc;
  ppidl: PItemIdList;
begin
  ppidl := nil;
  try
    if SHGetMalloc(shellMalloc) = NOERROR then
    begin
      SHGetSpecialFolderLocation(0, CSIDL_DESKTOP, ppidl);
      SetLength(Result, MAX_PATH);
      if not SHGetPathFromIDList(ppidl, PChar(Result)) then
        raise exception.create('SHGetPathFromIDList failed : invalid pidl');
      SetLength(Result, lStrLen(PChar(Result)));
    end;
  finally
   if ppidl <> nil then
         shellMalloc.free(ppidl);
  end;
  Result := Result+'\';
end;

function GetWindowsTempPath: string;
var
	lng: DWORD;
  thePath: string;
begin
  SetLength(thePath, MAX_PATH);
  lng := GetTempPath(MAX_PATH, PChar(thePath));
  SetLength(thePath, lng);
  Result := thePath;
end;

procedure TokenizeGridString(const S: String; const Delimiter, QuoteChar: Char; Tokens: TStringList);

function RemoveQuoteChar(str: string): string;
begin
  Result := str;
	if LeftStr(Result, 1) = QuoteChar then
  	Delete(Result, 1, 1);
	if RightStr(Result, 1) = QuoteChar then
  	Delete(Result, Length(Result), 1);
end;

var
	i, Len: Integer;
  CurToken: String;
begin
	Tokens.Clear;
  CurToken:='';
  Len:=Length(S);
  for i:=1 to Len do
  begin
  	if S[i] = Delimiter then
    begin
    	Tokens.Add(RemoveQuoteChar(CurToken));
      CurToken:='';
    end
    else
    	CurToken:=CurToken+S[i];
  end;
  Tokens.Add(RemoveQuoteChar(CurToken));
end;

function GetDataKey: string;
begin
  Result := '';
	while Length(Result) < 8 do
  	Result := Result+Chars[Random(Length(Chars))+1];
end;

function MinutesToMinuteSecond(sFloat: Double): string;
begin
	if sFloat <> 0 then
		Result := IntToStr(Trunc(sFloat))+':'+FormatFloat('00', Trunc(Frac(Abs(sFloat)) * 60))
  else
    Result := '';
end;

function DateTimeToHourMinute(sFloat: Double): string;
begin
	if sFloat <> 0 then
		Result := IntToStr(Trunc(sFloat*24))+':'+FormatFloat('00', Frac(Abs(sFloat)*24) * 60)
  else
    Result := '';
end;

function FloatToHourMinute(sFloat: Double): string;
begin
	if sFloat <> 0 then
    Result := FormatFloat('00', Trunc(sFloat))+':'+FormatFloat('00', Frac(Abs(sFloat)) * 60)
  else
    Result := '';
end;

function FloatToHourMinuteFloat(sFloat: Double): Variant;
begin
	if sFloat <> 0 then
		Result := Trunc(sFloat)+MyRound(Frac(Abs(sFloat))*60/100, -2)
  else
    Result := null;
end;

function FloatToHours(sFloat: Double): string;
begin
  Result := '';
	if Trunc(sFloat) > 0 then
    Result := Result+IntToStr(Trunc(sFloat))+' saat ';

  if Trunc(Frac(sFloat) * 60) > 0 then
    Result := Result+IntToStr(Trunc(Frac(sFloat) * 60))+' dak. ';

  Result := Trim(Result);
end;

function DateTimeToText(DateTime: TDateTime) : string;
var
	AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond: Word;
  Day : Integer;
begin
  DecodeDateTime(DateTime, AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond);
  Day := DaysBetween(DateTime, 0);
  Result := '';
  if Day > 0 then
    Result := Result+ifthen(Result='','',' ')+IntToStr(Day)+' gün';
  if AHour > 0 then
    Result := Result+ifthen(Result='','',' ')+IntToStr(AHour)+' sa';
  if AMinute > 0 then
    Result := Result+ifthen(Result='','',' ')+IntToStr(AMinute)+' dk';
  if ASecond > 0 then
    Result := Result+ifthen(Result='','',' ')+IntToStr(ASecond)+' sn';
end;

function AciklamaToMetreAciklama(Text: string): TMetreAciklama;
var
	s, s1, s2 : string;
begin
  Result.aciklama := null;
  Result.metre1 := null;
  Result.metre2 := null;
  Result.ok := False;

  if Trim(Text) = '' then
  begin
	  Result.ok := True;
    Exit;
  end;

  s := Trim(Text);
	s := StringReplace(s, FormatSettings.ThousandSeparator, FormatSettings.DecimalSeparator, [rfReplaceAll]);

  if Pos('-', s) = 0 then
  begin
  	s1 := s;
    s2 := '';
  end
  else
  begin
  	s1 := Trim(Copy(s, 1, Pos('-', s)-1));
    s2 := Trim(Copy(s, Pos('-', s)+1, Length(s)));
  end;

  if s1 = '' then
  	Exit
  else
  begin
  	try
	  	if StrToFloat(s1) <= 0 then
  	  	Exit
    	else
	    begin
				Result.metre1 := StrToFloat(s1);

	      if s2 <> '' then
  	    begin
			  	if StrToFloat(s2) <= StrToFloat(s1) then
    				Abort
			    else
  	        Result.metre2 := StrToFloat(s2);
	    	end
      end;
    except
    	Exit;
    end;
  end;

  if Result.metre2 = null then
    Result.aciklama := FloatToStr(Result.metre1)
  else
    Result.aciklama := FloatToStr(Result.metre1)+'-'+FloatToStr(Result.metre2);

  Result.ok := True;
end;

function Coalesce(V, Res: Variant): Variant;
begin
	if V = null then
  	Result := Res
  else
  	Result := V;
end;

function MyExtractFileName(str: string): string;
begin
  Result := str;
	if Pos('/', str) > 0 then
    Result := ExtractFileName(StringReplace(str, '/', '\', [rfReplaceAll]))
  else
    Result := ExtractFileName(str);
end;

function MyExtractFilePath(str: string): string;
begin
  Result := str;
	if Pos('/', str) > 0 then
    Result := StringReplace(ExtractFilePath(StringReplace(str, '/', '\', [rfReplaceAll])), '\', '/', [rfReplaceAll])
  else
    Result := ExtractFilePath(str)
end;

procedure CapsLockKapat;
begin
	Keybd_Event(VK_CAPITAL, 0, KEYEVENTF_EXTENDEDKEY or 0, 0) ;
  Keybd_Event(VK_CAPITAL, 0, KEYEVENTF_EXTENDEDKEY or KEYEVENTF_KEYUP, 0) ;
end;

function TrToUpperEn(S: string): string;
var
  I: Integer;
begin
  for I := 1 to Length(S) do
  begin
    if S[I] = 'ş' then
      S[I] := 'S'
    else
      if S[I] = 'Ş' then
      S[I] := 'S'
    else
      if S[I] = 'ğ' then
      S[I] := 'G'
    else
      if S[I] = 'Ğ' then
      S[I] := 'G'
    else
      if S[I] = 'ü' then
      S[I] := 'U'
    else
      if S[I] = 'Ü' then
      S[I] := 'U'
    else
      if S[I] = 'ö' then
      S[I] := 'O'
    else
      if S[I] = 'Ö' then
      S[I] := 'O'
    else
      if S[I] = 'ç' then
      S[I] := 'C'
    else
      if S[I] = 'Ç' then
      S[I] := 'C'
    else
      if S[I] = 'ı' then
      S[I] := 'I'
    else
      if S[I] = 'i' then
      S[I] := 'I'
    else
      if S[I] = 'İ' then
      S[I] := 'I'
    else
      S[I] := UpperCase(S[I])[1];
  end;
  Result := S;
end;

function TrToUpper(S: string): string;
var
  I: Integer;
begin
  for I := 1 to Length(S) do
  begin
    if S[I] = 'ş' then
      S[I] := 'Ş'
    else
    if S[I] = 'ğ' then
      S[I] := 'Ğ'
    else
    if S[I] = 'ü' then
      S[I] := 'Ü'
    else
    if S[I] = 'ö' then
      S[I] := 'Ö'
    else
    if S[I] = 'ç' then
      S[I] := 'Ç'
    else
    if S[I] = 'ı' then
      S[I] := 'I'
    else
    if S[I] = 'i' then
      S[I] := 'İ'
    else
      S[I] := UpperCase(S[I])[1];
  end;
  Result := S;
end;

function TrToLower(S: string): string;
var
  I: Integer;
begin
  for I := 1 to Length(S) do
  begin
    if S[I] = 'Ş' then
      S[I] := 'ş'
    else
    if S[I] = 'Ğ' then
      S[I] := 'ğ'
    else
    if S[I] = 'Ü' then
      S[I] := 'ü'
    else
    if S[I] = 'Ö' then
      S[I] := 'ö'
    else
    if S[I] = 'Ç' then
      S[I] := 'ç'
    else
    if S[I] = 'I' then
      S[I] := 'ı'
    else
    if S[I] = 'İ' then
      S[I] := 'i'
    else
      S[I] := LowerCase(S[I])[1];
  end;
  Result := S;
end;

function Double_To_Currency(D: Double): string;
var
	P : Integer;
  S : string;
begin
	S := FloatToStr(D);
  P := Pos(FormatSettings.DecimalSeparator, S);
  if (P = 0) or (Length(S)-P < 2) then
	  Result := FormatFloat('0.00', D)
  else
  	Result := s;
end;

function StrEllipsis(s: string; sLength: Integer): string;
begin
	Result := ifthen(Length(s)<=sLength, s, Copy(s, 1, sLength-3)+'...');
end;

function GetText(H: THandle): string;
var
  S: PChar;
  Len: Integer;
begin
  if H <> 0 then
  begin
    S := StrAlloc(256);
    Len := SendMessage(H, WM_GETTEXT, 255, Longint(S));
    if Len = 0 then Result := ''
    else Result := S;
    StrDispose(S);
  end;
end;


function GetComputerName: string;
var
  buffer: array[0..MAX_COMPUTERNAME_LENGTH + 1] of Char;
  Size: Cardinal;
begin
  Size := MAX_COMPUTERNAME_LENGTH + 1;
  Windows.GetComputerName(@buffer, Size);
  Result := StrPas(buffer);
end;




function GetKeybStateHelper(VirtualKey: Cardinal; Mask: Byte): Boolean;
var
  Keys: TKeyboardState;
begin
  Result := GetKeyBoardState(Keys) and (Keys[VirtualKey] and Mask <> 0);
end;

function myIndexOf(S: string; Strings: TStrings): Integer;
var
	I : Integer;
begin
  Result := -1;
  for I := 0 to Strings.Count-1 do
  begin
  	if Buyuk(S) = Buyuk(Strings[I]) then
    begin
      Result := I;
      Break;
    end;
  end;
end;

function MyFirstUpperCase(s: string): string;
var
  PrevChar, R : string;
  I : Integer;
begin
  PrevChar := ' ';
  R := '';
  for I := 1 to Length(s) do
  begin
  	if (PrevChar = ' ') or (PrevChar = '.') then
    begin
    	if s[I] = 'ı' then
	    	R := R+'I'
      else
    	if s[I] = 'i' then
	    	R := R+'İ'
      else
	    	R := R+AnsiUpperCase(s[I]);
    end
    else
    begin
    	if s[I] = 'I' then
	    	R := R+'ı'
      else
    	if s[I] = 'İ' then
	    	R := R+'i'
      else
	    	R := R+AnsiLowerCase(s[I]);
    end;
    PrevChar := s[I];
  end;
  Result := R;
end;

function Buyuk(S: string): string;
var
  I: Integer;
begin
  for I := 1 to Length(S) do
  begin
    if S[I] = 'ş' then
      S[I] := 'Ş'
    else
      if S[I] = 'ğ' then
      S[I] := 'Ğ'
    else
      if S[I] = 'ü' then
      S[I] := 'Ü'
    else
      if S[I] = 'ö' then
      S[I] := 'Ö'
    else
      if S[I] = 'ç' then
      S[I] := 'Ç'
    else
      if S[I] = 'ı' then
      S[I] := 'I'
    else
      if S[I] = 'i' then
      S[I] := 'İ'
    else
      S[I] := UpperCase(S[I])[1];
  end;
  Result := S;
end;

function Kucuk(S: string): string;
var
  I: Integer;
begin
  for I := 1 to Length(S) do
  begin
    if S[I] = 'Ş' then
      S[I] := 'ş'
    else
      if S[I] = 'Ğ' then
      S[I] := 'ğ'
    else
      if S[I] = 'Ü' then
      S[I] := 'ü'
    else
      if S[I] = 'Ö' then
      S[I] := 'ö'
    else
      if S[I] = 'Ç' then
      S[I] := 'ç'
    else
      if S[I] = 'I' then
      S[I] := 'ı'
    else
      if S[I] = 'İ' then
      S[I] := 'i'
    else
      S[I] := LowerCase(S[I])[1];
  end;
  Result := S;
end;

function FileVersionInfo(sAppNamePath: TFileName): TFileVersionInfo;
var
  rSHFI: TSHFileInfo;
  iRet: Integer;
  VerSize: Integer;
  VerBuf: PChar;
  VerBufValue: Pointer;
  VerHandle: Cardinal;
  VerBufLen: Cardinal;
  VerKey: string;
  FixedFileInfo: PVSFixedFileInfo;

  // dwFileType, dwFileSubtype
  function GetFileSubType(FixedFileInfo: PVSFixedFileInfo) : string;
  begin
    case FixedFileInfo.dwFileType of

      VFT_UNKNOWN: Result := 'Unknown';
      VFT_APP: Result := 'Application';
      VFT_DLL: Result := 'DLL';
      VFT_STATIC_LIB: Result := 'Static-link Library';

      VFT_DRV:
        case
          FixedFileInfo.dwFileSubtype of
          VFT2_UNKNOWN: Result := 'Unknown Driver';
          VFT2_DRV_COMM: Result := 'Communications Driver';
          VFT2_DRV_PRINTER: Result := 'Printer Driver';
          VFT2_DRV_KEYBOARD: Result := 'Keyboard Driver';
          VFT2_DRV_LANGUAGE: Result := 'Language Driver';
          VFT2_DRV_DISPLAY: Result := 'Display Driver';
          VFT2_DRV_MOUSE: Result := 'Mouse Driver';
          VFT2_DRV_NETWORK: Result := 'Network Driver';
          VFT2_DRV_SYSTEM: Result := 'System Driver';
          VFT2_DRV_INSTALLABLE: Result := 'InstallableDriver';
          VFT2_DRV_SOUND: Result := 'Sound Driver';
        end;
      VFT_FONT:
         case FixedFileInfo.dwFileSubtype of
          VFT2_UNKNOWN: Result := 'Unknown Font';
          VFT2_FONT_RASTER: Result := 'Raster Font';
          VFT2_FONT_VECTOR: Result := 'Vector Font';
          VFT2_FONT_TRUETYPE: Result :='Truetype Font';
          else;
        end;
      VFT_VXD: Result :='Virtual Defice Identifier = ' +
          IntToHex(FixedFileInfo.dwFileSubtype, 8);
    end;
  end;


  function HasdwFileFlags(FixedFileInfo: PVSFixedFileInfo; Flag : Word) : Boolean;
  begin
    Result := (FixedFileInfo.dwFileFlagsMask and
              FixedFileInfo.dwFileFlags and
              Flag) = Flag;
  end;

  function GetFixedFileInfo: PVSFixedFileInfo;
  begin
    if not VerQueryValue(VerBuf, '', Pointer(Result), VerBufLen) then
      Result := nil
  end;

  function GetInfo(const aKey: string): string;
  begin
    Result := '';
    VerKey := Format('\StringFileInfo\%.4x%.4x\%s',
              [LoWord(Integer(VerBufValue^)),
               HiWord(Integer(VerBufValue^)), aKey]);
    if VerQueryValue(VerBuf, PChar(VerKey),VerBufValue,VerBufLen) then
      Result := StrPas(PAnsiChar(VerBufValue));
  end;

  function QueryValue(const aValue: string): string;
  begin
    Result := '';
    // obtain version information about the specified file
    if GetFileVersionInfo(PChar(sAppNamePath), VerHandle, VerSize, VerBuf) and
       // return selected version information
       VerQueryValue(VerBuf, '\VarFileInfo\Translation', VerBufValue, VerBufLen) then
         Result := GetInfo(aValue);
  end;


begin
  // Initialize the Result
  with Result do
  begin
    FileType := '';
    CompanyName := '';
    FileDescription := '';
    FileVersion := '';
    InternalName := '';
    LegalCopyRight := '';
    LegalTradeMarks := '';
    OriginalFileName := '';
    ProductName := '';
    ProductVersion := '';
    Comments := '';
    SpecialBuildStr:= '';
    PrivateBuildStr := '';
    FileFunction := '';
    DebugBuild := False;
    Patched := False;
    PreRelease:= False;
    SpecialBuild:= False;
    PrivateBuild:= False;
    InfoInferred := False;
  end;

  // Get the file type
  if SHGetFileInfo(PChar(sAppNamePath), 0, rSHFI, SizeOf(rSHFI),
    SHGFI_TYPENAME) <> 0 then
  begin
    Result.FileType := rSHFI.szTypeName;
  end;

  iRet := SHGetFileInfo(PChar(sAppNamePath), 0, rSHFI, SizeOf(rSHFI), SHGFI_EXETYPE+SHGFI_ATTRIBUTES);
  if iRet <> 0 then
  begin
    // determine whether the OS can obtain version information
    VerSize := GetFileVersionInfoSize(PChar(sAppNamePath), VerHandle);
    if VerSize > 0 then
    begin
      VerBuf := AllocMem(VerSize);
      try
        with Result do
        begin
          CompanyName      := QueryValue('CompanyName');
          FileDescription  := QueryValue('FileDescription');
          FileVersion      := QueryValue('FileVersion');
          InternalName     := QueryValue('InternalName');
          LegalCopyRight   := QueryValue('LegalCopyRight');
          LegalTradeMarks  := QueryValue('LegalTradeMarks');
          OriginalFileName := QueryValue('OriginalFileName');
          ProductName      := QueryValue('ProductName');
          ProductVersion   := QueryValue('ProductVersion');
          Comments         := QueryValue('Comments');
          SpecialBuildStr  := QueryValue('SpecialBuild');
          PrivateBuildStr  := QueryValue('PrivateBuild');
          // Fill the  VS_FIXEDFILEINFO structure
          FixedFileInfo    := GetFixedFileInfo;
          DebugBuild       := HasdwFileFlags(FixedFileInfo,VS_FF_DEBUG);
          PreRelease       := HasdwFileFlags(FixedFileInfo,VS_FF_PRERELEASE);
          PrivateBuild     := HasdwFileFlags(FixedFileInfo,VS_FF_PRIVATEBUILD);
          SpecialBuild     := HasdwFileFlags(FixedFileInfo,VS_FF_SPECIALBUILD);
          Patched          := HasdwFileFlags(FixedFileInfo,VS_FF_PATCHED);
          InfoInferred     := HasdwFileFlags(FixedFileInfo,VS_FF_INFOINFERRED);
          FileFunction     := GetFileSubType(FixedFileInfo);
        end;
      finally
        FreeMem(VerBuf, VerSize);
      end
    end;
  end
end;

function GetNetworkDriveMapping(s: string): string;
var
  ThePath: string;
  MaxNetPathLen: DWord;
begin
  MaxNetPathLen := MAX_PATH;
  SetLength(ThePath, MAX_PATH) ;
  if WNetGetConnection(PChar('' + s + ':'), PChar(ThePath), MaxNetPathLen) = NO_ERROR then
  	Result := ThePath;
end;

function GetIPFromHost(const HostName: string): string;
type
  TaPInAddr = array[0..10] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  phe: PHostEnt;
  pptr: PaPInAddr;
  i: Integer;
  GInitData: TWSAData;
begin
  WSAStartup($101, GInitData);
  Result := '';
  phe := GetHostByName(PAnsiChar(HostName));
  if phe = nil then Exit;
  pPtr := PaPInAddr(phe^.h_addr_list);
  i := 0;
  while pPtr^[i] <> nil do
  begin
    Result := inet_ntoa(pptr^[i]^);
    Inc(i);
  end;
  WSACleanup;
end;

function GetExeIP: string;
var
	Yol : string;
	s : string;
  typ: Integer;
begin
	Result := '';
	Yol := MyExtractFilePath(Application.ExeName);
  if Yol[1] = '\' then
  begin
    s := Yol;
    s := Copy(s, 3, Length(s));
    s := Copy(s, 1, Pos('\', s)-1);
    Result := GetIPFromHost(s);
  end
  else
  begin
  	s := Yol[1]+':\';
  	typ := GetDriveType(PChar(s));
    if typ = DRIVE_REMOTE then
    begin
    	s := s[1];
    	s := GetNetworkDriveMapping(s);
      s := Copy(s, 3, Length(s));
      s := Copy(s, 1, Pos('\', s)-1);
      Result := GetIPFromHost(s);
    end
    else
      Result := GetLocalIP;
  end;
end;

function AddSlash(str: string): string;
begin
  Result := str;
  if Result = '' then
  	Exit;

  if Pos('/', Result) > 0 then
  begin
	  if RightStr(Result, 1) <> '/' then
  	  Result := Result + '/';
  end
  else
  begin
	  if RightStr(Result, 1) <> '\' then
  	  Result := Result + '\';
  end
end;

procedure PostKeyEx32(key: Word; const shift: TShiftState; specialkey: Boolean) ;
type
   TShiftKeyInfo = record
     shift: Byte ;
     vkey: Byte ;
   end;
   ByteSet = set of 0..7 ;
const
   shiftkeys: array [1..3] of TShiftKeyInfo =
     ((shift: Ord(ssCtrl) ; vkey: VK_CONTROL),
     (shift: Ord(ssShift) ; vkey: VK_SHIFT),
     (shift: Ord(ssAlt) ; vkey: VK_MENU)) ;
var
   flag: DWORD;
   bShift: ByteSet absolute shift;
   j: Integer;
begin
   for j := 1 to 3 do
   begin
     if shiftkeys[j].shift in bShift then
       keybd_event(shiftkeys[j].vkey, MapVirtualKey(shiftkeys[j].vkey, 0), 0, 0) ;
   end;
   if specialkey then
     flag := KEYEVENTF_EXTENDEDKEY
   else
     flag := 0;

   keybd_event(key, MapvirtualKey(key, 0), flag, 0) ;
   flag := flag or KEYEVENTF_KEYUP;
   keybd_event(key, MapvirtualKey(key, 0), flag, 0) ;

   for j := 3 downto 1 do
   begin
     if shiftkeys[j].shift in bShift then
       keybd_event(shiftkeys[j].vkey, MapVirtualKey(shiftkeys[j].vkey, 0), KEYEVENTF_KEYUP, 0) ;
   end;
end;

function GetLocalIP: string;
type
   TaPInAddr = array [0..10] of PInAddr;
   PaPInAddr = ^TaPInAddr;
var
    phe: PHostEnt;
    pptr: PaPInAddr;
    Buffer: PAnsichar;
    i: Integer;
    GInitData: TWSADATA;
begin
    WSAStartup($101, GInitData);
    Result := '';
    GetHostName(Buffer, SizeOf(Buffer));
    phe :=GetHostByName(buffer);
    if phe = nil then Exit;
    pptr := PaPInAddr(Phe^.h_addr_list);
    i := 0;
    while pptr^[i] <> nil do
    begin
      result := StrPas(inet_ntoa(pptr^[i]^));
      Inc(i);
    end;
    WSACleanup;
end;








function MyRound(const AValue: Double; const ADigit: smallint): Double;
begin
  Result := AValue*IntPower(10, -ADigit);
  if Result > 0 then
	  Result := Result+0.5
  else
	  Result := Result-0.5;
  Result := int(Result);
  Result := Result/IntPower(10, -ADigit);
end;

function MyRound(const AValue: Double): Integer;
begin
  Result := StrToInt(FormatFloat('0', MyRound(AValue, 0)));
end;


procedure StrToFont(sFont : string; Font : TFont);
var
	p : integer;
   sStyle : string;
begin
	with Font do
  begin
  	p := Pos( ',', sFont );
    Name := Copy( sFont, 2, p-3 );
   	Delete( sFont, 1, p );

   	p := Pos( ',', sFont );
    if p = 0 then
    	Exit;
    Size := StrToInt( Copy( sFont, 2, p-2 ) );
   	Delete( sFont, 1, p );

   	p := Pos( ',', sFont );
    if p = 0 then
    	Exit;
    sStyle := '|' + Copy( sFont, 3, p-4 );
    Style := [];
   	Delete( sFont, 1, p );

   	if( Pos( csfsBold,sStyle ) > 0 )then
   		Style := Style + [ fsBold ];

	   if( Pos( csfsItalic,sStyle ) > 0 )then
   		Style := Style + [ fsItalic ];

	   if( Pos( csfsUnderline,sStyle ) > 0 )then
   		Style := Style + [ fsUnderline ];

	   if( Pos( csfsStrikeout,sStyle ) > 0 )then
   		Style := Style + [ fsStrikeout ];

    if Copy( sFont, 3,Length( sFont ) - 3 ) = '' then
    	Exit;

   	Color := StringToColor(Copy( sFont, 3,Length( sFont ) - 3 ) );
	end;
end;

function FontToStr(Font : TFont ) : string;
var
	sStyle : string;
begin
	with Font do
   begin
   	// convert font style to string
      sStyle := '';

      if( fsBold in Style )then
      	sStyle := sStyle + csfsBold;

      if( fsItalic in Style )then
      	sStyle := sStyle + csfsItalic;

      if( fsUnderline in Style )then
      	sStyle := sStyle + csfsUnderline;

      if( fsStrikeout in Style )then
      	sStyle := sStyle + csfsStrikeout;

      if( ( Length( sStyle ) > 0 ) and ( '|' = sStyle[ 1 ] ) )then
      	sStyle := Copy( sStyle, 2,Length( sStyle ) - 1 );

      Result := Format(
                    '"%s", %d, [%s], [%s]',
                    [ Name,
                      Size,
                      sStyle,
                      ColorToString( Color ) ] );
   end;
end;

function SetFloatStr(S : string): string;
var
  PVirgul, PNokta: Integer;
begin
  Result := S;

  PVirgul := Pos(',', Result);
  PNokta := Pos('.', Result);
  if (PNokta > 0) and (PVirgul > 0) and (PNokta > PVirgul) then
    Result := StringReplace(Result, ',', '', [rfReplaceAll])
  else
  if (PNokta > 0) and (PVirgul > 0) and (PVirgul > PNokta) then
    Result := StringReplace(Result, '.', '', [rfReplaceAll]);

  Result := StringReplace(Result, '.', ',', [rfReplaceAll]);
  Result := StringReplace(Result, ' ', '', [rfReplaceAll]);
end;



function FindWindowByTitle(WindowTitle: string): Hwnd;
var
  NextHandle: Hwnd;
  NextTitle: array[0..260] of char;
begin
  // Get the first window
  NextHandle := GetWindow(Application.Handle, GW_HWNDFIRST);
  while NextHandle > 0 do
  begin
    // retrieve its text
    GetWindowText(NextHandle, NextTitle, 255);
    if Pos(WindowTitle, StrPas(NextTitle)) <> 0 then
    begin
      Result := NextHandle;
      Exit;
    end
    else
      // Get the next window
      NextHandle := GetWindow(NextHandle, GW_HWNDNEXT);
  end;
  Result := 0;
end;

procedure LoadPictureFromBlob(Picture: TPicture; BlobField: TBlobField);
var
	JpegImage : TJPEGImage;
  ms2: TStream;
begin
	if BlobField.IsNull then
  begin
    Picture.Graphic := nil;
    Exit;
  end;
  JpegImage := TJPEGImage.Create;
  try
  	ms2 := BlobField.DataSet.CreateBlobStream(BlobField, bmRead);
    JpegImage.LoadFromStream(ms2);
    Picture.Assign(JpegImage);
  finally
    FreeAndNil(JpegImage);
    FreeAndNil(ms2);
  end;
end;

function GetURL(URL: string): string;
var
	HTTPClient : TIdHTTP;
begin
	try
    HTTPClient := TIdHTTP.Create(nil);
    try
      Result := HTTPClient.Get(URL);
    finally
      FreeAndNil(HTTPClient);
    end;
  except
  end;
end;

procedure Yaz(Rect: TRect; cCanvas: TCanvas; LM, TM: Integer; defColor: TColor; str: string);
var
	stag : string;
  L, I : Integer;
  open_tag : boolean;
begin
  if LM < 0 then
  	LM := Rect.Left+Rect.Right-cCanvas.TextWidth(str)+LM;
  open_tag := false;
  cCanvas.Font.Style := [];
  cCanvas.Brush.Style := bsClear;
  L := 0;
  for I := 1 to Length(str) do
  begin
    if not open_tag then
    begin
      if str[I] <> '<' then
      begin
        cCanvas.TextRect(Rect, LM+Rect.Left+L, TM+Rect.Top, str[I]);
        L := L + cCanvas.TextWidth(str[I]);
      end
      else
      begin
        open_tag := true;
        stag := '';
        Continue;
      end;
    end
    else
    if open_tag then
    begin
      if str[I] <> '>' then
      begin
        stag := stag + str[I];
      end
      else
      begin
        open_tag := false;
        if stag = 'b' then
          cCanvas.Font.Style := [fsBold]
        else
        if stag = '/b' then
          cCanvas.Font.Style := []
        else
        if stag = 'i' then
          cCanvas.Font.Style := [fsItalic]
        else
        if stag = '/i' then
          cCanvas.Font.Style := []
        else
        if pos('renk', stag) = 1 then
          cCanvas.Font.Color := StrToInt('$'+Copy(stag, 5, Length(stag)))
        else
        if pos('/renk', stag) = 1 then
          cCanvas.Font.Color := defColor;
        Continue;
      end;
    end;
  end;
end;

function IsUACActive: Boolean;
var
  Reg: TRegistry;
begin
  Result := FALSE;

  if CheckWin32Version(6, 0) then
  begin
    Result := FALSE;

    Reg := TRegistry.Create;
    try
      Reg.RootKey := HKEY_LOCAL_MACHINE;

      if Reg.OpenKeyReadOnly('SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System') then
      begin
        if (Reg.ValueExists('EnableLUA')) and (Reg.ReadBool('EnableLUA')) then
          Result := TRUE;
      end;
    finally
      FreeAndNil(Reg);
    end;
  end;
end;

function ExecuteFile(Handle: HWND; const Filename, Paramaters: String; Options: TExecuteFileOptions): Integer;
var
  ShellExecuteInfo: TShellExecuteInfo;
  ExitCode: DWORD;
begin
  Result := -1;

  ZeroMemory(@ShellExecuteInfo, SizeOf(ShellExecuteInfo));
  ShellExecuteInfo.cbSize := SizeOf(TShellExecuteInfo);
  ShellExecuteInfo.Wnd := Handle;
  ShellExecuteInfo.fMask := SEE_MASK_NOCLOSEPROCESS;

  if (eoElevate in Options) and (IsUACActive) then
    ShellExecuteInfo.lpVerb := PChar('runas');

  ShellExecuteInfo.lpFile := PChar(Filename);

  if Paramaters <> '' then
    ShellExecuteInfo.lpParameters := PChar(Paramaters);

  // Show or hide the window
  if eoHide in Options then
    ShellExecuteInfo.nShow := SW_HIDE
  else
    ShellExecuteInfo.nShow := SW_SHOWNORMAL;

  if ShellExecuteEx(@ShellExecuteInfo) then
    Result := 0;

  if (Result = 0) and (eoWait in Options) then
  begin
    GetExitCodeProcess(ShellExecuteInfo.hProcess, ExitCode);

    while (ExitCode = STILL_ACTIVE) and
          (not Application.Terminated) do
    begin
      sleep(50);

      GetExitCodeProcess(ShellExecuteInfo.hProcess, ExitCode);
    end;

    Result := ExitCode;
  end;
end;

function IsLike(AString, Pattern: string): boolean;
var
   j, n, n1, n2: integer ;
   p1, p2: pchar ;
label
   match, nomatch;
begin
   AString := UpperCase(AString) ;
   Pattern := UpperCase(Pattern) ;
   n1 := Length(AString) ;
   n2 := Length(Pattern) ;
   if n1 < n2 then n := n1 else n := n2;
   p1 := pchar(AString) ;
   p2 := pchar(Pattern) ;
   for j := 1 to n do begin
     if p2^ = '%' then goto match;
     if (p2^ <> '?') and ( p2^ <> p1^ ) then goto nomatch;
     inc(p1) ; inc(p2) ;
   end;
   if n1 > n2 then begin
nomatch:
     Result := False;
     exit;
   end else if n1 < n2 then begin
     for j := n1 + 1 to n2 do begin
       if not ( p2^ in ['%','?'] ) then goto nomatch ;
       inc(p2) ;
     end;
   end;
match:
   Result := True
end;

function WideStringToString(const ws: WideString; codePage: Word): AnsiString;
var
  l: integer;
begin
  if ws = '' then
    Result := ''
  else
  begin
    l := WideCharToMultiByte(codePage,
      WC_COMPOSITECHECK or WC_DISCARDNS or WC_SEPCHARS or WC_DEFAULTCHAR,
      @ws[1], - 1, nil, 0, nil, nil);
    SetLength(Result, l - 1);
    if l > 1 then
      WideCharToMultiByte(codePage,
        WC_COMPOSITECHECK or WC_DISCARDNS or WC_SEPCHARS or WC_DEFAULTCHAR,
        @ws[1], - 1, @Result[1], l - 1, nil, nil);
  end;
end;


procedure DataSetToXml(DS: TUniQuery; XMLAdi: string);
var
  XML : IXMLDOCUMENT;
  XMLExport,TabloName,Field:IXMLNODE;
  i, a:integer;
begin
  try
    if  DS.IsEmpty then Exit;
    //ind := DS.FieldByName('CAR_ID').AsInteger;
    XML := NewXMLDocument;
    XML.Encoding  := 'utf-8';
    XML.Options   := [doNodeAutoIndent];
    XMLExport := XML.AddChild('BMSoftXMLExport');
    //for I := 1 to DS.RecordCount do
    //  begin
        TabloName := XMLExport.AddChild('BMSoft', i);
        //DS.First;
        for a := 1 to DS.FieldCount do
        begin
          Field := TabloName.AddChild(DS.Fields[a-1].FieldName,0);
          Field.Text := DS.Fields[a-1].AsString;
        end;
    //  end;
    //DS.Locate('STK_ID', ind, []);
    XMl.SaveToFile(UniServerModule.TempFolderPath + XMLAdi + '.xml');
  except on E: Exception do
  end;
end;

procedure DownloadFile(AFile: string);
var
  IdHTTP1: TIdHTTP;
  Stream: TMemoryStream;
  Url, FileName: String;
begin
  Url := 'https://www.tcmb.gov.tr/kurlar/today.xml';
  IdHTTP1 := TIdHTTP.Create(nil);
  Stream := TMemoryStream.Create;
  try
    IdHTTP1.Get(Url, Stream);
    Stream.SaveToFile(AFile);
  finally
    Stream.Free;
    IdHTTP1.Free;
  end;
end;


procedure TarihSec(Secenek: SmallInt; edt1, edt2: TDate);
begin
  if Secenek = 1 then // bugün
  begin
    edt1 := System.DateUtils.DateOf(Date);
    edt2 := System.DateUtils.DateOf(Date);
  end
  else if Secenek = 2 then // dün
  begin
    edt1 := System.DateUtils.DateOf(Date - 1);
    edt2 := System.DateUtils.DateOf(Date - 1);
  end
  else if Secenek = 9 then // yarın
  begin
    edt1 := System.DateUtils.DateOf(Date + 1);
    edt2 := System.DateUtils.DateOf(Date + 1);
  end
  else if Secenek = 3 then // bu hafta
  begin
    edt1 := System.DateUtils.DateOf(System.DateUtils.StartOfTheWeek(Date));
    edt2 := System.DateUtils.DateOf(System.DateUtils.EndOfTheWeek(Date));
  end
  else if Secenek = 4 then // geçen hafta
  begin
    edt1 := System.DateUtils.DateOf(System.DateUtils.StartOfTheWeek(IncWeek(Date, -1)));
    edt2 := System.DateUtils.DateOf(System.DateUtils.EndOfTheWeek(IncWeek(Date, -1)));
  end
  else if Secenek = 10 then // gelecek hafta
  begin
    edt1 := System.DateUtils.DateOf(System.DateUtils.StartOfTheWeek(IncWeek(Date, 1)));
    edt2 := System.DateUtils.DateOf(System.DateUtils.EndOfTheWeek(IncWeek(Date, 1)));
  end
  else if Secenek = 5 then // bu ay
  begin
    edt1 := System.DateUtils.DateOf(System.DateUtils.StartOfTheMonth(Date));
    edt2 := System.DateUtils.DateOf(System.DateUtils.EndOfTheMonth(Date));
  end
  else if Secenek = 6 then // geçen ay
  begin
    edt1 := System.DateUtils.DateOf(System.DateUtils.StartOfTheMonth(IncMonth(Date, -1)));
    edt2 := System.DateUtils.DateOf(System.DateUtils.EndOfTheMonth(IncMonth(Date, -1)));
  end
  else if Secenek = 11 then // gelecek ay
  begin
    edt1 := System.DateUtils.DateOf(System.DateUtils.StartOfTheMonth(System.SysUtils.IncMonth(Date, 1)));
    edt2 := System.DateUtils.DateOf(System.DateUtils.EndOfTheMonth(System.SysUtils.IncMonth(Date, 1)));
  end
  else if Secenek = 7 then // bu yıl
  begin
    edt1 := System.DateUtils.DateOf(System.DateUtils.StartOfTheYear(Date));
    edt2 := System.DateUtils.DateOf(System.DateUtils.EndOfTheYear(Date));
  end
  else if Secenek = 8 then // geçen yıl
  begin
    edt1 := System.DateUtils.DateOf(System.DateUtils.StartOfTheYear(IncYear(Date, -1)));
    edt2 := System.DateUtils.DateOf(System.DateUtils.EndOfTheYear(IncYear(Date, -1)));
  end
  else if Secenek = 12 then // gelecek yıl
  begin
    edt1 := System.DateUtils.DateOf(System.DateUtils.StartOfTheYear(IncYear(Date, 1)));
    edt2 := System.DateUtils.DateOf(System.DateUtils.EndOfTheYear(IncYear(Date, 1)));
  end
  else if Secenek = 13 then // son 30 gün
  begin
    edt1 := System.DateUtils.DateOf(Date - 30);
    edt2 := System.DateUtils.DateOf(Date);
  end;
end;

function SuzgecVerisiIsle(veri: string): string;
begin
  Result := Trim(veri);
  if Result = '' then
    Exit;
  if Trim(Result)[1] = '=' then
    Result := Copy(Result, Pos('=', Result) + 1, Length(Result))
  else if Pos('%', Result) = 0 then
    Result := '%' + Result + '%';
end;

function HataMesaj(s: string): string;
var
  TmpStr: string;
begin
  Result:= s;
  if Pos('Cannot perform this operation on a closed dataset', Result) > 0 then
    Result:= 'Veri seti kapalı. İşlem gerçekleştirilemiyor!';
  if Pos('edit because another user changed the record', Result) > 0 then
    Result:= 'Kayıt başka bir kullanıcı tarafından değiştirilmiş!';
  if Pos('Update failed. Found 0 records', Result) > 0 then
    Result:= 'Kayıt başka bir kullanıcı tarafından değiştirilmiş!';
  if Pos('Field', Result) > 0 then
    Result:= StringReplace(Result, 'Field', 'Alan', []);
  if Pos('not found', Result) > 0 then
    Result:= StringReplace(Result, 'not found', 'bulunamadı', []);
  if Pos('Could not find object', Result) > 0 then
    Result:= StringReplace(Result, 'Could not find object', 'Nesne Bulunamadı', []);
  if Pos('Unknown database', Result) > 0 then
    Result:= StringReplace(Result, 'Unknown database', 'Bilinmeyen Veritabanı', [])
  else if Pos('Procedure unknown', Result) > 0 then
    Result:= StringReplace(Result, 'Procedure unknown', 'Bilinmeyen Prosedür', [])
  else if Pos('Table unknown', Result) > 0 then
    Result:= StringReplace(Result, 'Table unknown', 'Bilinmeyen Tablo', []);
  if Pos('is of an unknown type', Result) > 0 then
    Result:= StringReplace(Result, 'is of an unknown type', 'tipi belirsiz', []);
  if Pos('Operation aborted', Result) > 0 then
    Result:= StringReplace(Result, 'Operation aborted', 'İşlem iptal edildi.', []);
  if Pos('General SQL error', Result) > 0 then
  begin
    Result:= StringReplace(Result, 'General SQL error', 'Genel SQL hatası', []);
    Result:= StringReplace(Result, 'Token unknown', 'Bilinmeyen', []);
    Result:= StringReplace(Result, 'line', 'Satır', []);
    Result:= StringReplace(Result, 'char', 'Karakter', []);
  end else if (Pos('violation of PRIMARY or UNIQUE KEY constraint', Result) > 0) then
  begin
    if (Pos('Problematic key value is', Result) > 0) then
    begin
      TmpStr:= Copy(Result, Pos('Problematic key value is', Result) + 25,
        Length(Result) - (Pos('Problematic key value is', Result) + 24));
      // Result:= 'Aynı indeks anahtarına sahip bir başka kayıt var!' +#13+
      //   'Kabul edilmeyen değer ' + TmpStr;
        Result:= 'Aynı değerde başka bir kayıt var.';
    end else
      Result:= 'Aynı değerde başka bir kayıt var!';
  end
  else
  if (Pos('validation error for column', Result) > 0)
    and (Pos('value "*** null ***"', Result) > 0) then
  begin
    Result:= Trim(Copy(Result, Pos('validation error for column', Result) + 27,
      Length(Result) - Pos('validation error for column', Result) - 26));
    if Pos('value "*** null ***"', Result) > 0 then
      Result:= Trim(Copy(Result, 1, Pos('value *** null ***', Result) - 1));
    Result:= QuotedStr(StringReplace(Result + ' mutlaka bir değer içermelidir!', '''', '', [rfReplaceAll]));
  end else
    if (Pos('Operation violates CHECK constraint', Result) > 0)
    and (Pos('on view or table', Result) > 0) then
  begin
    Result:= Trim(Copy(Result, Pos('on view or table', Result) + 16,
      Length(Result) - Pos('on view or table', Result) - 15));
    if Pos('At trigger', Result) > 0 then
      Result:= Trim(Copy(Result, 1, Pos('At trigger', Result) - 1));
    Result:= Result + ' üzerinde kısıtlama kural ihlali oluştu!';
  end else
    if Pos('EX_HATA', Result) > 0 then
  begin
    Result:= Copy(Result, Pos('EX_HATA', Result) + 8, Length(Result) - Pos('EX_HATA', Result) - 7);
    if Pos('At procedure', Result) > 0 then
      Result:= Copy(Result, 1, Pos('At procedure', Result) - 1)
    else if Pos('At trigger', Result) > 0 then
      Result:= Copy(Result, 1, Pos('At trigger', Result) - 1);
  end;
  if Pos('violation of FOREIGN KEY constraint', Result) > 0 then
    Result:= 'Bu kayıt ile ilişkili başka bir kayıt var';
  if Pos('Foreign key references are present for the record', Result) > 0 then
    Result:= 'Bu kayıt ile ilişkili başka bir kayıt var';
  if Pos('Problematic key value is', Result) > 0 then
    Result:= 'Aynı değerde başka bir kayıt var!';
  if Pos('Foreign key reference target does not exist', Result) > 0 then
    Result:= 'Foreign key referansı bulunamıyor';
  if Pos('validation error for column', Result) > 0 then
    Result:= 'Veri doğrulama hatası';
  if Pos('exception 1', Result) > 0 then
    Result:= StringReplace(Result, 'exception 1', '', []);
  if Pos('exception 2', Result) > 0 then
    Result:= StringReplace(Result, 'exception 2', '', []);
  if Pos('exception 3', Result) > 0 then
    Result:= StringReplace(Result, 'exception 3', '', []);
  if Pos('exception 4', Result) > 0 then
    Result:= StringReplace(Result, 'exception 4', '', []);
  if Pos('exception 5', Result) > 0 then
    Result:= StringReplace(Result, 'exception 5', '', []);
  if Pos('At procedure', Result) > 0 then
    Result:= StringReplace(Result, 'At procedure', 'Prosedür', []);
  if Pos('At trigger', Result) > 0 then
    Result:= StringReplace(Result, 'At trigger', 'Tetikleyici', []);
  if Pos('line:', Result) > 0 then
    Result:= StringReplace(Result, 'line:', 'Satır:', []);
  if Pos('col:', Result) > 0 then
    Result:= StringReplace(Result, 'line:', 'Sütun:', []);
  if Pos('unknown type', Result) > 0 then
    Result:= StringReplace(Result, 'unknown type', 'bilinmeyen tip', []);
  if Pos('At line', Result) > 0 then
    Result:= StringReplace(Result, 'At line', 'Satır', []);
  if Pos('column', Result) > 0 then
    Result:= StringReplace(Result, 'column', 'Sütun', []);
  if Pos('Unable to complete network request to host', Result) > 0 then
    Result:= StringReplace(Result, 'Unable to complete network request to host', 'Sunucu ile ağ bağlantısı sağlanamıyor', []);
  if Pos('Failed to locate host machine', Result) > 0 then
    Result:= StringReplace(Result, 'Failed to locate host machine', 'Sunucu bilgisayar bulunamıyor', []);
  if Pos('Failed to establish a connection', Result) > 0 then
    Result:= StringReplace(Result, 'Failed to establish a connection', 'Bağlantı kurulamıyor', []);
  if Pos('Error while trying to open file', Result) > 0 then
    Result:= StringReplace(Result, 'Error while trying to open file', 'Veritabanı bulunamıyor', []);
  if Pos('I/O error for file', Result) > 0 then
    Result:= StringReplace(Result, 'I/O error for file', 'Dosya Giriş/Çıkış hatası', []);
  if Pos('no permission for read-write access to database', Result) > 0 then
    Result:= StringReplace(Result, 'no permission for read-write access to database', 'Veritabanı salt okunur, giriş yapılamıyor', []);
  if Pos('Insufficient SQL rights for operation', Result) > 0 then
    Result:= StringReplace(Result, 'Insufficient SQL rights for operation', 'SQL operasyonu gerçekleştirilemiyor', []);
  if Pos('unsupported on-disk structure for file', Result) > 0 then
    Result:= StringReplace(Result, 'unsupported on-disk structure for file', 'Veritabanı dosyası bozuk', []);
  if Pos('No such file or directory', Result) > 0 then
    Result:= StringReplace(Result, 'No such file or directory', 'Dosya ya da dizin yok', []);
  if Pos('must have a value', Result) > 0 then
    Result:= StringReplace(Result, 'must have a value', 'bir değer içermelidir', []);
end;



end.
