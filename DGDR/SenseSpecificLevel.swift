//
//  SenseSpecificLevel.swift
//  DGDR
//
//  Created by 석민솔 on 8/9/25.
//

import Foundation

enum SenseSpecificLevel: String, Hashable {
    case nonSense
    
    case ear
    case eye
    case nose
    case touch
    
    case eareye
    case earnose
    case eartouch
    case eyenose
    case eyetouch
    case nosetouch
    
    case eareyenose
    case eareyetouch
    case earnosetouch
    case eyenosetouch
    
    case allSense
}

extension SenseSpecificLevel {
    // code로부터 SenseSpecificLevel 생성
    init?(code: String) {
        switch code {
        case "0000":
            self = .nonSense
        case "1000":
            self = .ear
        case "0100":
            self = .eye
        case "0010":
            self = .nose
        case "0001":
            self = .touch
        case "1100":
            self = .eareye
        case "1010":
            self = .earnose
        case "1001":
            self = .eartouch
        case "0110":
            self = .eyenose
        case "0101":
            self = .eyetouch
        case "0011":
            self = .nosetouch
        case "1110":
            self = .eareyenose
        case "1101":
            self = .eareyetouch
        case "1011":
            self = .earnosetouch
        case "0111":
            self = .eyenosetouch
        case "1111":
            self = .allSense
        default:
            return nil
        }
    }
}


extension SenseSpecificLevel {
    /// 큰 범위
    var bigCase: SenseLevel {
        switch self {
        case .nonSense:
                .nonSense
        case .ear, .eye, .nose, .touch:
                .singleSense(Sense(rawValue: self.rawValue)!)
            
        case .eareye, .earnose, .eartouch, .eyenose, .eyetouch, .nosetouch:
                .doubleSense
            
        case .eareyenose, .eareyetouch, .earnosetouch, .eyenosetouch:
                .tripleSense
        case .allSense:
                .allSense
        }
    }
    
    // SenseLevel을 코드로 변환하는 static 함수
    var code: String {
        switch self {
        // 감각 없음
        case .nonSense:
            return "0000"
        
        // 단일 감각 (1개)
        case .ear:
            return "1000"  // ear만
        case .eye:
            return "0100"  // eye만
        case .nose:
            return "0010"  // nose만
        case .touch:
            return "0001"  // touch만
        
        // 이중 감각 (2개)
        case .eareye:
            return "1100"  // ear + eye
        case .earnose:
            return "1010"  // ear + nose
        case .eartouch:
            return "1001"  // ear + touch
        case .eyenose:
            return "0110"  // eye + nose
        case .eyetouch:
            return "0101"  // eye + touch
        case .nosetouch:
            return "0011"  // nose + touch
        
        // 삼중 감각 (3개)
        case .eareyenose:
            return "1110"  // ear + eye + nose
        case .eareyetouch:
            return "1101"  // ear + eye + touch
        case .earnosetouch:
            return "1011"  // ear + nose + touch
        case .eyenosetouch:
            return "0111"  // eye + nose + touch
        
        // 모든 감각
        case .allSense:
            return "1111"  // 모든 감각 활성화
        }
    }
    
    var senses: [Sense] {
        switch self {
        case .nonSense:
            return []
        case .ear:
            return [.ear]
        case .eye:
            return [.eye]
        case .nose:
            return [.nose]
        case .touch:
            return [.touch]
        case .eareye:
            return [.ear, .eye]
        case .earnose:
            return [.ear, .nose]
        case .eartouch:
            return [.ear, .touch]
        case .eyenose:
            return [.eye, .nose]
        case .eyetouch:
            return [.eye, .touch]
        case .nosetouch:
            return [.nose, .touch]
        case .eareyenose:
            return [.ear, .eye, .nose]
        case .eareyetouch:
            return [.ear, .eye, .touch]
        case .earnosetouch:
            return [.ear, .nose, .touch]
        case .eyenosetouch:
            return [.eye, .nose, .touch]
        case .allSense:
            return [.ear, .eye, .nose, .touch]
        }
    }
}
