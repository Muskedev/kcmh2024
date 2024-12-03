from fastapi import FastAPI
from services.example_mongo_service import ExampleMongoService
from services.ai import InformaniakAiService
from settings import MongoDBSettings, InformaniakAISettings
from pymongo import AsyncMongoClient
from aiohttp import ClientSession
from contextlib import asynccontextmanager
from dotenv import load_dotenv


load_dotenv()

#http
session: ClientSession | None = None

@asynccontextmanager
async def lifespan(app: FastAPI):
    session = ClientSession()

    #mongo
    mongodb_configuration = MongoDBSettings()
    mongo_client = AsyncMongoClient(str(mongodb_configuration.mongodb_connection_string))

    #services
    informaniak_ai_settings = InformaniakAISettings() 
    informaniak_ai_service = InformaniakAiService(informaniak_ai_settings, session)


    
    yield
    
    await session.close()
    
app = FastAPI(lifespan=lifespan)
