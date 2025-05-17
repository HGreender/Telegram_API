def api_id_input():
    while True:
        user_input = input("Введите API ID: ").strip()
        if user_input.lower() == 'exit':
            return None
        if not user_input:
            print("Поле не может быть пустым!")
            continue
        try:
            number = int(user_input)  # или int()
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
            my_string = str(user_input)
            return my_string
        except ValueError:
            print("Неверный формат данных!")

def api_phone_input():
    while True:
        user_input = input("Введите номер телефона (начиная с 8): ").strip()
        if not user_input:
            print("Поле не может быть пустым!")
            continue
        try:
            my_string = str(user_input)
            return my_string
        except ValueError:
            print("Неверный формат данных!")
