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
            
            Text(title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .center)
            
            if showPageButton {
                Button {
                    coordinator.push(.report)
                } label: {
                    Image(systemName: "book.pages")
                        .font(Font.custom("SF Pro", size: 24))
                        .frame(width: 51, alignment: .center)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
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
