@echo off
set CONFIG=config\projetos.conf

:MENU
cls
echo ============================
echo GERENCIAR PROJETOS
echo ============================
echo.

echo 1 - Cadastrar projeto
echo 2 - Excluir projeto
echo 0 - Voltar
echo.

set /p op=Escolha: 

if "%op%"=="1" goto CADASTRAR
if "%op%"=="2" goto EXCLUIR
if "%op%"=="0" exit /b 0

goto MENU


:CADASTRAR

echo.
set /p NOME=Nome do projeto: 
set /p CAMINHO=Caminho da pasta raiz: 

if not exist config mkdir config

if exist %CONFIG% echo.>>%CONFIG%

echo %NOME%^|%CAMINHO%>>%CONFIG%

echo Projeto cadastrado com sucesso.
pause
goto MENU


:EXCLUIR

if not exist %CONFIG% (
    echo Nenhum projeto cadastrado.
    pause
    goto MENU
)

echo Projetos cadastrados:
echo.

set i=0
for /f "tokens=1 delims=|" %%a in (%CONFIG%) do (
    set /a i+=1
    echo !i! - %%a
)

echo.
set /p NUM=Digite o numero do projeto a excluir: 

set i=0
(
for /f "tokens=1* delims=|" %%a in (%CONFIG%) do (
    set /a i+=1
    if not "!i!"=="%NUM%" echo %%a^|%%b
)
) > config\temp.conf

move /y config\temp.conf %CONFIG% >nul

echo Projeto removido.
pause
goto MENU