namespace BriansBrainlab.Shared.AI;

public interface IPromptExecutor    
{
    public Task<T> ExecutePrompt<T>(Prompt prompt, JsonSchema? schema) where T : class;
}