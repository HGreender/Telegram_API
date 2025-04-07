#!/bin/bash

REQUIRED_PYTHON_VERSION="3.10.7"

echo "🔍 Проверяю наличие pyenv..."

# Проверка установлен ли pyenv
if ! command -v pyenv &> /dev/null; then
    echo "❌ pyenv не найден."
    echo "➡️ Установи pyenv вручную: https://github.com/pyenv/pyenv#installation"
    echo "   Или удали ~/.pyenv, если предыдущая установка была повреждена:"
    echo "     rm -rf ~/.pyenv"
    exit 1
fi

# Инициализация pyenv в текущем shell
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

# Установка нужной версии Python, если её нет
if ! pyenv versions --bare | grep -q "$REQUIRED_PYTHON_VERSION"; then
    echo "⬇️ Устанавливаю Python $REQUIRED_PYTHON_VERSION..."
    pyenv install "$REQUIRED_PYTHON_VERSION"
fi

# Используем нужную версию Python глобально
pyenv global "$REQUIRED_PYTHON_VERSION"

PYTHON_BIN="$(pyenv which python)"
PIP_BIN="$(pyenv which pip)"

echo "🧪 Используется Python: $($PYTHON_BIN --version)"

# Установка зависимостей прямо в текущий Python (без venv)
$PIP_BIN install --upgrade pip
$PIP_BIN install uv
uv pip install telethon pandas asyncio openpyxl

echo "✅ Установка завершена (без виртуального окружения)."
