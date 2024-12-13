namespace BriansBrainLab.Domain.GameModes.FunFacts;

public record FunFactsRound(
    Guid Id,
    Guid UserId,
    IList<FunFactsQuestion> Questions,
    int Score = -1
);