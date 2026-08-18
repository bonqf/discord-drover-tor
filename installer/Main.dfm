object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Discord Drover'
  ClientHeight = 250
  ClientWidth = 260
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object lTorPath: TLabel
    Left = 10
    Top = 15
    Width = 95
    Height = 15
    Caption = 'Execut'#225'vel do Tor:'
  end
  object lTorTip: TLabel
    Left = 10
    Top = 68
    Width = 240
    Height = 77
    AutoSize = False
    Caption = 
      'Dica: Basta instalar o Tor Browser. O caminho padr'#227'o '#233':'#13#10'C:\User' +
      's\User\Desktop\Tor Browser\Browser\TorBrowser\Tor\tor.exe'#13#10#13#10'O D' +
      'rover usa SOCKS5 local (127.0.0.1:9050 / 9150) automaticamente.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGrayText
    Font.Height = -9
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object eTorPath: TEdit
    Left = 10
    Top = 38
    Width = 185
    Height = 23
    TabOrder = 0
  end
  object btnBrowseTor: TButton
    Left = 200
    Top = 38
    Width = 50
    Height = 20
    Caption = 'Buscar...'
    TabOrder = 1
    OnClick = btnBrowseTorClick
  end
  object btnInstall: TButton
    Left = 10
    Top = 210
    Width = 115
    Height = 25
    Caption = 'Install'
    TabOrder = 3
    OnClick = btnInstallClick
  end
  object btnUninstall: TButton
    Left = 137
    Top = 210
    Width = 115
    Height = 25
    Caption = 'Uninstall'
    TabOrder = 4
    OnClick = btnUninstallClick
  end
  object cbAutoStartTor: TCheckBox
    Left = 8
    Top = 151
    Width = 244
    Height = 18
    Caption = 'Start Tor in the Background'
    TabOrder = 2
    OnClick = cbAutoStartTorClick
  end
  object MainMenu: TMainMenu
    Left = 432
    Top = 16
    object miAbout: TMenuItem
      Caption = 'View on GitHub'
      OnClick = miAboutClick
    end
  end
  object OpenDialogTor: TOpenDialog
    DefaultExt = 'exe'
    Filter = 'Execut'#225'vel Tor (tor.exe)|tor.exe|Todos os arquivos (*.*)|*.*'
    Title = 'Selecione o execut'#225'vel do Tor'
    Left = 432
    Top = 80
  end
end
