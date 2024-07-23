//
//  ProjectSampleData.swift
//  ToDoApp
//
//  Created by John Edison on 7/23/24.
//

import Foundation
import SwiftData

extension Project {
    static let cookingProject = Project(title: "Cooking Mastery", dateCreated: Date.now)
    static let fitnessProject = Project(title: "Physical Training", dateCreated: Date.now)
    static let houseProject = Project(title: "Home Maintenance", dateCreated: Date.now)
    
    static func insertSampleData(modelContext: ModelContext) {
        
        /// Cooking Projects
        modelContext.insert(cookingProject)
        
        cookingProject.lists?.append(List.bakingList)
        List.bakingList.items?.append(Item.firstItem)
        List.bakingList.items?.append(Item.secondItem)
        List.bakingList.items?.append(Item.thirdItem)
        List.bakingList.items?.append(Item.fourthItem)
        
        cookingProject.lists?.append(List.grillingList)
        List.grillingList.items?.append(Item.firstItem)
        List.grillingList.items?.append(Item.secondItem)
        List.grillingList.items?.append(Item.thirdItem)
        List.grillingList.items?.append(Item.fourthItem)
        
        
        /// Fitness Projects
        modelContext.insert(fitnessProject)
        
        fitnessProject.lists?.append(List.marathonList)
        List.marathonList.items?.append(Item.firstItem)
        
        fitnessProject.lists?.append(List.bikeTrailList)
        List.bikeTrailList.items?.append(Item.firstItem)
        List.bikeTrailList.items?.append(Item.secondItem)
        
        fitnessProject.lists?.append(List.hikingBucketList)
        List.hikingBucketList.items?.append(Item.fourthItem)
        
        /// House Projects
        modelContext.insert(houseProject)
        
        houseProject.lists?.append(List.indoorMaintenaceList)
        List.indoorMaintenaceList.items?.append(Item.thirdItem)
        
        houseProject.lists?.append(List.outdoorMaintenanceList)
        List.outdoorMaintenanceList.items?.append(Item.secondItem)
        
        
    }
    
    static func reloadSampleData(modelContext: ModelContext) {
        do {
            try modelContext.delete(model: Project.self)
            insertSampleData(modelContext: modelContext)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
