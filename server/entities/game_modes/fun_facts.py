from pydantic import UUID4, BaseModel
from uuid import uuid4

class Question(BaseModel):
    question: str
    explanation: str
    correct_answer: bool
    user_answer: bool | None

    def __init__(self, question: str, explanation: str, correct_answer: bool, user_answer: bool | None = None):
        self.question = question
        self.explanation = explanation
        self.correct_answer = correct_answer
        self.user_answer = user_answer

class FunFactsRound(BaseModel):
    id: UUID4
    user_id: UUID4
    score: int
    questions: list[Question]

    def __init__(self, user_id: UUID4, questions: list[Question], id: UUID4 = uuid4(), score = 0):
        self.id = id
        self.user_id = user_id
        self.score = score
        self.questions = questions
