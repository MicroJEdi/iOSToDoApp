//
//  ProjectDetailView.swift
//  ToDoApp
//
//  Created by John Edison on 7/22/24.
//

import SwiftUI
import SwiftData

struct ProjectDetailView: View {
    
    let project: Project
    let lists: [List]
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var searchText: String = ""
    @State private var isEditing = false
    @State private var isDeleting = false
    @State private var showFiltersSelector: Bool = false
    
    init(project: Project) {
        self.project = project
        self.lists = project.lists ?? []
    }
    
    // A computed property that returns an array of filtered items
    var filteredLists: [List] {
        guard !searchText.isEmpty else {
            return lists
        }
        var lowercasedQuery = searchText.lowercased()
        // Return only the posts that match the query by title or author
        return lists.filter { list in
            list.title.lowercased().contains(lowercasedQuery)
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: addList) {
                    Label("Add List", systemImage: "plus")
                }
            }
            SwiftUI.List {
                ForEach(filteredLists) { list in
                    NavigationLink {
                        ListDetailView(list: list)
                    } label: {
                        Text(list.title)
                    }
                }
                .onDelete(perform: deleteItems)
            }
        }
        .navigationTitle("\(project.title)")
        .searchable(text: $searchText)
        .toolbar {
            Button { isEditing = true } label: {
                Label("Edit \(project.title)", systemImage: "pencil")
                    .help("Edit the project")
            }
            
            Button { isDeleting = true } label: {
                Label("Delete \(project.title)", systemImage: "trash")
                    .help("Delete the project")
            }
        }
        .overlay {
            if filteredLists.isEmpty {
                ContentUnavailableView(
                    searchText.isEmpty ? "Create A New List" : "List not available",
                    systemImage: searchText.isEmpty ? "note.text.badge.plus" : "magnifyingglass",
                    description: searchText.isEmpty ? Text("No Lists Exist") : Text("No results for \(searchText)")
                )
            }
        }
        .sheet(isPresented: $isEditing) {
            ProjectEditor(project: project)
       }
        .sheet(isPresented: $showFiltersSelector) {
            ListEditor(list: nil, project: project)
       }
        .alert("Delete \(project.title)?", isPresented: $isDeleting) {
            Button("Yes, delete \(project.title)", role: .destructive) {
                delete(project)
            }
        }
    }
    
    private func addList() {
        withAnimation {
            self.showFiltersSelector = true
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(lists[index])
            }
        }
    }
    
    private func delete(_ project: Project) {
        modelContext.delete(project)
    }

    
}

#Preview {
    ModelContainerPreview(ModelContainer.sample) {
        NavigationStack {
            ProjectDetailView(project: Project.cookingProject)
        }
    }
}
