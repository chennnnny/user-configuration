@echo off

setx HOME %USERPROFILE%
reg add "HKLM\Software\Microsoft\Command Processor" /v "AutoRun" /t REG_SZ /d "%USERPROFILE%\.config\bashrc.bat" /f

clink autorun install
