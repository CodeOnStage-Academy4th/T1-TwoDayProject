//
//  MockData.swift
//  DGDR
//
//  Created by ellllly on 8/9/25.
//

import Foundation

struct MockData {
    static let questions: [Question] = [
        Question(
            id: 1,
            text: "방 안에 조명은 어디까지 허용가능한가요?",
            choices: [
                Choice(text: "잘 때는 완전 어두워야해요."),
                Choice(text: "노트북에서 나오는 빛까지는 괜찮아요."),
                Choice(text: "책상 스탠드까지는 괜찮아요."),
                Choice(text: "조명을 다 켜도 상관없어요.")
            ]
        ),
        Question(
            id: 2,
            text: "소음에 대한 민감도는 어떤가요?",
            choices: [
                Choice(text: "아주 민감해요(작은 소리도 신경쓰임)."),
                Choice(text: "조용하면 좋아요."),
                Choice(text: "어느 정도 소음은 괜찮아요."),
                Choice(text: "활기찬 분위기를 좋아해요.")
            ]
        ),
        Question(
            id: 3,
            text: "청소/정리 습관은?",
            choices: [
                Choice(text: "매일 정리하고 싶어요."),
                Choice(text: "주 1회 정리면 충분해요."),
                Choice(text: "한 번 어지르면 오래 가요."),
                Choice(text: "정리는 거의 안 해요.")
            ]
        )
    ]
}

struct Question: Identifiable {
    let id: Int
    let text: String
    let choices: [Choice]
}

struct Choice: Identifiable {
    let id = UUID()
    let text: String
}
