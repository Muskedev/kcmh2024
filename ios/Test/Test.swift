//
//  Test.swift
//  Test
//
//  Created by Mia Koring on 05.12.24.
//

import XCTest

final class Test: XCTestCase {
    var userId: String = "40d908b8-e0b6-4a4d-8a85-0ecb8a27eee2"
    let roundId = "9cb8ec95-e092-4d84-9083-3e435a33a1ec"
    

    func testCreateUser() async throws {
        let res = await BHController.request(.createUser("Testuser11234"), expected: UserCreationResponse.self)
        switch res {
        case .success(let success):
            userId = success.id
            print(userId)
        case .failure(let failure):
            print(failure.localizedDescription)
        }
    }
    
    func testCreateFunfactsRound() async throws {
        let res = await BHController.request(.createFunfactsRound(userId), expected: FinishedFunfactsRound.self)
        switch res {
        case .success(let success):
            print(success)
        case .failure(let failure):
            print(failure.localizedDescription)
        }
    }
    
    func testFinishRound() async throws {
        let res = await BHController.request(.finishFunfactsRound(userId, roundId, 30, [
            AnsweredQuestion(id: "d1d54664-9d8e-4145-8733-82e0243a4424", userAnswer: false),
            AnsweredQuestion(id: "76c63006-a38d-4f6c-b5e5-9ab04bea990a", userAnswer: false),
            AnsweredQuestion(id: "2fbf59e0-177b-486d-8993-b017002e9911", userAnswer: false),
            AnsweredQuestion(id: "f28e455f-359a-408a-8e56-0bd9200b7894", userAnswer: false),
            AnsweredQuestion(id: "dc77e46b-dcee-44d8-9a31-0bb99bb1912d", userAnswer: false),
            AnsweredQuestion(id: "3747ffcd-b04d-441e-979e-bf4b18a71ab5", userAnswer: false),
            AnsweredQuestion(id: "1402aabb-c120-4ad1-a66d-da96aa7172ae", userAnswer: false),
            AnsweredQuestion(id: "ddb27211-2c61-4b86-8e1c-759ecf580d58", userAnswer: false),
            AnsweredQuestion(id: "2b71a3a4-1a87-48b3-a46c-9e405c52d2f9", userAnswer: false),
            AnsweredQuestion(id: "e0d53b4f-48b6-45c0-9706-20061cefb979", userAnswer: false)
        ]), expected: FinishedFunfactsRound.self)
        switch res {
        case .success(let success):
            print("Test")
            print(success.userId)
        case .failure(let failure):
            print("test")
            print(failure)
        }
    }

}
