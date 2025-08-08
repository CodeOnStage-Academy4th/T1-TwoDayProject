//
//  SenseScoring.swift
//  DGDR
//
//  Created by ellllly on 8/9/25.
//

import Foundation


// 예민/무던
enum Sensitivity: String, Codable {
    case sensitive = "예민"
    case mellow    = "무던"
}

// 사용자가 고른 보기 인덱스(1~4) -> 가중치: 1,2=0 / 3,4=1
@inline(__always)
func highWeight(for choiceIndex: Int) -> Int {
    return (3...4).contains(choiceIndex) ? 1 : 0
}

// 질문ID -> 감각 매핑 (MockData 기준: 1~4=청각, 5~8=시각, 9~12=후각, 13~16=촉각)
let questionSense: [Int: Sense] = [
    // 청각(ear)
    1: .ear, 2: .ear, 3: .ear, 4: .ear,
    // 시각(eye)
    5: .eye, 6: .eye, 7: .eye, 8: .eye,
    // 후각(nose)
    9: .nose, 10: .nose, 11: .nose, 12: .nose,
    // 촉각(touch)
    13: .touch, 14: .touch, 15: .touch, 16: .touch
]

// 메인 함수: 응답으로부터 감각별 예민/무던 + SenseLevel 산출
// 중요: SenseLevel 비트 순서는 eye(0), nose(1), ear(2), touch(3)
func scoreSense(
    responses: [Int: Int]
) -> (
    perSense: [Sense: Sensitivity],
    highCounts: [Sense: Int],
    level: SenseLevel
) {
    // 1) 감각별 고자극(3,4) 카운트
    var highBySense: [Sense: Int] = [.ear: 0, .eye: 0, .nose: 0, .touch: 0]
    
    for (qid, choice) in responses {
        guard let sense = questionSense[qid] else { continue }
        highBySense[sense, default: 0] += highWeight(for: choice)
    }
    
    // 2) 4문항 중 고자극이 3개 이상이면 "예민", 아니면 "무던"
    var resultBySense: [Sense: Sensitivity] = [:]
    for sense in [Sense.ear, .eye, .nose, .touch] {
        let high = highBySense[sense, default: 0]
        resultBySense[sense] = (high >= 3) ? .sensitive : .mellow
    }
    
    // 3) SenseLevel 코드 생성 — 반드시 eye, nose, ear, touch 순서로!
    // SenseLevel.getSenseLevel(from:)가 이 순서를 전제로 함.
    let codeChars: [Character] = [
        resultBySense[.eye]   == .sensitive ? "1" : "0",  // eye -> index 0
        resultBySense[.nose]  == .sensitive ? "1" : "0",  // nose -> index 1
        resultBySense[.ear]   == .sensitive ? "1" : "0",  // ear -> index 2
        resultBySense[.touch] == .sensitive ? "1" : "0",  // touch -> index 3
    ]
    let code = String(codeChars)
    
    // 4) SenseLevel 변환 (안전 fallback)
    let level = SenseLevel.getSenseLevel(from: code) ?? .nonSense
    
    return (resultBySense, highBySense, level)
}
