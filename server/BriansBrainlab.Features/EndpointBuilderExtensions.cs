using BriansBrainlab.Features.User;
using Microsoft.AspNetCore.Routing;

namespace BriansBrainlab.Features;

public static class EndpointBuilderExtensions
{
    public static IEndpointRouteBuilder MapFeaturesRoutes(this IEndpointRouteBuilder endpoints)
    {
        endpoints.MapUserRoutes();        
        
        return endpoints;
    }
}