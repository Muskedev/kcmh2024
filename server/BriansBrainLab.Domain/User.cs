using CommunityToolkit.Diagnostics;

namespace BriansBrainLab.Domain;

public record User
{
    public Guid Id { get; }
    public string Name { get; }

    public User(Guid? id, string name)
    {
        Guard.IsNotNullOrEmpty(name);
        if(id is not null) Guard.IsNotDefault(id.Value);
        
        Id = id ?? Guid.NewGuid();
        Name = name;
    }
}