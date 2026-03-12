@echo off
setlocal EnableDelayedExpansion

set ATUAL=dados\projeto-atual.tmp

REM verifica projeto selecionado
if not exist "%ATUAL%" (
    echo Nenhum projeto selecionado.
    exit /b 1
)

REM lê projeto e caminho
for /f "tokens=1,2 delims=|" %%a in ("%ATUAL%") do (
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

if not exist "%CAMINHO%\pom.xml" (
    echo ERRO: pom.xml nao encontrado.
    exit /b 3
)

REM entra na pasta do projeto
pushd "%CAMINHO%"

set VERSAO=

for /f "delims=" %%v in ('mvn help:evaluate -Dexpression=project.version -q -DforceStdout') do (
    set VERSAO=%%v
)

popd

if not defined VERSAO (
    echo ERRO: nao foi possivel identificar a versao.
    exit /b 4
)

echo Versao do projeto: %VERSAO%

exit /b 0