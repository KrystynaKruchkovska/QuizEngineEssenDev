//
//  Flow.swift
//  QuizEngine
//
//  Created by Krystyna Kruchkovska on 10/20/19.
//  Copyright © 2019 Krystyna Kruchkovska. All rights reserved.
//

import Foundation

class Flow <Question, Answer:Equatable, R:Router> where R.Question == Question, R.Answer == Answer {
    
    private let router: R
    private let questions:[Question]
    private var answers: [Question:Answer] = [:]
    private var scoring: ([Question:Answer]) -> Int
    
    init(questions: [Question], router: R, scoring: @escaping ([Question:Answer]) -> Int){
        self.router = router
        self.questions = questions
        self.scoring = scoring
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion as! String, answerCallBack: nextCallBack(from: firstQuestion))
        } else {
            router.routeTo(result: result())
        }
    }
    
    private func nextCallBack(from question: Question) -> (Answer) -> (){
        return { answer in
            self.routeToNext(question, answer)
        }
    }
    
    private func routeToNext(_ question: Question, _ answer: Answer) {
        if let currentQuestionIndex =
            self.questions.firstIndex(of: question) {
            self.answers[question] = answer
            let nextQuestionIndex = currentQuestionIndex+1
            if nextQuestionIndex < self.questions.count {
                let nextQuestion = self.questions[nextQuestionIndex]
                self.router.routeTo(question: nextQuestion as! String , answerCallBack: self.nextCallBack(from: nextQuestion))
            } else {
                self.router.routeTo(result: result())
            }
        }
    }
    
    private func result() -> Result<Question, Answer> {
        return Result(answer: answers, score: scoring(answers))
    }
}
