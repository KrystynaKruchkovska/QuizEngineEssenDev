//
//  FlowTest.swift
//  QuizEngineTests
//
//  Created by Krystyna Kruchkovska on 10/20/19.
//  Copyright © 2019 Krystyna Kruchkovska. All rights reserved.
//

import Foundation
import XCTest
@testable import QuizEngine

class FlowTest: XCTestCase {
    let router = RouterSpy()
    // system under test
    func makeSUT(questions: [String], scoring: @escaping ([String:String]) -> Int = {_ in 0}) -> Flow<String, String, RouterSpy> {
        return Flow(questions: questions, router: router,scoring: scoring)
    }
    
    func test_start_withNoQuestions_doesNotRouteToQuestion(){
        makeSUT(questions: []).start()
    XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    func test_start_withOneQuestion_doesNotRouteToResult(){
        makeSUT(questions: ["Q1"]).start()
        XCTAssertNil(router.routedResult)
    }
    
    
    func test_start_withOneQuestions_routeToCorrectQuestion(){
        makeSUT(questions: ["Q1"]).start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withOneQuestions_routeToCorrectQuestion_2(){
      makeSUT(questions: ["Q2"]).start()
        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }
    
    func test_withTwoQuestions_routeToFirstQuestion(){
        makeSUT(questions: ["Q1", "Q2"]).start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withTwoQuestions_AnswerFirstQuestion_doesNotRouteToResult(){
        makeSUT(questions: ["Q1", "Q2"]).start()
        router.answerCallBack("A1")
        XCTAssertNil(router.routedResult)
    }
    
    func test_startTwice_withTwoQuestions_routeToFirstQuestionTwice(){
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        sut.start()
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }
    
    func test_startAndAnswearFirstQuestion_WithTwoQuestions_routeToSecondQuestion(){
        makeSUT(questions: ["Q1", "Q2"]).start()
        router.answerCallBack("A1")
        XCTAssertEqual(router.routedQuestions, ["Q1","Q2"])
    }
    
    func test_startAndAnswearFirstAndSecondQuestion_WithThreeQuestions_routeToThirdQuestion(){
        makeSUT(questions: ["Q1", "Q2", "Q3"]).start()
        router.answerCallBack("A1")
        router.answerCallBack("A1")
        XCTAssertEqual(router.routedQuestions, ["Q1","Q2", "Q3"])
    }
    
    
    func test_startAndAnswearFirstQuestion_WithOneQuestions_notRouteToAnotherQuestion(){
        makeSUT(questions: ["Q1"]).start()
        
        router.answerCallBack("A1")
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withNoQuestions_RouteEmptyREsult(){
        makeSUT(questions: []).start()
        XCTAssertEqual(router.routedResult!.answer, [:])
    }
    
    func test_startAndAnswearFirstQuestion_WithOneQuestions_RouteToResult(){
        makeSUT(questions: ["Q1"]).start()
        
        router.answerCallBack("A1")
        XCTAssertEqual(router.routedResult!.answer, ["Q1":"A1"])
    }
    
    func test_startAndAnswearFirstAndSecondQuestion_WithTwoQuestions_scoring(){
        let sut = makeSUT(questions: ["Q1", "Q2"], scoring: {_ in 10 })
        
        sut.start()
        
        router.answerCallBack("A1")
         router.answerCallBack("A1")
        XCTAssertEqual(router.routedResult!.score, 10)
    }
    
    func test_startAndAnswearFirstAndSecondQuestion_WithTwoQuestions_scorsWithRightAnswers(){
        
        var resivedAnswers = [String:String]()
        let sut = makeSUT(questions: ["Q1", "Q2"], scoring: {answers
            in
            resivedAnswers = answers
            return 20 })
        
        sut.start()
        
        router.answerCallBack("A1")
        router.answerCallBack("A2")
        XCTAssertEqual(resivedAnswers,["Q1":"A1","Q2":"A2"] )
    }
}
