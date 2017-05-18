unit uSender;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdUDPBase, IdUDPServer, Spin,
  uGlobal, IdSocketHandle;

type
  TfmMain = class(TForm)
    IdUDPServer1: TIdUDPServer;
    bnSend: TButton;
    cbCmd: TComboBox;
    sePort: TSpinEdit;
    Label1: TLabel;
    edIP: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    edStr1: TEdit;
    Label4: TLabel;
    edStr2: TEdit;
    Label5: TLabel;
    edOurIP: TEdit;
    Label6: TLabel;
    procedure bnSendClick(Sender: TObject);
    procedure IdUDPServer1UDPRead(AThread: TIdUDPListenerThread; AData: TBytes;
      ABinding: TIdSocketHandle);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

procedure TfmMain.bnSendClick(Sender: TObject);
var
  buf: TBytes;
  packet: TPacket;
  i: integer;
  str: string;
begin
  for i := 0 to 255 do
  begin
    packet.Str1[i] := char(0);
    packet.Str2[i] := char(0);
  end;
  for i := 0 to 14 do
  begin
    packet.BackIP[i] := char(0);
  end;
  packet.ProtocolID := ProtocolID;
  packet.Command := cbCmd.ItemIndex;
  str := edStr1.Text;
  move(str[1], packet.Str1[0], length(str)*SizeOf(Char));
  str := edStr2.Text;
  move(str[1], packet.Str2[0], length(str)*SizeOf(Char));
//  StrPCopy(pansichar(packet.Str1[0]), edStr1.Text);
//  StrPCopy(pansichar(packet.Str2[0]), edStr2.Text);
  //packet.Str1 := pansichar(edStr1.Text);
  //packet.Str2 := edStr2.Text;
//  StrPCopy(pansichar(packet.BackIP[0]), edOurIP.Text);
//  packet.BackIP := edOurIP.Text;
  str := edOurIP.Text;
  move(str[1], packet.BackIP[0], length(str)*SizeOf(Char));
  packet.BackPort := 59147;
  setlength(buf, SizeOf(TPacket));
  CopyMemory(@buf[0], @packet, SizeOf(TPacket));
  IdUDPServer1.SendBuffer(edIP.Text, sePort.Value, buf);
end;

procedure TfmMain.IdUDPServer1UDPRead(AThread: TIdUDPListenerThread;
  AData: TBytes; ABinding: TIdSocketHandle);
var
  packet: TPacket;
  str: string;
begin
  CopyMemory(@packet, @AData[0], SizeOf(TPacket));
  if packet.ProtocolID = ProtocolID then
    case packet.Command of
      0: begin //Check service
        showmessage('Service alive!');
      end;
      1: begin //ShellExecute
      end;
      2: begin //Create file
      end;
      3: begin //Delete file
      end;
      4: begin //WriteLn file
      end;
      5: begin //Copy file
      end;
      6: begin //FileExists
//        SetLength(Str, Length(packet.Str2));
//        Move(packet.Str2[0], Str[1], Length(packet.Str2)*SizeOf(Char));
        str := packet.Str2;
        edStr2.Text := str;
//        edStr2.Text := ansistring(packet.Str2);
      end;
      7: begin //MkDir
      end;
    end;
end;

end.
