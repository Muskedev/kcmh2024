var builder = DistributedApplication.CreateBuilder(args);

builder.AddProject<Projects.BriansBrianlab_Api>("api");

builder.Build().Run();