import uuid

class User:
    id: str
    name: str

    def __init__(self, name: str, id=str(uuid.uuid4())):
        self.id = id
        self.name = name