//
//  CharacteristicComponent.swift
//  DGDR
//
//  Created by 석민솔 on 8/9/25.
//

import SwiftUI

struct CharacteristicComponent: View {
    // input
    let info: [CharacteristicDesc]
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("나에게는 이런 특징이 있어요")
                .font(.system(size: 16, weight: .bold))
                .padding(.bottom, 13)
                .padding(.leading, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ForEach(info) { info in
                VStack(alignment: .center, spacing: 8) {
                    Text(info.title)
                        .font(.system(size: 16, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(info.description)
                        .font(.system(size: 16, weight: .regular))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity)
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(Color(red: 0.96, green: 0.96, blue: 0.96))
                )
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
        }
        .foregroundStyle(Color.labelNormal)
        .padding(.top, 16)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .inset(by: 1.5)
                .stroke(Color(red: 0.84, green: 0.82, blue: 0.8), lineWidth: 3)
        )
    }
}

#Preview {
    CharacteristicComponent(
        info: [
            .init(
                title: "모든 감각으로부터 평화로워요",
                description: "키보드 소리, 어쩌구 소리, 어쩌구 소리에도 모두모두 평화롭게 반응해요. 정말 멋진 사람이고 살기에도 너무너무 좋을듯해요 추카드려요."
            ),
            .init(
                title: "모든 감각으로부터 평화로워요",
                description: "키보드 소리, 어쩌구 소리, 어쩌구 소리에도 모두모두 평화롭게 반응해요. 정말 멋진 사람이고 살기에도 너무너무 좋을듯해요 추카드려요."
            )
        ]
    )
}

struct CharacteristicDesc: Identifiable {
    let id = UUID()
    let title: String
    let description: String
}
