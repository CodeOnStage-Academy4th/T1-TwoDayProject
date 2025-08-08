//
//  RoomieTypeSelectView.swift
//  DGDR
//
//  Created by 석민솔 on 8/9/25.
//

import SwiftUI

struct RoomieTypeSelectView: View {
    @State var nextDisabled: Bool = true
    
    @State var selectedType: SenseLevel?
    
    @State var selectedCode: String? = nil
    
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        NavigationBar(
            title: "룸메 유형 선택하기",
            showBackButton: true,
            showPageButton: false
        )
        
        ScrollView {
            VStack {
                Text("룸메와의 궁합을 점쳐보기 위해\n룸메의 유형을 선택해주세요!")
                    .font(.system(size: 16, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.labelNormal)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 21)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(Color(red: 0.96, green: 0.96, blue: 0.96))
                    )
                
                ForEach(SenseLevel.allCases, id: \.self) { senseLevel in
                    Button {
                        selectedType = senseLevel
                    } label: {
                        // 각 senseLevel에 대한 UI 구성
                        // TODO: 이름 목데이터에서 가져오기
                        Text("\(senseLevel)")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(
                                senseLevel == selectedType
                                ? Color.labelSelected
                                : Color.labelNormal
                            )
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical, 20)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundStyle(
                                        senseLevel == selectedType
                                        ? Color(red: 1, green: 0.84, blue: 0.84)
                                        : Color.white
                                    )
                            )
                            .overlay {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(
                                        senseLevel == selectedType
                                        ? Color(red: 1, green: 0.69, blue: 0.69)
                                        : Color(red: 0.84, green: 0.82, blue: 0.8),
                                        lineWidth: 3
                                    )
                                    .foregroundStyle(Color.clear)
                            }
                    }
                }
                
                // 다음 버튼
                Button {
                    coordinator.push(.typecheck(type: selectedCode!))
                } label: {
                    Text("다음")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 20)
                }
                .disabled(selectedCode == nil)
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    RoomieTypeSelectView()
}
