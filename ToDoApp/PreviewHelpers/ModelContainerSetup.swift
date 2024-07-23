//
//  ModelContainerSetup.swift
//  ToDoApp
//
//  Created by John Edison on 7/23/24.
//

import Foundation
import SwiftData

extension ModelContainer {
    static var sample: () throws -> ModelContainer = {
        let schema = Schema([
            Project.self,
            List.self,
            Item.self
        ])
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: schema, configurations: [configuration])
        Task { @MainActor in
            Project.insertSampleData(modelContext: container.mainContext)
        }
        return container
    }
}
