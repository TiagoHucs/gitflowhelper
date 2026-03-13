@echo off
setlocal EnableDelayedExpansion

set ATUAL=dados\projeto-atual.tmp

REM verifica se existe projeto selecionado
if not exist "%ATUAL%" (
    echo Nenhum projeto selecionado.
    exit /b 1
)

REM lê nome e caminho do projeto
for /f "tokens=1,2 delims=|" %%a in (%ATUAL%) do (
    set NOME=%%a
    set CAMINHO=%%b
)

echo =============================
echo Verificando versao do projeto
echo =============================
echo Projeto : %NOME%
echo Caminho : %CAMINHO%
echo.

if not exist "%CAMINHO%" (
    echo ERRO: caminho nao encontrado.
    exit /b 2
)

set POM=%CAMINHO%\pom.xml

if not exist "%POM%" (
    echo ERRO: pom.xml nao encontrado.
    exit /b 3
)

set VERSAO=

for /f "delims=" %%V in ('powershell -NoProfile -Command ^
    "[xml]$xml = Get-Content '!POM!'; $xml.project.version"') do (
    set VERSAO=%%V
)

if not defined VERSAO (
    echo ERRO: nao foi possivel identificar a versao.
    exit /b 4
)

echo Versao do projeto: !VERSAO!
pause
exit /b 0