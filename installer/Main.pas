unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.Win.Registry, System.RegularExpressions,
  System.IOUtils, Options, TlHelp32, Vcl.Menus, ShellApi, DiscordFolders;

type
  TVersion = array [0 .. 3] of integer;

  TfrmMain = class(TForm)
    lTorPath: TLabel;
    lTorTip: TLabel;
    eTorPath: TEdit;
    btnBrowseTor: TButton;
    btnInstall: TButton;
    btnUninstall: TButton;
    MainMenu: TMainMenu;
    miAbout: TMenuItem;
    OpenDialogTor: TOpenDialog;
    cbAutoStartTor: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnInstallClick(Sender: TObject);
    procedure btnUninstallClick(Sender: TObject);
    procedure miAboutClick(Sender: TObject);
    procedure btnBrowseTorClick(Sender: TObject);
    procedure cbAutoStartTorClick(Sender: TObject);
  private
    currentProcessDir: string;
    messageCaption: PChar;

    function FindMostSuitableOptionsPath: string;
    procedure FindDiscordBaseDirs(list: TStringList);
    procedure FindDiscordDirs(list: TStringList);
    function GetNewestDiscordDir(list: TStringList): string;
    function IsDiscordRunning: boolean;
    function ShowDiscordRunningMessage: boolean;
    function SuggestDefaultTorPath: string;
    procedure LaunchTorHidden(const exePath: string);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

function TfrmMain.SuggestDefaultTorPath: string;
var
  desktopTor, standardTor: string;
begin
  desktopTor := 'C:\Users\User\Desktop\Tor Browser\Browser\TorBrowser\Tor\tor.exe';
  standardTor := 'C:\Tor Browser\Browser\TorBrowser\Tor\tor.exe';

  if FileExists(desktopTor) then
    exit(desktopTor);
  if FileExists(standardTor) then
    exit(standardTor);

  result := desktopTor;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  optPath: string;
  opt: TDroverOptions;
begin
  messageCaption := PChar(Application.Title);
  currentProcessDir := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));

  optPath := FindMostSuitableOptionsPath;

  if optPath <> '' then
  begin
    opt := LoadOptions(optPath);
    if Trim(opt.torExecutable) <> '' then
      eTorPath.Text := opt.torExecutable
    else
      eTorPath.Text := SuggestDefaultTorPath;
    cbAutoStartTor.Checked := opt.autoStartTor;
  end
  else
  begin
    eTorPath.Text := SuggestDefaultTorPath;
    cbAutoStartTor.Checked := false;
  end;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  self.ActiveControl := btnInstall;
end;

procedure TfrmMain.cbAutoStartTorClick(Sender: TObject);
begin
  // sem ação necessária — o estado é lido em btnInstallClick
end;

procedure TfrmMain.btnBrowseTorClick(Sender: TObject);
begin
  if Trim(eTorPath.Text) <> '' then
  begin
    if DirectoryExists(ExtractFileDir(eTorPath.Text)) then
      OpenDialogTor.InitialDir := ExtractFileDir(eTorPath.Text);
    OpenDialogTor.FileName := ExtractFileName(eTorPath.Text);
  end;

  if OpenDialogTor.Execute then
    eTorPath.Text := OpenDialogTor.FileName;
end;

