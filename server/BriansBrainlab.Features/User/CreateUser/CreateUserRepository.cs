using BriansBrainlab.Shared.Persistence;
using BriansBrainlab.Shared.Persistence.User;
using BriansBrainlab.Shared.Persistence.User.Filters;
using BriansBrainlab.Shared.Persistence.User.Mappers;
using MongoDB.Driver;

namespace BriansBrainlab.Features.User.CreateUser;

public class CreateUserRepository(IMongoCollection<PersistenceUser> collection) : ICreateUserRepository
{
    private IMongoCollection<PersistenceUser> Collection { get; init; } = collection;

    public async Task<BriansBrainLab.Domain.User> InsertUser(BriansBrainLab.Domain.User user)
    {
        if (await Collection.CountDocumentsAsync(UserFilters.FindUserByName(user.Name),
                new CountOptions { Limit = 1 }) > 0)
            throw new UserAlreadyExist(user.Name);
        
        await Collection.InsertOneAsync(UserMappers.FromDomain(user));

        return user;
    }
}