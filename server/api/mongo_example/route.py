from fastapi import FastAPI
from services import ExampleMongoService

class MongoExampleRoute:
    def __init__(self, app: FastAPI, example_mongo_service: ExampleMongoService):
       self.app = app 
       self.example_mongo_client = example_mongo_service
       self.add_route()

    def add_route(self):
        @self.app.post("/mongoexample")
        async def mongo_push():
            await self.example_mongo_client.post_example_document()