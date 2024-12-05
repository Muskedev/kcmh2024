from .gamemode_enum import GameModeEnum

    
class LeaderboardEntry:
    name: str
    score: int
    rank: int
    
    def __init__(self, name: str, score: int, rank: int):
        self.name = name
        self.score = score
        self.rank = rank
        
class Leaderboard:
    game_mode: GameModeEnum
    entries: list[LeaderboardEntry]
    
    def __init__(self, game_mode: GameModeEnum, entries: list[LeaderboardEntry]):
        self.game_mode = game_mode
        self.entries = entries