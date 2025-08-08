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
    }
}
