@echo off
:: Получаем версию Python
for /f "tokens=2 delims= " %%v in ('python --version 2^>^&1') do set PYTHON_VERSION=%%v

:: Проверяем, установлена ли нужная версия (3.10.7)
if "%PYTHON_VERSION%"=="3.10.7" (
    echo Python 3.10.7 is installed.
) else (
    echo Python 3.10.7 is not installed. Installing...
    curl -o python-installer.exe https://www.python.org/ftp/python/3.10.7/python-3.10.7-amd64.exe
    start /wait python-installer.exe /quiet InstallAllUsers=1 PrependPath=1
    del python-installer.exe
    echo Python has been installed.
    exit /b
)

:: Устанавливаем зависимости
python -m pip install --upgrade pip
python -m venv .env
call .env\Scripts\activate

python -m pip install --upgrade pip
pip install uv
uv pip install telethon pandas asyncio openpyxl

pause
