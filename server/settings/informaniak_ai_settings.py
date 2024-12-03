from pydantic import Field
from pydantic_settings import BaseSettings

class InformaniakAISettings(BaseSettings):
    api_token: str = Field(validation_alias="INFORMANIAK_AI_API_TOKEN")
    product_id: str = Field(validation_alias="INFORMANIAK_AI_PRODUCT_ID")
    model: str = Field("llama3", validation_alias="INFORMANIAK_MODEL")