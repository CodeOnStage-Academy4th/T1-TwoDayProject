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
        let schema = Schema([
            Item.self,
        ])
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
                        case .qna:
                            QnAView()
                        case .typecheck(let type):
                            TypeCheckView(type: type)
                        case .chemistry:
                            ChemistryView()
                        case .report:
                            ReportView()
                        }
                    }
            }
            .environmentObject(coordinator)
        }
        .modelContainer(sharedModelContainer)
    }
}
