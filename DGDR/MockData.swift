//
//  MockData.swift
//  DGDR
//
//  Created by ellllly on 8/9/25.
//

import Foundation

struct MockData {
    static let questions: [Question] = [
        // MARK: - 청각
        Question(
            id: 1,
            text: "룸메의 기상 알람이 계속 울리면, 당신의 반응은?",
            choices: [
                Choice(text: "그대로 숙면 가능"),
                Choice(text: "룸메 일어날 시간인가 보네"),
                Choice(text: "여러 번 울리는데 왜 안 일어나냐..."),
                Choice(text: "알람 소리 좀 안나게 해라~!!")
            ]
        ),
        Question(
            id: 2,
            text: "방에서 노트북 사용 허용 기준은?",
            choices: [
                Choice(text: "기계식 피씨방 키보드 사용해도 괜찮아"),
                Choice(text: "맥북 키보드까지는 괜찮아"),
                Choice(text: "키스킨 사용하면 괜찮아"),
                Choice(text: "노트북 작업은 메인랩에서 끝내줘")
            ]
        ),
        Question(
            id: 3,
            text: "릴스/짧은 영상 시청은 어떻게 해줬으면 해?",
            choices: [
                Choice(text: "블루투스 스피커 써도 돼"),
                Choice(text: "이어폰 안 쓰고 편하게 틀어도 돼"),
                Choice(text: "이어폰 안 쓰고 볼륨 세 칸 정도는 괜찮아"),
                Choice(text: "봐도 되지~ 이어폰 끼고.")
            ]
        ),
        Question(
            id: 4,
            text: "드라이기 소음(머리 말리기) 허용 범위는?",
            choices: [
                Choice(text: "그럼~ 나 잘 때 말려도 돼"),
                Choice(text: "방에서 편하게 말려"),
                Choice(text: "약한 바람으로만 말려줘"),
                Choice(text: "머리는 세면대에서 말려줄래?")
            ]
        ),

        // MARK: - 시각
        Question(
            id: 5,
            text: "나는 졸린데 룸메는 깨어 있을 때, 조명은?",
            choices: [
                Choice(text: "불 켜진 채로도 딥슬립 가능"),
                Choice(text: "혹시 책상 스탠드만 켜줄 수 있을까?"),
                Choice(text: "핸드폰/노트북 밝기도 약간 거슬려"),
                Choice(text: "나 졸려. 우리 불 끄고 자자.")
            ]
        ),
        Question(
            id: 6,
            text: "바닥 머리카락(청결)에 대한 기준은?",
            choices: [
                Choice(text: "나 탈모인가? 하고 청소 안 한다."),
                Choice(text: "나중에 청소할 때 한 번에 치운다."),
                Choice(text: "하루에 한 번 정도는 돌돌이로 정리한다."),
                Choice(text: "수시로 보일 때마다 돌돌이로 정리한다.")
            ]
        ),
        Question(
            id: 7,
            text: "팀원이 방에 와서 잠깐 얘기해도 될까?",
            choices: [
                Choice(text: "완전 좋지! 나도 친해질래~"),
                Choice(text: "그래~ 잠깐이면 괜찮지~"),
                Choice(text: "이번 한 번만이다"),
                Choice(text: "안돼. 팀원이랑은 세션 때 이야기 끝내.")
            ]
        ),
        Question(
            id: 8,
            text: "새로 산 물건을 우리 침대 사이에 둬도 될까?",
            choices: [
                Choice(text: "그럼~ 내 침대 위에 둬도 돼."),
                Choice(text: "잠시 두고 나중에는 치워줘~"),
                Choice(text: "너 개인공간 정리하고 거기에 둬"),
                Choice(text: "너 더이상 쇼핑 금지.")
            ]
        ),

        // MARK: - 후각
        Question(
            id: 9,
            text: "방 안에서 향수/방향제 사용 기준은?",
            choices: [
                Choice(text: "얼마든지 사용해도 괜찮아!"),
                Choice(text: "페브리즈 정도는 괜찮아"),
                Choice(text: "향수는 밖에 나가서 사용해줘"),
                Choice(text: "나랑 사는 동안, 향수는 사용하지 말아줘.")
            ]
        ),
        Question(
            id: 10,
            text: "방에서 야식 섭취 허용 범위는?",
            choices: [
                Choice(text: "방에서 고기 구워 먹어도 괜찮아"),
                Choice(text: "방에서 라면 먹어도 괜찮아"),
                Choice(text: "방에서 초콜릿이나 젤리는 괜찮아"),
                Choice(text: "방에서는 물만 마시자")
            ]
        ),
        Question(
            id: 11,
            text: "방 환기는 언제/how 자주 하면 좋을까?",
            choices: [
                Choice(text: "출입할 때로 환기는 충분해"),
                Choice(text: "냄새 날 때만 환기해도 충분해"),
                Choice(text: "하루에 한 번은 창문 열고 환기해야 돼"),
                Choice(text: "현관문, 창문 둘 다 열고 환기하자!")
            ]
        ),
        Question(
            id: 12,
            text: "샤워/세면(냄새 관리) 기준은?",
            choices: [
                Choice(text: "뭐 언젠간 씻겠지~"),
                Choice(text: "냄새만 안 나면 괜찮아."),
                Choice(text: "하루 한 번이면 괜찮아."),
                Choice(text: "아침, 저녁으로 씻어줘, 부탁이야...")
            ]
        ),

        // MARK: - 촉각(심리적 거리)
        Question(
            id: 13,
            text: "여름철 에어컨 사용 방식은?",
            choices: [
                Choice(text: "나는 파워 냉방도, 에어컨이 없어도 괜찮아."),
                Choice(text: "나는 그냥 적당히 시원하면 돼~!"),
                Choice(text: "나는 21도로 중간 바람 세기로 해줘~"),
                Choice(text: "나는 에어컨 온도 조절 나만 하고 싶어.")
            ]
        ),
        Question(
            id: 14,
            text: "신체적 거리감(스킨십/접촉) 허용 범위는?",
            choices: [
                Choice(text: "한 침대에 누워서 회고도 가능해요~"),
                Choice(text: "룸메와 포옹도 가능해요~"),
                Choice(text: "룸메와 어깨동무 할 수 있어요~"),
                Choice(text: "룸메와 닿고 싶지 않아요.")
            ]
        ),
        Question(
            id: 15,
            text: "같이 식사하는 빈도는?",
            choices: [
                Choice(text: "매번 너랑 밥 같이 먹어도 돼"),
                Choice(text: "하루에 한 번은 너랑 같이 밥 먹어도 돼"),
                Choice(text: "일주일에 한 번 정도는 같이 밥 먹을 수 있어"),
                Choice(text: "우리 밥은 따로 먹자.")
            ]
        ),
        Question(
            id: 16,
            text: "물건 공유 허용 범위는?",
            choices: [
                Choice(text: "속옷까지 공유 가능"),
                Choice(text: "가방 혹은 겉옷 공유 가능"),
                Choice(text: "드라이기, 고데기 정도 공유 가능"),
                Choice(text: "네 꺼 써.")
            ]
        )
    ]
}

