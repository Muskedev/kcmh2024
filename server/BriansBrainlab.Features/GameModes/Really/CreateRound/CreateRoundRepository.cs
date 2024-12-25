using BriansBrainLab.Domain.GameModes.Really;
using BriansBrainlab.Shared.Persistence.GameModes;
using BriansBrainlab.Shared.Persistence.GameModes.Filters;
using BriansBrainlab.Shared.Persistence.GameModes.Mappers;
using MongoDB.Driver;

namespace BriansBrainlab.Features.GameModes.Really.CreateRound;

public class CreateRoundRepository(IMongoCollection<PersistenceFunFactsRound> collection)
{
    private readonly IMongoCollection<PersistenceFunFactsRound> _collection = collection;

    public async Task Insert(ReallyRound round)
    {
        if (await _collection.CountDocumentsAsync(ReallyRoundFilters.FindReallyRoundById(round.Id.ToString())) > 0)
            throw new ReallyRoundAlreadyExists();
        
        await _collection.InsertOneAsync(ReallyRoundMappers.FromDomain(round));
    }
}