from fastapi import FastAPI
from api.hello_world import HelloWorldRoute


app = FastAPI()
HelloWorldRoute(app)
