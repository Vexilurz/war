unit uGlobal;

interface

type
  TPacket = packed record
    ProtocolID: cardinal;
    Command: byte;
    BackIP: array [0..14] of char;
    BackPort: word;
    Str1: array [0..255] of char;
    Str2: array [0..255] of char;
  end;

const
  ProtocolID = $BEDABEDA;

implementation

end.
