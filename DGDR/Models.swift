//
//  Models.swift
//  DGDR
//
//  Created by 석민솔 on 8/9/25.
//

import Foundation
import SwiftData

@Model
class QnA {
    var number: Int
    var answer: Int
    
    init(number: Int, answer: Int) {
        self.number = number
        self.answer = answer
    }
}

@Model
class User {
    var qnaList: [QnA]
    var senseType: SenseLevel
    
    init(qnaList: [QnA], senseTypeCode: String) {
        self.qnaList = qnaList
        self.senseType = SenseLevel(code: senseTypeCode) ?? .nonSense
    }
}

