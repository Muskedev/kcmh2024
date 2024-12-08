//
//  BHAPI.swift
//  HirnOderHumbug
//
//  Created by Mia Koring on 02.12.24.
//
import Foundation
import Mammut

enum BHAPI {
    ///userId
    case createRound(String, GameMode)
    ///name
    case createUser(String)
    ///userId
    case getFinishedRounds(String, GameMode)
    ///userId, roundId, score, answered questions
    case finishRound(GameMode, String, String, Int, [AnsweredQuestion])
    /// userid, roundId, questionid, answer
    case answerQuestion(String, String, String, String)
    
    case getLeaderboard(GameMode)
}
extension BHAPI: URLReqEndpoint {
    var path: String {
        switch self {
        case .createRound(let string, let mode):
            "/gamemode/\(mode.apiPath)/create?userId=\(string)"
        case .createUser:
            "/user/create"
        case .getFinishedRounds(let string, let mode):
            "/gamemode/\(mode.apiPath)/getFinishedRounds?userId=\(string)"
        case .finishRound(let mode, let userId, let roundId, _, _):
            "/gamemode/\(mode.apiPath)/finishRound?userId=\(userId)&roundId=\(roundId)"
        case .getLeaderboard(let mode):
            "/gamemode/\(mode.apiPath)/getLeaderboard"
        case .answerQuestion(let userId, let roundId, _, _):
            "/gamemode/thinkSolve/answerQuestion?userId=\(userId)&roundId=\(roundId)"
        }
    }

    var method: MammutMethod {
        switch self {
        case .createRound, .createUser:
            .post
        case .getFinishedRounds, .getLeaderboard:
            .get
        case .finishRound, .answerQuestion:
            .put
        }
    }

    var headers: [MammutHeader] {
        []
    }
    
    var urlReqHeaders: [String: String] {
        [:]
    }

    var parameters: [String : Any] {
        switch self {
        case .createUser(let name):
            return ["name": name]
        case .finishRound(let mode, _, _, let score, let questions):
            var serializedQuestions: Any? = nil
            if let data = try? JSONEncoder().encode(questions), let serialized = try? JSONSerialization.jsonObject(with: data) {
                serializedQuestions = serialized
            }
            if mode == .really {
                return [
                    "score": score,
                    "questions":serializedQuestions ?? "Failed"
                ]
            } else {
                return [
                    "score": score
                ]
            }
        case .answerQuestion(_, _, let questionId, let answer):
            return [
                "questionId": questionId,
                "userAnswer": answer
            ]
        default: return [:]
        }
    }

    var encoding: Encoding {
        .json
    }
}

