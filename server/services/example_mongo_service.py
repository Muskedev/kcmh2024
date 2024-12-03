from pymongo import AsyncMongoClient
from random import randint

class ExampleMongoService:
    def __init__(self, mongo_client: AsyncMongoClient, database_name: str):
        self.collection = mongo_client[database_name]["example"]

    async def post_example_document(self):
        example_document = {
            "random_number": randint(0, 100)
        }

        await self.collection.insert_one(example_document)
    
    