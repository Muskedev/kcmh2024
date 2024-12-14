using BriansBrainlab.Api;
using BriansBrainlab.Shared;

var builder = WebApplication.CreateBuilder(args);

builder.ConfigureOpenTelemetry();
builder.ConfigureSharedServices();

var app = builder.Build();


app.MapGet("/", () => "Hello World!");

app.Run();