//
//  MyTypeComponent.swift
//  DGDR
//
//  Created by 석민솔 on 8/9/25.
//

import SwiftUI

/// 나는 어쩌구 유형이에요 and 간단 설명
struct MyTypeComponent: View {
    // input
    let type: String
    let description: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            VStack(spacing: 8) {
                Text("나는...")
                
                Text(type)
                    .font(.system(size: 26, weight: .bold))
                
                Text("유형이에요.")
            }
            .font(.system(size: 16, weight: .bold))
            .padding(.bottom, 25)
            
            VStack(alignment: .center) {
                Text(description)
                    .font(.system(size: 16, weight: .bold))
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 25)
            }
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(Color(red: 0.96, green: 0.96, blue: 0.96))
            )
            .padding(.horizontal, 16)
        }
        .foregroundStyle(Color.labelNormal)
        .padding(.top, 32)
        .padding(.bottom, 16)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .inset(by: 1.5)
                .stroke(Color(red: 0.84, green: 0.82, blue: 0.8), lineWidth: 3)
        )

        
    }
}

#Preview {
    MyTypeComponent(type: "더블센스", description: "무더니스트는 이런 유형이에요.")
        .padding(.horizontal, 16)
}
