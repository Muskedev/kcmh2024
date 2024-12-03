from entities.game_modes import FunFactsRound, Question
from services.ai import InformaniakAiService, Prompt, Message
from .fun_facts_mongo_service import FunFactsMongoService

import json

prompt = Prompt([
    Message("""Du bist ein LLM, was darauf trainiert ist, FunFacts zurück zu liefern, die entweder mit True oder False beantwortet werden können. Hierbei wird der Benutzer eine Zahl nennen, dass bestimmt wie viele FunFacts erzeugt werden sollen. Wichtig ist hierbei, dass die Fakts immer unterschiedlich sind und humorvoll. Achte darauf, dass die Kategorien nicht immer in der selben Reihenfolge sind. Bitte antworte nur in JSON im folgenden Format:
    {
        "questions": [
            {
                "question": "hier steht dann die frage",
                "answer": true|false,
                "explanation": "Erklärung warum etwas wahr oder falsch ist"
            }
        ]
    }"""),
    Message("10", "user") #damit können wir aktuell die Fragenanzahl bestimmen (Wenn das LLM das nicht verkackt :P)
])

class FunFactsGameModeService:
    def __init__(self, fun_facts_persistence_service: FunFactsMongoService, ai_service: InformaniakAiService):
        self.fun_facts_persistence_service = fun_facts_persistence_service
        self.ai_service = ai_service

    def _convert_json_response(self, user_id: str, json_response: dict) -> FunFactsRound:
        return FunFactsRound(
            user_id=user_id,
            score=0,
            questions=[ Question(
                question=question["question"],
                correct_answer=question["answer"],
                explanation=question["explanation"],
                user_answer=None
            ) for question in json_response["questions"]]
        )
        
    async def start_round(self, user_id: str):
       json_response = json.loads(await self.ai_service.execute_prompt(prompt))
       fun_fact_round = self._convert_json_response(user_id, json_response)
       return await self.fun_facts_persistence_service.update_round(fun_fact_round)

    