using BriansBrainlab.Features.User;
using Microsoft.Extensions.Hosting;

namespace BriansBrainlab.Features;

public static class WebHostBuilderExtensions
{
    public static IHostApplicationBuilder AddBriansBrainlabFeatures(this IHostApplicationBuilder builder)
    {
        builder.AddUserFeatures();
        
        return builder;
    }
}