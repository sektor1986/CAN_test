unit Unit_glavn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TForm1 = class(TForm)
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Vci3Can, VCI3Error, Vci3Lin, VCI3Types;

{$R *.dfm}

procedure TForm1.FormShow(Sender: TObject);
var
  phDevice: Cardinal;
begin
  vciDeviceOpenDlg(WindowHandle, phDevice);
  Close;
end;

end.
