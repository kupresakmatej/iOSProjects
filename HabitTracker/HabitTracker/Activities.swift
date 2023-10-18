//
//  Activities.swift
//  HabitTracker
//
//  Created by Matej Kuprešak on 16.08.2023..
//

import Foundation

class Activities: ObservableObject {
    @Published var activities = [Activity]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(activities) {
                UserDefaults.standard.set(encoded, forKey: "Activities")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Activities") {
            if let decodedItems = try? JSONDecoder().decode([Activity].self, from: savedItems) {
                activities = decodedItems
                return
            }
        }
        
        activities = []
    }
}
