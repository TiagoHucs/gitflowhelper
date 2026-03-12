@echo off
setlocal enabledelayedexpansion

set ATUAL=dados\projeto-atual.tmp

REM verifica se existe projeto selecionado
if not exist "%ATUAL%" (
    echo Nenhum projeto selecionado.
    exit /b 1
)

REM lê nome e caminho
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

if not exist "%CAMINHO%\pom.xml" (
    echo ERRO: pom.xml nao encontrado.
    exit /b 3
)

set IN_PARENT=0
set VERSION=

for /f "usebackq delims=" %%l in ("%CAMINHO%\pom.xml") do (

    set linha=%%l

    echo !linha! | find "<parent>" >nul && set IN_PARENT=1
    echo !linha! | find "</parent>" >nul && set IN_PARENT=0

    if !IN_PARENT! == 0 (
        echo !linha! | find "<version>" >nul
        if !errorlevel! == 0 (
            for /f "tokens=2 delims=<>" %%v in ("!linha!") do (
                if not defined VERSION set VERSION=%%v
            )
        )
    )
)

if not defined VERSION (
    echo ERRO: versao nao encontrada no pom.xml
    exit /b 4
)

echo Versao do projeto: !VERSION!

exit /b 0