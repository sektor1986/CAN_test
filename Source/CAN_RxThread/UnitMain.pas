(*************************************************************************
**    IXXAT Automation GmbH
**************************************************************************
**
**   $Workfile: UnitMain.PAS $ UnitMain
**     Summary: Demonstration for configuration and update from a
**              CAN-object with VCI V3.
**              In this example the use of a own thread for the receive
**              function is shown.
**
**   $Revision: 1 $
**     Version: @(VERSION)
**       $Date: 2006-07-24 $
**    Compiler: Delphi 5.0
**      Author: Peter Wucherer
**
**************************************************************************
**    all rights reserved
*************************************************************************)
unit UnitMain;

interface

uses
  Windows, Messages, Classes, Graphics, Controls, Forms, Dialogs,
  Vci3Can, StdCtrls, ExtCtrls, UnitRxThread, ComCtrls,
  iVCLComponent, iCustomComponent, iPositionComponent, iScaleComponent, iKnob,
  iThreadTimers, iTimers, iSwitchRocker, iObjectCanvas, iSlider, iOdometer,
  iAnalogDisplay, iSevenSegmentDisplay, iSevenSegmentHexadecimal, iSwitchPanel,
  iSwitchLed, iSwitchToggle, sRadioButton, sGroupBox, sCheckBox, sEdit,
  sSpinEdit, Buttons, sBitBtn, ImgList, acAlphaImageList, sSkinProvider,
  sSkinManager, Menus, sLabel, sComboBox, Mask, sMaskEdit, sCustomComboEdit,
  sCurrEdit, sCurrencyEdit, iComponent;

const
  BitTimingReg0 = CAN_BT0_250KB;
  BitTimingReg1 = CAN_BT1_250KB;
  BitTimingString = '250 kbit/s';


