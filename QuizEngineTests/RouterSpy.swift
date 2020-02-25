//
//  RouterSpy.swift
//  QuizEngine
//
//  Created by Krystyna Kruchkovska on 10/23/19.
//  Copyright © 2019 Krystyna Kruchkovska. All rights reserved.
//

import Foundation
import QuizEngine

class RouterSpy: Router {

    
    var routedResult: Result<String, String>? = nil
    var routedQuestions: [String] = []
    var answerCallBack: ((String) -> ()) = { _ in }
    
    func routeTo(question: String, answerCallBack: @escaping (String) ->() ) {
        routedQuestions.append(question)
        self.answerCallBack = answerCallBack
    }

    
    func routeTo(result: Result<String, String>) {
        self.routedResult = result
      }
}
