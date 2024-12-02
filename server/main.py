from fastapi import FastAPI
from api.hello_world.route import HelloWorldRoute


app = FastAPI()
HelloWorldRoute(app)
