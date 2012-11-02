program DeviceList;

uses
  Forms,
  Unit_glavn in 'Unit_glavn.pas' {Form1},
  VCI3Types in '..\common\VCI3Types.pas',
  Vci3Can in '..\common\Vci3Can.pas',
  VCI3Error in '..\common\VCI3Error.pas',
  Vci3Lin in '..\common\Vci3Lin.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
