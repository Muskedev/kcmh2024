namespace BriansBrainlab.Features.User.CreateUser;

public interface ICreateUserRepository
{
    Task<BriansBrainLab.Domain.User> InsertUser(BriansBrainLab.Domain.User user);
}