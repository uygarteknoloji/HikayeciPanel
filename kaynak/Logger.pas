unit Logger;
{***********************
TLogger
v. 1.0, 2016, Стрелец Streletz
***********************
Delphi component to save the records in the log file.

Not intended for versions prior to XE2.
***********************}
interface

uses
  System.SysUtils, System.Classes;

type
  TLoggerBeforeFilePathChangeEvent = procedure(Sender: Tobject; NewPath: String)
    of object;

type
  TLogger = class(TComponent)
  private
    fFilePath: string;
    fOnBeforeWriting: TNotifyEvent;
    fOnAfterWriting: TNotifyEvent;
    fOnFilePathChange: TNotifyEvent;
    fOnBeforeFilePathChange: TLoggerBeforeFilePathChangeEvent;
    procedure SaveFilePath(Path: string);
    procedure WriteInFile(LogRec: string);
  public
    procedure WriteLog(LogRec: string);
  published
    property FilePath: string read fFilePath write SaveFilePath;
    property OnBeforeWriting: TNotifyEvent read fOnBeforeWriting
      write fOnBeforeWriting;
    property OnAfterWriting: TNotifyEvent read fOnAfterWriting
      write fOnAfterWriting;
    property OnFilePathChange: TNotifyEvent read fOnFilePathChange
      write fOnFilePathChange;
    property OnBeforeFilePathChange: TLoggerBeforeFilePathChangeEvent
      read fOnBeforeFilePathChange write fOnBeforeFilePathChange;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Logger', [TLogger]);
end;

{ TLogger }

procedure TLogger.SaveFilePath(Path: string);
begin
  if Assigned(fOnBeforeFilePathChange) then
    fOnBeforeFilePathChange(Self, Path);
  fFilePath := Path;
  if Assigned(fOnFilePathChange) then
    fOnFilePathChange(Self);
end;

procedure TLogger.WriteInFile(LogRec: string);
var
  FileName, Path, Rec: string;
  LogFile: TextFile;
begin
  // Проверяем на заполнение поля с путём к файлу журнала
  if fFilePath <> '' then
    FileName := fFilePath
  else
  begin
    GetDir(0, Path);
    FileName := Path + '\logfile.log';
  end;
  AssignFile(LogFile, FileName);
  // Проверяем существование файла журнала
  if not FileExists(FileName) then
    Rewrite(LogFile)
  else
    Append(LogFile);
  // Формируем запись и сохраняем в файл журнала
  Rec := Format('%s %s', [DateTimeToStr(Now), LogRec]);
  WriteLn(LogFile, Rec);
  CloseFile(LogFile);
end;

procedure TLogger.WriteLog(LogRec: string);
begin
  // Событие "Перед сохранением"
  if Assigned(fOnBeforeWriting) then
    fOnBeforeWriting(Self);
  // Сохранение строки с текстом записи в файл
  WriteInFile(LogRec);
  // Событие "После сохранения"
  if Assigned(fOnAfterWriting) then
    fOnAfterWriting(Self);
end;

end.
