from fastapi import FastAPI
from services.game_modes.fun_facts import FunFactsGameModeService, FunFactsMongoService
from services.ai import InformaniakAiService
from services.user import UserService, UserMongoService
from api.game_modes.fun_facts  import FunFactsRoutes
from api.user import UserRoutes
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

    fun_facts_mongo_service = FunFactsMongoService(mongo_client)
    fun_facts_service = FunFactsGameModeService(fun_facts_mongo_service, informaniak_ai_service)

    user_mongo_service = UserMongoService(mongo_client)
    user_service = UserService(user_mongo_service)

    #routes
    FunFactsRoutes(app, fun_facts_service)
    UserRoutes(app, user_service)

    
    yield
    
    await session.close()
    
app = FastAPI(lifespan=lifespan)
