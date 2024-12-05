from settings import OpenAIAISettings
from aiohttp import ClientSession

import json

class Message:
    content: str
    role: str

    def __init__(self, content: str, role: str):
        self.content = content
        self.role = role

class Prompt:
    messages: list[Message]
    json_schema: dict

    def __init__(self, messages: list[Message], json_schema: dict):
        self.messages = messages
        self.json_schema = json_schema

class OpenAIAIService:
    def __init__(self, configuration: OpenAIAISettings, client_session: ClientSession):
        self.model = configuration.model
        self.api_token = configuration.api_token
        self.client_session = client_session
        self.base_url = 'https://api.openai.com'

    def _create_headers(self) -> dict:
        return {
            'Authorization': f'Bearer {self.api_token}',
            'Content-Type': 'application/json'
        }

    
    def _create_request_payload(self, prompt: Prompt) -> dict:
        return {
            'messages': [ {'role': message.role, 'content': message.content} for message in prompt.messages],
            'model': self.model,
            'response_format': prompt.json_schema
        }

    
    async def execute_prompt(self, prompt: Prompt) -> str:
        payload = self._create_request_payload(prompt)
        headers = self._create_headers()
        async with self.client_session.post(f'{self.base_url}/v1/chat/completions', json=payload, headers=headers) as resp:
            json_response = await resp.json()
            return json_response['choices'][0]['message']['content']

