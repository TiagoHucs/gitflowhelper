@echo off
setlocal

REM Caminho do pom.xml (mesma pasta do BAT)
set POM=%~dp0pom.xml

if not exist "%POM%" (
    echo pom.xml nao encontrado!
    pause
    exit /b
)

REM Ler versao do projeto via PowerShell (evita pegar parent ou dependencies)
for /f "delims=" %%V in ('powershell -NoProfile -Command ^
    "[xml]$xml = Get-Content '%POM%'; $xml.project.version"') do set VERSAO=%%V

echo.
echo ============================
echo Versao atual do projeto: %VERSAO%
echo ============================
echo.

:MENU
echo.
set /p NOVA_VERSAO=Digite a nova versao: 

set /p OPCAO=Deseja gerar os backups dos poms (S) Sim ou (N) Não? 

echo Comando para a nova versao:

if /I "%OPCAO%"=="S" goto COMBACKUP
if /I "%OPCAO%"=="N" goto SEMBACKUP

:COMBACKUP
set COMANDOCOMPLETO=mvn versions:set -DnewVersion=%NOVA_VERSAO%
echo %COMANDOCOMPLETO%
goto PERGUNTAEXECUTAR

:SEMBACKUP
set COMANDOCOMPLETO=mvn versions:set -DnewVersion=%NOVA_VERSAO% -DgenerateBackupPoms=false
echo %COMANDOCOMPLETO%
goto PERGUNTAEXECUTAR

:PERGUNTAEXECUTAR
set /p OPCAO=Deseja executar o comando (S) Sim ou (N) Não? 
if /I "%OPCAO%"=="S" goto EXECUTA
if /I "%OPCAO%"=="N" goto FIM

:EXECUTA
%COMANDOCOMPLETO%
git status

:FIM
echo.
pause
endlocal
