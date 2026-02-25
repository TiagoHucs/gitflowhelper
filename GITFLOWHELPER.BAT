@echo off
setlocal enabledelayedexpansion

call setup.bat
call selecao-projeto.bat

if errorlevel 1 (
    echo Erro detectado. Encerrando script principal.
    exit /b 1
)

REM =============================
REM Ler versao via PowerShell
REM =============================
for /f "delims=" %%V in ('powershell -NoProfile -Command ^
    "[xml]$xml = Get-Content '!POM!'; $xml.project.version"') do set VERSAO=%%V

echo.
echo ============================
echo Versao atual do projeto: !VERSAO!
echo ============================
echo.

:MENU
set /p NOVA_VERSAO=Digite a nova versao: 

echo.
echo Comando para a nova versao:

if /I "!CRIAR_BACKUPS!"=="true" (
    set COMANDOCOMPLETO=mvn -f "!PROJETO_PATH!\pom.xml" versions:set -DnewVersion=!NOVA_VERSAO!
) else (
    set COMANDOCOMPLETO=mvn -f "!PROJETO_PATH!\pom.xml" versions:set -DnewVersion=!NOVA_VERSAO! -DgenerateBackupPoms=false
)

echo !COMANDOCOMPLETO!
echo.

:PERGUNTAEXECUTAR
set /p OPCAO=Deseja que este script execute o comando? (S) Sim / (N) Nao : 
if /I "!OPCAO!"=="S" goto EXECUTA
if /I "!OPCAO!"=="N" goto FIM
goto PERGUNTAEXECUTAR

:EXECUTA
echo.
echo Executando...
!COMANDOCOMPLETO!
echo.
git -C "!PROJETO_PATH!" status

:FIM
echo.
pause
endlocal