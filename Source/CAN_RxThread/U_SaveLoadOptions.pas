unit U_SaveLoadOptions;

interface

uses IniFiles, Variants;

const
  IniFileName = 'options.ini';

type
  ROptionIni = record
    section :  string;
    key     :  string;
    value   : Variant;
  end;

  TOptionsIni = record
    options : array of ROptionIni;
    procedure AddOption(section, key: string; value: Variant);
    procedure SaveOptions;
    procedure Clear;
  end;

procedure SaveParamToIniFiles(section, key: string; value: Variant);
function LoadParamFromIniFiles(section, key: string; VarT: TVarType): Variant;

implementation

uses U_my;

//********* SaveParamToIniFiles ******************************
//��������� ����������� ��������� � ini ����
// se�tion - �������� ������ (string)
// key     - �������� ��������� ���� (string)
// value - ��� ����������� ������:
//    varInteger - ������������� ������
//    varDouble  - ������� �����
//    varDate    - ��� ���
//    varBoolean - ����� ���
//    varString  - ��������� ���
procedure SaveParamToIniFiles(section, key: string; value: Variant);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(ApplicationFilePath + IniFileName);
  case VarType(value) of
    varInteger: Ini.WriteInteger(section, key, value); //�������� ���� Integer
    varDouble : Ini.WriteFloat(section, key, value);   //�������� ���� Double
    varDate   : Ini.WriteDateTime(section, key, value);
    varBoolean: Ini.WriteBool(section, key, value);
    varString : Ini.WriteString(section, key, value);
  end;
  Ini.UpdateFile;
  Ini.Free;
end;

//********* LoadParamFromIniFiles *****************************
// ��������� �������� ���������� �� ini �����
// se�tion - �������� ������ (string)
// key     - �������� ��������� ���� (string)
function LoadParamFromIniFiles(section, key: string; VarT: TVarType): Variant;
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(ApplicationFilePath + IniFileName);
  case VarT of
    varInteger: Result := Ini.ReadInteger(section, key, 0); //�������� ���� Integer
    varDouble : Result := Ini.ReadFloat(section, key, 0);   //�������� ���� Double
    varDate   : Result := Ini.ReadDateTime(section, key, 0);
    varBoolean: Result := Ini.ReadBool(section, key, false);
    varString : Result := Ini.ReadString(section, key, '');
  end;
  Ini.UpdateFile;
  Ini.Free;
end;

{ TOptionsIni }

procedure TOptionsIni.AddOption(section, key: string; value: Variant);
var
  option: ROptionIni;
begin
  option.section := section;
  option.key := key;
  option.value := value;
  SetLength(options, High(options)+2);
  options[High(options)] := option;
end;

procedure TOptionsIni.Clear;
begin
  options := nil;  
end;

procedure TOptionsIni.SaveOptions;
var
  Ini: TIniFile;
  i: Integer;
begin
  Ini := TIniFile.Create(ApplicationFilePath + IniFileName);
  for i := 0 to High(options) do
    begin
      case VarType(options[i].value) of
        varInteger: Ini.WriteInteger(options[i].section, options[i].key, options[i].value); //�������� ���� Integer
        varDouble : Ini.WriteFloat(options[i].section, options[i].key, options[i].value);   //�������� ���� Double
        varDate   : Ini.WriteDateTime(options[i].section, options[i].key, options[i].value);
        varBoolean: Ini.WriteBool(options[i].section, options[i].key, options[i].value);
        varString : Ini.WriteString(options[i].section, options[i].key, options[i].value);
      end;
    end;
  Ini.UpdateFile;
  Ini.Free;
end;

end.
