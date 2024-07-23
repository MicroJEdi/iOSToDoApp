//
//  ProjectListView.swift
//  ToDoApp
//
//  Created by John Edison on 7/22/24.
//

import SwiftUI
import SwiftData

struct ProjectListView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var searchText: String = ""
    @State private var showFiltersSelector: Bool = false
    
    @Query private var projects: [Project]
    
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

    var body: some View {
        VStack {
            SwiftUI.List {
                ForEach(filteredProjects) { project in
                    NavigationLink {
                        ProjectDetailView(project: project)
                    } label: {
                        Text(project.title)
                    }
                }
                .onDelete(perform: deleteItems)
            }
        }
        .navigationTitle("Projects")
        .searchable(text: $searchText)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: addProject) {
                    Label("Add Project", systemImage: "plus")
                }
            }
        }
        .overlay {
            if filteredProjects.isEmpty {
                ContentUnavailableView(
                    searchText.isEmpty ? "Create A New Project" : "Project not available",
                    systemImage: searchText.isEmpty ? "note.text.badge.plus" : "magnifyingglass",
                    description: searchText.isEmpty ? Text("No Projects Exist") : Text("No results for \(searchText)")
                )
            }
        }
        .sheet(isPresented: $showFiltersSelector) {
            ProjectEditor(project: nil)
       }
    }

    private func addProject() {
        withAnimation {
            self.showFiltersSelector = true
        }
    }
    
    private func editProject() {
        withAnimation {
            self.showFiltersSelector = true
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(projects[index])
            }
        }
    }
}

#Preview {
    ModelContainerPreview(ModelContainer.sample) {
        NavigationStack {
            ProjectListView()
        }
    }
}
