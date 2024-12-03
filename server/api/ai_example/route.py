from fastapi import FastAPI
from services.ai import Prompt, InformaniakAiService, Message

class AiExampleRoute:
    def __init__(self, app: FastAPI, ai_service: InformaniakAiService):
       self.app = app 
       self.ai_service = ai_service
       self.add_route()

    def add_route(self):
        @self.app.post("/aiexample")
        async def get_ai_answer():
            prompt = Prompt([Message("Gib mir ein Randomfakt", "user")])
            return await self.ai_service.execute_prompt(prompt)