using BriansBrainlab.Features.User.CreateUser;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Routing;

namespace BriansBrainlab.Features.User;

public static class EndpointBuilderExtensions
{
    public static IEndpointRouteBuilder MapUserRoutes(this IEndpointRouteBuilder endpoints)
    {
        endpoints.MapGroup("/user")
            .MapCreateUserEndpoint();
        
        return endpoints;
    }
}