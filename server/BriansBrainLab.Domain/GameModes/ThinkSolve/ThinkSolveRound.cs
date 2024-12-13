namespace BriansBrainLab.Domain.GameModes.ThinkSolve;

public record ThinkSolveRound(
    Guid Id,
    Guid UserId,
    IList<ThinkSolveQuestion> Questions,
    int Score = -1
);