namespace BriansBrainlab.Shared.Persistence.User.Mappers;

public static class UserMappers
{
    public static BriansBrainLab.Domain.User FromPersistence(PersistenceUser persistenceUser)
        => new(
            id: Guid.Parse(persistenceUser.Id!),
            name: persistenceUser.Name!
        );

    public static PersistenceUser  FromDomain(BriansBrainLab.Domain.User user)
        => new()
        {
            Id = user.Id.ToString(),
            Name = user.Name,
        };
}