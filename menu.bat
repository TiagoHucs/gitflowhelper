@echo off
setlocal enabledelayedexpansion

set CONFIG=config\projetos.conf

:MENU
cls
echo ===============================
echo      GERENCIADOR DE PROJETOS
echo ===============================
echo.

echo 1 - Gerenciar projetos

if exist %CONFIG% (
    echo 2 - Selecionar projeto
    echo 3 - Consultar versao
    echo 4 - Verifica status
    echo 5 - Atualizar codigo
)

echo 0 - Sair
echo.

set /p opcao=Escolha: 

if "%opcao%"=="1" call sub-rotinas\gerenciar-projetos.bat

if exist %CONFIG% (
    if "%opcao%"=="2" call sub-rotinas\selecionar-projeto.bat
    if "%opcao%"=="3" call sub-rotinas\consultar-versao.bat
    if "%opcao%"=="4" call sub-rotinas\verifica-status.bat
    if "%opcao%"=="5" call sub-rotinas\atualizar-codigo.bat
)

if "%opcao%"=="0" goto SAIR

pause
goto MENU

:SAIR
exit