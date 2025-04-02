curl -o python-installer.exe https://www.python.org/ftp/python/3.10.7/python-3.10.7-amd64.exe
python-installer.exe /quiet InstallAllUsers=1 PrependPath=1
python --version
python3 -m venv .env
.env\Scripts\activate
pip install uv
uv pip install telethon pandas asyncio --system
uv pip install platform --system