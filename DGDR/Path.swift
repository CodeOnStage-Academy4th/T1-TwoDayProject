//
//  Path.swift
//  DGDR
//
//  Created by 배현진 on 8/9/25.
//

import Foundation

enum Path: Hashable {
    case home
    case qna
    case typecheck(type: String, entry: EntryContext)
    case chemistry
    case report(qnaList: [QnA])
}
