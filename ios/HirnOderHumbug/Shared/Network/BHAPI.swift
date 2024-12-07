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
    case createFunfactsRound(String)
    ///name
    case createUser(String)
    ///userId
    case getFinishedRounds(String, GameMode)
    ///userId, roundId, score, answered questions
    case finishFunfactsRound(String, String, Int, [AnsweredQuestion])
    
    case getLeaderboard(GameMode)
}
extension BHAPI: URLReqEndpoint {
    var path: String {
        switch self {
        case .createFunfactsRound(let string):
            "/gamemode/funFacts/create?userId=\(string)"
        case .createUser:
            "/user/create"
        case .getFinishedRounds(let string, let mode):
            "/gamemode/\(mode.apiPath)/getFinishedRounds?userId=\(string)"
        case .finishFunfactsRound(let userId, let roundId, _, _):
            "/gamemode/funFacts/finishRound?userId=\(userId)&roundId=\(roundId)"
        case .getLeaderboard(let mode):
            "/gamemode/\(mode.apiPath)/getLeaderboard"
        }
    }

    var method: MammutMethod {
        switch self {
        case .createFunfactsRound, .createUser:
            .post
        case .getFinishedRounds, .getLeaderboard:
            .get
        case .finishFunfactsRound:
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
        case .finishFunfactsRound(_, _, let score, let questions):
            var serializedQuestions: Any? = nil
            if let data = try? JSONEncoder().encode(questions), let serialized = try? JSONSerialization.jsonObject(with: data) {
                serializedQuestions = serialized
            }
            return [
            "score": score,
            "questions":serializedQuestions ?? "Failed"
            ]
        default: return [:]
        }
    }

    var encoding: Encoding {
        .json
    }
}

