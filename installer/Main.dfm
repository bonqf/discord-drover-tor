object frmMain: TfrmMain
  Left = 0
  Top = 0
  Margins.Left = 6
  Margins.Top = 6
  Margins.Right = 6
  Margins.Bottom = 6
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Discord Drover'
  ClientHeight = 500
  ClientWidth = 520
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -24
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 192
  TextHeight = 32
  object lTorPath: TLabel
    Left = 20
    Top = 30
    Width = 190
    Height = 32
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Execut'#225'vel do Tor:'
  end
  object lTorTip: TLabel
    Left = 20
    Top = 135
    Width = 480
    Height = 220
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    AutoSize = False
    Caption =
      'Dica: Basta instalar o Tor Browser. O caminho padr'#227'o '#233':'#13#10'C:\User' +
      's\User\Desktop\Tor Browser\Browser\TorBrowser\Tor\tor.exe'#13#10#13#10'O Dr' +
      'over usa SOCKS5 local (127.0.0.1:9050 / 9150) automaticamente.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGrayText
    Font.Height = -18
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object eTorPath: TEdit
    Left = 20
    Top = 75
    Width = 370
    Height = 40
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    TabOrder = 0
  end
  object btnBrowseTor: TButton
    Left = 400
    Top = 75
    Width = 100
    Height = 40
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Buscar...'
    TabOrder = 1
    OnClick = btnBrowseTorClick
  end
  object btnInstall: TButton
    Left = 20
    Top = 420
    Width = 230
    Height = 50
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Install'
    TabOrder = 2
    OnClick = btnInstallClick
  end
  object btnUninstall: TButton
    Left = 270
    Top = 390
    Width = 230
    Height = 50
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Uninstall'
    TabOrder = 3
    OnClick = btnUninstallClick
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
