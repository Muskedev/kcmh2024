# Database

## User
{
    "id": string
    "name": string
}

## Spielmodus FunFacts
{
    "id": string,
    "userId: string,
    "score": int,
    "questions": [
        {
            "question": string
            "userAnswer": bool?
            "isCorrect": bool?
            "explanation": string
        }
    ]
}


## Spielmodus GenialDaneben
{
    "id": string,
    "questions": [
        {
            "question": string
            "userAnswer": string?
            "isCorrect": bool?
            "explanation": string
        }
    ]
}