procedure TfrmMain.miAboutClick(Sender: TObject);
begin
  ShellExecute(0, 'open', 'https://github.com/bonqf/discord-drover-tor', nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmMain.btnInstallClick(Sender: TObject);
var
  dirs, errors: TStringList;
  dir, dllPath, filename, srcPath, dstPath, s: string;
  TaskDialog: TTaskDialog;
  opt: TDroverOptions;
  extraFilenames: TArray<string>;
begin
  dllPath := currentProcessDir + DLL_FILENAME;
  if not FileExists(dllPath) then
  begin
    Application.MessageBox(PChar(Format('The file ''%s'' is missing.', [DLL_FILENAME])), messageCaption, MB_ICONERROR);
    exit;
  end;

  opt.proxy := 'socks5://127.0.0.1:9050';
  opt.torExecutable := Trim(eTorPath.Text);
  opt.autoStartTor := cbAutoStartTor.Checked;

  if (opt.torExecutable <> '') and not FileExists(opt.torExecutable) then
  begin
    if Application.MessageBox(
      'O executável do Tor especificado não foi encontrado. Deseja continuar mesmo assim?',
      messageCaption, MB_ICONWARNING or MB_YESNO) <> IDYES then
      exit;
  end;

  if ShowDiscordRunningMessage then
    exit;

  dirs := TStringList.Create;
  errors := TStringList.Create;
  try
    FindDiscordDirs(dirs);
    if dirs.Count = 0 then
    begin
      Application.MessageBox('The Discord folder was not found.', messageCaption, MB_ICONERROR);
      exit;
    end;

    s := currentProcessDir + OPTIONS_FILENAME;
    if not SaveOptions(s, opt) then
      errors.Add(s);

    extraFilenames := GetExtraFilenames(currentProcessDir, false);

    for dir in dirs do
    begin
      s := dir + OPTIONS_FILENAME;
      if not SaveOptions(s, opt) then
        errors.Add(s);

      s := dir + DLL_FILENAME;
      if not SameText(dllPath, s) and not CopyFile(PChar(dllPath), PChar(s), false) then
        errors.Add(s);

      for filename in extraFilenames do
      begin
        srcPath := currentProcessDir + filename;
        dstPath := dir + filename;
        if FileExists(srcPath) and not SameText(srcPath, dstPath) and not CopyFile(PChar(srcPath), PChar(dstPath), false)
        then
          errors.Add(dstPath);
      end;
    end;

    if errors.Count > 0 then
    begin
      TaskDialog := TTaskDialog.Create(nil);
      try
        TaskDialog.Caption := messageCaption;
        TaskDialog.Title := 'Installation error';
        TaskDialog.Text := 'Some files could not be written.';
        TaskDialog.ExpandedText := Trim(errors.Text);
        TaskDialog.CommonButtons := [tcbClose];
        TaskDialog.Flags := [tfExpandFooterArea];
        TaskDialog.MainIcon := tdiError;
        TaskDialog.Execute;
      finally
        TaskDialog.Free;
      end;
    end
    else
    begin
      if cbAutoStartTor.Checked and FileExists(opt.torExecutable) then
        LaunchTorHidden(opt.torExecutable);
      Application.MessageBox('Installation complete!', messageCaption, MB_ICONINFORMATION);
    end;
  finally
    dirs.Free;
    errors.Free;
  end;
end;

procedure TfrmMain.btnUninstallClick(Sender: TObject);
var
  dirs, errors: TStringList;
  dir, filename, s: string;
  TaskDialog: TTaskDialog;
  extraFilenames: TArray<string>;
begin
  if ShowDiscordRunningMessage then
    exit;

  dirs := TStringList.Create;
  errors := TStringList.Create;
  try
    FindDiscordDirs(dirs);
    if dirs.Count = 0 then
    begin
      Application.MessageBox('The Discord folder was not found.', messageCaption, MB_ICONERROR);
      exit;
    end;

    extraFilenames := GetExtraFilenames(currentProcessDir, true);

    for dir in dirs do
    begin
      s := dir + DLL_FILENAME;
      if FileExists(s) and not DeleteFile(s) then
        errors.Add(s);

      s := dir + OPTIONS_FILENAME;
      if FileExists(s) and not DeleteFile(s) then
        errors.Add(s);

      for filename in extraFilenames do
      begin
        s := dir + filename;
        if FileExists(s) and not DeleteFile(s) then
          errors.Add(s);
      end;
    end;

    if errors.Count > 0 then
    begin
      TaskDialog := TTaskDialog.Create(nil);
      try
        TaskDialog.Caption := messageCaption;
        TaskDialog.Title := 'Uninstall error';
        TaskDialog.Text := 'Some files could not be deleted.';
        TaskDialog.ExpandedText := Trim(errors.Text);
        TaskDialog.CommonButtons := [tcbClose];
        TaskDialog.Flags := [tfExpandFooterArea];
        TaskDialog.MainIcon := tdiError;
        TaskDialog.Execute;
      finally
        TaskDialog.Free;
      end;
    end
    else
    begin
      Application.MessageBox('Uninstall complete!', messageCaption, MB_ICONINFORMATION);
    end;
  finally
    dirs.Free;
    errors.Free;
  end;
end;

function TfrmMain.FindMostSuitableOptionsPath: string;
var
  dirs: TStringList;
  s, dir: string;
begin
  dirs := TStringList.Create;
  try
    FindDiscordDirs(dirs);
    dir := GetNewestDiscordDir(dirs);
  finally
    dirs.Free;
  end;

  if dir <> '' then
  begin
    s := dir + OPTIONS_FILENAME;
    if FileExists(s) then
      exit(s);
  end;

  s := currentProcessDir + OPTIONS_FILENAME;
  if FileExists(s) then
    exit(s);

  result := '';
end;

procedure TfrmMain.FindDiscordBaseDirs(list: TStringList);
var
  reg: TRegistry;
  match: TMatch;
  s, app: string;
const
  APPS: array [0 .. 2] of string = ('Discord', 'DiscordCanary', 'DiscordPTB');
begin
  list.Clear;
  list.Sorted := true;
  list.Duplicates := dupIgnore;
  list.CaseSensitive := false;

  reg := TRegistry.Create(KEY_QUERY_VALUE);
  try
    reg.RootKey := HKEY_CURRENT_USER;

    for app in APPS do
    begin
      if reg.OpenKeyReadOnly('Software\Microsoft\Windows\CurrentVersion\Uninstall\' + app) then
      begin
        if reg.ValueExists('InstallLocation') then
        begin
          s := reg.ReadString('InstallLocation');
          if s <> '' then
          begin
            s := IncludeTrailingPathDelimiter(s);
            if DirectoryExists(s) then
              list.Add(s);
          end;
        end;
        reg.CloseKey;
      end;
    end;

    if reg.OpenKeyReadOnly('Software\Classes\Discord\shell\open\command') then
    begin
      if reg.ValueExists('') then
      begin
        s := reg.ReadString('');
        if s <> '' then
        begin
          match := TRegEx.match(s, '\A"(.+\\)app-');
          if match.Success then
          begin
            s := match.Groups[1].Value;
            if DirectoryExists(s) then
              list.Add(s);
          end;
        end;
      end;
      reg.CloseKey;
    end;
  finally
    reg.Free;
  end;
end;

procedure TfrmMain.FindDiscordDirs(list: TStringList);
var
  baseDirs: TStringList;
  subfolders: TArray<string>;
  s, subfolder, baseDir: string;
begin
  baseDirs := TStringList.Create;
  try
    FindDiscordBaseDirs(baseDirs);
    for baseDir in baseDirs do
    begin
      if TDirectory.Exists(baseDir) then
      begin
        subfolders := TDirectory.GetDirectories(baseDir, 'app-*', TSearchOption.soTopDirectoryOnly);
        for subfolder in subfolders do
        begin
          s := IncludeTrailingPathDelimiter(subfolder);
          if DirHasDiscordExecutable(s) then
            list.Add(s);
        end;
      end;
    end;
  finally
    baseDirs.Free;
  end;
end;

function TfrmMain.GetNewestDiscordDir(list: TStringList): string;
var
  i, partsLen: integer;
  dir: string;
  match: TMatch;
  maxVer, curVer: TVersion;
  parts: TArray<string>;
begin
  if list.Count = 0 then
    exit('');

  result := list[0];
  maxVer := Default(TVersion);

  for dir in list do
  begin
    match := TRegEx.match(dir, 'app-([\d.]+)');
    if not match.Success then
      continue;
    parts := match.Groups[1].Value.Split(['.']);
    partsLen := Length(parts);
    for i := 0 to High(curVer) do
    begin
      if i < partsLen then
        curVer[i] := StrToIntDef(parts[i], 0)
      else
        curVer[i] := 0;
    end;

    for i := 0 to High(curVer) do
    begin
      if curVer[i] <> maxVer[i] then
      begin
        if curVer[i] > maxVer[i] then
        begin
          maxVer := curVer;
          result := dir;
        end;
        break;
      end;
    end;
  end;
end;

procedure TfrmMain.LaunchTorHidden(const exePath: string);
var
  si: TStartupInfo;
  pi: TProcessInformation;
  cmd: string;
begin
  ZeroMemory(@si, SizeOf(si));
  si.cb := SizeOf(si);
  si.dwFlags := STARTF_USESHOWWINDOW;
  si.wShowWindow := SW_HIDE;

  ZeroMemory(@pi, SizeOf(pi));

  cmd := '"' + exePath + '"';
  if CreateProcess(nil, PChar(cmd), nil, nil, false,
    CREATE_NO_WINDOW, nil,
    PChar(ExtractFileDir(exePath)), si, pi) then
  begin
    CloseHandle(pi.hThread);
    CloseHandle(pi.hProcess);
  end;
end;

function TfrmMain.IsDiscordRunning: boolean;
var
  snapshot: THandle;
  pe: TProcessEntry32;
begin
  result := false;

  snapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if snapshot = INVALID_HANDLE_VALUE then
    exit;

  try
    pe.dwSize := SizeOf(TProcessEntry32);
    if Process32First(snapshot, pe) then
    begin
      repeat
        if IsDiscordExecutable(pe.szExeFile) then
          exit(true);
      until not Process32Next(snapshot, pe);
    end;
  finally
    CloseHandle(snapshot);
  end;
end;

function TfrmMain.ShowDiscordRunningMessage: boolean;
begin
  result := false;

  if IsDiscordRunning then
  begin
    Application.MessageBox('Discord is running. Please close it before continuing.', messageCaption,
      MB_ICONWARNING or MB_OK);
    exit(true);
  end;
end;

end.
