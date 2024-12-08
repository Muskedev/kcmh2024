from pymongo import AsyncMongoClient
from entities.game_modes import ThinkSolveRound, ThinkSolveQuestion, LeaderboardEntry


class DocumentNotFound(Exception):
    pass

class ThinkSolveMongoService:

    def __init__(self, mongo_client: AsyncMongoClient):
        self.collection = mongo_client["hirnOderHumbug"]["thinkSolveRounds"]
    
    def _bson_to_entity(self, bson: dict) -> ThinkSolveRound:
       return ThinkSolveRound(
            id=bson["id"],
            score=bson["score"],
            user_id=bson["userId"],
            questions=[ ThinkSolveQuestion(
                id=question["id"],
                question=question["question"],
                correct_answer=question["correctAnswer"],
                explanation=question["explanation"],
                user_answer=question["userAnswer"]
            ) for question in bson["questions"]]
        ) 

    async def replace_round(self, round: ThinkSolveRound, upsert: bool = True):
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
        result: list[ThinkSolveRound] = []
        
        async for game_round in self.collection.find({"userId": user_id, "score": {"$gt": -1}}):
            result.append(self._bson_to_entity(game_round))
        
        return result
    
    async def generate_leaderboard(self):
        pipeline = [
            {
                "$match": {"score": {"$gte": 0}}
            },
            {
                "$lookup": {
                    "from": "users",
                    "localField": "userId",
                    "foreignField": "id",
                    "as": "userInfo"
                }
            },
            {
                "$unwind": "$userInfo"
            },
            {
                "$group": {
                    "_id": "$userInfo.name",
                    "totalScore": {"$sum": "$score"}
                }
            },
            {
                "$project": {
                    "_id": 0,
                    "name": "$_id",
                    "score": "$totalScore"
                }
            },
            {
                "$sort": {"score": -1}
            }
        ]

        leaderboard_cursor = await self.collection.aggregate(pipeline=pipeline)
        leaderboard: list[LeaderboardEntry] = []
        rank = 1
        async for leaderboard_entry in leaderboard_cursor:
            leaderboard.append(LeaderboardEntry(
                name=leaderboard_entry['name'],
                score=leaderboard_entry['score'],
                rank=rank
            ))
            rank += 1
        
        return leaderboard