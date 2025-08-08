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
    let context: EntryContext
    
    private var showBackButton: Bool { context == .fromHome }
    private var showBottomButton: Bool { context == .fromQnA }
    
    var body: some View {
        VStack {
            if showBackButton {
                NavigationBar(
                    title: "나의 유형",
                    showBackButton: showBackButton,
                    showPageButton: showBackButton
                )
            } else {
                NavigationBar(
                    title: "테스트결과",
                    showBackButton: showBackButton,
                    showPageButton: showBackButton
                )
            }
            
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
            
            if showBottomButton {
            Button(action: {
                // type 부분에 내 유형 넣기
                coordinator.push(.home)
            }) {
                Text("홈으로 돌아가기")
                    .frame(height: 64)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(.primaryPinkLight)
                    .cornerRadius(12)
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

enum EntryContext {
    case fromHome
    case fromQnA
}
