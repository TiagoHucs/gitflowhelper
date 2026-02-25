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