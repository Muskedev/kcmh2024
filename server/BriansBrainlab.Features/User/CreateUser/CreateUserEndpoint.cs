using Microsoft.AspNetCore.Builder;

namespace BriansBrainlab.Features.User.CreateUser;

public record CreateUserRequest(string Name);

public static class CreateUserEndpoint
{
    public static void Map(WebApplication app)
    {
        app.MapPost("/createUser", async (CreateUserRequest createUserRequest) =>
        {
            
        });
    }
}