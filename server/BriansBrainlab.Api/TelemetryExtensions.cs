using OpenTelemetry;
using OpenTelemetry.Metrics;
using OpenTelemetry.Trace;

namespace BriansBrainlab.Api;

public static class TelemetryExtensions
{
    public static IHostApplicationBuilder ConfigureOpenTelemetry(this IHostApplicationBuilder builder)
    {
        builder.Logging.AddOpenTelemetry();

        builder.Services
            .AddOpenTelemetry()
            .WithMetrics(providerBuilder =>
            {
                providerBuilder.AddAspNetCoreInstrumentation()
                    .AddHttpClientInstrumentation()
                    .AddRuntimeInstrumentation();
            })
            .WithTracing(providerBuilder =>
            {
                providerBuilder.AddSource(builder.Environment.ApplicationName)
                    .AddAspNetCoreInstrumentation()
                    .AddHttpClientInstrumentation();
            })
            .UseOtlpExporter();
        
        return builder;
    }
}