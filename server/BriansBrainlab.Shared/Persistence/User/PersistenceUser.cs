using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace BriansBrainlab.Shared.Persistence.User;

public class PersistenceUser
{
    [BsonElement("_id")]
    [BsonId]
    [BsonRepresentation(BsonType.ObjectId)]
    public string? MongoId { get; init; }
    public string? Id { get; init; }
    public string? Name { get; init; }
}