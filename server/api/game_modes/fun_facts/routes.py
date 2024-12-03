from fastapi import FastAPI
from services.game_modes.fun_facts import FunFactsGameModeService

class AiExampleRoute:
    def __init__(self, app: FastAPI, fun_fact_service: FunFactsGameModeService):
       self.app = app 
       self.fun_fact_service = fun_fact_service
       self.add_route()

    def add_route(self):
        @self.app.post("/gamemode/fun_facts/create")
        async def create_fun_facts_rounds(user_id: str):
            return await self.fun_fact_service.start_round(user_id)