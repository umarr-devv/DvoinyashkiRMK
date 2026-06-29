[Setup]
AppName=Двойняшки РМК 
AppVersion=1.13.0
DefaultDirName={pf}\dvoinyashki_rmk
DefaultGroupName=dvoinyashki_rmk
OutputBaseFilename=РМК 1.13.0
Compression=lzma
SolidCompression=yes
UninstallDisplayName=РМК Удаление
ArchitecturesInstallIn64BitMode=x64

[Files]
Source: "build\windows\x64\runner\Release\*"; DestDir: "{app}"; Flags: recursesubdirs

[Icons]
Name: "{group}\Двойняшки РМК"; Filename: "{app}\app.exe"

[Run]
Filename: "{app}\app.exe"; 