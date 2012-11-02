program CAN_test_V3;

uses
  Forms,
  UnitMain in 'UnitMain.pas' {Form1},
  UnitRxThread in 'UnitRxThread.pas',
  VCI3Error in '..\common\VCI3Error.pas',
  Vci3Can in '..\common\Vci3Can.pas',
  VCI3Types in '..\common\VCI3Types.pas',
  U_SaveLoadOptions in 'U_SaveLoadOptions.pas',
  U_my in 'U_my.pas',
  ABOUT in 'ABOUT.pas' {AboutBox};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'CAN Test ';
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.
