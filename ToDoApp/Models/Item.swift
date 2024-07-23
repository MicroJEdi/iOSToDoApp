//
//  Item.swift
//  ToDoApp
//
//  Created by John Edison on 7/22/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class Item {
    var title: String
    var dateCreated: Date
    var dateCompleted: Date?
    var list: List?
    
    init(title: String, dateCreated: Date) {
        self.title = title
        self.dateCreated = dateCreated
    }
}
