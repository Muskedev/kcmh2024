namespace BriansBrainlab.Features.User.CreateUser;

public interface ICreateUserRepository
{
    Task InsertUser(BriansBrainLab.Domain.User user);
}