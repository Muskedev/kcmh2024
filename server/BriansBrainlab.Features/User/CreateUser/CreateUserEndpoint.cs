using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Routing;

namespace BriansBrainlab.Features.User.CreateUser;

public record CreateUserRequest(string Name);
public record CreateUserResponse(string Id, string Name);

public static class CreateUserEndpoint
{
    public static RouteGroupBuilder MapCreateUserEndpoint(this RouteGroupBuilder group)
    {
        group.MapPost("/createUser", async (CreateUserRequest createUserRequest, ICreateUserRepository createUserRepository) =>
        {
            var user = new BriansBrainLab.Domain.User(name: createUserRequest.Name, id: null);

            try
            {
                await createUserRepository.InsertUser(user);
            }
            catch (UserAlreadyExist _)
            {
                return Results.BadRequest("User already exists");
            }

            return TypedResults.Ok(new CreateUserResponse(
                Id: user.Id.ToString(),
                Name: user.Name
            ));
        });
        
        return group;
    }
}