// MARK: - reports 목 데이터
extension MockData {
    static let reports: [UserTypeReport] = [
            UserTypeReport(
                id: 1,
                title: "무더니스트",
                descriptionLines: [
                    "어떤 풍파에도 무던하게 반응하는",
                    "당신은 무더니스트입니다.",
                    "어떤 룸메이트를 만나더라도",
                    "평화로운 생활을 할 수 있을 거예요."
                ]
            ),
            UserTypeReport(
                id: 2,
                title: "에어팟 이식필요",
                descriptionLines: [
                    "청각에 민감한",
                    "당신은 에어팟 이식필요 유형입니다.",
                    "소리에 예민하여 조용한 환경을",
                    "가장 편안하게 느낍니다."
                ]
            ),
            UserTypeReport(
                id: 3,
                title: "마이뷰 컨트롤러",
                descriptionLines: [
                    "시야 속 질서와 빛을 중요하게 생각하는",
                    "당신은 마이뷰 컨트롤러입니다.",
                    "눈앞의 공간이 편안해야",
                    "마음도 편안합니다."
                ]
            ),
            UserTypeReport(
                id: 4,
                title: "에어퀄리티 지킴이",
                descriptionLines: [
                    "공기의 질과 향기에 민감한",
                    "당신은 에어퀄리티 지킴이입니다.",
                    "신선한 공기와 적당한 향이",
                    "생활의 질을 높여줍니다."
                ]
            ),
            UserTypeReport(
                id: 5,
                title: "프라이버시 마스터",
                descriptionLines: [
                    "개인 공간과 심리적 거리가 중요한",
                    "당신은 프라이버시 마스터입니다.",
                    "나만의 안전 구역이 있을 때",
                    "가장 편안합니다."
                ]
            ),
            UserTypeReport(
                id: 6,
                title: "눈치빠른 센스러",
                descriptionLines: [
                    "두 가지 감각에 민감한",
                    "당신은 눈치빠른 센스러입니다.",
                    "방 안의 변화, 룸메이트와의 분위기까지",
                    "빠르게 읽고 상황에 맞춰 반응합니다."
                ]
            ),
            UserTypeReport(
                id: 7,
                title: "예민 상위권",
                descriptionLines: [
                    "대부분의 감각에 예민한",
                    "당신은 예민 상위권입니다.",
                    "세심하게 환경을 관리하고",
                    "불편 요소를 최소화하려 합니다."
                ]
            ),
            UserTypeReport(
                id: 8,
                title: "풀옵션 예민 끝판왕",
                descriptionLines: [
                    "모든 감각에 예민한",
                    "당신은 풀옵션 예민 끝판왕입니다.",
                    "완벽하게 조율된 환경에서",
                    "가장 빛나는 타입입니다."
                ]
            )
        ]
}

struct Question: Identifiable {
    let id: Int
    let text: String
    let choices: [Choice]
}

struct Choice: Identifiable {
    let id = UUID()
    let text: String
}

struct UserTypeReport: Identifiable {
    let id: Int
    let title: String
    let descriptionLines: [String]
}
