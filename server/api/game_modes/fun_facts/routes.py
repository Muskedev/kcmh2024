from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, Field
from services.game_modes.fun_facts import FunFactsGameModeService, QuestionCanNotBeUpdated, QuestionAnswerDto, RoundCanNotBeFound
import services.game_modes.fun_facts


class AnsweredQuestionDto(BaseModel):
    questionId: str
    userAnswer: bool

class FinishRoundDto(BaseModel):
    score: int = Field(gt=0)
    questions: list[AnsweredQuestionDto]


class FunFactsRoutes:
    def __init__(self, app: FastAPI, fun_fact_service: FunFactsGameModeService):
       self.app = app 
       self.fun_fact_service = fun_fact_service
       self.add_routes()

    def add_routes(self):
        @self.app.post("/gamemode/funFacts/create")
        async def create_fun_facts_rounds(userId: str):
            return await self.fun_fact_service.start_round(userId)
        
        @self.app.get("/gamemode/funFacts/getFinishedRounds")
        async def get_finished_rounds(userId: str):
            return await self.fun_fact_service.get_rounds(userId)
        
        @self.app.post("/gamemode/funFacts/finishRound")
        async def finish_fun_facts_rounds(userId: str, roundId: str, finishRoundDto: FinishRoundDto):
            try:
                return await self.fun_fact_service.finish_round(services.game_modes.fun_facts.FinishRoundDto(
                    user_id=userId,
                    round_id=roundId,
                    questions=[QuestionAnswerDto(question_id=question.questionId, user_answer=question.userAnswer) for question in finishRoundDto.questions],
                    score=finishRoundDto.score
                ))
            except QuestionCanNotBeUpdated:
                raise HTTPException(status_code=404, detail="It seems that you are trying to update questions which are not existing in the given round")
            except RoundCanNotBeFound:
                raise HTTPException(status_code=404, detail="The given round doesnt exist for the user") 