namespace BriansBrainLab.Domain.GameModes.Really;

public record ReallyRound(
    Guid Id,
    Guid UserId,
    IList<ReallyQuestion> Questions,
    int Score = -1
);