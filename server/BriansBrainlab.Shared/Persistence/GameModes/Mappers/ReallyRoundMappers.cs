using BriansBrainLab.Domain.GameModes.Really;

namespace BriansBrainlab.Shared.Persistence.GameModes.Mappers;

public static class ReallyRoundMappers
{
    public static ReallyRound FromPersistence(PersistenceFunFactsRound persistenceReallyRound)
        => new(
            id: Guid.Parse(persistenceReallyRound.Id!),
            userId: Guid.Parse(persistenceReallyRound.UserId!),
            score: persistenceReallyRound.Score!.Value,
            questions: persistenceReallyRound.Questions?.Select(
                q => new ReallyQuestion(
                    Id: Guid.Parse(q.Id!),
                    Question: q.Question!,
                    UserAnswer: q.UserAnswer,
                    CorrectAnswer: q.CorrectAnswer!.Value,
                    Explanation: q.Explanation!
                )
            ).ToList()!
        );

    public static PersistenceFunFactsRound FromDomain(ReallyRound reallyRound)
        => new()
        {
            Id = reallyRound.Id.ToString(),
            UserId = reallyRound.UserId.ToString(),
            Score = reallyRound.Score,
            Questions = reallyRound.Questions.Select(q => new PersistenceFunFactsQuestion
            {
                Id = q.Id.ToString(),
                Explanation = q.Explanation,
                Question = q.Question,
                UserAnswer = q.UserAnswer,
                CorrectAnswer = q.CorrectAnswer
            }).ToList()
        };
}