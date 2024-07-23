//
//  Project.swift
//  ToDoApp
//
//  Created by John Edison on 7/22/24.
//

import Foundation
import SwiftData

@Model
final class Project {
    var title: String
    var dateCreated: Date
    @Relationship(deleteRule: .cascade, inverse: \List.project)
    var lists: [List]?
    
    init(title: String, dateCreated: Date) {
        self.title = title
        self.dateCreated = dateCreated
    }
}
