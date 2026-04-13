[Setup]
AppName=Двойняшки РМК 
AppVersion=1.2.0
DefaultDirName={pf}\dvoinyashki_rmk
DefaultGroupName=dvoinyashki_rmk
OutputBaseFilename=Двойняшки РМК Installer
Compression=lzma
SolidCompression=yes
UninstallDisplayName=РМК Двойняшки Uninstaller

[Files]
Source: "build\windows\x64\runner\Release\*"; DestDir: "{app}"; Flags: recursesubdirs

[Icons]
Name: "{group}\Двойняшки РМК"; Filename: "{app}\app.exe"

[Run]
Filename: "{app}\app.exe"; 