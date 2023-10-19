//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Matej Kuprešak on 06.09.2023..
//

import Foundation

class Favorites: ObservableObject {
    private var resorts: Set<String>
    private let saveKey = "Favorites"
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedResorts")
    
    init() {
        self.resorts = []
        
        do {
            let data = try Data(contentsOf: savePath)
            resorts = try JSONDecoder().decode(Set<String>.self, from: data)
            print("Data loaded sucessfully")
        } catch {
            resorts = []
        }
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        // save data
        do {
            let data = try JSONEncoder().encode(resorts)
            try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
            print("Data saved successfully at: \(savePath)")
        } catch {
            print("Error saving data: \(error)")
        }
    }
}
