unit uSender;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdUDPBase, IdUDPServer;

type
  TForm1 = class(TForm)
    IdUDPServer1: TIdUDPServer;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  buf: TBytes;
begin
  setlength(buf, 1);
  buf[0] := 10;
  IdUDPServer1.SendBuffer('192.168.1.111', 59148, buf);
end;

end.
