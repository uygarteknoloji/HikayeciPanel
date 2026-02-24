unit ServiceModule;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs,
  uniGUIService;

type
  THikayeciPanelServiceModule = class(TUniGUIService)
  private
    { Private declarations }
  protected
    procedure InitService; override;
  public
    { Public declarations }
    function GetServiceController: TServiceController; override;
  end;

var
  HikayeciPanelServiceModule: THikayeciPanelServiceModule;

implementation

{$R *.dfm}

uses
  UniGUIVars;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  HikayeciPanelServiceModule.Controller(CtrlCode);
end;

function THikayeciPanelServiceModule.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure THikayeciPanelServiceModule.InitService;
begin
  SetServerClass(UniGUIServerModuleClass);
end;

end.
