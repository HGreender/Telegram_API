#!/bin/bash

if command -v python3 &>/dev/null; then
    echo "Python 3 уже установлен: $(python3 --version)"
else
    echo "Python 3 не найден. Устанавливаю через Homebrew..."

    if ! command -v brew &>/dev/null; then
        echo "Установка Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    brew install python
fi

echo "Обновление pip..."
python3 -m pip install --upgrade pip

if [ -f "requirements.txt" ]; then
    echo "Установка зависимостей из requirements.txt..."
    python3 -m pip install -r requirements.txt
else
    pip install uv
    uv pip install telethon pandas asyncio openpyxl
fi

echo "Установка завершена."

================================

#!/bin/bash

set -e  # Остановить скрипт при ошибке

# 1. Установка Homebrew (если ещё не установлен)
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew уже установлен."
fi

echo "Installing Python3..."
brew install python

# 3. Убедимся, что python3 и pip3 в PATH
export PATH="/opt/homebrew/bin:$PATH"

# 4. Создание виртуального окружения в текущей директории
python3 -m venv venv

# 5. Активация виртуального окружения
source ./venv/bin/activate

# 6. Установка библиотеки pandas в виртуальное окружение
pip install --upgrade pip
pip install pandas

echo "\n✅ Всё готово! Виртуальное окружение активировано, pandas установлен."
