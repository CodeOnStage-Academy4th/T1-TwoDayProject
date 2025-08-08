//
//  HomeView.swift
//  DGDR
//
//  Created by 배현진 on 8/9/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var coordinator: Coordinator

    var body: some View {
        VStack {
            Spacer()
            
            Image("HomeLogo")
            
            Spacer()
            
            Button(action: {
                coordinator.push(.qna)
            }) {
                Text("내 유형 테스트하기")
            }
            Button(action: {
                coordinator.push(.chemistry)
            }) {
                Text("룸메랑 궁합보기")
            }
            Button(action: {
                // type 부분에 내 유형 넣기
                coordinator.push(.typecheck(type: "무더니스트"))
            }) {
                Text("내 유형 보기")
            }
        }
    }
}
