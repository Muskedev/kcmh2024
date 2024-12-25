namespace BriansBrainlab.Shared.AI;

public enum Role
{
    User,
    Assistant,
    System
}

public record Message(Role Role, string Content);

public record Prompt(IList<Message> Messages);

public record JsonSchema(string Schema, string Name);