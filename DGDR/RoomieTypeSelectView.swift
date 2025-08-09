//
//  RoomieTypeSelectView.swift
//  DGDR
//
//  Created by 석민솔 on 8/9/25.
//

import SwiftUI

struct RoomieTypeSelectView: View {
    @State var nextDisabled: Bool = true
    @State var selectedType: SenseLevel?
    @State var selectedCode: String? = nil
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        NavigationBar(
            title: "룸메 유형 선택하기",
            showBackButton: true,
            showPageButton: false
        )
        
        ScrollView {
            VStack {
                Text("룸메와의 궁합을 점쳐보기 위해\n룸메의 유형을 선택해주세요!")
                    .font(.system(size: 16, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.labelNormal)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 21)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(Color(red: 0.96, green: 0.96, blue: 0.96))
                    )
                    .padding(.bottom, 40)
                    .padding(.top, 12)
                
                ForEach(SenseLevel.allCases, id: \.self) { senseLevel in
                    VStack(spacing: 8) {
                        // 메인 SenseLevel 버튼
                        Button {
                            selectedType = senseLevel
                            // doubleSense나 tripleSense가 아닌 경우 바로 코드 설정
                            if case .doubleSense = senseLevel {
                                selectedCode = nil // 하위 선택 필요
                            } else if case .tripleSense = senseLevel {
                                selectedCode = nil // 하위 선택 필요
                            } else {
                                selectedCode = getCodeForSenseLevel(senseLevel)
                            }
                        } label: {
                            Text(
                                buttontitle(selectedType: senseLevel)
                            )
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(
                                    senseLevel == selectedType
                                    ? Color.labelSelected
                                    : Color.labelNormal
                                )
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.vertical, 20)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .foregroundStyle(
                                            senseLevel == selectedType
                                            ? Color(red: 1, green: 0.84, blue: 0.84)
                                            : Color.white
                                        )
                                )
                                .overlay {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(
                                            senseLevel == selectedType
                                            ? Color(red: 1, green: 0.69, blue: 0.69)
                                            : Color(red: 0.84, green: 0.82, blue: 0.8),
                                            lineWidth: 3
                                        )
                                        .foregroundStyle(Color.clear)
                                }
                        }
                        
                        // doubleSense나 tripleSense인 경우 세부 옵션 표시
                        if selectedType == senseLevel {
                            if case .doubleSense = senseLevel {
                                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 8) {
                                    ForEach(getDoubleSenseOptions(), id: \.self) { option in
                                        Button {
                                            selectedCode = option.code
                                        } label: {
                                            Text(option.code)
                                                .font(.system(size: 16, weight: .bold))
                                                .foregroundStyle(
                                                    selectedCode == option.code ? Color.labelSelected : Color.labelNormal
                                                )
                                                .padding(.vertical, 20)
                                                .frame(maxWidth: .infinity, alignment: .center)
                                                .background(
                                                    RoundedRectangle(cornerRadius: 16)
                                                        .foregroundStyle(
                                                            selectedCode == option.code
                                                            ? Color(red: 1, green: 0.69, blue: 0.69)
                                                            : Color(red: 0.95, green: 0.95, blue: 0.95)
                                                        )
                                                )
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 16)
                                                        .stroke(
                                                            selectedCode == option.code
                                                            ? Color(red: 0.66, green: 0.08, blue: 0.08)
                                                            : Color(red: 0.84, green: 0.82, blue: 0.8),
                                                            lineWidth: 3
                                                        )
                                                        .foregroundStyle(Color.clear)
                                                }
                                        }
                                    }
                                }
                                .padding(.horizontal, 16)
                                .frame(maxWidth: .infinity)
                            }
                            
                            if case .tripleSense = senseLevel {
                                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 8) {
                                    ForEach(getTripleSenseOptions(), id: \.self) { option in
                                        Button {
                                            selectedCode = option.code
                                        } label: {
                                            Text(option.code)
                                                .font(.system(size: 16, weight: .bold))
                                                .foregroundStyle(
                                                    selectedCode == option.code ? Color.labelSelected : Color.labelNormal
                                                )
                                                .padding(.vertical, 20)
                                                .frame(maxWidth: .infinity, alignment: .center)
                                                .background(
                                                    RoundedRectangle(cornerRadius: 16)
                                                        .foregroundStyle(
                                                            selectedCode == option.code
                                                            ? Color(red: 1, green: 0.69, blue: 0.69)
                                                            : Color(red: 0.95, green: 0.95, blue: 0.95)
                                                        )
                                                )
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 16)
                                                        .stroke(
                                                            selectedCode == option.code
                                                            ? Color(red: 0.66, green: 0.08, blue: 0.08)
                                                            : Color(red: 0.84, green: 0.82, blue: 0.8),
                                                            lineWidth: 3
                                                        )
                                                        .foregroundStyle(Color.clear)
                                                }
                                        }
                                    }
                                }
                                .padding(.horizontal, 16)
                            }
                        }
                    }
                }
                
                // 다음 버튼
                Button {
                    coordinator.push(.typecheck(type: selectedCode!))
                } label: {
                    Text("다음")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 20)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundStyle(
                                    selectedCode == nil
                                    ? Color(red: 0.88, green: 0.88, blue: 0.88)
                                    : Color(red: 1, green: 0.69, blue: 0.69)
                                )
                        )
                }
                .disabled(selectedCode == nil)
            }
            .padding(.horizontal, 16)
        }
    }
    
    // Helper functions
    private func getCodeForSenseLevel(_ senseLevel: SenseLevel) -> String {
        switch senseLevel {
        case .nonSense:
            return SenseSpecificLevel.nonSense.code
        case .singleSense(let sense):
            switch sense {
            case .ear: return SenseSpecificLevel.ear.code
            case .eye: return SenseSpecificLevel.eye.code
            case .nose: return SenseSpecificLevel.nose.code
            case .touch: return SenseSpecificLevel.touch.code
            }
        case .allSense:
            return SenseSpecificLevel.allSense.code
        default:
            return ""
        }
    }
    
    private func getDoubleSenseOptions() -> [SenseSpecificLevel] {
        return [.eareye, .earnose, .eartouch, .eyenose, .eyetouch, .nosetouch]
    }
    
    private func getTripleSenseOptions() -> [SenseSpecificLevel] {
        return [.eareyenose, .eareyetouch, .earnosetouch, .eyenosetouch]
    }
}

extension RoomieTypeSelectView {
    func buttontitle(selectedType: SenseLevel) -> String {
        let titleText = MockData.reports.filter {
            $0.id == selectedType
        }.first?.title
        
        if let titleText {
            return titleText
        } else {
            return ""
        }
    }
}

#Preview {
    RoomieTypeSelectView()
}
