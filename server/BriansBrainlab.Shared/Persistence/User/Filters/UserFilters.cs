using MongoDB.Driver;
using MongoDB.Bson;

namespace BriansBrainlab.Shared.Persistence.User.Filters;

public static class UserFilters
{
    private static readonly FilterDefinitionBuilder<PersistenceUser> Builder = Builders<PersistenceUser>.Filter;
    
    public static FilterDefinition<PersistenceUser> FindUserByName(string name) => Builder.Eq(u => u.Name, name);
}