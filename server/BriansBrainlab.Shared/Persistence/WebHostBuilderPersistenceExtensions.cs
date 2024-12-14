using BriansBrainlab.Shared.Settings;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Options;
using MongoDB.Driver;

namespace BriansBrainlab.Shared.Persistence;

public static class WebHostBuilderPersistenceExtensions
{
    public static IHostApplicationBuilder ConfigurePersistence(this IHostApplicationBuilder builder)
    {
        builder.Services
            .AddOptions<MongoOptions>()
            .BindConfiguration("Mongo")
            .ValidateDataAnnotations()
            .ValidateOnStart();
        
        
        var serviceProvider = builder.Services.BuildServiceProvider();
        var mongoOptions = serviceProvider.GetRequiredService<IOptions<MongoOptions>>().Value;

        var database = new MongoClient(mongoOptions.ConnectionString).GetDatabase(mongoOptions.Database);
        
        builder.Services.AddSingleton(database.GetCollection<PersistenceUser>(mongoOptions.UserCollection));
        
        
        return builder;
    }
}