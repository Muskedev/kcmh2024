using System.ComponentModel.DataAnnotations;

namespace BriansBrainlab.Shared.Options;


public class MongoOptions
{
    [Required] public required string ConnectionString { get; init; }
    [Required] public required string Database { get; init; } = "BriansBrainlab";
    [Required] public required string ThinkSolveCollection { get; init; } = "thinkSolveRounds";
    [Required] public required string FunFactsCollection { get; init; } = "funFactsRounds";
    [Required] public required string UserCollection { get; init; } = "users";
}