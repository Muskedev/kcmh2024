from pydantic import UUID4, BaseModel
from uuid import uuid4

class ThinkSolveQuestion:
    id: str
    question: str
    explanation: str
    correct_answer: bool | None
    user_answer: str | None
    
    def __init__(self, question: str, explanation: str, user_answer: str | None = None, id: str | None = None, correct_answer: str | None = None):
        self.id = str(uuid4()) if id is None else id
        self.question = question
        self.explanation = explanation
        self.correct_answer = correct_answer
        self.user_answer = user_answer
        self.correct_answer = correct_answer

class ThinkSolveRound:
    id: str
    user_id: str
    score: int
    questions: list[ThinkSolveQuestion]

    def __init__(self, user_id: str, questions: list[ThinkSolveQuestion], id: str | None = None, score = -1):
        self.id = str(uuid4()) if id is None else id
        self.user_id = user_id
        self.score = score
        self.questions = questions
