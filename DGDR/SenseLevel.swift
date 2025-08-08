//
//  SenseLevel.swift
//  DGDR
//
//  Created by 석민솔 on 8/9/25.
//

import Foundation

/**
 
 ## 사용 예시
 ```swift
 func testSenseLevelUsage() {
     // code로 생성
     if let level1 = SenseLevel(code: "1000") {
         print(level1) // singleSense(.eye)
         print(level1.code) // "1000"
     }
     
     // rawValue로 생성
     if let level2 = SenseLevel(rawValue: "doubleSense_ear_touch") {
         print(level2) // doubleSense(.ear, .touch)
         print(level2.code) // "0011"
     }
     
     // 직접 생성
     let level3 = SenseLevel.singleSense(.eye)
     print(level3.rawValue) // "singleSense_eye"
     print(level3.code) // "1000"
     
     // static 메서드 사용
     if let level4 = SenseLevel.getSenseLevel(from: "1111") {
         print(level4) // allSense
     }
     
     let code = SenseLevel.getCode(from: .nonSense)
     print(code) // "0000"
 }
 ```
 
 */

enum SenseLevel: Codable, CaseIterable, Hashable {
    static var allCases: [SenseLevel] = [
        .nonSense, .singleSense(.ear), .singleSense(.eye), .singleSense(.nose), .singleSense(.touch), .doubleSense,.tripleSense, .allSense
    ]
    
    case nonSense
    case singleSense(Sense)
    case doubleSense
    case tripleSense
    case allSense
    
    
    // code로부터 SenseLevel 생성
    init?(code: String) {
        guard let senseLevel = SenseLevel.getSenseLevel(from: code) else {
            return nil
        }
        self = senseLevel
    }
}

// MARK: - Static Helper Methods
extension SenseLevel {
    // 코드를 SenseLevel로 변환하는 static 함수
    static func getSenseLevel(from code: String) -> SenseLevel? {
        guard code.count == 4,
              code.allSatisfy({ $0 == "0" || $0 == "1" }) else {
            return nil
        }
        
        let codeArray = Array(code)
        var activeSenses: [Sense] = []
        
        // 각 비트 위치에 따른 감각 확인
        if codeArray[0] == "1" { activeSenses.append(.ear) }
        if codeArray[1] == "1" { activeSenses.append(.eye) }
        if codeArray[2] == "1" { activeSenses.append(.nose) }
        if codeArray[3] == "1" { activeSenses.append(.touch) }
        
        // 활성화된 감각 수에 따라 SenseLevel 반환
        switch activeSenses.count {
        case 0:
            return .nonSense
        case 1:
            return .singleSense(activeSenses[0])
        case 2:
            return .doubleSense
        case 3:
            return .tripleSense
        case 4:
            return .allSense
        default:
            return nil
        }
    }
}
