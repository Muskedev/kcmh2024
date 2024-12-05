from entities.game_modes import FunFactsRound, Question
from entities.game_modes import Leaderboard, GameModeEnum
from services.ai.openai_ai_service import Message, Prompt
#from services.ai import InformaniakAiService, Prompt, Message
from services.ai import OpenAIAIService
from .fun_facts_mongo_service import FunFactsMongoService, DocumentNotFound

import json

# prompt = Prompt([
#     Message("""Du bist ein LLM, was darauf trainiert ist, FunFacts zurück zu liefern, die entweder mit True oder False beantwortet werden können. Hierbei wird der Benutzer eine Zahl nennen, dass bestimmt wie viele FunFacts erzeugt werden sollen. Wichtig ist hierbei, dass die Fakts immer unterschiedlich sind und humorvoll. Achte darauf, dass die Kategorien nicht immer in der selben Reihenfolge sind. Bitte antworte nur in JSON im folgenden Format:
#     {
#         "questions": [
#             {
#                 "question": "hier steht dann die frage",
#                 "answer": true|false,
#                 "explanation": "Erklärung warum etwas wahr oder falsch ist"
#             }
#         ]
#     }""", "system"),
#     Message("10", "user") #damit können wir aktuell die Fragenanzahl bestimmen (Wenn das LLM das nicht verkackt :P)
# ])

prompt = Prompt(
    messages=[
        Message('Fun Facts die wahr oder falsch sein können. Der User gibt an, wie viele Facts erzeugt werden sollen', "system"),
        Message("5", "user") #damit können wir aktuell die Fragenanzahl bestimmen (Wenn das LLM das nicht verkackt :P)
    ],
    json_schema=
    {
        "type": "json_schema",
        "json_schema": {
            "name": "questions_schema",
            "schema": {
                "type": "object",
                "properties": {
                "questions": {
                    "type": "array",
                    "items": {
                    "type": "object",
                    "properties": {
                        "question": {
                        "type": "string",
                        "description": "Die Frage(Fakt), die gestellt wird"
                        },
                        "answer": {
                        "type": "boolean",
                        "description": "Ob der Fakt wahr oder falsch ist"
                        },
                        "explanation": {
                        "type": "string",
                        "description": "Erklärung warum der Fakt wahr oder falsch ist"
                        }
                    },
                    "required": ["question", "answer", "explanation"],
                    "additionalProperties": False
                    }
                }
                },
                "required": ["questions"],
                "additionalProperties": False
            } 
        }
  }
)


class QuestionAnswerDto:
    question_id: str
    user_answer: bool

    def __init__(self, question_id: str, user_answer: bool):
        self.question_id = question_id
        self.user_answer = user_answer 


class FinishRoundDto:
    round_id: str
    user_id: str
    score: int
    questions: list[QuestionAnswerDto]

    def __init__(self, round_id: str, user_id: str, score: str, questions: list[QuestionAnswerDto]):
        self.round_id = round_id
        self.user_id = user_id
        self.score = score
        self.questions = questions

class QuestionCanNotBeUpdated(Exception):
    pass

class RoundCanNotBeFound(Exception):
    pass

class FunFactsGameModeService:
    def __init__(self, fun_facts_persistence_service: FunFactsMongoService, ai_service: OpenAIAIService):
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
       return await self.fun_facts_persistence_service.replace_round(fun_fact_round)
    
    async def get_rounds(self, user_id: str):
       return await self.fun_facts_persistence_service.get_finished_rounds(user_id)
    
    async def finish_round(self, finished_round_dto: FinishRoundDto):
        try:
            game_round = await self.fun_facts_persistence_service.get_round(round_id=finished_round_dto.round_id, user_id=finished_round_dto.user_id)
            for sent_question in finished_round_dto.questions:
                question_to_update = next((question for question in game_round.questions if question.id == sent_question.question_id), None)
                if question_to_update is None:
                    raise QuestionCanNotBeUpdated()
                question_to_update.user_answer = sent_question.user_answer
            game_round.score = finished_round_dto.score
            await self.fun_facts_persistence_service.replace_round(round=game_round, upsert=False)
            return game_round
                
        except DocumentNotFound as e:
           raise RoundCanNotBeFound(DocumentNotFound)
    
    async def get_leaderboard(self):
        return Leaderboard(entries=await self.fun_facts_persistence_service.generate_leaderboard(), game_mode=GameModeEnum.FUNFACTS)