//
//  Prospect.swift
//  HotProspects
//
//  Created by Matej Kuprešak on 25.08.2023..
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymus"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
    private(set) var dateAdded = Date.now
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    
    let saveKey = "SavedData"
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPeople")
    
    init() {
//        if let data = UserDefaults.standard.data(forKey: saveKey) {
//            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
//                people = decoded
//
//                return
//            }
//        }
        
        do {
            let data = try Data(contentsOf: savePath)
            people = try JSONDecoder().decode([Prospect].self, from: data)
        } catch {
            people = []
        }
        
        // no saved data
//        people = []
    }
    
    private func save() {
//        if let encoded = try? JSONEncoder().encode(people) {
//            UserDefaults.standard.set(encoded, forKey: saveKey)
//        }
        
        do {
            let data = try JSONEncoder().encode(people)
            try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
            print("Data saved successfully at: \(savePath)")
        } catch {
            print("Error saving data: \(error)")
        }

    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        
        prospect.isContacted.toggle()
        
        save()
    }
    
    func add(_ person: Prospect) {
        people.append(person)
        
        save()
    }
    
    func sort(by: String) {
        if by == "Name" {
            people.sort {
                $0.name < $1.name
            }
        } else {
            people.sort {
                $0.dateAdded < $1.dateAdded
            }
        }
        
        save()
    }
}
