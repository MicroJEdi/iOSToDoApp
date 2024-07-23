//
//  ListView.swift
//  ToDoApp
//
//  Created by John Edison on 7/22/24.
//

import SwiftUI
import SwiftData

struct ListDetailView: View {
    
    let list: List
    let items: [Item]
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var searchText: String = ""
    @State private var isEditing = false
    @State private var isDeleting = false
    @State private var showFiltersSelector: Bool = false
    
    init(list: List) {
        self.list = list
        self.items = list.items ?? []
    }
    
    // A computed property that returns an array of filtered items
    var filteredItems: [Item] {
        guard !searchText.isEmpty else {
            return items
        }
        var lowercasedQuery = searchText.lowercased()
        // Return only the posts that match the query by title or author
        return items.filter { item in
            item.title.lowercased().contains(lowercasedQuery)
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: addItem) {
                    Label("Add Item", systemImage: "plus")
                }
            }
            SwiftUI.List {
                ForEach(filteredItems) { item in
                    NavigationLink {
                        ItemDetailView(item: item)
                    } label: {
                        Text(item.title)
                    }
                }
                .onDelete(perform: deleteItems)
            }
        }
        .navigationTitle("\(list.title)")
        .searchable(text: $searchText)
        .toolbar {
            Button { isEditing = true } label: {
                Label("Edit \(list.title)", systemImage: "pencil")
                    .help("Edit the project")
            }
            
            Button { isDeleting = true } label: {
                Label("Delete \(list.title)", systemImage: "trash")
                    .help("Delete the project")
            }
        }
        .overlay {
            if filteredItems.isEmpty {
                ContentUnavailableView(
                    searchText.isEmpty ? "Create A New Item" : "Item not available",
                    systemImage: searchText.isEmpty ? "note.text.badge.plus" : "magnifyingglass",
                    description: searchText.isEmpty ? Text("No Items Exist") : Text("No results for \(searchText)")
                )
            }
        }
        .sheet(isPresented: $isEditing) {
            ListEditor(list: list, project: list.project!)
       }
        .sheet(isPresented: $showFiltersSelector) {
            ItemEditor(item: nil, list: list)
       }
        .alert("Delete \(list.title)?", isPresented: $isDeleting) {
            Button("Yes, delete \(list.title)", role: .destructive) {
                delete(list)
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            self.showFiltersSelector = true
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
    
    private func delete(_ list: List) {
        modelContext.delete(list)
    }

    
}

#Preview {
    ModelContainerPreview(ModelContainer.sample) {
        NavigationStack {
            ListDetailView(list: List.hikingBucketList)
        }
    }
}
