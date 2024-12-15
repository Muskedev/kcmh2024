namespace BriansBrainLab.Domain.GameModes.Really;

public record ReallyQuestion(
    Guid Id,
    string Question,
    bool? UserAnswer,
    bool CorrectAnswer,
    string Explanation
);