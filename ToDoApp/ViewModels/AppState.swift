//
//  AppState.swift
//  ToDoApp
//
//  Created by John Edison on 7/23/24.
//

import Foundation
import SwiftUI
import SwiftData


class ProjectListState: ObservableObject {
    @Environment(\.modelContext) private var modelContext: ModelContext
    
    @Query var projects: [Project]
    
    @Published var searchText: String = ""
    @Published var showFiltersSelector: Bool = false
    
    var filteredProjects: [Project] {
        guard !searchText.isEmpty else {
            return projects
        }
        var lowercasedQuery = searchText.lowercased()
        // Return only the posts that match the query by title or author
        return projects.filter { project in
            project.title.lowercased().contains(lowercasedQuery)
        }
    }
}

class AppState: ObservableObject {
    
    var projectListState = ProjectListState()
}
