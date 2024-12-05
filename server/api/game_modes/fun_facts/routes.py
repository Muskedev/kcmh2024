from fastapi import FastAPI, HTTPException
from entities.game_modes.fun_facts import FunFactsRound
from pydantic import BaseModel, Field
from services.game_modes.fun_facts import FunFactsGameModeService, QuestionCanNotBeUpdated, QuestionAnswerDto, RoundCanNotBeFound
import services.game_modes.fun_facts


class AnsweredQuestionDto(BaseModel):
    id: str
    userAnswer: bool


class StartRoundQuestionDto(BaseModel):
    id: str
    question: str
    explanation: str
    correctAnswer: bool


class StartRoundDto(BaseModel):
    id: str
    userId: str
    questions: list[StartRoundQuestionDto]



class FinishRoundDto(BaseModel):
    score: int = Field(gt=-1)
    questions: list[AnsweredQuestionDto]


class FinishedQuestionDto(BaseModel):
    id: str
    question: str
    explanation: str
    userAnswer: bool
    correctAnswer: bool

class FinishedRoundDto(BaseModel):
    id: str
    userId: str
    score: int
    questions: list[FinishedQuestionDto]


class FinishedRoundsDto(BaseModel):
    finishedRounds: list[FinishedRoundDto]

class FunFactsRoutes:
    def __init__(self, app: FastAPI, fun_fact_service: FunFactsGameModeService):
       self.app = app 
       self.fun_fact_service = fun_fact_service
       self.add_routes()

    def _convert_round_to_dto(self, round: FunFactsRound):
        return FinishedRoundDto(
            id=round.id,
            userId=round.user_id,
            score=round.score,
            questions=[FinishedQuestionDto(
                id=question.id,
                correctAnswer=question.correct_answer,
                explanation=question.explanation,
                userAnswer=question.user_answer,
                question=question.question
            ) for question in round.questions]
        )

    def add_routes(self):
        @self.app.post("/gamemode/funFacts/create")
        async def create_fun_facts_round(userId: str) -> StartRoundDto:
            round = await self.fun_fact_service.start_round(userId)
            return StartRoundDto(
                id=round.id,
                userId=round.user_id,
                questions=[StartRoundQuestionDto(
                    id=question.id,
                    explanation=question.explanation,
                    correctAnswer=question.correct_answer,
                    question=question.question
                ) for question in round.questions]
            ) 
        @self.app.get("/gamemode/funFacts/getFinishedRounds")
        async def get_finished_rounds(userId: str) -> FinishedRoundsDto:
            finished_rounds = await self.fun_fact_service.get_rounds(userId)
            return FinishedRoundsDto(finishedRounds =  [self._convert_round_to_dto(round) for round in finished_rounds])

        @self.app.put("/gamemode/funFacts/finishRound")
        async def finish_fun_facts_round(userId: str, roundId: str, finishRoundDto: FinishRoundDto) -> FinishedRoundDto:
            try:

                round_entity = await self.fun_fact_service.finish_round(services.game_modes.fun_facts.FinishRoundDto(
                    user_id=userId,
                    round_id=roundId,
                    questions=[QuestionAnswerDto(question_id=question.id, user_answer=question.userAnswer) for question in finishRoundDto.questions],
                    score=finishRoundDto.score
                ))

                return self._convert_round_to_dto(round_entity)
                
            except QuestionCanNotBeUpdated:
                raise HTTPException(status_code=404, detail="It seems that you are trying to update questions which are not existing in the given round")
            except RoundCanNotBeFound:
                raise HTTPException(status_code=404, detail="The given round doesnt exist for the user") 