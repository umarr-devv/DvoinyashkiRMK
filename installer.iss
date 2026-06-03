[Setup]
AppName=Двойняшки РМК 
AppVersion=1.10.0
DefaultDirName={pf}\dvoinyashki_rmk
DefaultGroupName=dvoinyashki_rmk
OutputBaseFilename=РМК 1.10.0
Compression=lzma
SolidCompression=yes
UninstallDisplayName=РМК Удаление

[Files]
Source: "build\windows\x64\runner\Release\*"; DestDir: "{app}"; Flags: recursesubdirs

[Icons]
Name: "{group}\Двойняшки РМК"; Filename: "{app}\app.exe"

[Run]
Filename: "{app}\app.exe"; 