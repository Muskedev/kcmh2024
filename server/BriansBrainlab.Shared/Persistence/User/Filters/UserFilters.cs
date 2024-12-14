using MongoDB.Driver;
using MongoDB.Bson;

namespace BriansBrainlab.Shared.Persistence.User.Filters;

public static class UserFilters
{
    private static FilterDefinitionBuilder<PersistenceUser> _builder = Builders<PersistenceUser>.Filter;
    
    public static FilterDefinition<PersistenceUser> FindUserByName(string name) => _builder.Eq(u => u.Name, name);
}