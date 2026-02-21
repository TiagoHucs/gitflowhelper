@echo off
setlocal enabledelayedexpansion

REM =============================
REM Arquivos de configuracao
REM =============================
set CONFIG_PROJETOS=%~dp0config-projetos.txt
set CONFIG_GERAL=%~dp0config-geral.txt

if not exist "%CONFIG_PROJETOS%" (
    echo Arquivo projetos-config.txt nao encontrado!
    pause
    exit /b
)

if not exist "%CONFIG_GERAL%" (
    echo Arquivo config.txt nao encontrado!
    pause
    exit /b
)

REM =============================
REM Ler configuracoes gerais
REM =============================
for /f "tokens=1,2 delims==" %%A in (%CONFIG_GERAL%) do (
    if /I "%%A"=="criarbackups" set CRIAR_BACKUPS=%%B
)

if "!CRIAR_BACKUPS!"=="" set CRIAR_BACKUPS=true

REM =============================
REM Menu de projetos
REM =============================
echo =============================
echo Escolha o projeto:
echo =============================

set COUNT=0

for /f "tokens=1,2 delims==" %%A in (%CONFIG_PROJETOS%) do (
    set /a COUNT+=1
    set PROJETO!COUNT!=%%A
    set CAMINHO!COUNT!=%%B
    echo !COUNT! - %%A  (%%B)
)

echo.
set /p ESCOLHA=Digite o numero do projeto: 

if "%ESCOLHA%"=="" goto FIM
if %ESCOLHA% GTR %COUNT% goto FIM

set PROJETO_NOME=!PROJETO%ESCOLHA%!
set PROJETO_PATH=!CAMINHO%ESCOLHA%!

echo.
echo Projeto selecionado: !PROJETO_NOME!
echo Caminho: !PROJETO_PATH!
echo.

REM =============================
REM Caminho do pom.xml
REM =============================
set POM=!PROJETO_PATH!\pom.xml

if not exist "!POM!" (
    echo pom.xml nao encontrado no projeto!
    pause
    exit /b
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