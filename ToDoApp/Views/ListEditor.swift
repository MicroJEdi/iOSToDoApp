//
//  ListEditor.swift
//  ToDoApp
//
//  Created by John Edison on 7/22/24.
//

import SwiftUI
import SwiftData

struct ListEditor: View {
    
    let list : List?
    let project : Project
    
    private var editorTitle: String {
        list == nil ? "Add List" : "Edit List"
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
                if let list {
                    title = list.title
                }
            }
        }
    }
    
    private func save() {
        if let list {
            do {
                try modelContext.transaction {
                    list.title = title
                }
            } catch {
                self.alertTitle = "Database Error"
                self.error = error
                self.showAlert = true
            }
        } else {
            let newList = List(title: title, dateCreated: Date.now)
            project.lists?.append(newList)
        }
    }
    
}

#Preview("Add List") {
    ModelContainerPreview(ModelContainer.sample) {
        ListEditor(list: nil, project: Project.cookingProject)
    }
}

#Preview("Edit List") {
    ModelContainerPreview(ModelContainer.sample) {
        ListEditor(list: List.hikingBucketList, project: Project.fitnessProject)
    }
}
