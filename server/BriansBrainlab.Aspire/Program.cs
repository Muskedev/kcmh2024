var builder = DistributedApplication.CreateBuilder(args);

var mongo = builder.AddMongoDB("mongo")
    .WithMongoExpress()
    .WithLifetime(ContainerLifetime.Persistent);

builder.AddProject<Projects.BriansBrainlab_Api>("api")
    .WithEnvironment("Mongo__ConnectionString", mongo)
    .WaitFor(mongo);

builder.Build().Run();