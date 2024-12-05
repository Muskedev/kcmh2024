from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from services.user import UserService, UserAlreadyExist  

import services.user

class CreateUserDto(BaseModel):
    name: str

class UserDto(BaseModel):
    id: str
    name: str

class UserRoutes:
    def __init__(self, app: FastAPI, user_service: UserService):
        self.app = app
        self.user_service = user_service
        self.add_routes()
    
    def add_routes(self):
        @self.app.post('/user/create')
        async def create_user(userDto: CreateUserDto) -> UserDto:
            try:
                user_entity = await self.user_service.create_user(services.user.CreateUserDto(name=userDto.name))
                return UserDto(id=user_entity.id, name=user_entity.name)
            except UserAlreadyExist as e:
                raise HTTPException(status_code=400, detail='User already exist') 