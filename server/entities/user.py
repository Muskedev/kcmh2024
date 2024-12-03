from pydantic import BaseModel, UUID4
import uuid

class User(BaseModel):
    id: UUID4
    name: str

    def __init__(self, name: str, id=uuid.uuid4()):
        self.id = id
        self.name = name