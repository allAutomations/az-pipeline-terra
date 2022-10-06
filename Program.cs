var builder = WebApplication.CreateBuilder(args);

string env;

IConfiguration config = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build();
env = config.GetSection("EnvName").Value;


// Add services to the container.

builder.Services.AddControllers();
builder.Configuration.AddJsonFile("appsettings.json").AddJsonFile($"appsettings.{env}.json");

var app = builder.Build();

// Configure the HTTP request pipeline.

app.UseAuthorization();

app.MapControllers();

app.Run();
