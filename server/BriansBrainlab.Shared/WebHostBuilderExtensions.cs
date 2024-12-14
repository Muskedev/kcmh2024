using BriansBrainlab.Shared.Persistence;
using Microsoft.Extensions.Hosting;

namespace BriansBrainlab.Shared;

public static class WebHostBuilderExtensions
{
    public static IHostApplicationBuilder ConfigureSharedServices(this IHostApplicationBuilder builder)
    {
        builder.ConfigurePersistence();
        
        return builder;
    }
}