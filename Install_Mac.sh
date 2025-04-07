#!/bin/bash

REQUIRED_PYTHON_VERSION="3.10.7"

# Проверка установлен ли pyenv
if ! command -v pyenv &> /dev/null; then
    echo "pyenv не установлен. Устанавливаю pyenv..."
    curl https://pyenv.run | bash

    # Добавляем pyenv в окружение
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv virtualenv-init -)"
fi

# Проверка установлен ли нужный Python
if ! pyenv versions --bare | grep -q "$REQUIRED_PYTHON_VERSION"; then
    echo "Python $REQUIRED_PYTHON_VERSION не найден. Устанавливаю..."
    pyenv install "$REQUIRED_PYTHON_VERSION"
fi

# Устанавливаем нужную версию Python локально
pyenv local "$REQUIRED_PYTHON_VERSION"

# Убедимся, что мы используем правильный Python
PYTHON_BIN="$(pyenv which python)"
echo "Используется Python: $($PYTHON_BIN --version)"

# Создание виртуального окружения
$PYTHON_BIN -m venv .env
source .env/bin/activate

# Установка зависимостей
pip install --upgrade pip
pip install uv
uv pip install telethon pandas asyncio openpyxl

echo "✅ Установка завершена."
