//
//  ReportView.swift
//  DGDR
//
//  Created by 배현진 on 8/9/25.
//

import SwiftUI

struct ReportView: View {
    @EnvironmentObject private var coordinator: Coordinator

    let selectedChoiceIndex: [QnA] // [선택한 질문 index]

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                ForEach(MockData.questions.indices, id: \.self) { index in
                    let question = MockData.questions[index]
                    let selectedAnswer = selectedChoiceIndex.first(where: { $0.number == question.id })?.answer

                    VStack(alignment: .leading, spacing: 16) {
                        Text("\(question.id). \(question.text)")
                            .font(.headline)
                            .foregroundColor(Color(.black))
                        
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(question.choices.indices, id: \.self) { choiceIndex in
                                Text(question.choices[choiceIndex].text)
                                    .foregroundColor(
                                        choiceIndex + 1 == selectedAnswer // answer는 1~4
                                        ? Color(.black)
                                        : Color(.black).opacity(0.3)
                                    )
                                    .fontWeight(
                                        choiceIndex + 1 == selectedAnswer ? .semibold : .regular
                                    )
                                    .padding(.vertical, 4)
                                    .padding(.horizontal, 8)
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.systemGray6))
                        .cornerRadius(16)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 32)
        }
    }
}