type
  CAN_DATA = array of byte;
  TFormMain = class(TForm)
    stbBottom: TStatusBar;
    pnlCANState: TPanel;
    lblCANInit: TLabel;
    lblTxPending: TLabel;
    lblDataOverrun: TLabel;
    lblWarningLevel: TLabel;
    lblBusOff: TLabel;
    shaCtrlInit: TShape;
    shaTxPending: TShape;
    shaDataOverrun: TShape;
    shaWarningLevel: TShape;
    shaBusOff: TShape;
    tmrUpdateInfo: TTimer;
    btnTransmit: TButton;
    lblTxResult: TLabel;
    lblLastRxMsgType: TLabel;
    lblMsgData: TLabel;
    iKnob1: TiKnob;
    iKnob2: TiKnob;
    iThreadTimers1: TiThreadTimers;
    iKnob3: TiKnob;
    iKnob4: TiKnob;
    iKnob5: TiKnob;
    iKnob6: TiKnob;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    iSlider1: TiSlider;
    iSlider2: TiSlider;
    Label2: TLabel;
    Label5: TLabel;
    iSlider3: TiSlider;
    iAnalogDisplay1: TiAnalogDisplay;
    iAnalogDisplay2: TiAnalogDisplay;
    RadioGroup1: TRadioGroup;
    CheckBox1: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox5: TCheckBox;
    sGroupBox2: TsGroupBox;
    sDecimalSpinEdit1: TsDecimalSpinEdit;
    CheckBox8: TCheckBox;
    sGroupBox3: TsGroupBox;
    iSlider4: TiSlider;
    Label3: TLabel;
    CheckBox9: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox10: TCheckBox;
    sDecimalSpinEdit2: TsDecimalSpinEdit;
    sGroupBox4: TsGroupBox;
    Label4: TLabel;
    iSlider5: TiSlider;
    CheckBox11: TCheckBox;
    RadioGroup2: TRadioGroup;
    CheckBox12: TCheckBox;
    RadioGroup3: TRadioGroup;
    CheckBox7: TCheckBox;
    sGroupBox1: TsGroupBox;
    sDecimalSpinEdit3: TsDecimalSpinEdit;
    CheckBox6: TCheckBox;
    sDecimalSpinEdit4: TsDecimalSpinEdit;
    sGroupBox5: TsGroupBox;
    sDecimalSpinEdit5: TsDecimalSpinEdit;
    CheckBox13: TCheckBox;
    Bevel1: TBevel;
    sGroupBox6: TsGroupBox;
    Label6: TLabel;
    iSlider6: TiSlider;
    CheckBox14: TCheckBox;
    sGroupBox7: TsGroupBox;
    Label7: TLabel;
    iSlider7: TiSlider;
    CheckBox15: TCheckBox;
    sTimePicker1: TsTimePicker;
    sBitBtn1: TsBitBtn;
    sAlphaImageList1: TsAlphaImageList;
    sBitBtn2: TsBitBtn;
    sBitBtn3: TsBitBtn;
    MainMenu1: TMainMenu;
    Abaut1: TMenuItem;
    Extit1: TMenuItem;
    Reset1: TMenuItem;
    RadioGroup4: TRadioGroup;
    CheckBox16: TCheckBox;
    RadioGroup5: TRadioGroup;
    CheckBox17: TCheckBox;
    sGroupBox8: TsGroupBox;
    Label8: TLabel;
    iSlider8: TiSlider;
    CheckBox18: TCheckBox;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    sGroupBox9: TsGroupBox;
    CheckBox19: TCheckBox;
    sComboBox1: TsComboBox;
    CheckBox20: TCheckBox;
    CheckBox21: TCheckBox;
    CheckBox22: TCheckBox;
    CheckBox23: TCheckBox;
    sCurrencyEdit1: TsCurrencyEdit;
    sCurrencyEdit2: TsCurrencyEdit;
    sCurrencyEdit3: TsCurrencyEdit;
    sGroupBox10: TsGroupBox;
    CheckBox24: TCheckBox;
    RadioGroup6: TRadioGroup;
    RadioGroup7: TRadioGroup;
    RadioGroup8: TRadioGroup;
    RadioGroup9: TRadioGroup;
    RadioGroup10: TRadioGroup;
    sGroupBox11: TsGroupBox;
    CheckBox25: TCheckBox;
    RadioGroup11: TRadioGroup;
    sGroupBox12: TsGroupBox;
    Label9: TLabel;
    iSlider9: TiSlider;
    CheckBox26: TCheckBox;
    sGroupBox13: TsGroupBox;
    sDecimalSpinEdit6: TsDecimalSpinEdit;
    CheckBox27: TCheckBox;
    sDecimalSpinEdit7: TsDecimalSpinEdit;
    chk1: TCheckBox;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tmrUpdateInfoTimer(Sender: TObject);
    procedure btnTransmitClick(Sender: TObject);
    procedure Timer50_msTimer(Sender: TObject);
    procedure iKnob1PositionChange(Sender: TObject);
    procedure iKnob2PositionChange(Sender: TObject);
    procedure iThreadTimers1Timer2(Sender: TObject);
    procedure iThreadTimers1Timer1(Sender: TObject);
    procedure iTimers1Timer1(Sender: TObject);
    procedure iTimers1Timer2(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure iSlider1PositionChange(Sender: TObject);
    procedure iThreadTimers1Timer5(Sender: TObject);
    procedure iSlider2PositionChange(Sender: TObject);
    procedure iSlider3PositionChange(Sender: TObject);
    procedure iThreadTimers1Timer6(Sender: TObject);
    procedure iKnob3PositionChange(Sender: TObject);
    procedure iThreadTimers1Timer3(Sender: TObject);
    procedure iSwitchRocker2Change(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure iThreadTimers1Timer7(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure iThreadTimers1Timer9(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure iThreadTimers1Timer8(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure sBitBtn1Click(Sender: TObject);
    procedure sBitBtn2Click(Sender: TObject);
    procedure sBitBtn3Click(Sender: TObject);
    procedure Extit1Click(Sender: TObject);
    procedure Reset1Click(Sender: TObject);
    procedure Abaut1Click(Sender: TObject);
    procedure iThreadTimers1Timer4(Sender: TObject);
    procedure chk1Click(Sender: TObject);

  private
    m_hDeviceHandle : THandle;       // the handle to the interface
    m_dwCanNo       : LongLong;      // the number of the can controller 0/1
    m_hCanChannel   : THandle;       // the handle to the can channel
    m_hCanChannelRex: THandle;
    m_hCanControl   : THandle;       // the handle to the can controller
    m_dwTimerResolution : LongWord;  // the timer resolution of the controller
    m_dwTimerOverruns   : LongWord;  // number of timer overruns
    m_qwOverrunValue    : Int64;     // stored value to add to every timestamp
    m_ReceiveQueueThread : TReceiveQueueThread; // a thread to receive data

    procedure InitSocket();
    procedure InitSocketRec();
    procedure ShowErrorMessage(errorText : string; hFuncResult : HResult);

    procedure ShowDataFrame(sCanMsg  : CANMSG);
    procedure ShowInfoFrame(sCanMsg  : CANMSG);
    procedure ShowErrorFrame(sCanMsg  : CANMSG);
    procedure ShowStatusFrame(sCanMsg  : CANMSG);
    procedure ShowWakeUpFrame(sCanMsg  : CANMSG);
    procedure HandleTimerOverrunFrame(sCanMsg  : CANMSG);
    procedure HandleTimerResetFrame(sCanMsg  : CANMSG);
    procedure SendCANMessage(MSG_ID: CANMSG_ID; data: CAN_DATA);
    procedure SaveOptions();
  public
    procedure ShowCANMessage(sCanMsg  : CANMSG);
    function GetMyVersion: string;
  end;

var
  FormMain: TFormMain;

implementation

{$R *.DFM}

uses
  VCI3Error, SysUtils, U_SaveLoadOptions, ABOUT;  // for the return codes of VCI 3 functions

var
  TimeWork: Integer;
  Speed: Integer;
  EngSpeed: Integer;
  OilPres: integer;
  OilLevel: Integer;
  CoolantLevel: Integer;
  CoolantTemp: Integer;

(************************************************************************
**
**    Function      : TFormMain.FormCreate
**                    Delphi Message Handler
**
**    Description   : Here the board selection dialog will be shown
**                    and the controller initializing routines will
**                    be called in the function InitSocket
**    Parameter     :
**
**    Returnvalues  : -
**
************************************************************************)
procedure TFormMain.Button1Click(Sender: TObject);
begin
  FormDestroy(self);
  FormCreate(self);
end;

procedure TFormMain.Button2Click(Sender: TObject);
begin
  TimeWork := 0;
end;

procedure TFormMain.Button3Click(Sender: TObject);
begin
  SaveOptions;
end;

procedure TFormMain.CheckBox1Click(Sender: TObject);
begin
  iKnob2.Enabled := CheckBox1.Checked;
end;

procedure TFormMain.CheckBox2Click(Sender: TObject);
begin
  iKnob3.Enabled := CheckBox2.Checked;
end;

procedure TFormMain.CheckBox3Click(Sender: TObject);
begin
  iKnob1.Enabled := CheckBox3.Checked;
end;

procedure TFormMain.CheckBox4Click(Sender: TObject);
begin
  RadioGroup1.Enabled := CheckBox4.Checked;
end;

procedure TFormMain.CheckBox5Click(Sender: TObject);
begin
  iSlider1.Enabled := CheckBox5.Checked;
  iSlider2.Enabled := CheckBox5.Checked;
  iSlider3.Enabled := CheckBox5.Checked;
end;

procedure TFormMain.CheckBox7Click(Sender: TObject);
begin
  RadioGroup3.Enabled := CheckBox7.Checked;
end;

procedure TFormMain.chk1Click(Sender: TObject);
begin
  iKnob5.Enabled := chk1.Checked;
  iKnob6.Enabled := chk1.Checked;
end;

procedure TFormMain.Extit1Click(Sender: TObject);
begin
  Close;
end;

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveOptions;
end;

procedure TFormMain.FormCreate(Sender: TObject);
var
  hFuncResult  : HResult;
  deviceInfo   : VCIDEVICEINFO;
  deviceInfo1   : VCIDEVICEINFO;
  ErrorText    : string;
  szIfaceName  : PChar;
  hEnum        : Cardinal;
  TG           : TGUID;
  deviceName   : string;
begin
  // use the first CAN
  m_dwCanNo := 0;

  // set the handles to zero
  m_hDeviceHandle      := 0;
  m_hCanChannel        := 0;
  m_hCanControl        := 0;
  m_dwTimerResolution  := 0;
  m_dwTimerOverruns    := 0;
  m_qwOverrunValue     := 0;
  m_ReceiveQueueThread := nil;

//***********Открытие программы без показа диалогового окна выбора устройства**********************
  deviceName := LoadParamFromIniFiles('Device', 'Number', varString);
  //Если в файле опций есть информация об устройстве то открываем его
  if deviceName <> EmptyStr then
    begin
      // Поиск устройства по уникальму номеру
      // Number = 35315748-3230-3035-0000-000000000000
      TG.D1 := StrToInt('$' + Copy(deviceName, 1, 8));
      TG.D2 := StrToInt('$' + Copy(deviceName, 10, 4));
      TG.D3 := StrToInt('$' + Copy(deviceName, 15, 4));
      TG.D4[0] := StrToInt('$' + Copy(deviceName, 20, 2));
      TG.D4[1] := StrToInt('$' + Copy(deviceName, 22, 2));
      TG.D4[2] := StrToInt('$' + Copy(deviceName, 25, 2));
      TG.D4[3] := StrToInt('$' + Copy(deviceName, 27, 2));
      TG.D4[4] := StrToInt('$' + Copy(deviceName, 29, 2));
      TG.D4[5] := StrToInt('$' + Copy(deviceName, 31, 2));
      TG.D4[6] := StrToInt('$' + Copy(deviceName, 33, 2));
      TG.D4[7] := StrToInt('$' + Copy(deviceName, 35, 2));
      hFuncResult := vciFindDeviceByHwid(TG, deviceInfo.VciObjectId);
      if ( hFuncResult = VCI_OK ) then
        begin
          hFuncResult := vciDeviceOpen(@deviceInfo.VciObjectId, m_hDeviceHandle);
          szIfaceName := @deviceInfo.Description;
          stbBottom.Panels[0].Text := szIfaceName;
          InitSocket();
          InitSocketRec();
        end
      else
        begin
          ErrorText := 'НЕ найден CAN интерфейс';
        end;
    end
  //Если и нформация не найдена открываем по списку
  else
    begin
      hFuncResult := vciEnumDeviceOpen(hEnum);
      if ( hFuncResult = VCI_OK ) then
        begin
          hFuncResult := vciEnumDeviceNext(hEnum, deviceInfo);
          vciEnumDeviceClose(hEnum);
          if ( hFuncResult = VCI_OK ) then
            begin
              hFuncResult := vciDeviceOpen(@deviceInfo.VciObjectId, m_hDeviceHandle);
              szIfaceName := @deviceInfo.Description;
              stbBottom.Panels[0].Text := szIfaceName;
              InitSocket();
              InitSocketRec();
            end
          else
            begin
              ErrorText := 'НЕ найден CAN интерфейс';
            end;
        end;
    end;


//---------------------------------------------------------------

  // show a dialog and open the selected device
{
  hFuncResult := vciDeviceOpenDlg(WindowHandle, m_hDeviceHandle);
  if ( hFuncResult = VCI_OK ) then
  begin
    hFuncResult := vciDeviceGetInfo(m_hDeviceHandle, deviceInfo);
    if ( hFuncResult = VCI_OK ) then
    begin
      szIfaceName := @deviceInfo.Description;
      stbBottom.Panels[0].Text := szIfaceName;
      // try to open the CAN channel
      InitSocket();
      InitSocketRec();
    end
    else
    begin
      ErrorText := 'Error in vciDeviceGetInfo';
    end;
  end
  else
    ErrorText := 'Error in vciDeviceOpen';
}

  if ( hFuncResult <> VCI_OK )
    then ShowErrorMessage(ErrorText, hFuncResult);
end;

(************************************************************************
**
**    Function      : TFormMain.FormDestroy
**                    Delphi Message Handler
**
**    Description   : Stop the receive thread and wait until it has finfished,
**                    close all handles from VCI V3
**    Parameter     :
**
**    Returnvalues  : -
**
************************************************************************)
procedure TFormMain.FormDestroy (Sender: TObject);
begin
  iThreadTimers1.Enabled1 := false;
  iThreadTimers1.Enabled2 := false;
  iThreadTimers1.Enabled3 := false;
  iThreadTimers1.Enabled4 := false;
  iThreadTimers1.Enabled5 := false;
  iThreadTimers1.Enabled6 := false;
  iThreadTimers1.Enabled7 := false;
  iThreadTimers1.Enabled8 := false;
  iThreadTimers1.Enabled9 := false;

  if (m_ReceiveQueueThread <> nil) then
  begin
    // call the thread function to terminate
    m_ReceiveQueueThread.Terminate;

    // wait for the thread until it's finfished
    m_ReceiveQueueThread.WaitFor;

    // now destroy the object
    m_ReceiveQueueThread.Destroy;

    // set the object to nil
    m_ReceiveQueueThread := nil;
  end;

  if (m_hCanControl <> 0) then
  begin
    canControlClose(m_hCanControl);
    m_hCanControl := 0;
  end;

  // when a CAN channel was opened then close it now
  if (m_hCanChannel <> 0) then
  begin
    canChannelClose(m_hCanChannel);
    m_hCanChannel := 0;
  end;

  if (m_hCanChannelRex <> 0) then
  begin
    canChannelClose(m_hCanChannelRex);
    m_hCanChannelRex := 0;
  end;

  // when a device was opened the close it now
  if (m_hDeviceHandle <> 0) then
  begin
    vciDeviceClose(m_hDeviceHandle);
    m_hDeviceHandle := 0;
  end;
end;

function TFormMain.GetMyVersion: string;
type
  TVerInfo=packed record
    Nevazhno: array[0..47] of byte; // ненужные нам 48 байт
    Minor,Major,Build,Release: word; // а тут версия
  end;
var
  s: TResourceStream;
  v: TVerInfo;
begin
  result := '';
  try
    s := TResourceStream.Create(HInstance,'#1',RT_VERSION); // достаём ресурс
    if s.Size > 0 then
      begin
        s.Read(v, SizeOf(v)); // читаем нужные нам байты
        result := IntToStr(v.Major)+'.'+IntToStr(v.Minor); //+'.'+ // вот и версия...
              //IntToStr(v.Release); //+'.'+IntToStr(v.Build);
      end;
    s.Free;
  except;
  end;
end;

procedure TFormMain.FormShow(Sender: TObject);
begin
  Caption := Caption + ' V ' + GetMyVersion;

  //***************Загрузка параметров**************************
  TimeWork := LoadParamFromIniFiles('Time', 'TimeWork', varInteger);
  iKnob1.Position := LoadParamFromIniFiles('Position', 'Speed', varDouble);
  iKnob2.Position := LoadParamFromIniFiles('Position', 'Tahometer', varDouble);
  iKnob3.Position := LoadParamFromIniFiles('Position', 'OilTemp', varDouble);
  iKnob5.Position := LoadParamFromIniFiles('Position', 'Brake1', varDouble);
  iKnob6.Position := LoadParamFromIniFiles('Position', 'Brake2', varDouble);
  iSlider1.Position := LoadParamFromIniFiles('Position', 'OilPress', varDouble);
  iSlider2.Position := LoadParamFromIniFiles('Position', 'OilLevel', varDouble);
  iSlider3.Position := LoadParamFromIniFiles('Position', 'OhlLevel', varDouble);
  iSlider4.Position := LoadParamFromIniFiles('Position', 'KppOilTemp', varDouble);
  iSlider5.Position := LoadParamFromIniFiles('Position', 'FuelEkonomy', varDouble);
  iSlider6.Position := LoadParamFromIniFiles('Position', 'CatalystLevel', varDouble);
  iSlider7.Position := LoadParamFromIniFiles('Position', 'UreaLevel', varDouble);
  iSlider8.Position := LoadParamFromIniFiles('Position', 'BatteryPotential', varDouble);

  CheckBox3.Checked := LoadParamFromIniFiles('Enabled', 'Speed', varBoolean);
  CheckBox5.Checked := LoadParamFromIniFiles('Enabled', 'EFL', varBoolean);
  CheckBox1.Checked := LoadParamFromIniFiles('Enabled', 'Tahometer', varBoolean);
  CheckBox2.Checked := LoadParamFromIniFiles('Enabled', 'OilTemp', varBoolean);
  CheckBox8.Checked := LoadParamFromIniFiles('Enabled', 'Probeg', varBoolean);
  CheckBox9.Checked := LoadParamFromIniFiles('Enabled', 'KppOilTemp', varBoolean);
  CheckBox4.Checked := LoadParamFromIniFiles('Enabled', 'AdBlueStatus', varBoolean);
  CheckBox12.Checked := LoadParamFromIniFiles('Enabled', 'WFI', varBoolean);
  CheckBox7.Checked := LoadParamFromIniFiles('Enabled', 'DP12', varBoolean);
  CheckBox11.Checked := LoadParamFromIniFiles('Enabled', 'FuelEkonomy', varBoolean);
  CheckBox6.Checked := LoadParamFromIniFiles('Enabled', 'EngineHours', varBoolean);
  CheckBox10.Checked := LoadParamFromIniFiles('Enabled', 'DateTime', varBoolean);
  CheckBox13.Checked := LoadParamFromIniFiles('Enabled', 'IdleOperation', varBoolean);
  CheckBox14.Checked := LoadParamFromIniFiles('Enabled', 'CatalystLevel', varBoolean);
  CheckBox15.Checked := LoadParamFromIniFiles('Enabled', 'UreaLevel', varBoolean);
  CheckBox16.Checked := LoadParamFromIniFiles('Enabled', 'FanDriveState', varBoolean);
  CheckBox17.Checked := LoadParamFromIniFiles('Enabled', 'StartLamp', varBoolean);
  CheckBox18.Checked := LoadParamFromIniFiles('Enabled', 'BatteryPotential', varBoolean);
  //--------------------------------------------------------------------
  OilPres :=        Round(iSlider1.Position * 100);
  OilLevel :=       Round(iSlider2.Position);
  CoolantLevel :=   Round(iSlider3.Position);

  iThreadTimers1.Enabled1 := true;
  iThreadTimers1.Enabled2 := true;
  iThreadTimers1.Enabled3 := true;
  iThreadTimers1.Enabled4 := true;
  iThreadTimers1.Enabled5 := true;
  iThreadTimers1.Enabled6 := true;
  iThreadTimers1.Enabled7 := true;
  iThreadTimers1.Enabled8 := true;
  iThreadTimers1.Enabled9 := true;
end;

(************************************************************************
**
**    Function      : TFormMain.InitSocket
**                    Private Method
**
**    Description   : The interface will openended and all needed
**                    handles to open the CAN controller will be set.
**                    Then the CAN controller will be initialized, the
**                    filters set to accept all identifiers and the
**                    CAN controller will be started.
**    Parameter     :
**
**    Returnvalues  : -
**
************************************************************************)
procedure TFormMain.InitSocket();
var
  hFuncResult  : HResult;
  wRxFifoSize  : Word;
  wRxThreshold : Word;
  wTxFifoSize  : Word;
  wTxThreshold : Word;
  pCanCaps     : CANCAPABILITIES;
  qwTimerTemp  : Int64;
  errorText    : string;
begin
  errorText := 'InitSocket was succesful';

  hFuncResult := canChannelOpen(m_hDeviceHandle, m_dwCanNo, FALSE, m_hCanChannel);
  if (hFuncResult = VCI_OK) then
  begin
    // device and CAN channel are now open, so initialize the CAN channel
    wRxFifoSize  := 1024;
    wRxThreshold := 1;
    wTxFifoSize  := 128;
    wTxThreshold := 1;

    hFuncResult := canChannelInitialize( m_hCanChannel,
                                         wRxFifoSize, wRxThreshold,
                                         wTxFifoSize, wTxThreshold);
    if (hFuncResult <> VCI_OK)
      then errorText := 'Error in canChannelInitialize';
  end;

  if (hFuncResult = VCI_OK) then
  begin
     // device, CAN channel are open and initialized,
     // so activate now the CAN channel
     hFuncResult := canChannelActivate(m_hCanChannel, TRUE);
     if (hFuncResult <> VCI_OK)
       then errorText := 'Error in canChannelActivate';
  end;

  if (hFuncResult = VCI_OK) then
  begin
    // the CAN channel is now activated, open now the CAN controller
    hFuncResult := canControlOpen(m_hDeviceHandle, m_dwCanNo, m_hCanControl);
    if (hFuncResult = VCI_OK) then
    begin
      stbBottom.Panels[1].Text := 'Ctrl: ' + IntToStr(m_dwCanNo + 1);

      hFuncResult := canControlGetCaps( m_hCanControl, pCanCaps);
      if (hFuncResult = VCI_OK) then
      begin
        // calulate the time resolution in 100 nSeconds
        qwTimerTemp := pCanCaps.dwTscDivisor * 10000000;
        m_dwTimerResolution := Round(qwTimerTemp / pCanCaps.dwClockFreq);
      end;
    end
    else
    begin
      errorText := 'Error in canControlOpen';
    end;
  end;

  if (hFuncResult = VCI_OK) then
  begin
    // the CAN control is now open, initialize it now
    hFuncResult := canControlInitialize( m_hCanControl
                                       , CAN_OPMODE_EXTENDED or CAN_OPMODE_ERRFRAME
                                       , BitTimingReg0
                                       , BitTimingReg1 );
    if (hFuncResult = VCI_OK)
      then stbBottom.Panels[2].Text := BitTimingString
      else errorText := 'Error in canControlInitialize';
  end;

  if (hFuncResult = VCI_OK) then
  begin
   // set the acceptance filter
   hFuncResult := canControlSetAccFilter( m_hCanControl
                                        , True
                                        , CAN_ACC_CODE_ALL
                                        , CAN_ACC_MASK_ALL );
    if (hFuncResult <> VCI_OK)
      then errorText := 'Error in canControlSetAccFilter';
  end;

  if (hFuncResult = VCI_OK) then
  begin
    // start the CAN controller
    hFuncResult := canControlStart( m_hCanControl, TRUE );
    if (hFuncResult <> VCI_OK)
      then errorText := 'Error in canControlStart';
  end;

  {if (m_hCanChannel <> 0) then
  begin
    // start the timer to look every 100 ms for data
    m_ReceiveQueueThread := TReceiveQueueThread.Create(m_hCanChannel);
  end;}

  if (hFuncResult <> VCI_OK)
    then ShowErrorMessage(errorText, hFuncResult);
end;

procedure TFormMain.InitSocketRec;
var
  hFuncResult  : HResult;
  wRxFifoSize  : Word;
  wRxThreshold : Word;
  wTxFifoSize  : Word;
  wTxThreshold : Word;
  pCanCaps     : CANCAPABILITIES;
  qwTimerTemp  : Int64;
  errorText    : string;
begin
  errorText := 'InitSocket was succesful';

  hFuncResult := canChannelOpen(m_hDeviceHandle, m_dwCanNo, FALSE, m_hCanChannelRex);
  if (hFuncResult = VCI_OK) then
  begin
    // device and CAN channel are now open, so initialize the CAN channel
    wRxFifoSize  := 1024;
    wRxThreshold := 1;
    wTxFifoSize  := 128;
    wTxThreshold := 1;

    hFuncResult := canChannelInitialize( m_hCanChannelRex,
                                         wRxFifoSize, wRxThreshold,
                                         wTxFifoSize, wTxThreshold);
    if (hFuncResult <> VCI_OK)
      then errorText := 'Error in canChannelInitialize';
  end;

  if (hFuncResult = VCI_OK) then
  begin
     // device, CAN channel are open and initialized,
     // so activate now the CAN channel
     hFuncResult := canChannelActivate(m_hCanChannelRex, TRUE);
     if (hFuncResult <> VCI_OK)
       then errorText := 'Error in canChannelActivate';
  end;

 { if (hFuncResult = VCI_OK) then
  begin
    // the CAN channel is now activated, open now the CAN controller
    hFuncResult := canControlOpen(m_hDeviceHandle, m_dwCanNo, m_hCanControl);
    if (hFuncResult = VCI_OK) then
    begin
      stbBottom.Panels[1].Text := 'Ctrl: ' + IntToStr(m_dwCanNo + 1);

      hFuncResult := canControlGetCaps( m_hCanControl, pCanCaps);
      if (hFuncResult = VCI_OK) then
      begin
        // calulate the time resolution in 100 nSeconds
        qwTimerTemp := pCanCaps.dwTscDivisor * 10000000;
        m_dwTimerResolution := Round(qwTimerTemp / pCanCaps.dwClockFreq);
      end;
    end
    else
    begin
      errorText := 'Error in canControlOpen';
    end;
  end; }

  if (m_hCanChannelRex <> 0) then
  begin
    // start the timer to look every 100 ms for data
    m_ReceiveQueueThread := TReceiveQueueThread.Create(m_hCanChannelRex);
  end;

  if (hFuncResult <> VCI_OK)
    then ShowErrorMessage(errorText, hFuncResult);

end;

procedure TFormMain.iSlider1PositionChange(Sender: TObject);
begin
  OilPres := Round(iSlider1.Position * 100);
  Label1.Caption := 'Давление масла ' + IntToStr(OilPres) + ' kPa';
end;

procedure TFormMain.iSlider2PositionChange(Sender: TObject);
begin
  OilLevel := Round(iSlider2.Position);
end;

procedure TFormMain.iSlider3PositionChange(Sender: TObject);
begin
  CoolantLevel := Round(iSlider3.Position);
end;

procedure TFormMain.iSwitchRocker2Change(Sender: TObject);
begin
  iKnob1.Enabled := CheckBox4.Checked;
end;

procedure TFormMain.iThreadTimers1Timer1(Sender: TObject);
var
  MSG_ID  : CANMSG_ID;
  tempEngSpeed: Integer;
  data: CAN_DATA;
begin
  if CheckBox1.Checked then
    begin
      SetLength(data, 8);
      with MSG_ID do
        begin
          priority := 3;
          PDUformat := 240;
          PDUspecific := 4;
        end;
      tempEngSpeed := EngSpeed * 8;
      data[0] := $FF;
      data[1] := $FF;
      data[2] := $FF;
      data[3] := tempEngSpeed and $FF;
      data[4] := (tempEngSpeed shr 8) and $FF;
      data[5] := $FF;
      data[6] := $FF;
      data[7] := $FF;
      SendCANMessage(MSG_ID, data);
    end;
end;

procedure TFormMain.iThreadTimers1Timer2(Sender: TObject);
var
  MSG_ID  : CANMSG_ID;
  tempSpeed: Integer;
  data: CAN_DATA;
begin
  if CheckBox3.Checked then
    begin
      SetLength(data, 8);
      with MSG_ID do
        begin
          priority := 3;
          PDUformat := $FE;
          PDUspecific := $6C;
        end;
      tempSpeed := Speed * 256;
      data[0] := $FF;
      data[1] := $FF;
      data[2] := $FF;
      data[3] := $FF;
      data[4] := $FF;
      data[5] := $FF;
      data[6] := tempSpeed and $FF;
      data[7] := (tempSpeed shr 8) and $FF;
      SendCANMessage(MSG_ID, data);
    end;
end;

procedure TFormMain.iThreadTimers1Timer3(Sender: TObject);
var
  MSG_ID  : CANMSG_ID;
  temp: Integer;
  data: CAN_DATA;
begin
  SetLength(data, 8);
  if CheckBox4.Checked then
    begin
      with MSG_ID do
        begin
          priority := 6;
          PDUformat := $FE;
          PDUspecific := $D9;
        end;
      data[0] := $FF;
      data[1] := $FF;
      data[2] := $FF;
      data[4] := $FF;
      data[5] := $FF;
      data[6] := $FF;
      data[7] := $FF;
      case RadioGroup1.ItemIndex of
        0: data[3] := $FC;
        1: data[3] := $FC or $01;
        2: data[3] := $FC or $02;
        3: data[3] := $FF;
      end;
      SendCANMessage(MSG_ID, data);
    end;

  if CheckBox7.Checked then
    begin
      with MSG_ID do
        begin
          priority := 6;
          PDUformat := $FF;
          PDUspecific := $0C;
        end;
      data[0] := $FF;
      if RadioGroup3.ItemIndex = 0 then
        data[1] := $80
      else
        data[1] := $00;;

      data[2] := $FF;
      data[3] := $FF;
      data[4] := $FF;
      data[5] := $FF;
      data[6] := $FF;
      data[7] := $FF;
      SendCANMessage(MSG_ID, data);
    end;

  if CheckBox11.Checked then
    begin
      with MSG_ID do
        begin
          priority := 6;
          PDUformat := $FE;
          PDUspecific := $F2;
        end;
      temp := Round(iSlider5.Position * 20);
      data[0] := temp and $FF;
      data[1] := (temp shr 8) and $FF;
      data[2] := $FF;
      data[3] := $FF;
      data[4] := $FF;
      data[5] := $FF;
      data[6] := $FF;
      data[7] := $FF;
      SendCANMessage(MSG_ID, data);
    end;

end;

procedure TFormMain.iThreadTimers1Timer4(Sender: TObject);
begin
  if shaBusOff.Brush.Color = clRed then
    sBitBtn3Click(Self);
end;

procedure TFormMain.iThreadTimers1Timer5(Sender: TObject);
var
  MSG_ID  : CANMSG_ID;
  tempOilPres: Integer;
  data: CAN_DATA;
begin
  if CheckBox5.Checked then
    begin
      SetLength(data, 8);
      with MSG_ID do
        begin
          priority := 6;
          PDUformat := 254;
          PDUspecific := 239;
        end;
      tempOilPres := Round(OilPres / 4);
      data[0] := $FF;
      data[1] := $FF;
      data[2] := Round(OilLevel / 0.4);
      data[3] := tempOilPres;
      data[4] := $FF;
      data[5] := $FF;
      data[6] := 0;
      data[7] := Round(CoolantLevel / 0.4);
      SendCANMessage(MSG_ID, data);
    end;
end;

procedure TFormMain.iThreadTimers1Timer6(Sender: TObject);
var
  MSG_ID  : CANMSG_ID;
  tempEngSpeed: Integer;
  data: CAN_DATA;
  msec, sec, min, hour, minGr, hourGr: Word;
  probeg: Integer;
  temp: Integer;
  y: TSystemTime;
  timeGr: TDateTime;
  spn, fmi, oc: word;
begin

  SetLength(data, 8);
  if CheckBox2.Checked then
    begin
      with MSG_ID do
        begin
          priority := 6;
          PDUformat := $FE;
          PDUspecific := $EE;
        end;
      data[0] := CoolantTemp;
      data[1] := $FF;
      data[2] := $FF;
      data[3] := 0;
      data[4] := 0;
      data[5] := $FF;
      data[6] := $FF;
      data[7] := $FF;
      SendCANMessage(MSG_ID, data);
    end;

  if chk1.Checked then
    begin
      with MSG_ID do
        begin
          priority := 6;
          PDUformat := $FE;
          PDUspecific := $FA;
        end;
      data[0] := $FF;
      data[1] := Round(iKnob5.Position * 25);
      data[2] := Round(iKnob6.Position * 25);;
      data[3] := $FF;
      data[4] := $FF;
      data[5] := $FF;
      data[6] := $FF;
      data[7] := $FF;
      SendCANMessage(MSG_ID, data);
    end;

    if CheckBox10.Checked then
      begin
      with MSG_ID do
        begin
          priority := 6;
          PDUformat := $FE;
          PDUspecific := $E6;
        end;
      GetSystemTime(y);
      timeGr := SystemTimeToDateTime(y);
      DecodeTime(Time, hour, min, sec, msec);
      DecodeTime(timeGr, hourGr, minGr, sec, msec);
      data[0] := sec * 4;
      data[1] := minGr;
      data[2] := hourGr;
      data[3] := 0;
      data[4] := 0;
      data[5] := 0;
      data[6] := 125 + min - minGr;
      data[7] := 125 + hour - hourGr;
      SendCANMessage(MSG_ID, data);
      end;

    if CheckBox8.Checked then
      begin
      with MSG_ID do
        begin
          priority := 6;
          PDUformat := $FE;
          PDUspecific := $C1;
        end;
      probeg := Round((sDecimalSpinEdit1.Value * 1000) / 5);
      data[0] :=  probeg and $FF;
      data[1] := (probeg shr 8)and  $FF;
      data[2] := (probeg shr 16) and $FF;
      data[3] := (probeg shr 24) and $FF;
      probeg := Round((sDecimalSpinEdit2.Value * 1000) / 5);
      data[4] :=  probeg and $FF;;
      data[5] := (probeg shr 8)and  $FF;;
      data[6] := (probeg shr 16) and $FF;;
      data[7] := (probeg shr 24) and $FF;
      SendCANMessage(MSG_ID, data);
      end;

    if CheckBox9.Checked then
    begin
      with MSG_ID do
        begin
          priority := 6;
          PDUformat := $FE;
          PDUspecific := $F8;
        end;
      temp := Round((iSlider4.Position + 273) * 32);
      data[0] := $FF;
      data[1] := $FF;
      data[2] := $FF;
      data[3] := $FF;
      data[4] := temp and $FF;
      data[5] := (temp shr 8)and $FF;
      data[6] := $FF;
      data[7] := $FF;
      SendCANMessage(MSG_ID, data);
    end;

    if CheckBox6.Checked then
      begin
        with MSG_ID do
          begin
            priority := 6;
            PDUformat := $FE;
            PDUspecific := $E5;
          end;
        probeg := Round((sDecimalSpinEdit3.Value * 100) / 5);
        data[0] :=  probeg and $FF;
        data[1] := (probeg shr 8)and  $FF;
        data[2] := (probeg shr 16) and $FF;
        data[3] := (probeg shr 24) and $FF;
        probeg := Round(sDecimalSpinEdit4.Value);
        data[4] :=  probeg and $FF;;
        data[5] := (probeg shr 8)and  $FF;;
        data[6] := (probeg shr 16) and $FF;;
        data[7] := (probeg shr 24) and $FF;
        SendCANMessage(MSG_ID, data);
      end;

    if CheckBox13.Checked then
      begin
        with MSG_ID do
          begin
            priority := 6;
            PDUformat := $FE;
            PDUspecific := $DC;
          end;
        probeg := Round((sDecimalSpinEdit5.Value * 100) / 5);
        data[0] := $FF;
        data[1] := $FF;
        data[2] := $FF;
        data[3] := $FF;
        data[4] :=  probeg and $FF;;
        data[5] := (probeg shr 8)and  $FF;;
        data[6] := (probeg shr 16) and $FF;;
        data[7] := (probeg shr 24) and $FF;
        SendCANMessage(MSG_ID, data);
      end;

    if CheckBox14.Checked then
      begin
        with MSG_ID do
          begin
            priority := 6;
            PDUformat := $FE;
            PDUspecific := $56;
          end;
        data[0] := Round(iSlider6.Position * 2.5);
        data[1] := $FF;
        data[2] := $FF;
        data[3] := $FF;
        data[4] := $FF;
        data[5] := $FF;
        data[6] := $FF;
        data[7] := $FF;
        SendCANMessage(MSG_ID, data);
      end;

  if CheckBox15.Checked then
    begin
      with MSG_ID do
        begin
          priority := 6;
          PDUformat := $FF;
          PDUspecific := $F0;
        end;
      data[0] := $FF;
      data[1] := $FF;
      data[2] := Round(iSlider7.Position);
      data[3] := $FF;
      data[4] := $FF;
      data[5] := $FF;
      data[6] := $FF;
      data[7] := $FF;
      SendCANMessage(MSG_ID, data);
    end;

  if CheckBox16.Checked then
    begin
      with MSG_ID do
        begin
          priority := 6;
          PDUformat := $FE;
          PDUspecific := $BD;
        end;
      data[0] := $FF;
      if RadioGroup4.ItemIndex = 0 then
        data[1] := $F9
      else
        data[1] := $F0;
      data[2] := $FF;
      data[3] := $FF;
      data[4] := $FF;
      data[5] := $FF;
      data[6] := $FF;
      data[7] := $FF;
      SendCANMessage(MSG_ID, data);
    end;

  if CheckBox17.Checked then
    begin
      with MSG_ID do
        begin
          priority := 6;
          PDUformat := $FE;
          PDUspecific := $E4;
        end;
      data[0] := $FF;
      data[1] := $FF;
      data[2] := $FF;
      if RadioGroup5.ItemIndex = 0 then
        data[3] := $FD
      else
        data[3] := $FC;
      data[4] := $FF;
      data[5] := $FF;
      data[6] := $FF;
      data[7] := $FF;
      SendCANMessage(MSG_ID, data);
    end;

  if CheckBox18.Checked then
    begin
      with MSG_ID do
        begin
          priority := 6;
          PDUformat := $FE;
          PDUspecific := $F7;
        end;
      temp := Round(iSlider8.Position * 20);
      data[0] := $FF;
      data[1] := $FF;
      data[2] := $FF;
      data[3] := $FF;
      data[4] := temp and $FF;
      data[5] := (temp shr 8)and $FF;
      data[6] := $FF;
      data[7] := $FF;
      SendCANMessage(MSG_ID, data);
    end;

  if CheckBox27.Checked then
    begin
      with MSG_ID do
        begin
          priority := 6;
          PDUformat := $FE;
          PDUspecific := $E9;
        end;
      probeg := Round(sDecimalSpinEdit7.Value * 2);
      data[0] :=  probeg and $FF;
      data[1] := (probeg shr 8)and  $FF;
      data[2] := (probeg shr 16) and $FF;
      data[3] := (probeg shr 24) and $FF;
      probeg := Round(sDecimalSpinEdit6.Value * 2);
      data[4] :=  probeg and $FF;
      data[5] := (probeg shr 8)and  $FF;
      data[6] := (probeg shr 16) and $FF;
      data[7] := (probeg shr 24) and $FF;
      SendCANMessage(MSG_ID, data);
    end;

  if CheckBox19.Checked then
    begin
      with MSG_ID do
        begin
          priority := 6;
          PDUformat := $FE;
          PDUspecific := $CA;
          case sComboBox1.ItemIndex of
            0: sourceAddr := $00;
            1: sourceAddr := $03;
          end;
        end;
      data[0] := $0;
      if CheckBox20.Checked then
        data[0] := data[0] or $40;

      if CheckBox21.Checked then
        data[0] := data[0] or $10;


      if CheckBox22.Checked then
        data[0] := data[0] or $04;

      if CheckBox23.Checked then
        data[0] := data[0] or $01;

      data[1] := $FF;
      try
        spn := StrToInt(sCurrencyEdit1.Text);
      finally

      end;
      data[2] := spn and $FF;
      spn := spn shr 8;
      data[3] := spn and $FF;
      spn := spn shr 8;
      data[4] := (spn shl 5) and $FF;

      try
        fmi := StrToInt(sCurrencyEdit2.Text);
      finally

      end;
      fmi := fmi and $1F;
      data[4] := data[4] or fmi;

      try
        data[5] := StrToInt(sCurrencyEdit3.Text);
      finally

      end;
      data[6] := $FF;
      data[7] := $FF;
      SendCANMessage(MSG_ID, data);
    end;

end;

procedure TFormMain.iThreadTimers1Timer7(Sender: TObject);
var
  MSG_ID  : CANMSG_ID;
  tempEngSpeed: Integer;
  data: CAN_DATA;
begin
  if CheckBox12.Checked then
    begin
      SetLength(data, 8);
      with MSG_ID do
      begin
        priority := 3;
        PDUformat := $FE;
        PDUspecific := $FF;
      end;
      if RadioGroup2.ItemIndex = 0 then
        data[0] := 1
      else
        data[0] := 0;
      data[1] := $FF;
      data[2] := $FF;
      data[3] := $FF;
      data[4] := $FF;
      data[5] := $FF;
      data[6] := $FF;
      data[7] := $FF;
      SendCANMessage(MSG_ID, data);
    end;
end;

procedure TFormMain.iThreadTimers1Timer8(Sender: TObject);
begin
  SaveParamToIniFiles('Time', 'TimeWork', TimeWork);
end;

procedure TFormMain.iThreadTimers1Timer9(Sender: TObject);
begin
  Inc(TimeWork);
  sTimePicker1.Time := TimeWork/86400;    //60*60*24
end;

procedure TFormMain.iTimers1Timer1(Sender: TObject);
var
  MSG_ID  : CANMSG_ID;
  tempEngSpeed: Integer;
  data: CAN_DATA;
begin
  SetLength(data, 8);
  with MSG_ID do
    begin
      priority := 3;
      PDUformat := 240;
      PDUspecific := 4;
    end;
  tempEngSpeed := EngSpeed * 8;
  data[0] := $FF;
  data[1] := $FF;
  data[2] := $FF;
  data[3] := tempEngSpeed and $FF;
  data[4] := (tempEngSpeed shr 8) and $FF;
  data[5] := $FF;
  data[6] := $FF;
  data[7] := $FF;
  SendCANMessage(MSG_ID, data);

end;

procedure TFormMain.iTimers1Timer2(Sender: TObject);
var
  MSG_ID  : CANMSG_ID;
  tempSpeed: Integer;
  data: CAN_DATA;
begin
  SetLength(data, 8);

  with MSG_ID do
    begin
      priority := 3;
      PDUformat := $FE;
      PDUspecific := $6C;
    end;
  tempSpeed := Speed * 256;
  data[0] := $FF;
  data[1] := $FF;
  data[2] := $FF;
  data[3] := $FF;
  data[4] := $FF;
  data[5] := $FF;
  data[6] := tempSpeed and $FF;
  data[7] := (tempSpeed shr 8) and $FF;
  SendCANMessage(MSG_ID, data);

end;

procedure TFormMain.Reset1Click(Sender: TObject);
begin
  sBitBtn3Click(Self);
end;

(************************************************************************
**
**    Function      : TFormMain.ShowCANMessage
**                    Private Method
**
**    Description   : Callback function for the receive thread.
**                    Must be called in a Synchronize function because
**                    here will be some GUI controls filled with data.
**    Parameter     : sCanMsg - the CAN message to show
**
**    Returnvalues  : -
**
************************************************************************)



procedure TFormMain.SaveOptions;
begin
  SaveParamToIniFiles('Time', 'TimeWork', TimeWork);
  SaveParamToIniFiles('Position', 'Speed', iKnob1.Position);
  SaveParamToIniFiles('Position', 'Tahometer', iKnob2.Position);
  SaveParamToIniFiles('Position', 'OilTemp', iKnob3.Position);
  SaveParamToIniFiles('Position', 'Brake1', iKnob5.Position);
  SaveParamToIniFiles('Position', 'Brake2', iKnob6.Position);
  SaveParamToIniFiles('Position', 'OilPress', iSlider1.Position);
  SaveParamToIniFiles('Position', 'OilLevel', iSlider2.Position);
  SaveParamToIniFiles('Position', 'OhlLevel', iSlider3.Position);
  SaveParamToIniFiles('Position', 'KppOilTemp', iSlider4.Position);
  SaveParamToIniFiles('Position', 'FuelEkonomy', iSlider5.Position);
  SaveParamToIniFiles('Position', 'CatalystLevel', iSlider6.Position);
  SaveParamToIniFiles('Position', 'UreaLevel', iSlider7.Position);
  SaveParamToIniFiles('Position', 'BatteryPotential', iSlider8.Position);

  SaveParamToIniFiles('Enabled', 'Speed', CheckBox3.Checked);
  SaveParamToIniFiles('Enabled', 'EFL', CheckBox5.Checked);
  SaveParamToIniFiles('Enabled', 'Tahometer', CheckBox1.Checked);
  SaveParamToIniFiles('Enabled', 'OilTemp', CheckBox2.Checked);
  SaveParamToIniFiles('Enabled', 'Probeg', CheckBox8.Checked);
  SaveParamToIniFiles('Enabled', 'KppOilTemp', CheckBox9.Checked);
  SaveParamToIniFiles('Enabled', 'AdBlueStatus', CheckBox4.Checked);
  SaveParamToIniFiles('Enabled', 'WFI', CheckBox12.Checked);
  SaveParamToIniFiles('Enabled', 'DP12', CheckBox7.Checked);
  SaveParamToIniFiles('Enabled', 'FuelEkonomy', CheckBox11.Checked);
  SaveParamToIniFiles('Enabled', 'EngineHours', CheckBox6.Checked);
  SaveParamToIniFiles('Enabled', 'DateTime', CheckBox10.Checked);
  SaveParamToIniFiles('Enabled', 'IdleOperation', CheckBox13.Checked);
  SaveParamToIniFiles('Enabled', 'CatalystLevel', CheckBox14.Checked);
  SaveParamToIniFiles('Enabled', 'UreaLevel', CheckBox15.Checked);
  SaveParamToIniFiles('Enabled', 'FanDriveState', CheckBox16.Checked);
  SaveParamToIniFiles('Enabled', 'StartLamp', CheckBox17.Checked);
  SaveParamToIniFiles('Enabled', 'BatteryPotential', CheckBox18.Checked);
end;

procedure TFormMain.sBitBtn1Click(Sender: TObject);
begin
  SaveOptions;
end;

procedure TFormMain.sBitBtn2Click(Sender: TObject);
begin
  TimeWork := 0;
end;

procedure TFormMain.sBitBtn3Click(Sender: TObject);
begin
  stbBottom.Panels[3].Text := 'Выполняется перезагрузка USB_to_CAN';
  Application.ProcessMessages;
  FormDestroy(self);
  FormCreate(self);
  iThreadTimers1.Enabled1 := true;
  iThreadTimers1.Enabled2 := true;
  iThreadTimers1.Enabled3 := true;
  iThreadTimers1.Enabled4 := true;
  iThreadTimers1.Enabled5 := true;
  iThreadTimers1.Enabled6 := true;
  iThreadTimers1.Enabled7 := true;
  iThreadTimers1.Enabled8 := true;
  iThreadTimers1.Enabled9 := true;
  stbBottom.Panels[3].Text := '';
  Application.ProcessMessages;
end;

procedure TFormMain.SendCANMessage(MSG_ID: CANMSG_ID; data: CAN_DATA);
var
  sMsgToSend  : CANMSG;
  hFuncResult : HResult;
  szResultText: PChar;
  i: Integer;
begin
  with MSG_ID do
    begin
      r := 0;
      dp := 0;
      //sourceAddr  := $00;
      sMsgToSend.dwMsgId := Integer(sourceAddr) or
                            (Integer(PDUspecific) shl 8) or
                            (Integer(PDUformat) shl 16)  or
                            (Integer(dp) shl 24) or
                            (Integer(r) shl 25) or
                            (Integer(priority) shl 26)
    end;
  for i := 1 to 8 do
    sMsgToSend.abData[i] := data[i-1];
  sMsgToSend.dwTime   := 0;
  sMsgToSend.uMsgInfo.bType   := CAN_MSGTYPE_DATA;
  sMsgToSend.uMsgInfo.bRes    := 0;
  sMsgToSend.uMsgInfo.bAfc    := 0;
  // DLC = 8 data bytes
  sMsgToSend.uMsgInfo.bFlags  := 8;
  // a sample to send a extended (29 bit) CAN message
  sMsgToSend.uMsgInfo.bFlags := sMsgToSend.uMsgInfo.bFlags or CAN_MSGFLAGS_EXT;

  if (m_hCanChannel <> 0) then
  begin
    hFuncResult := canChannelPostMessage(m_hCanChannel, sMsgToSend);
    szResultText := StrAlloc(255);
    vciFormatError(hFuncResult, szResultText, 255);
    lblTxResult.Caption := szResultText;
    StrDispose(szResultText);
  end
  else
    lblTxResult.Caption := 'No CAN channel open';
end;

procedure TFormMain.ShowCANMessage(sCanMsg  : CANMSG);
var
  time : Double;
begin
  // every timetick has 100 nano seconds
  time := sCanMsg.dwTime * m_dwTimerResolution + m_qwOverrunValue;

  // we want to show the time in milli seconds
  // so divide with 10.000
  time := time / 10000 / 1000;

  // show the time stamp in the edit field
  lblMsgData.Caption := FloatToStr(time);

  // check what kind of CAN message
  if (sCanMsg.uMsgInfo.bType = CAN_MSGTYPE_DATA)
    then ShowDataFrame(sCanMsg)
  else if (sCanMsg.uMsgInfo.bType = CAN_MSGTYPE_INFO)
    then ShowInfoFrame(sCanMsg)
  else if (sCanMsg.uMsgInfo.bType = CAN_MSGTYPE_ERROR)
    then ShowErrorFrame(sCanMsg)
  else if (sCanMsg.uMsgInfo.bType = CAN_MSGTYPE_STATUS)
    then ShowStatusFrame(sCanMsg)
  else if (sCanMsg.uMsgInfo.bType = CAN_MSGTYPE_WAKEUP)
    then ShowWakeUpFrame(sCanMsg)
  else if (sCanMsg.uMsgInfo.bType = CAN_MSGTYPE_TIMEOVR)
    then HandleTimerOverrunFrame(sCanMsg)
  else if (sCanMsg.uMsgInfo.bType = CAN_MSGTYPE_TIMERST)
    then HandleTimerResetFrame(sCanMsg);
end;

(************************************************************************
**
**    Function      : TFormMain.ShowDataFrame
**                    Private Method
**
**    Description   : Show the data of a normal CAN dataframe.
**                    Check the CAN mode and if it is a remote request.
**    Parameter     : sCanMsg - the CAN message to show
**
**    Returnvalues  : -
**
************************************************************************)
procedure TFormMain.ShowDataFrame(sCanMsg  : CANMSG);
var
  i    : longint;
  dlc  : Byte;
  data : String;
begin

  if (sCanMsg.uMsgInfo.bFlags and CAN_MSGFLAGS_EXT = CAN_MSGFLAGS_EXT)
    then lblMsgData.Caption := lblMsgData.Caption + ' Extended '
    else lblMsgData.Caption := lblMsgData.Caption + ' Standard ';

  lblMsgData.Caption := lblMsgData.Caption + ' ID:' + IntToHex(sCanMsg.dwMsgId, 2);
  data := '';
  dlc := sCanMsg.uMsgInfo.bFlags and CAN_MSGFLAGS_DLC;
  if (sCanMsg.uMsgInfo.bFlags and CAN_MSGFLAGS_RTR = CAN_MSGFLAGS_RTR) then
  begin
    // it's a remote request frame
    lblLastRxMsgType.Caption  := 'Remote frame';
    lblMsgData.Caption := lblMsgData.Caption + ' RTR Length: ' + IntToStr(dlc);
  end else
  begin
    lblLastRxMsgType.Caption  := 'Data Frame';
    lblMsgData.Caption := lblMsgData.Caption + 'h Data(hex): ';
    // it's a normal frame with data
    for i := 1 to dlc do
      data := data + IntToHex(sCanMsg.abData[i], 2) + ' ';
    lblMsgData.Caption := lblMsgData.Caption + ' ' + data;
  end;
end;

(************************************************************************
**
**    Function      : TFormMain.ShowInfoFrame
**                    Private Method
**
**    Description   : Show a information frame.
**    Parameter     : sCanMsg - the CAN message to show
**
**    Returnvalues  : -
**
************************************************************************)
procedure TFormMain.ShowInfoFrame(sCanMsg  : CANMSG);
begin
  lblLastRxMsgType.Caption  := 'Info Frame';
  case sCanMsg.abData[1] of
   CAN_INFO_START:  // start of CAN controller
     lblMsgData.Caption := 'Start Controller';
   CAN_INFO_STOP:   // stop of CAN controller
     lblMsgData.Caption := 'Stop Controller';
   CAN_INFO_RESET:  // reset of CAN controller
     lblMsgData.Caption := 'Reset Controller';
  end;
end;

(************************************************************************
**
**    Function      : TFormMain.ShowErrorFrame
**                    Private Method
**
**    Description   : Show a error frame.
**    Parameter     : sCanMsg - the CAN message to show
**
**    Returnvalues  : -
**
************************************************************************)
procedure TFormMain.ShowErrorFrame(sCanMsg  : CANMSG);
begin
  lblLastRxMsgType.Caption  :=  'Error Frame';
  case sCanMsg.abData[1] of
    CAN_ERROR_STUFF: // stuff error
      lblMsgData.Caption := 'Stuff Error';
    CAN_ERROR_FORM:  // form error
      lblMsgData.Caption := 'Form Error';
    CAN_ERROR_ACK:   // acknowledgment error
      lblMsgData.Caption := 'Acknowledgment Error';
    CAN_ERROR_BIT:   // bit error
      lblMsgData.Caption := 'Bit Error';
    CAN_ERROR_CRC:   // CRC error
      lblMsgData.Caption := 'CRC Error';
    CAN_ERROR_OTHER: // other (unspecified) error
      lblMsgData.Caption := 'Other Error';
    else
      lblMsgData.Caption := 'Unknown Error';
  end;
end;

(************************************************************************
**
**    Function      : TFormMain.ShowStatusFrame
**                    Private Method
**
**    Description   : Show a status frame.
**    Parameter     : sCanMsg - the CAN message to show
**
**    Returnvalues  : -
**
************************************************************************)
procedure TFormMain.ShowStatusFrame(sCanMsg  : CANMSG);
begin
  lblLastRxMsgType.Caption  :=  'Status Frame';
  lblMsgData.Caption        :=  'Data byte 1: ' + IntToHex(sCanMsg.abData[1],2 );
end;

(************************************************************************
**
**    Function      : TFormMain.ShowWakeUpFrame
**                    Private Method
**
**    Description   : Show a wakeup frame.
**    Parameter     : sCanMsg - the CAN message to show
**
**    Returnvalues  : -
**
************************************************************************)
procedure TFormMain.ShowWakeUpFrame(sCanMsg  : CANMSG);
begin
  lblLastRxMsgType.Caption  :=  'WakeUp Frame';
end;

procedure TFormMain.Timer50_msTimer(Sender: TObject);
var
  MSG_ID  : CANMSG_ID;
  tempSpeed: Integer;
  tempEngSpeed: Integer;
  data: CAN_DATA;
begin
  SetLength(data, 8);

  with MSG_ID do
    begin
      priority := 3;
      PDUformat := $FE;
      PDUspecific := $6C;
    end;
  tempSpeed := Speed * 256;
  data[1] := $FF;
  data[2] := $FF;
  data[3] := $FF;
  data[4] := $FF;
  data[5] := $FF;
  data[6] := $FF;
  data[7] := tempSpeed and $FF;
  data[8] := (tempSpeed shr 8) and $FF;
  SendCANMessage(MSG_ID, data);

  {
  unsigned int engSpeed = 0;
        if (this->EngSpeed->Text!="")
                engSpeed = (unsigned int)(StrToFloat(this->EngSpeed->Text)/0.125f);
        msg.priority = 3;
        msg.PDUformat = 240;
        msg.PDUspecific = 4;
        msg.dataLen = 8;
        msg.data[0] = 0xFF;
        msg.data[1] = 0xFF;
        msg.data[2] = 0xFF;
        msg.data[3] =  engSpeed    &0xFF;
        msg.data[4] = (engSpeed>>8)&0xFF;
        msg.data[5] = 0xFF;
        msg.data[6] = 0xFF;
        msg.data[7] = 0xFF;}
  with MSG_ID do
    begin
      priority := 3;
      PDUformat := 240;
      PDUspecific := 4;
    end;
  tempEngSpeed := EngSpeed * 8;
  data[1] := $FF;
  data[2] := $FF;
  data[3] := $FF;
  data[4] := tempEngSpeed and $FF;
  data[5] := (tempEngSpeed shr 8) and $FF;
  data[6] := $FF;
  data[7] := $FF;
  data[8] := $FF;
  SendCANMessage(MSG_ID, data);
end;

(************************************************************************
**
**    Function      : TFormMain.HandleTimerOverrunFrame
**                    Private Method
**
**    Description   : Show and handle a timeoverrun frame.
**    Parameter     : sCanMsg - the CAN message to use
**
**    Returnvalues  : -
**
************************************************************************)
procedure TFormMain.HandleTimerOverrunFrame(sCanMsg  : CANMSG);
begin
  lblLastRxMsgType.Caption  :=  'Timer Overrun';
  m_dwTimerOverruns := m_dwTimerOverruns + sCanMsg.dwMsgId;
  // the overruns can be set to the upper 32 bits of the int64
  m_qwOverrunValue := Int64(m_dwTimerOverruns) shl 32;
end;

(************************************************************************
**
**    Function      : TFormMain.HandleTimerResetFrame
**                    Private Method
**
**    Description   : Show and handle a timerreset frame.
**    Parameter     : sCanMsg - the CAN message to use
**
**    Returnvalues  : -
**
************************************************************************)
procedure TFormMain.HandleTimerResetFrame(sCanMsg  : CANMSG);
begin
  lblLastRxMsgType.Caption  :=  'Timer Reset';
  m_dwTimerOverruns := 0;
  m_qwOverrunValue  := 0;
end;

procedure TFormMain.iKnob1PositionChange(Sender: TObject);
begin
  iAnalogDisplay1.Value := iKnob1.Position;
  Speed := Round(iKnob1.Position);
end;

procedure TFormMain.iKnob2PositionChange(Sender: TObject);
begin
  EngSpeed := Round(iKnob2.Position*100);
  iAnalogDisplay2.Value := EngSpeed;
end;

procedure TFormMain.iKnob3PositionChange(Sender: TObject);
begin
  CoolantTemp := Round(iKnob3.Position) + 40;
end;

(************************************************************************
**
**    Function      : TFormMain.TimerUpdateInfoTimer
**                    Delphi Message Handler
**
**    Description   : Called periodically from the timer and show the
**                    current CAN controller state in some symbolize LEDs
**    Parameter     : sender - the calling object
**
**    Returnvalues  : -
**
************************************************************************)
procedure TFormMain.tmrUpdateInfoTimer(Sender: TObject);
var
  hFuncResult : HResult;
  pStatus : CANLINESTATUS;
  fIsDataAvailable : boolean;
begin
  fIsDataAvailable := false;
  if (m_hCanControl <> 0) then
  begin
    hFuncResult := canControlGetStatus(m_hCanControl, pStatus);
    if (hFuncResult = VCI_OK) then
    begin
      fIsDataAvailable := true;
      if (pStatus.dwStatus and CAN_STATUS_ININIT = CAN_STATUS_ININIT)
        then shaCtrlInit.Brush.Color := clRed
        else shaCtrlInit.Brush.Color := clLime;

      if (pStatus.dwStatus and CAN_STATUS_TXPEND = CAN_STATUS_TXPEND)
        then shaTxPending.Brush.Color := clRed
        else shaTxPending.Brush.Color := clLime;

      if (pStatus.dwStatus and CAN_STATUS_OVRRUN = CAN_STATUS_OVRRUN)
        then shaDataOverrun.Brush.Color := clRed
        else shaDataOverrun.Brush.Color := clLime;

      if (pStatus.dwStatus and CAN_STATUS_ERRLIM = CAN_STATUS_ERRLIM)
        then shaWarningLevel.Brush.Color := clRed
        else shaWarningLevel.Brush.Color := clLime;

      if (pStatus.dwStatus and CAN_STATUS_BUSOFF = CAN_STATUS_BUSOFF)
        then shaBusOff.Brush.Color := clRed
        else shaBusOff.Brush.Color := clLime;
    end;
  end;

  if (not fIsDataAvailable) then
  begin
    shaCtrlInit.Brush.Color     := clBtnFace;
    shaTxPending.Brush.Color    := clBtnFace;
    shaDataOverrun.Brush.Color  := clBtnFace;
    shaWarningLevel.Brush.Color := clBtnFace;
    shaBusOff.Brush.Color       := clBtnFace;
  end;
end;

(************************************************************************
**
**    Function      : TFormMain.ButtonTransmitClick
**                    Delphi Message Handler
**
**    Description   : Called when the user press the Transmit ID button.
**                    Following CAN message will be send one time:
**                    ID=100, frame format = standard,
**                    Data = 1 2 3 4 5 6 7 8
**    Parameter     : sender - the calling object
**
**    Returnvalues  : -
**
************************************************************************)
procedure TFormMain.Abaut1Click(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

procedure TFormMain.btnTransmitClick(Sender: TObject);
var
  hFuncResult : HResult;
  sMsgToSend  : CANMSG;
  sIdMsg      : CANMSG_ID;
  iData       : integer;
  szResultText: PChar;
begin
  with sIdMsg do
    begin
      priority := 3;
      r := 0;
      dp := 0;
      PDUformat := 40;
      PDUspecific := 128;
      sourceAddr  := 0;
      sMsgToSend.dwMsgId := Integer(sourceAddr) or
                            (Integer(PDUspecific) shl 8) or
                            (Integer(PDUformat) shl 16)  or
                            (Integer(dp) shl 24) or
                            (Integer(r) shl 25) or
                            (Integer(priority) shl 26)
    end;
  for iData := 1 to 8 do
    sMsgToSend.abData[iData] := iData;

  sMsgToSend.dwTime   := 0;
  sMsgToSend.uMsgInfo.bType   := CAN_MSGTYPE_DATA;
  sMsgToSend.uMsgInfo.bRes    := 0;
  sMsgToSend.uMsgInfo.bAfc    := 0;
  // DLC = 8 data bytes
  sMsgToSend.uMsgInfo.bFlags  := 8;
  // add the self reception flag
  //sMsgToSend.uMsgInfo.bFlags    := sMsgToSend.uMsgInfo.bFlags or CAN_MSGFLAGS_SRR;
  // a sample to send a extended (29 bit) CAN message
   sMsgToSend.uMsgInfo.bFlags := sMsgToSend.uMsgInfo.bFlags or CAN_MSGFLAGS_EXT;

  if (m_hCanChannel <> 0) then
  begin
    hFuncResult := canChannelPostMessage(m_hCanChannel, sMsgToSend);
    szResultText := StrAlloc(255);
    vciFormatError(hFuncResult, szResultText, 255);
    lblTxResult.Caption := szResultText;
    StrDispose(szResultText);
  end
  else
    lblTxResult.Caption := 'No CAN channel open';
end;

(************************************************************************
**
**    Function      : TFormMain.ShowErrorMessage
**                    Private Method
**
**    Description   : Show messagebox with the error text
**    Parameter     : errorText   - additiobnal error text
**                    hFuncResult - a HResult to get the error text from
**                                  the VCI
**
**    Returnvalues  : -
**
************************************************************************)
procedure TFormMain.ShowErrorMessage(errorText : string; hFuncResult : HResult);
var
  szErrorText  : PChar;
begin
   if (hFuncResult <> 0) then
   begin
     szErrorText := StrAlloc(255);
     vciFormatError(hFuncResult, szErrorText, 255);
     ShowMessage(errorText + ' : ' + szErrorText);
     StrDispose(szErrorText);
   end
   else
     ShowMessage(errorText);
end;


end.
