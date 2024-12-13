namespace BriansBrainLab.Domain.GameModes.ThinkSolve;

public record ThinkSolveQuestion(
    Guid Id,
    string Question,
    string? UserAnswer,
    bool? CorrectAnswer,
    string? Explanation
);