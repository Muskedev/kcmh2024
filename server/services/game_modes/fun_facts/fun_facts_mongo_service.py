from pymongo import AsyncMongoClient
from entities.game_modes import FunFactsRound, Question

class FunFactsMongoService:

    def __init__(self, mongo_client: AsyncMongoClient):
        self.collection = mongo_client["hirnOderHumbug"]["funFactsRounds"]
    
    async def update_round(self, round: FunFactsRound):
        return (await self.collection.update_one({"id": str(round.id)}, round.__dict__, upsert=True)).upserted_id
    
    async def get_rounds(self, userId: str): 
        result: list[FunFactsRound] = []
        
        async for gameRound in self.collection.find({"userId": userId, "score": {"$gt": 0}}):
            result.append(FunFactsRound(
                id=gameRound["id"],
                score=gameRound["score"],
                user_id=gameRound["user_id"],
                questions=[ Question(
                    question=question["question"],
                    correct_answer=question["correct_answer"],
                    explanation=question["explanation"],
                    user_answer=question["user_answer"]
                ) for question in gameRound["questions"]]
            ))
        
        return result