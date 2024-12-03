from settings import InformaniakAISettings
from aiohttp import ClientSession

class Message:
    def __init__(self, content: str, role: str):
        self.content = content
        self.role = role

class Prompt:
    def __init__(self, messages: list[Message]):
        self.messages = messages

class InformaniakAiService:
    def __init__(self, configuration: InformaniakAISettings, client_session: ClientSession):
        self.model = configuration.model
        self.api_token = configuration.api_token
        self.product_id = configuration.product_id
        self.client_session = client_session
        self.base_url = 'https://api.infomaniak.com/1/ai'

    def _create_headers(self) -> dict:
        return {
            'Authorization': f'Bearer {self.api_token}',
            'Content-Type': 'application/json'
        }

    
    def _create_request_payload(self, prompt: Prompt) -> dict:
        return {
            'messages': [ {'role': message.role, 'content': message.content} for message in prompt.messages],
            'model': self.model
        }

    
    async def execute_prompt(self, prompt: Prompt) -> str:
        payload = self._create_request_payload(prompt)
        headers = self._create_headers()
        async with self.client_session.post(f'{self.base_url}/{self.product_id}/openai/chat/completions', json=payload, headers=headers) as resp:
            json_response = await resp.json()
            return json_response['choices'][0]['message']['content']

