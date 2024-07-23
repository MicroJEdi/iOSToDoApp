//
//  ItemEditor.swift
//  ToDoApp
//
//  Created by John Edison on 7/22/24.
//

import SwiftUI
import SwiftData

struct ItemEditor: View {
    
    let item : Item?
    let list : List
    
    private var editorTitle: String {
        item == nil ? "Add Item" : "Edit Item"
    }
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State var title : String = ""
    @State var showAlert : Bool = false
    @State var alertTitle : String = ""
    @State var error : Error?
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Name")) {
                        TextField("Name", text: $title)
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("\(alertTitle)"),
                    message: Text("\(error.debugDescription)"),
                    dismissButton: .cancel(Text("Dismiss"), action: {
                        showAlert = false
                    })
                )
            }
            .toolbar(content: {
                ToolbarItem(placement: .principal) {
                    Text(editorTitle)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        withAnimation {
                            save()
                            dismiss()
                        }
                    }
                    // Require a category to save changes.
                    .disabled($title.wrappedValue.isEmpty)
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            })
            .onAppear() {
                if let item {
                    title = item.title
                }
            }
        }
    }
    
    private func save() {
        if let item {
            do {
                try modelContext.transaction {
                    item.title = title
                }
            } catch {
                self.alertTitle = "Database Error"
                self.error = error
                self.showAlert = true
            }
        } else {
            let newItem = Item(title: title, dateCreated: Date.now)
            list.items?.append(newItem)
        }
    }
    
}

#Preview("Add Item") {
    ModelContainerPreview(ModelContainer.sample) {
        ItemEditor(item: nil, list: List.indoorMaintenaceList)
    }
}

#Preview("Edit Item") {
    ModelContainerPreview(ModelContainer.sample) {
        ItemEditor(item: Item.thirdItem, list: List.indoorMaintenaceList)
    }
}
