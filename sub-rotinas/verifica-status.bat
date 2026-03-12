@echo off
setlocal

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
echo Atualizando projeto
echo =============================
echo Projeto : %NOME%
echo Caminho : %CAMINHO%
echo.

REM verifica se o caminho existe
if not exist "%CAMINHO%" (
    echo ERRO: caminho do projeto nao encontrado.
    exit /b 2
)

REM entra na pasta do projeto
cd /d "%CAMINHO%"

REM verifica se é um repositorio git
if not exist ".git" (
    echo ERRO: este diretorio nao e um repositorio git.
    exit /b 3
)

echo Executando: git status
echo.

git status

REM captura retorno do git
if errorlevel 1 (
    echo.
    echo ERRO ao executar git pull.
    exit /b 4
)

echo.

exit /b 0