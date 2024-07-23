//
//  ListSampleData.swift
//  ToDoApp
//
//  Created by John Edison on 7/23/24.
//

import Foundation

extension List {
    static let bakingList = List(title: "Baking Mastery", dateCreated: Date.now)
    static let grillingList = List(title: "Grilling Mastery", dateCreated: Date.now)
    
    static let marathonList = List(title: "Upcoming Marathons", dateCreated: Date.now)
    static let bikeTrailList = List(title: "Bike Trails To Explore", dateCreated: Date.now)
    static let hikingBucketList = List(title: "Places To Hike", dateCreated: Date.now)
    
    static let indoorMaintenaceList = List(title: "Indoor Home Repairs", dateCreated: Date.now)
    static let outdoorMaintenanceList = List(title: "Yard Work", dateCreated: Date.now)
}
