//
//  QnaView.swift
//  DGDR
//
//  Created by ellllly on 8/9/25.
//

import SwiftUI
import SwiftData


struct QnAView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
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
        let user = User(qnaList: qnaList, senseTypeCode: "NS")
        modelContext.insert(user)
        
        try? modelContext.save()
        dismiss()
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
