//
//  QnAView.swift
//  DGDR
//
//  Created by ellllly on 8/9/25.
//

import SwiftUI
import SwiftData


struct QnAView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var coordinator: Coordinator
    
    @State private var index = 0
    @State private var selectedChoiceIndex: Int? = nil
    
    private let questions = MockData.questions
    @State private var pickedChoices: [Int: Int] = [:]
    
    
    var body: some View {
        let q = questions[index]
        let choices = Array(q.choices.enumerated())
        
        VStack(spacing: 20) {
            // 상단 네비게이션
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.black)
                }
                Spacer()
                Text("\(index+1)/\(questions.count)")
                    .foregroundStyle(.secondary)
                Spacer()
                // 오른쪽은 비워둠
                Spacer().frame(width: 24)
            }
            
            // 질문
            Text(q.text)
                .font(.title3.bold())
                .multilineTextAlignment(.center)
                .padding(.vertical, 8)
            
            // 보기 리스트
            VStack(spacing: 12) {
                ForEach(choices, id: \.element.id) { pair in
                    let idx = pair.offset
                    let choice = pair.element
                    let isSelected = (selectedChoiceIndex == idx)
                    
                    Button {
                        selectedChoiceIndex = idx
                        pickedChoices[q.id] = idx
                    } label: {
                        Text(choice.text)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(isSelected ? Color.pink.opacity(0.3) : Color.white)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                    }
                    .buttonStyle(.plain)
                }
            }

            
            Spacer()
            
            // 하단 버튼
            HStack(spacing: 12) {
                // 이전 버튼
                Button {
                    if index > 0 {
                        index -= 1
                        selectedChoiceIndex = pickedChoices[questions[index].id]
                    }
                } label: {
                    Label("이전", systemImage: "chevron.left")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .disabled(index == 0) // 첫 질문에서는 비활성화
                
                // 다음 / 완료 버튼
                Button {
                    if index < questions.count - 1 {
                        index += 1
                        selectedChoiceIndex = pickedChoices[questions[index].id]
                    } else {
                        print("✅ 완료 처리") // 완료 로직
                        saveAndClose()
                    }
                } label: {
                    if index == questions.count - 1 {
                        Text("완료")
                            .frame(maxWidth: .infinity)
                    } else {
                        Label("다음", systemImage: "chevron.right")
                            .frame(maxWidth: .infinity)
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(selectedChoiceIndex == nil) // 선택 안했을 때 비활성화
            }
        }
        .padding(20)
        .onChange(of: index) {
            // 인덱스 바뀔 때 선택 복원
            selectedChoiceIndex = pickedChoices[questions[index].id]
        }
    }

    // MARK: - 저장 (QnA / User 사용)
    private func saveAndClose() {
        var qnaList: [QnA] = []
        for q in questions {
            guard let answerIndex = pickedChoices[q.id] else { continue }
            qnaList.append(QnA(number: q.id, answer: answerIndex))
        }
        
        // 2) 감각별 고자극(2,3) 개수 세기
        var highBySense: [Sense: Int] = [.ear:0, .eye:0, .nose:0, .touch:0]
        for (qid, idx) in pickedChoices {
            guard let sense = questionSense[qid] else { continue }
            highBySense[sense, default: 0] += highWeight(for: idx)
        }

        // 3) 예민/무던 판정 (4문항 중 고자극 3개 이상 -> 예민)
        let perSense: [Sense: Sensitivity] = [
            .ear:   (highBySense[.ear, default: 0]   >= 3) ? .sensitive : .mellow,
            .eye:   (highBySense[.eye, default: 0]   >= 3) ? .sensitive : .mellow,
            .nose:  (highBySense[.nose, default: 0]  >= 3) ? .sensitive : .mellow,
            .touch: (highBySense[.touch, default: 0] >= 3) ? .sensitive : .mellow
        ]

        // 4) SenseLevel 코드 생성 (반드시 eye-nose-ear-touch 순서!)
        let codeChars: [Character] = [
            perSense[.eye]   == .sensitive ? "1" : "0",
            perSense[.nose]  == .sensitive ? "1" : "0",
            perSense[.ear]   == .sensitive ? "1" : "0",
            perSense[.touch] == .sensitive ? "1" : "0",
        ]
        let senseCode = String(codeChars)

        // (선택) SenseLevel로 변환해둠 — 필요시 rawValue로 사용 가능
        let _ = SenseLevel.getSenseLevel(from: senseCode) ?? .nonSense

        // 5) User 저장 (senseTypeCode에 코드 저장)
        let user = User(qnaList: qnaList, senseTypeCode: senseCode)
        modelContext.insert(user)
        
        debugDumpSelections()
        
        try? modelContext.save()
        
        coordinator.push(.typecheck(type: senseCode))
    }
    
    // 선택(0~3)을 무던/예민으로 즉시 판정
    private func choiceSensitivity(for zeroBasedIndex: Int) -> Sensitivity {
        // 0,1 -> 무던(저자극), 2,3 -> 예민(고자극)
        return (2...3).contains(zeroBasedIndex) ? .sensitive : .mellow
    }

    // 디버그: 질문별 선택의 무던/예민, 감각별 집계, 최종 코드까지 출력
    private func debugDumpSelections() {
        
        // 1) 질문별로 "선택 보기 / 무던·예민" 출력
        // 섹션 헤더 편하게 출력하기 위해 sense 이름 맵
        let senseKorean: [Sense:String] = [.ear:"청각", .eye:"시각", .nose:"후각", .touch:"촉각"]
        
        // 감각별 정렬된 질문ID 목록
        let groups: [(Sense, [Int])] = [
            (.ear,   [1,2,3,4]),
            (.eye,   [5,6,7,8]),
            (.nose,  [9,10,11,12]),
            (.touch, [13,14,15,16])
        ]
        
        var highBySense: [Sense:Int] = [.ear:0, .eye:0, .nose:0, .touch:0]
        var perSenseResult: [Sense:Sensitivity] = [:]
        
        for (sense, qids) in groups {
            print("\n[\(senseKorean[sense] ?? "\(sense)")]")
            for qid in qids {
                if let idx = pickedChoices[qid] { // 0~3
                    let sens = choiceSensitivity(for: idx)
                    print(" - Q\(qid): 선택 \(idx+1) → \(sens.rawValue)")
                    if sens == .sensitive { highBySense[sense, default: 0] += 1 }
                } else {
                    print(" - Q\(qid): 선택 없음")
                }
            }
            // 감각별 최종 판정 (고자극 3개 이상 → 예민)
            let final = (highBySense[sense, default: 0] >= 3) ? Sensitivity.sensitive : .mellow
            perSenseResult[sense] = final
        }
        
        // 2) SenseLevel 코드(순서: eye, nose, ear, touch)
        let codeChars: [Character] = [
            perSenseResult[.ear]   == .sensitive ? "1" : "0",
            perSenseResult[.eye]  == .sensitive ? "1" : "0",
            perSenseResult[.nose]   == .sensitive ? "1" : "0",
            perSenseResult[.touch] == .sensitive ? "1" : "0",
        ]
        let code = String(codeChars)

    }

    
}

struct SavedAnswer: Codable {
    let questionId: Int
    let choiceId: Int
}


#Preview {
    QnAView()
        .modelContainer(for: [QnA.self, User.self], inMemory: true)
}


