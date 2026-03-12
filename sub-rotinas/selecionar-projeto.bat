@echo off
setlocal EnableDelayedExpansion

set CONFIG=config\projetos.conf
set ATUAL=dados\projeto-atual.tmp

if not exist dados mkdir dados

cls
echo ============================
echo SELECIONAR PROJETO
echo ============================
echo.

set i=0
for /f "tokens=1 delims=|" %%a in (%CONFIG%) do (
    set /a i+=1
    echo !i! - %%a
)

echo.
set /p NUM=Escolha o projeto: 

set i=0
for /f "tokens=1,2 delims=|" %%a in (%CONFIG%) do (
    set /a i+=1
    if "!i!"=="%NUM%" (
        set LINHA=%%a^|%%b
        > "%ATUAL%" <nul set /p=!LINHA!
        echo.
        echo Projeto selecionado: %%a
    )
)

exit /b 0