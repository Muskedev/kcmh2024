using System.ComponentModel.DataAnnotations;

namespace BriansBrainlab.Shared.Settings;


public class MongoOptions
{
    [Required]
    public required string ConnectionString { get; init; }
    [Required]
    public required string Database { get; init; }
    [Required]
    public required string ThinkSolveCollection { get; init; }
    [Required]
    public required string FunFactsCollection { get; init; }
    [Required]
    public required string UserCollection { get; init; }
}