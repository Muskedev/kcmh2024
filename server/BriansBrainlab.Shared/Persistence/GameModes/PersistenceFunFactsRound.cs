namespace BriansBrainlab.Shared.Persistence.GameModes;

public class PersistenceFunFactsQuestion
{
    public string? Id { get; set; }
    public string? Question { get; set; }
    public bool? UserAnswer { get; set; }
    public bool? CorrectAnswer { get; set; }
    public string? Explanation { get; set; }
}

public class PersistenceFunFactsRound
{
    public string? Id { get; set; }
    public string? UserId { get; set; }
    public IList<PersistenceFunFactsQuestion>? Questions { get; set; }
    public int? Score { get; set; }
}