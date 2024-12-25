using System.Text.Json;
using OpenAI;
using OpenAI.Chat;

namespace BriansBrainlab.Shared.AI;

public class OpenAIPromptExecutor(OpenAIClient client) : IPromptExecutor
{
    private readonly ChatClient _client = client.GetChatClient(model: "gpt-4o-mini");
    
    public async Task<T> ExecutePrompt<T>(Prompt prompt, JsonSchema? schema = null) where T : class
    {
        var convertedPrompt = ConvertPrompt(prompt);
        
        ChatCompletionOptions? chatCompletionOptions = null;

        if (schema is not null)
        {
            chatCompletionOptions = new ChatCompletionOptions
            {
                ResponseFormat = ChatResponseFormat.CreateJsonSchemaFormat(
                    jsonSchemaFormatName: schema.Name,
                    jsonSchema:  BinaryData.FromString(schema.Schema),
                    jsonSchemaIsStrict: true
                )
            };
        }

        var result = (ChatCompletion) await _client.CompleteChatAsync(convertedPrompt, chatCompletionOptions);

        T? jsonDeserializedResult;
        try
        { 
            jsonDeserializedResult = JsonSerializer.Deserialize<T>(result.Content.First().Text);
        }
        catch (Exception ex)
        {
            throw new ResultCanNotBeDeserializedException("There was an error deserializing the prompt.", ex);
        }

        if(jsonDeserializedResult is null) throw new ResultCanNotBeDeserializedException("Result is null after deserialization");
        return jsonDeserializedResult;
    }

    private static IEnumerable<ChatMessage> ConvertPrompt(Prompt prompt) => prompt.Messages.Select(ConvertMessage);

    private static ChatMessage ConvertMessage(Message message) 
        => message.Role switch
        {
            Role.Assistant => ChatMessage.CreateAssistantMessage(message.Content),
            Role.System => ChatMessage.CreateSystemMessage(message.Content),
            Role.User => ChatMessage.CreateUserMessage(message.Content),
            _ => throw new ArgumentOutOfRangeException(nameof(message.Role), message.Role, "unknown role")
        };
}