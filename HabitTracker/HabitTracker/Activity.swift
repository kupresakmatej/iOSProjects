//
//  Activity.swift
//  HabitTracker
//
//  Created by Matej Kuprešak on 16.08.2023..
//

import Foundation

struct Activity: Identifiable, Codable, Equatable {
    let id = UUID()
    let name: String
    let shortDescription: String
    let description: String
    var completionCount: Int
    
    init(name: String, shortdescription: String, description: String, completionCount: Int) {
        self.name = name
        self.shortDescription = shortdescription
        self.description = description
        self.completionCount = completionCount
    }
}
