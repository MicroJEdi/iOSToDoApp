//
//  ContentView.swift
//  ToDoApp
//
//  Created by John Edison on 7/22/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @StateObject private var appState = AppState()

    var body: some View {
        NavigationStack {
            ProjectListView()
        }
        .environmentObject(appState)
        .environmentObject(appState.projectListState)
    }
    
}

#Preview {
    ContentView().modelContainer(try! ModelContainer.sample())
}
