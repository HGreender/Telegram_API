import telethon, platform
from telethon import TelegramClient
from telethon.tl.functions.contacts import GetContactsRequest
import pandas as pd
import asyncio

import test_inputs

api_id = test_inputs.api_id_input()
api_hash = test_inputs.api_hash_input()

session_name = 'Session'
system_version = platform.uname().release
device_model = platform.uname().machine
app_version = telethon.version.__version__

client = TelegramClient(
    session_name,
    api_id=api_id,
    api_hash=api_hash,
    system_version=system_version,
    device_model=device_model,
    app_version=app_version
)

async def export_contacts():
    response = await client(GetContactsRequest(hash=0))
    data = []
    for contact in response.users:
        full_name = (contact.first_name or '') + (' ' + contact.last_name if contact.last_name else '')
        is_premium = getattr(contact, 'premium', False)
        data.append({
            'Имя': full_name.strip(),
            'Номер телефона': contact.phone or 'Не указан',
            'Premium': is_premium
        })


    df = pd.DataFrame(data)
    # new_df = df.sort_values(by='Premium', ascending=False)
    # print(new_df.head())
    df.to_excel('contacts.xlsx', index=False)
    print("Контакты сохранены в файл contacts.xlsx")

async def main():
    await client.start()
    await export_contacts()
    await client.disconnect()

if __name__ == '__main__':
    asyncio.run(main())
