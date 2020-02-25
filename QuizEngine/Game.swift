//
//  Game.swift
//  QuizEngine
//
//  Created by Krystyna Kruchkovska on 10/23/19.
//  Copyright © 2019 Krystyna Kruchkovska. All rights reserved.
//

import Foundation

public class Game <Question, Answer: Equatable, R: Router> where R.Question == Question, R.Answer == Answer {
    let flow: Flow <Question, Answer, R>
    init(flow:Flow <Question, Answer, R>) {
        self.flow = flow
    }
}

public func startGame<Question, Answer: Equatable, R: Router>(questions: [Question], router: R, correctAnswer: [Question:Answer]) -> Game<Question, Answer, R> where R.Question == Question, R.Answer == Answer {
    let flow = Flow(questions: questions, router: router, scoring: { scoring(answers: $0, correctAnswer: correctAnswer)})
    flow.start()
    return Game(flow: flow)
    
}

public func scoring<Question, Answer: Equatable>(answers:[Question:Answer], correctAnswer:[Question:Answer]) -> Int {
    return answers.reduce(0) { (score, tuple) in
        return score + (correctAnswer[tuple.key] == tuple.value ? 1 : 0 )
    }
}
