//
//  DGDRApp.swift
//  DGDR
//
//  Created by 배현진 on 8/9/25.
//

import SwiftUI
import SwiftData

@main
struct DGDRApp: App {
    @StateObject private var coordinator = Coordinator()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([QnA.self, User.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                HomeView()
                    .navigationDestination(for: Path.self) { path in
                        switch path {
                        case .home:
                            HomeView()
                                .toolbar(.hidden, for: .navigationBar)
                        case .qna:
                            QnAView()
                                .toolbar(.hidden, for: .navigationBar)
                        case .typecheck(let type, let entry):
                            TypeCheckView(type: type, context: entry)
                                .toolbar(.hidden, for: .navigationBar)
                        case .chemistry:
                            ChemistryView()
                                .toolbar(.hidden, for: .navigationBar)
                        case .report(let qnaList):
                            ReportView(selectedChoiceIndex: qnaList)
                                .toolbar(.hidden, for: .navigationBar)
                        }
                    }
            }
            .environmentObject(coordinator)
        }
        .modelContainer(for: [QnA.self, User.self])
    }
}
