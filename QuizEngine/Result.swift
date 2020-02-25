//
//  Result.swift
//  QuizEngine
//
//  Created by Krystyna Kruchkovska on 10/23/19.
//  Copyright © 2019 Krystyna Kruchkovska. All rights reserved.
//

import Foundation

public struct Result<Question:Hashable, Answer> {
    public let answers:[Question:Answer]
    public let score: Int?
    
    public init(answers:[Question: Answer], score: Int) {
        self.answers = answers
        self.score = score
    }
}
