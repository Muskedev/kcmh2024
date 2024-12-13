namespace BriansBrainLab.Domain.GameModes;

public record LeaderBoardEntry(
    string Username,
    int Score,
    int Rank
);