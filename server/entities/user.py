from uuid import uuid4

class User:
    id: str
    name: str

    def __init__(self, name: str, id: str | None = None):
        self.id = str(uuid4()) if id is None else id 
        self.name = name