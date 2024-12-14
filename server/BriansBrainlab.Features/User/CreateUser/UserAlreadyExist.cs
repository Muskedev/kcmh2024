namespace BriansBrainlab.Features.User.CreateUser;

public class UserAlreadyExist(string userName) : Exception($"User {userName} already exists");