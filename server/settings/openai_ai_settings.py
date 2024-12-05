from pydantic import Field
from pydantic_settings import BaseSettings

class OpenAIAISettings(BaseSettings):
    api_token: str = Field(validation_alias="OPENAI_AI_API_TOKEN")
    model: str = Field("gpt-4o-mini", validation_alias="OPENAI_MODEL")