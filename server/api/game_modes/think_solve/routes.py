from fastapi import FastAPI, HTTPException
from entities.game_modes.think_solve import ThinkSolveRound
from entities.game_modes import GameModeEnum
from pydantic import BaseModel, Field
from services.game_modes.think_solve import ThinkSolveGameModeService, AnswerDto, RoundCanNotBeClosed, RoundCanNotBeFound, QuestionCanNotBeFound
import services.game_modes.think_solve

class AnswerQuestionDto(BaseModel):
    questionId: str
    userAnswer: str

class AnswerDto(BaseModel):
    explanation: str
    isUserCorrect: bool

class AnsweredQuestionDto(BaseModel):
    id: str
    userAnswer: bool

class StartRoundQuestionDto(BaseModel):
    id: str
    question: str

class StartRoundDto(BaseModel):
    id: str
    userId: str
    questions: list[StartRoundQuestionDto]

class FinishRoundDto(BaseModel):
    score: int = Field(gt=-1)

class FinishedQuestionDto(BaseModel):
    id: str
    question: str
    explanation: str
    userAnswer: str
    correctAnswer: bool

class FinishedRoundDto(BaseModel):
    id: str
    userId: str
    score: int
    questions: list[FinishedQuestionDto]
    
class LeaderBoardEntryDto(BaseModel):
    name: str
    score: int
    rank: int

class LeaderBoardDto(BaseModel):
    entries: list[LeaderBoardEntryDto]
    gameMode: GameModeEnum

class FinishedRoundsDto(BaseModel):
    finishedRounds: list[FinishedRoundDto]

class ThinkSolveRoutes:
    def __init__(self, app: FastAPI, think_solve_service: ThinkSolveGameModeService):
       self.app = app 
       self.think_solve_service = think_solve_service
       self.add_routes()

    def _convert_round_to_dto(self, round: ThinkSolveRound):
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
        @self.app.post("/gamemode/thinkSolve/create")
        async def create_think_solve_round(userId: str) -> StartRoundDto:
            round = await self.think_solve_service.start_round(userId)
            return StartRoundDto(
                id=round.id,
                userId=round.user_id,
                questions=[StartRoundQuestionDto(
                    id=question.id,
                    question=question.question
                ) for question in round.questions]
            ) 
        @self.app.get("/gamemode/thinkSolve/getFinishedRounds")
        async def get_finished_rounds(userId: str) -> FinishedRoundsDto:
            finished_rounds = await self.think_solve_service.get_rounds(userId)
            return FinishedRoundsDto(finishedRounds =  [self._convert_round_to_dto(round) for round in finished_rounds])

        @self.app.put("/gamemode/thinkSolve/finishRound")
        async def finish_think_solve_round(userId: str, roundId: str, finishRoundDto: FinishRoundDto) -> FinishedRoundDto:
            try:

                round_entity = await self.think_solve_service.finish_round(services.game_modes.think_solve.FinishRoundDto(
                    user_id=userId,
                    round_id=roundId,
                    score=finishRoundDto.score
                ))

                return self._convert_round_to_dto(round_entity)
                
            except RoundCanNotBeClosed:
                raise HTTPException(status_code=400, detail="Round can not be closed. Its very likely that not all questions are answered yet")
            except RoundCanNotBeFound:
                raise HTTPException(status_code=404, detail="The given round doesnt exist for the user")
        
        @self.app.get("/gamemode/thinkSolve/getLeaderboard")
        async def get_leaderboard() -> LeaderBoardDto:
            leaderboard = await self.think_solve_service.get_leaderboard()
            return LeaderBoardDto(gameMode=leaderboard.game_mode, entries=[
                LeaderBoardEntryDto(
                    name=entry.name,
                    score=entry.score,
                    rank=entry.rank    
                ) for entry in leaderboard.entries
            ])
        
        @self.app.put("/gamemode/thinkSolve/answerQuestion")
        async def answer_question(userId: str, roundId: str, questionAnswer: AnswerQuestionDto):
            try:

                answer = await self.think_solve_service.answer_question(services.game_modes.think_solve.AnswerQuestionDto(
                    user_id=userId,
                    round_id=roundId,
                    question_id=questionAnswer.questionId,
                    user_answer=questionAnswer.userAnswer
                ))

                return AnswerDto(isUserCorrect=answer.is_user_correct, explanation=answer.explanation)
                
            except RoundCanNotBeClosed:
                raise HTTPException(status_code=400, detail="Round can not closed. Its very likely that not all Questions are answered yet")
            except RoundCanNotBeFound:
                raise HTTPException(status_code=404, detail="The given round doesnt exist for the user")
            except QuestionCanNotBeFound:
                raise HTTPException(status_code=404, detail='The given question doesnt exist for the user')
        
            