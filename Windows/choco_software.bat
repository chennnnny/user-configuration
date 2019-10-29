:: https://chocolatey.org/packages

:: global envriment
choco install vcredist2010 -y
choco install powershell -y

choco install notepadplusplus.install --ia "'/D=d:\choco_apps\notepad++'" -y

choco install googlechrome -y
choco install cmder -y
choco install fluent-terminal -y
choco install f.lux.portable -y
choco install picpick.portable -y

:: media
choco install potplayer -y

:: unimportance
REM choco install github-desktop -y
REM choco install filezilla -y
REM choco install filezilla.server -y

:: development envriment
REM choco install autohotkey.portable -y
REM choco install procexp -y
REM choco install vsvim -y

:: others
REM choco install launchy -y
REM choco install autohotkey.install --ia "'/D=d:\choco_apps\autohotkey'" -y
