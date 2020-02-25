//
//  Router.swift
//  QuizEngine
//
//  Created by Krystyna Kruchkovska on 10/23/19.
//  Copyright © 2019 Krystyna Kruchkovska. All rights reserved.
//

import Foundation

public protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer

    func routeTo(question: Question, answerCallBack: @escaping (Answer) -> ())
    func routeTo(result: Result<Question, Answer>)
}
