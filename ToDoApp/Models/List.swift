//
//  List.swift
//  ToDoApp
//
//  Created by John Edison on 7/22/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class List {
    var title: String
    var dateCreated: Date
    var project: Project?
    @Relationship(deleteRule: .cascade, inverse: \Item.list)
    var items: [Item]?
    
    init(title: String, dateCreated: Date) {
        self.title = title
        self.dateCreated = dateCreated
    }
}
