import os.path
import json

import telethon, platform

from my_libs.test_inputs import api_id_input, api_hash_input, api_phone_input

def get_attributes(path='.env/data.dat'):
    if not os.path.isfile(path):
        create_data(path)
        api_id, api_hash, phone = read_data(path)
        print('data.dat has been loaded')
    else:
        api_id, api_hash, phone = read_data(path)
        if (api_id != None) and (api_hash != None) or (phone != None):
            print('data.dat has been loaded')
        else:
            create_data(path)
            api_id, api_hash, phone = read_data(path)
    return api_id, api_hash, phone

def read_data(path: str):
    try:
        with open(path, 'r') as file:
            data = json.load(file)
            api_id = data.get("api_id")
            api_hash = data.get("api_hash")
            phone = data.get("phone")
            if not all([api_id, api_hash, phone]):
                raise ValueError("Missing required fields in data.dat")
            return api_id, api_hash, phone
    except (FileNotFoundError, json.JSONDecodeError, ValueError) as e:
        print(f"Error reading {path}: {e}")
        return None, None, None

def create_data(path: str):
    api_id = api_id_input()
    api_hash = api_hash_input()
    phone = api_phone_input()
    data = {
        "api_id": api_id,
        "api_hash": api_hash,
        "phone": phone
    }
    with open(path, 'w') as file:
        json.dump(data, file, indent=4)
    print('data.dat has been created')

def get_device_info():
    system_version = platform.uname().release
    device_model = platform.uname().machine
    app_version = telethon.version.__version__
    return system_version, device_model, app_version
