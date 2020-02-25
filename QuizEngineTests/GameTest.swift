//
//  GameTest.swift
//  QuizEngineTests
//
//  Created by Krystyna Kruchkovska on 10/23/19.
//  Copyright © 2019 Krystyna Kruchkovska. All rights reserved.
//

import Foundation
import XCTest
import QuizEngine

class GameTest: XCTestCase {
    let router = RouterSpy()
    var game: Game<String, String, RouterSpy>!
    
    override func setUp() {
        super.setUp()
       game = startGame(questions:["Q1", "Q2"], router: router, correctAnswer:["Q1":"A1", "Q2":"A2"])
    }
    
    func test_answerZeroOutOfTwoQuestionCorrectly_Score0(){
        router.answerCallBack("wrong")
        router.answerCallBack("wrong")
        XCTAssertEqual(router.routedResult!.score, 0)
    }
    
    func test_answerOneOutOfTwoQuestionCorrectly_Score1(){
        router.answerCallBack("A1")
        router.answerCallBack("wrong")
        XCTAssertEqual(router.routedResult!.score, 1)
    }
    
    func test_answerTwoOutOfTwoQuestionCorrectly_Score2(){
        router.answerCallBack("A1")
        router.answerCallBack("A2")
        XCTAssertEqual(router.routedResult!.score, 2)
    }
    
}
