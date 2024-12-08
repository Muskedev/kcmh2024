from entities.game_modes import ThinkSolveRound, ThinkSolveQuestion
from entities.game_modes import Leaderboard, GameModeEnum
from services.ai.openai_ai_service import Message, Prompt
#from services.ai import InformaniakAiService, Prompt, Message
from services.ai import OpenAIAIService
from .think_solve_mongo_service import ThinkSolveMongoService, DocumentNotFound

import json

generate_questions_prompt = Prompt(
    messages=[
        Message('unique but coherent fun facts from science, history, nature and technology. user give int how many. data in german', "system"),
        Message('5', 'user') #damit können wir aktuell die Fragenanzahl bestimmen (Wenn das LLM das nicht verkackt :P)
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
                            "type": "string"
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
    round_id: str
    user_id: str
    question_id: str
    user_answer: bool

    def __init__(self, round_id: str, question_id: str, user_answer: bool):
        self.round_id = round_id
        self.question_id = question_id
        self.user_answer = user_answer 

class AnswerDto:
    is_user_correct: bool
    explanation: bool
    
    def __init__(self, is_user_correct: bool, explanation: str):
        self.is_user_correct = is_user_correct
        self.explanation = explanation

class UpdateRoundDto:
    round_id: str
    user_id: str
    question_id: str
    user_answer: str

class FinishRoundDto:
    round_id: str
    user_id: str
    score: int

    def __init__(self, round_id: str, user_id: str, score: str):
        self.round_id = round_id
        self.user_id = user_id
        self.score = score

class QuestionCanNotBeUpdated(Exception):
    pass

class RoundCanNotBeFound(Exception):
    pass

class QuestionCanNotBeFound(Exception):
    pass

class RoundCanNotBeClosed(Exception):
    pass

class FunFactsGameModeService:
    def __init__(self, think_solve_persistence_service: ThinkSolveMongoService, ai_service: OpenAIAIService):
        self.think_solve_persistence_service = think_solve_persistence_service
        self.ai_service = ai_service

    def _convert_json_response(self, user_id: str, json_response: dict) -> ThinkSolveRound:
        return ThinkSolveRound(
            user_id=user_id,
            score=0,
            questions=[ ThinkSolveQuestion(
                question=question,
                correct_answer=None,
                explanation=None,
                user_answer=None
            ) for question in json_response["questions"]]
        )
     
    def _generate_answer_prompt(self, question: str, user_answer: str) -> Prompt:
        return Prompt(
            messages=[
                Message('the user will give you a question and a answer, and you should specify if the answer is correct and give an explanation. data in german', "system"),
                Message(f'question: {question}, userAnswer: {user_answer}', 'user') #damit können wir aktuell die Fragenanzahl bestimmen (Wenn das LLM das nicht verkackt :P)
            ],
            json_schema=
            {
                "type": "json_schema",
                "json_schema": {
                    "name": "question_answer_schema",
                    "schema": {
                        "type": "object",
                        "properties": {
                            "isUserCorrect": {
                                "type": "bool"
                            },
                            "explanation": {
                                "type": "string"
                            }
                        },
                        "required": ["isUserCorrect, explanation"],
                        "additionalProperties": False
                    } 
                }
            }
        )
        
    async def start_round(self, user_id: str) -> ThinkSolveRound:
       json_response = json.loads(await self.ai_service.execute_prompt(generate_questions_prompt))
       think_solve_round = self._convert_json_response(user_id, json_response)
       return await self.think_solve_persistence_service.replace_round(think_solve_round)
    
    async def get_rounds(self, user_id: str) -> list[ThinkSolveRound]:
       return await self.think_solve_persistence_service.get_finished_rounds(user_id)
    
    async def finish_round(self, finished_round_dto: FinishRoundDto) -> ThinkSolveRound:
        try:
            game_round = await self.think_solve_persistence_service.get_round(round_id=finished_round_dto.round_id, user_id=finished_round_dto.user_id)
            unanswered_question = next((question for question in game_round.questions if question.user_answer is None), None)
            
            if unanswered_question is not None:
                raise RoundCanNotBeClosed()
            
            game_round.score = finished_round_dto.score
            await self.think_solve_persistence_service.replace_round(round=game_round, upsert=False)
            return game_round
                
        except DocumentNotFound as e:
           raise RoundCanNotBeFound(DocumentNotFound)
    
    async def question_answer(self, question_answer: QuestionAnswerDto) -> AnswerDto:
        try:
            game_round = await self.think_solve_persistence_service.get_round(round_id=question_answer.round_id, user_id=question_answer.user_id)
            question = next((question for question in game_round.questions if question.id == question_answer.question_id), None)
            
            if question is None:
                raise QuestionCanNotBeFound()
            
            answer_prompt = self._generate_answer_prompt(self, question=question.question, user_answer=question_answer.user_answer)
            answer_explanation = json.loads(self.ai_service.execute_prompt(answer_prompt))
            
            result = AnswerDto(is_user_correct=answer_explanation["isUserCorrect"], explanation=answer_explanation["explanation"])  

            question.correct_answer = result.is_user_correct
            question.explanation = result.explanation
            
            await self.think_solve_persistence_service.replace_round(round=game_round, upsert=False)
            return question
                
        except DocumentNotFound as e:
           raise RoundCanNotBeFound(DocumentNotFound)
    
    async def get_leaderboard(self) -> Leaderboard:
        return Leaderboard(entries=await self.think_solve_persistence_service.generate_leaderboard(), game_mode=GameModeEnum.THINKSOLVE)