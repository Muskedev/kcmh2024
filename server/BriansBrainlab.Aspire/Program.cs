var builder = DistributedApplication.CreateBuilder(args);

builder.AddProject<Projects.BriansBrainlab_Api>("api");

builder.Build().Run();