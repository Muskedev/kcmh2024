from pymongo import AsyncMongoClient
from entities.user import User

class DocumentAlreadyExist(Exception):
    pass

class UserMongoService:
    def __init__(self, mongo_client: AsyncMongoClient):
        self.collection = mongo_client["hirnOderHumbug"]["users"]

    async def check_if_user_exist(self, user: User):
        return True if (await self.collection.count_documents({"name": user.name}, limit=1)) > 0 else False

    async def replace_user(self, user: User, upsert=True): 
        if(upsert and await self.check_if_user_exist(user=user)):
            raise DocumentAlreadyExist()

        bson = {
            "id": user.id,
            "name": user.name
        }
        await self.collection.replace_one({"id": user.id}, bson, upsert=upsert)
        return user