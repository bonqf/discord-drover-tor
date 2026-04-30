unit DiscordFolders;

interface

uses
  System.SysUtils;

const
  DISCORD_FILENAME_MAIN = 'Discord.exe';
  DISCORD_FILENAME_CANARY = 'DiscordCanary.exe';
  DISCORD_FILENAME_PTB = 'DiscordPTB.exe';
  DISCORD_FILENAMES: array [0 .. 2] of string = (DISCORD_FILENAME_MAIN, DISCORD_FILENAME_CANARY, DISCORD_FILENAME_PTB);

function IsDiscordExecutable(filename: string): boolean;
function DirHasDiscordExecutable(dir: string): boolean;

implementation

function IsDiscordExecutable(filename: string): boolean;
var
  s: string;
begin
  for s in DISCORD_FILENAMES do
  begin
    if SameText(s, filename) then
      exit(true);
  end;

  result := false;
end;

function DirHasDiscordExecutable(dir: string): boolean;
var
  s: string;
begin
  for s in DISCORD_FILENAMES do
  begin
    if FileExists(dir + s) then
      exit(true);
  end;

  result := false;
end;

end.
