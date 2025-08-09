//
//  NavigationBar.swift
//  DGDR
//
//  Created by 석민솔 on 8/9/25.
//

import SwiftUI

struct NavigationBar: View {
    // input
    let title: String
    let showBackButton: Bool
    let showPageButton: Bool

    
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        ZStack {
            HStack {
                if showBackButton {
                    Button {
                        coordinator.popLast()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(Font.custom("SF Pro", size: 24))
                            .frame(width: 51, alignment: .center)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                
                Spacer()
                
                if showPageButton {
                    Button {
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

                    } label: {
                        Image(systemName: "book.pages")
                            .font(Font.custom("SF Pro", size: 24))
                            .frame(width: 51, alignment: .center)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
            }
            
            Text(title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .center)
                .allowsHitTesting(false)            
        }
        .foregroundStyle(Color.labelNormal)
        .frame(height: 62)
        .background(
            Color.white
        )
    }
}

#Preview {
    ZStack {
        Color.blue
        
        NavigationBar(
            title: "나의 유형",
            showBackButton: true,
            showPageButton: true
        )
    }
}
