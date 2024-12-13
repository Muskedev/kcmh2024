namespace BriansBrainLab.Domain.GameModes;

public record Leaderboard(
    GameModeEnum GameMode, 
    IList<LeaderBoardEntry> Entries
);