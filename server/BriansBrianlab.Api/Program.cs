using BriansBrianlab.Api;

var builder = WebApplication.CreateBuilder(args);

builder.ConfigureOpenTelemetry();

var app = builder.Build();


app.MapGet("/", () => "Hello World!");

app.Run();