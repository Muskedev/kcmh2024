using MongoDB.Driver;

namespace BriansBrainlab.Shared.Persistence.GameModes.Filters;

public static class ReallyRoundFilters
{
    private static readonly FilterDefinitionBuilder<PersistenceFunFactsRound> Builder = Builders<PersistenceFunFactsRound>.Filter;
    
    public static FilterDefinition<PersistenceFunFactsRound> FindReallyRoundById(string id) => Builder.Eq(rd => rd.Id, id);
}