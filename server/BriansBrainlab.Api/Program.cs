using BriansBrainlab.Api;
using BriansBrainlab.Features;
using BriansBrainlab.Shared;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddOpenApi();
builder.ConfigureOpenTelemetry();
builder.ConfigureSharedServices();
builder.AddBriansBrainlabFeatures();

var app = builder.Build();

app.MapOpenApi();

if (app.Environment.IsDevelopment())
{
    app.UseSwaggerUI(options =>
    {
        options.SwaggerEndpoint("/openapi/v1.json", "v1");
    });
}

app.MapGet("/", () => "Hello World!");

app.MapFeaturesRoutes();

app.Run();