using CommunityToolkit.Diagnostics;

namespace BriansBrainLab.Domain.GameModes.Really;

public record ReallyRound
{
    public Guid Id { get; }
    public Guid UserId { get; }
    public IList<ReallyQuestion> Questions { get; }
    public int Score { get; }
    
    public ReallyRound(
        Guid id,
        Guid userId,
        IList<ReallyQuestion> questions,
        int score = -1)
    {
        Guard.IsGreaterThanOrEqualTo(score, -1, nameof(score));
        
        Id = id;
        UserId = userId;
        Questions = questions;
        Score = score;
    }
}