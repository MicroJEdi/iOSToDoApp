//
//  CreateProjectView.swift
//  ToDoApp
//
//  Created by John Edison on 7/22/24.
//

import SwiftUI
import SwiftData

struct ProjectEditor: View {
    
    let project : Project?
    
    private var editorTitle: String {
        project == nil ? "Add Project" : "Edit Project"
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
                if let project {
                    title = project.title
                }
            }
        }
    }
    
    private func save() {
        if let project {
            do {
                try modelContext.transaction {
                    project.title = title
                }
            } catch {
                self.alertTitle = "Database Error"
                self.error = error
                self.showAlert = true
            }
        } else {
            let newProject = Project(title: title, dateCreated: Date.now)
            modelContext.insert(newProject)
        }
    }
    
}

#Preview("Add Project") {
    ModelContainerPreview(ModelContainer.sample) {
        ProjectEditor(project: nil)
    }
}

#Preview("Edit Project") {
    ModelContainerPreview(ModelContainer.sample) {
        ProjectEditor(project: Project.fitnessProject)
    }
}
