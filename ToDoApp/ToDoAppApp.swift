//
//  ToDoAppApp.swift
//  ToDoApp
//
//  Created by John Edison on 7/22/24.
//

import SwiftUI
import SwiftData

@main
struct ToDoAppApp: App {
    
    var sharedModelContainer: ModelContainer = {
        let persistedSchema = Schema([
            Project.self,
            List.self,
            Item.self
        ])
        
        let modelConfiguration = ModelConfiguration(schema: persistedSchema, isStoredInMemoryOnly: true)

        do {
            return try ModelContainer(for: persistedSchema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
