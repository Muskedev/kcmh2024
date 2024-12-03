from fastapi import FastAPI
from api.hello_world import HelloWorldRoute
from api.mongo_example import MongoExampleRoute
from services.example_mongo_service import ExampleMongoService
from configuration import MongoDBConfiguration
from pymongo import AsyncMongoClient

mongodb_configuration = MongoDBConfiguration()
mongo_client = AsyncMongoClient(str(mongodb_configuration.mongodb_connection_string))
example_mongo_service = ExampleMongoService(mongo_client, "example")


app = FastAPI()
HelloWorldRoute(app)
MongoExampleRoute(app, example_mongo_service)
