from entities.user import User
from .user_mongo_service import UserMongoService, DocumentAlreadyExist

class CreateUserDto:
    name: str

    def __init__(self, name: str):
        self.name = name

class UserAlreadyExist(Exception):
    pass

class UserService:
    def __init__(self, persistence_service: UserMongoService):
        self.persistence_service = persistence_service
    
    async def create_user(self, create_user_dto: CreateUserDto):
        try:
            return await self.persistence_service.replace_user(User(name=create_user_dto.name))
        except DocumentAlreadyExist as e: 
            raise UserAlreadyExist(DocumentAlreadyExist)