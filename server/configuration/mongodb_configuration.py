from pydantic import MongoDsn, Field
from pydantic_settings import BaseSettings

class MongoDBConfiguration(BaseSettings):
    mongodb_connection_string: MongoDsn = Field('mongodb://root:example@localhost:27017/', validation_alias="MONGODB_CONNECTION_STRING")
