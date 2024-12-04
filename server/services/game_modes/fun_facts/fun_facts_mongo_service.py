from pymongo import AsyncMongoClient
from entities.game_modes import FunFactsRound, Question

import json

class DocumentNotFound(Exception):
    pass

class FunFactsMongoService:

    def __init__(self, mongo_client: AsyncMongoClient):
        self.collection = mongo_client["hirnOderHumbug"]["funFactsRounds"]
    
    def _bson_to_entity(self, bson: dict) -> FunFactsRound:
       return FunFactsRound(
            id=bson["id"],
            score=bson["score"],
            user_id=bson["userId"],
            questions=[ Question(
                id=question["id"],
                question=question["question"],
                correct_answer=question["correctAnswer"],
                explanation=question["explanation"],
                user_answer=question["userAnswer"]
            ) for question in bson["questions"]]
        ) 

    async def replace_round(self, round: FunFactsRound, upsert: bool = True):
        bson_payload = {
            "id": round.id,
            "score": round.score,
            "userId": round.user_id,
            "questions": [{ "id": question.id, "question": question.question, "correctAnswer": question.correct_answer, "userAnswer": question.user_answer, "explanation": question.explanation } for question in round.questions]
        }
        await self.collection.replace_one({"id": round.id, "userId": round.user_id}, bson_payload, upsert=upsert)
        return round

    async def get_round(self, user_id: str, round_id: str):
        result = await self.collection.find_one({"userId": user_id, "id": round_id })
        if result is None:
            raise DocumentNotFound()

        return self._bson_to_entity(result) 

    async def get_finished_rounds(self, user_id: str): 
        result: list[FunFactsRound] = []
        
        async for game_round in self.collection.find({"userId": user_id, "score": {"$gt": 0}}):
            result.append(self._bson_to_entity(game_round))
        
        return result