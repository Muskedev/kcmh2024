namespace BriansBrainLab.Domain.GameModes.FunFacts;

public record FunFactsQuestion(
    Guid Id,
    string Question,
    bool? UserAnswer,
    bool CorrectAnswer,
    string Explanation
);