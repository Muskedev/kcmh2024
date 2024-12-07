from pydantic import UUID4, BaseModel
from uuid import uuid4

class FunFactQuestion:
    id: str
    question: str
    explanation: str
    correct_answer: bool
    user_answer: bool | None
    
    def __init__(self, question: str, explanation: str, correct_answer: bool, user_answer: bool | None = None, id: str | None = None):
        self.id = str(uuid4()) if id is None else id
        self.question = question
        self.explanation = explanation
        self.correct_answer = correct_answer
        self.user_answer = user_answer

class FunFactsRound:
    id: str
    user_id: str
    score: int
    questions: list[FunFactQuestion]

    def __init__(self, user_id: str, questions: list[FunFactQuestion], id: str | None = None, score = -1):
        self.id = str(uuid4()) if id is None else id
        self.user_id = user_id
        self.score = score
        self.questions = questions
