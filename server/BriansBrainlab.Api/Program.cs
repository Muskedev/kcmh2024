using BriansBrainlab.Api;
using BriansBrainlab.Features;
using BriansBrainlab.Shared;

var builder = WebApplication.CreateBuilder(args);

builder.ConfigureOpenTelemetry();
builder.ConfigureSharedServices();
builder.AddBriansBrainlabFeatures();

var app = builder.Build();

app.MapGet("/", () => "Hello World!");

app.MapFeaturesRoutes();

app.Run();