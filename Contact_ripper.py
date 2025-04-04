from telethon import TelegramClient
from telethon.tl.functions.contacts import GetContactsRequest
import pandas as pd
import asyncio

from data_checker import get_attributes, get_device_info

async def export_contacts(client):
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
    df.to_excel('contacts.xlsx', index=False)
    print("Контакты сохранены в файл contacts.xlsx")

async def main():
    api_id, api_hash, phone = get_attributes()
    session_name = f'session_{phone}'
    system_version, device_model, app_version = get_device_info()

    client = TelegramClient(
        session_name,
        api_id=api_id,
        api_hash=api_hash,
        system_version=system_version,
        device_model=device_model,
        app_version=app_version
    )

    await client.start(phone)
    await export_contacts(client)
    await client.disconnect()

if __name__ == '__main__':
    asyncio.run(main())
