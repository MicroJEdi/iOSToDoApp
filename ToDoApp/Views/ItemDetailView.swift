//
//  ItemDetailView.swift
//  ToDoApp
//
//  Created by John Edison on 7/22/24.
//

import SwiftUI
import SwiftData

struct ItemDetailView: View {
    
    let item: Item
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var isEditing = false
    @State private var isDeleting = false
    @State private var showFiltersSelector: Bool = false
    
    
    var body: some View {
        VStack {
        }
        .navigationTitle("\(item.title)")
        .toolbar {
            Button { isEditing = true } label: {
                Label("Edit \(item.title)", systemImage: "pencil")
                    .help("Edit the project")
            }
            
            Button { isDeleting = true } label: {
                Label("Delete \(item.title)", systemImage: "trash")
                    .help("Delete the project")
            }
        }
        .sheet(isPresented: $isEditing) {
            ItemEditor(item: item, list: item.list!)
       }
        .sheet(isPresented: $showFiltersSelector) {
              Text("Hello Worlds")
       }
        .alert("Delete \(item.title)?", isPresented: $isDeleting) {
            Button("Yes, delete \(item.title)", role: .destructive) {
                delete(item)
            }
        }
    }
    
    private func addSubtask() {
        withAnimation {
            self.showFiltersSelector = true
        }
    }
    
    private func delete(_ item: Item) {
        modelContext.delete(item)
    }

    
}

#Preview {
    ModelContainerPreview(ModelContainer.sample) {
        NavigationStack {
            ItemDetailView(item: Item.fourthItem)
        }
    }
}
