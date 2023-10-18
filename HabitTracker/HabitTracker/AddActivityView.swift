//
//  AddActivityView.swift
//  HabitTracker
//
//  Created by Matej Kuprešak on 16.08.2023..
//

import SwiftUI

struct AddActivityView: View {
    @ObservedObject var activities: Activities
    
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var shortDescription = ""
    @State private var description = ""
    
    private let completionCount = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("Enter the name for your activity!")
                        .font(.headline)
                    
                    TextField("Name", text: $name)
                }
                
                Section {
                    Text("Enter a short description for your activity!")
                        .font(.headline)
                    
                    TextField("Short description", text: $shortDescription)
                }
                
                Section {
                    Text("Enter a description for your activity!")
                        .font(.headline)
                    
                    TextField("Description", text: $description)
                }
            }
            .navigationTitle("Add activities")
            .toolbar {
                HStack {
                    Button("Save") {
                        let item = Activity(name: name, shortdescription: shortDescription, description: description, completionCount: completionCount)
                        
                        activities.activities.append(item)
                        
                        dismiss()
                    }
                    
                    Spacer()
                    
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.red)
                }
            }
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView(activities: Activities())
    }
}
