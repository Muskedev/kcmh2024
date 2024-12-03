from fastapi import FastAPI

class HelloWorldRoute:
    def __init__(self, app: FastAPI):
       self.app = app 
       self.add_route()

    def add_route(self):
        @self.app.get("/")
        def hello_world():
            return "Hello World"