using BriansBrainlab.Features.User.CreateUser;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

namespace BriansBrainlab.Features.User;

public static class WebHostBuilderExtensions
{
    public static IHostApplicationBuilder AddUserFeatures(this IHostApplicationBuilder builder)
    {
        builder.Services.AddSingleton<ICreateUserRepository, CreateUserRepository>();
        
        return builder;
    }
}