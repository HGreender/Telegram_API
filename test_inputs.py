def api_id_input():
    while True:
        user_input = input("Введите API ID: ").strip()
        if user_input.lower() == 'exit':
            return None
        if not user_input:
            print("Поле не может быть пустым!")
            continue
        try:
            number = float(user_input)  # или int()
            return number
        except ValueError:
            print("Ошибка: введите число!")

def api_hash_input():
    while True:
        user_input = input("Введите API hash: ").strip()
        if not user_input:
            print("Поле не может быть пустым!")
            continue
        try:
            number = str(user_input)  # или int()
            return number
        except ValueError:
            print("Неверный формат данных!")