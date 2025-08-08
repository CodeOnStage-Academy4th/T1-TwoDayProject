//
//  TypeCheckView.swift
//  DGDR
//
//  Created by 배현진 on 8/9/25.
//

import SwiftUI

struct TypeCheckView: View {
    @EnvironmentObject private var coordinator: Coordinator

    // 표시해줄 유형 종류
    let type: String
    
    var body: some View {
        VStack {
            if let report = MockData.reports.first(where: { $0.title == type }) {
                
                ScrollView {
                    MyTypeComponent(
                        type: report.title,
                        description: report.descriptionLines.joined(separator: "\n")
                    )
                    .padding(.horizontal, 16)
                    .padding(.top, 24)
                    .padding(.bottom, 40)
                }
                .navigationTitle("테스트결과")
            } else {
                Text("해당 유형의 리포트를 찾을 수 없어요.")
                    .foregroundColor(.gray)
                    .padding()
            }
            
            Button(action: {
                // type 부분에 내 유형 넣기
                coordinator.push(.report(qnaList: [
                    QnA(number: 1, answer: 1),
                    QnA(number: 2, answer: 3),
                    QnA(number: 3, answer: 2),
                    QnA(number: 4, answer: 4),
                    QnA(number: 5, answer: 1),
                    QnA(number: 6, answer: 2),
                    QnA(number: 7, answer: 4),
                    QnA(number: 8, answer: 3),
                    QnA(number: 9, answer: 2),
                    QnA(number: 10, answer: 1),
                    QnA(number: 11, answer: 3),
                    QnA(number: 12, answer: 4),
                    QnA(number: 13, answer: 2),
                    QnA(number: 14, answer: 1),
                    QnA(number: 15, answer: 4),
                    QnA(number: 16, answer: 3)
                ]))
            }) {
                Text("내 유형 보기")
                    .frame(height: 64)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(.primaryPinkLight)
                    .cornerRadius(12)
            }
        }
        .padding(.horizontal, 16)
    }
}
