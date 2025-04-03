:: @echo off
:: Проверяем, установлен ли Python
where python
if %errorlevel% equ 0 (
    echo Python уже установлен.
    python --version
) else (
    echo Python не найден. Устанавливаем...
    curl -o python-installer.exe https://www.python.org/ftp/python/3.10.7/python-3.10.7-amd64.exe
    python-installer.exe /quiet InstallAllUsers=1 PrependPath=1
    del python-installer.exe
    echo Python успешно установлен.
    python --version
)
python -m venv .env
.env\Scripts\activate
pip install uv
uv pip install telethon pandas asyncio --system
uv pip install platform --system