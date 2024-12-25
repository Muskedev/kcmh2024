using System.ComponentModel.DataAnnotations;

namespace BriansBrainlab.Shared.Options;

public class OpenAIOptions
{
    [Required]
    public required string ApiKey { get; init; }
}