namespace BriansBrainlab.Shared.AI;

public class ResultCanNotBeDeserializedException(string message, Exception? innerException = null)
    : Exception(message, innerException);