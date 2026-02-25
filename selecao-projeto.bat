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
    exit /b 1
)